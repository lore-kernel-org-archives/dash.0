Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD3BC54EBE
	for <linux-dash@archiver.kernel.org>; Fri, 13 Jan 2023 13:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbjAMNsO (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 13 Jan 2023 08:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjAMNrQ (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 13 Jan 2023 08:47:16 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDDF63D5D9
        for <dash@vger.kernel.org>; Fri, 13 Jan 2023 05:41:43 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id E3EEC105F;
        Fri, 13 Jan 2023 13:41:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl E3EEC105F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1673617302;
        bh=fPYjGpjKPWfHGcbId6dj2SOdiSeMFAfbVw3DYrp8Uto=; l=4375;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=CbJZKGdcsoOxRtoyxrPdNtOO6JtvWF8dR5dpoyJyC2Y9bCyEufOHYwsnJhLbCCFEY
         MiDzQsEg3IsLlK3Ibn8dNE/UyxkpKnzCS8Nt+6oyNHxHY9bgqKDPzERfBzGN4o/K0f
         Ri8PX5GY2OMAFp6RbqHrG7HMu0ZtGOh0dptFVw48=
Message-ID: <24a86069-8589-4bba-f90a-105ec3619da1@gigawatt.nl>
Date:   Fri, 13 Jan 2023 13:41:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: alias confusion due to internal word representation
To:     Michael Greenberg <michael@greenberg.science>,
        DASH shell mailing list <dash@vger.kernel.org>
References: <444eaa61-35a8-15f4-5aeb-14a56aa38d07@gigawatt.nl>
 <m2zganhhlt.fsf@greenberg.science>
Content-Language: en-GB
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <m2zganhhlt.fsf@greenberg.science>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 12/01/2023 15:56, Michael Greenberg wrote:
> I've seen this issue in interop with modernish, where dash doesn't
> properly support multibyte character encodings. It would be great to
> have proper support for more interesting character sets.

Agreed, but personally, I see that as a separate issue. Non-ASCII bytes 
in alias names are potentially useful even without multibyte character 
support, and multibyte character support is definitely useful regardless 
of anything that aliases do.

> It's worth looking at how other shells implement this, but a natural
> choice is to choose a more sophisticated representation of string, where
> control characters are represented out-of-band rather than by using
> 'unused' values (well, unused by ASCII, but not by
> others). Unfortunately, this rope-like representation is not very
> convenient to work with.

There are a few shells that store words in the exact form that they 
appear in the script. This has interesting consequences: it shows the 
same effect, but in an arguably less problematic form. In bosh:

   $ alias '\a=echo what'
   $ a
   a: not found
   $ \a
   what

Other shells that take this approach restrict alias names so that shell 
special characters, including '\', cannot appear, but other characters can.

Although this representation is not without its problems, it would 
handle this transparently, and has the arguable benefit of automatically 
handling things like

   $ cat <<`this is problematic`
   hello world
   `this is problematic`

as well. This has come up on the list before; this works in bash, ksh, 
yash, and zsh, and POSIX places no restrictions on what words can be 
used as heredoc delimiters, so I think shells are required to accept 
this and it is technically a bug that dash doesn't (as well as several 
other shells), even if no one would ever make use of it.

It would require massive changes and is almost certainly not appropriate 
for dash.

But we can take inspiration from it and think of a more limited fix, one 
that works to handle the alias issue, but nothing else: it should be 
possible to change the representation of CTLESC and other control 
characters. If their representation is changed to that of characters 
that cannot appear in alias names without quoting anyway, e.g. by 
changing the value of CTLESC to \ and similarly for other control 
characters, the second problem is avoided. By changing the parser to set 
quoteflag when processing command substitutions etc., the first problem 
is avoided. (This may involve renaming quoteflag, since it would no 
longer reflect simply whether any part of the word was quoted. Or a new 
variable may be added to track this.) This should be enough to make it work.

Cheers,
Harald van Dijk

> Cheers,
> Michael
> 
> On 2023-01-11 at 02:01:03 AM, Harald van Dijk wrote:
> 
>> Hi,
>>
>> Please consider
>>
>>     alias $(printf "\204")="exit 2"
>>     $(:)
>>     echo ok
>>
>> This is a perfectly valid shell script. The alias command is permitted
>> to either succeed or fail, and if it succeeds, it defines an alias whose
>> name is the single byte '\204'. No command by that name is ever
>> executed, so this script is required to then print 'ok' and exit
>> successfully.
>>
>> This is not what happens. Internally, '\204' is the value of CTLBACKQ,
>> and the word $(:) gets translated to an internal representation of just
>> that -- coupled with a pointer to the parsed command. Since the word
>> $(:) contains zero quote characters, it is subjected to alias expansion,
>> and picks up this alias definition that makes the command expand to
>> exit 2.
>>
>> Consider also:
>>
>>     alias $(printf "\201")="echo ok" $(printf "\201\201")="echo bad" &&
>>     eval $(printf "\201")
>>
>> This should either print "ok", or reject the aliases. Instead, it prints
>> "bad". This happens because '\201' is the internal representation of
>> CTLESC, and a literal byte of that value is represented by escaping it
>> with CTLESC. Therefore, it triggers the expansion of the \201\201 alias.
>>
>> Supporting alias names containing non-ASCII characters, while not
>> required by POSIX, seems desirable, and almost all other shells (mksh
>> being the exception) do appear to support this. I am not yet seeing a
>> good way of solving this.
>>
>> Cheers,
>> Harald van Dijk
> 
