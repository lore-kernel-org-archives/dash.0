From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Alias/heredoc/cmdsubst regression
Date: Sat, 25 Jan 2020 01:38:34 +0000
Message-ID: <f40ce455-afd8-05f4-e594-4395bb2a8ed0@gigawatt.nl>
References: <40db0aa1-195b-f29e-5068-01fa101affd9@inlv.org>
 <8b48cd04-b85f-1086-55c8-8e17800f5693@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:47160 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387406AbgAYBje (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 24 Jan 2020 20:39:34 -0500
In-Reply-To: <8b48cd04-b85f-1086-55c8-8e17800f5693@gigawatt.nl>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>, DASH shell mailing list <dash@vger.kernel.org>

On 25/01/2020 01:13, Harald van Dijk wrote:
> On 24/01/2020 23:48, Martijn Dekker wrote:
>> There is a regression involving alias expansion, a here-document, and 
>> a command substitution. The following worked fine until dash 0.5.8; it 
>> throws a syntax error as of dash 0.5.9.
>>
>> alias BEGIN='{' END='}'
>> BEGIN
>> cat <<eof
>> $(echo hi)
>> eof
>> END
> 
> Nice find.
> 
> When the newline after cat <<eof is seen, checkkwd is changed to 
> indicate that the shell is in a state where aliases can be expanded. 
> Then, parseheredoc() is called, which in turn calls readtoken1() to 
> parse the here-document. readtoken() re-sets checkkwd once it is done, 
> but readtoken1() does not, so normally this preserves the "can expand 
> aliases" state. However, nested command substitutions do reset checkkwd, 
> so things break.
> 
> Until 0.5.8, parseheredoc() was called first, and only after that did 
> checkkwd get changed.
> 
> Either parseheredoc() needs to save and restore checkkwd, or the code 
> calling parseheredoc() needs to ensure that it sets checkkwd as 
> appropriate afterwards.

There is another place that parseheredoc() can be called from where 
checkkwd was not being corrected afterwards:

   alias BEGIN='{' END='}'
   : <<EOF &&
   $(echo hi)
   EOF
   BEGIN
   echo ok
   END

This has been failing for longer. This prints "Syntax error: "(" 
unexpected" since at least 0.5.1.

> Cheers,
> Harald van Dijk
