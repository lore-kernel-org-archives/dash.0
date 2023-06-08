Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371ADC7EE29
	for <linux-dash@archiver.kernel.org>; Thu,  8 Jun 2023 10:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjFHKCe (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 8 Jun 2023 06:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjFHKCd (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 8 Jun 2023 06:02:33 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D59426BB
        for <dash@vger.kernel.org>; Thu,  8 Jun 2023 03:02:31 -0700 (PDT)
Received: from [IPV6:2a02:8010:68a1:0:404b:37aa:f9a:f0ea] (unknown [IPv6:2a02:8010:68a1:0:404b:37aa:f9a:f0ea])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 7BCB0741;
        Thu,  8 Jun 2023 11:02:30 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 7BCB0741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1686218550;
        bh=uOGtKyQekgPrqPTU3ifxVXTMhlCzolnAKKSTLQJoAdw=; l=2824;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=W6zyvqgotDk2Iu9SvFUfr+DizLElEV3Pf9wWbig8RR/2JknzmenQ4N7c0YBiuLUV9
         rR1A4mW7etuKvVRPPtev60LweWRCH3DZkBfg8epU7MejYDsMQsh5ttYwvk5b3FOKql
         ymmTVzULlHXL7X2Ur8c/2K4E4ei+qJs8+Vi4zE6A=
Message-ID: <a752feed-9c2d-b1ec-f901-188554a53a39@gigawatt.nl>
Date:   Thu, 8 Jun 2023 11:02:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:110.0) Gecko/20100101
 Thunderbird/110.0
Subject: Re: [Debian#1037195] dash: $(here-doc in <<substitution) is always
 empty, must consume subsequent lines per POSIX?
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
References: <ZIGaJAHo8OY1QzQa@gondor.apana.org.au>
 <efbfb9b1-5e73-0ff7-2b17-56c1406982c7@gigawatt.nl>
In-Reply-To: <efbfb9b1-5e73-0ff7-2b17-56c1406982c7@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 08/06/2023 10:19, Harald van Dijk wrote:
> On 08/06/2023 10:06, Herbert Xu wrote:
>> наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
>>>
>>> POSIX Issue 7, XCU, 2. Shell Command Language says
>>>    2.7.4 Here-Document
>>>   The redirection operators "<<" and "<<-" both allow redirection of 
>>> subsequent lines read by the shell to the input of a command. The 
>>> redirected lines are known as a "here-document".
>>>   The here-document shall be treated as a single word that begins 
>>> after the next <newline> and continues until there is a line 
>>> containing only the delimiter and a <newline>, with no <blank> 
>>> characters in between. Then the next here-document starts, if there 
>>> is one. The format is as follows:
>>> and its counterpart in Issue 8 Draft 3
>>>   80601  2.7.4 Here-Document
>>>   80602  The redirection operators "<<" and "<<-" both allow 
>>> redirection of subsequent lines read by
>>>   80603  the shell to the input of a command. The redirected lines 
>>> are known as a ``here-document’’.
>>>   80604  The here-document shall be treated as a single word that 
>>> begins after the next NEWLINE token
>>>   80605  and continues until there is a line containing only the 
>>> delimiter and a <newline>, with no
>>>   80606  <blank> characters in between. Then the next here-document 
>>> starts, if there is one. For the
>>>   80607  purposes of locating this terminating line, the end of a 
>>> command_string operand (see sh) shall be
>>>   80608  treated as a <newline> character, and the end of the 
>>> commands string in $(commands) and
>>>   80609  `commands` may be treated as a <newline>. If the end of 
>>> input is reached without finding the
>>>   80610  terminating line, the shell should, but need not, treat this 
>>> as a redirection error. The format is as
>>>   80611  follows:
>>
>> I don't know.  It sounds like someone has changed the standard
>> to support what you want it to do, but at the same time the old
>> behaviour is still allowed.  This is because the text uses the
>> word may instead of must.
> 
> "what you want it to do"? What dash is doing is not what I want from a 
> shell. I did say I did differently in my own. I am only saying dash's 
> behaviour is permitted by POSIX.
> 
> This particular bit of the change to POSIX is to say something about 
> things like

Apologies, you were clearly referring to the part just above that.

That part is relevant to the examples you put at the end of your 
original message, but not your main example.

>> Does anyone have a link to the discussion around this change so
>> we can infer the intention?
> 
> https://austingroupbugs.net/view.php?id=1036
> https://austingroupbugs.net/view.php?id=1521
> 
> Cheers,
> Harald van Dijk
> 
