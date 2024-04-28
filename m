Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395304A01
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714315870; cv=none; b=Oi7v4lIXq3zHrzU9DNlqc4gkJ05ximehfDGhtOgju4TAHE7uiITtUQFbtkcAWxSN4Sfcvzt7jo7Mh1WN5DRbRP49tl8oWyN8Q4XVninyxuF0HtJhCC8a91dvEZyjcRqEI+4CIrSdgW5n3VWJBGPYQRmE0FVFZodZB11qCyulF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714315870; c=relaxed/simple;
	bh=uTIL2+V1DPY8Nk02Y/oanL5Lw13WWJLIkILqDNWAReI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKWtkB4y7ku6pdnuamM+h5WMNYxI2fEV3kN8OnodNC6HXpy897D0rBiZTTseXe+YRecOuJauLfgfUnJpXNJxg/JR7Ex19DouoqQoRo3iQ038U7jegXtQHSZC36m5RmGFt8LlMWTkM31Y0k1IIOrgyIf31hQTgDg3tBRJmNwevfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=aHSe2cvO; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="aHSe2cvO"
Received: from [IPV6:2a02:8010:68a1:0:b093:5565:50db:e14f] (unknown [IPv6:2a02:8010:68a1:0:b093:5565:50db:e14f])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 99201DA3;
	Sun, 28 Apr 2024 15:50:58 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 99201DA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1714315858;
	bh=3DwWMw0VsiwBKniB0wEEGB5MKNnmzG2fBbAm/JNLiSc=; l=1928;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aHSe2cvOIaSCmgB3IPonzwYsUQWxmZWp+o7T+mUIx9YsyoLK7xNG0kZtcE88O92H4
	 0aAqrjuwc+w3R8EmYjqCiNzp/q1mTPNgJtHfh80WSVW5o2FVB+7V5HHNPf9+dE1AAS
	 /FhrsBhPPvBPKsDxAuRdEaaVzKAk2L2JPkvM12ww=
Message-ID: <abc8daf0-60ab-4e7c-aba7-9a3f3b973f57@gigawatt.nl>
Date: Sun, 28 Apr 2024 15:50:57 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add multi-byte support
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Christoph Anton Mitterer <calestyo@scientia.org>
Cc: DASH Mailing List <dash@vger.kernel.org>
References: <cover.1714215826.git.herbert@gondor.apana.org.au>
 <eb927eeff3d1da7406c998d0ce816d3b6a061fc7.camel@scientia.org>
 <Zi2dIJQcNVwJgxuN@gondor.apana.org.au>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Zi2dIJQcNVwJgxuN@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/04/2024 01:49, Herbert Xu wrote:
> On Sat, Apr 27, 2024 at 11:31:43PM +0200, Christoph Anton Mitterer wrote:
>>
>> Long story short:
>> The recommended way was to add a sentinel character '.' at the end of
>> the output within the command substitution and strip that off later
>> with parameter expansion.
>> But despite of the very special properties[0] of '.', it's apparently
>> still required to set LC_ALL=C when stripping the sentinel, because the
>> pattern matching notation in ${foo%.} is defined only on strings of
>> characters, not on strings of bytes.
> 
> Are you talking about a theoretical undefined condition, or an
> actual one?  Which shell doesn't deal with ${foo%.} correctly?

The way you are implementing it, once you get to pmatch(), arguably you 
will not handle ${foo%.} correctly.

Consider an UTF-8 locale, where '\303' is not a valid multibyte 
character. In this locale, consider

   foo=$(printf '\303.')
   foo=${foo%.}

This is something I expect to set foo to '\303', and it does in all 
shells I know of, despite POSIX not saying this needs to work. The way 
you are implementing multibyte character support, if I am reading it 
right, as long as a full multibyte character has not been read, the next 
byte will be taken as part of that multibyte character, meaning you will 
take '\303.' as a single invalid multibyte character.

At the same time, '\303\251' is a valid multibyte character, and '\251' 
is not. So also consider

   foo=$(printf '\303\251')
   foo=${foo%$(printf '\251')}

Here, it is not clear what the correct result is, and indeed, shells 
disagree. bosh, ksh, zsh, and my shell do not break up characters, which 
I believe to be the most sensible behaviour. bash and mksh do.

The corner cases need to be carefully considered in order to figure out 
how to write the multibyte character support core functionality.

Cheers,
Harald van Dijk
