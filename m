Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D34594D
	for <dash@vger.kernel.org>; Sun, 10 Nov 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731258420; cv=none; b=sMnj8jLGEq15ppGsG1s7/k59Yq1Ux6WnfIsVtxlCF4Xo518xM5DNTtJhfv7bGYXvCQ+pSxwPo4WojS645ojmr86Tymi8WvDU8g9lsRCy9KR3YrOF6tJIr5xzkWWZRIawQrKqodQ3OsnvqDRBZMgtCAI+tM+wy+AZLC9F9ineHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731258420; c=relaxed/simple;
	bh=pN89rY4I3z8cO9gbZvKw5yjFsms2V2cCYTpPYrbbqog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCt926+UxJjEtGjwF3irq/w4i63nI3m9EQWoTf3vlSmVxiS1F+eV2XvltgJc1sNDdAcO2NOlArZ3z36ekKpDK8yqaYA7+wyTfRGGmsDJy1aQ+dd14zK9wZ/Vu8Y5PKqSllWzIw7GnSbJ4BDAl/Vyn5daaxa4NuHLd4Q0/jQD7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=V2e+w8H6; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="V2e+w8H6"
Received: from [IPV6:2a02:8010:68a1:0:c3eb:cbfe:ac4b:964a] (unknown [IPv6:2a02:8010:68a1:0:c3eb:cbfe:ac4b:964a])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 8DC6532;
	Sun, 10 Nov 2024 17:06:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 8DC6532
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1731258413;
	bh=OzMpBXjSIAd8WOz93z2p6cqmdSL4/HJpg+So3UxJAaQ=; l=2984;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V2e+w8H60syKDKovUTxUR2akW4Fmdp9uFjNeQHvPC6oZIoLUAQBoY67POnjWxGBBH
	 OoYON0Ah4zs+HrzXsVeE35EV5bJ635cMwycvnGcskkhY798OlmmRAgyBLIEooR2Jic
	 B0qYR686dAWTNby7ImUBWiMoyVhk3Zrv3T2jzjbw=
Message-ID: <65b72665-6d65-446f-b32b-968c6116ef1e@gigawatt.nl>
Date: Sun, 10 Nov 2024 17:06:52 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: set -e not ignored in AND-OR list
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
 <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
 <6496f8a6-bf07-4c4c-bbb6-3ce42dc378bd@gigawatt.nl>
 <85df2488f78032cfb64acc98ec2c483bc1fb03e5.camel@scientia.org>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <85df2488f78032cfb64acc98ec2c483bc1fb03e5.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/2024 16:52, Christoph Anton Mitterer wrote:
> Hey Harald.
> 
> On Sun, 2024-11-10 at 10:04 +0000, Harald van Dijk wrote:
>> I think you're right that POSIX specifies the behaviour.
> 
> Herbert still said it (I presume the ignoring of set -e) would not
> apply to command substitution subshells, though I haven't found
> anything yet, which would mandate this.

To be clear, I'm agreeing with your understanding of what POSIX says.

>> The reason why bash by default behaves contrary to what POSIX
>> specifies
>> is that what POSIX specifies is not useful. In command substitutions,
>> ignoring set -e in the way that you are asking for is even less
>> useful.
> 
> You mean now with respect to "inheriting" -e, right? Not with respect
> to ignoring -e (because there it seems to behave as POSIX says).

Yes.

Basically, my view is that the way 'set -e' is specified to work is only 
useful for the most simple basic cases. The way it is specified to work 
is not really useful for anything more complicated. The way it works 
differently in bash, in non-POSIX mode, is to make it useful in more 
cases, but still not all.

> Actually, there's IMO no case were it makes much sense to ignore set -e
> ... not even in the first command list of an if/etc. ... because if
> that e.g. calls a function, the function may depend on it exiting in a
> set -e case, and no just keep going.

I agree.

>>   Is there a real use case that would be helped by making this
>> change? If there is, I am not seeing it.
> 
> If Herbert is right and POSIX allows for this, it should IMO still
> explicitly be documented in the manpage (probably at both, set -e and
> command substitution documntation ).

Sure, that I do agree with. In dash, the effect of 'set -e' in a command 
substitution is that a command is never considered "tested", unless that 
testing happens inside the command substitution, and it would be useful 
for that to be documented.

> If POSIX would forbid it, but dash would still keep it, it should
> perhaps additionally be documented in some POSIX-incompatibilites
> section?
> 
> Reasons for changing the behaviour could be:
> - breaking software that already depend on the behaviour ;-)
> - being in line (and thus especially *portable*) with what POSIX says
>    (which is might also be used as kind of a documentation an thus
>    people could blindly assume the behaviour).
> - behaving more similar to bash (which is of course no must, but surely
>    not bad either).
> 
> 
> If it's however long standing behaviour of dash (and perhaps others),
> maybe POSIX should instead be revised.

Yes, that would be my preference. This is already something scripts 
cannot rely on, because widely used shells (bash and dash) are not in 
agreement. And I see at least mksh appears to behave the same way as dash:

   $ mksh -ec 'echo $(false; echo 123) || :'

The output is a blank line, like in dash.

Cheers,
Harald van Dijk
