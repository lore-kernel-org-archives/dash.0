From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/2] mkbuiltins: Use a `while` loop rather than `nl`
Date: Mon, 8 Aug 2016 23:33:37 +0800
Message-ID: <20160808153337.GA31891@gondor.apana.org.au>
References: <be6ddf83-041e-7dca-5f5c-16167faa9d95@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:60735 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbcHHPdo (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Aug 2016 11:33:44 -0400
Content-Disposition: inline
In-Reply-To: <be6ddf83-041e-7dca-5f5c-16167faa9d95@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: somasissounds@gmail.com, dash@vger.kernel.org, somasis@exherbo.org

Harald van Dijk <harald@gigawatt.nl> wrote:
> On 04/08/2016 07:54, Kylie McClain wrote:
>> From: Kylie McClain <somasis@exherbo.org>
>>
>> nl, while specified in POSIX, is rather obscure and isn't provided by small
>> coreutils implementations such as `busybox`. This while loop works just as
>> well for our purposes.
> ...
>> -sed 's/      -[a-z]*//' $temp2 | nl -ba -v0 |
>> +sed 's/      -[a-z]*//' $temp2 | while read line;do \
>> +     i=$(( ${i:--1} + 1 )); printf '%s %s\n' "${i}" "${line}";done |
> 
> $(( ... )) is mentioned in 
> <https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Shell-Substitutions.html> 
> as not universally supported, notably Solaris 10 /bin/sh does not have 
> it. Given that dash was fairly recently changed to make it build on 
> Solaris 9, it seems like a mistake to break that again.
> 
> Aside from that, i is such a common variable name that it seems risky to 
> assume it is unset. I know I've set it myself in shell sessions that I 
> ended up using for building dash. I never exported it, so it wouldn't 
> break here, but it doesn't seem like a stretch that someone else does 
> export it.

nl has been around forever.  I'm not taking this patch.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
