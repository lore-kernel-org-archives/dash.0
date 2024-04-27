Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7A54D5AC
	for <dash@vger.kernel.org>; Sat, 27 Apr 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714225574; cv=none; b=G623AxzhNX5BFPKZRnQQP4fEjuzhFpxvraR9jslkUNQRFcpezfFa7aqCeJt4advhEYhMEeCze0yBwBdJD5kb16t/NxQFfL209FC2CtPmXkJ5VURKUHLp3iXzRC8aklgIDrcn859sQ5l+KZkutH08sOy3TzJ2NZN/vXbHfUN+lvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714225574; c=relaxed/simple;
	bh=zoAo6qk1uCshWMDqSw8G/JuPhMeIJERrZeRbl4mjpFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/24T1OSDooOMqoOJA3S8GBnpyaaVrGthZKOgkFuYOcaRd7FfcyjFsQ43xNsG37JF89AHE0xJIOPzuh8stb1mkct1x3Rb9PAyLn13tquwuGsFVBp+fM3uXXbY7PbFPQrCDCOxAcaf7LfHFnqnwXgegtGR0Y3h7UE0LCjP4gOtuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=aphccgqq; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="aphccgqq"
Received: from [IPV6:2a02:8010:68a1:0:9b52:1030:9fa8:4969] (unknown [IPv6:2a02:8010:68a1:0:9b52:1030:9fa8:4969])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 02A89DA3;
	Sat, 27 Apr 2024 14:46:06 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 02A89DA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1714225567;
	bh=CuWuzHMQL5EzwCeXVgSj1oBIdbZjcWKxJcTeI1lTH6Q=; l=1317;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aphccgqqtQECpyYq4IYOxGcgJqyRRyZk1/D3lmgeiuT41dZd7PZZVP1mqblHEYf3a
	 fEbkZKmEafxopiCnDWyI/ebqoLN3CRxWr5IFcOhT+YrCd/SnUSAacjvdQK8DJJ9/Q7
	 /heEZi4oeYM53+iar3O0H/GiBbpp/8JII6I1iebk=
Message-ID: <2bf68a06-2050-4e5c-8e5e-3a703b21c9ee@gigawatt.nl>
Date: Sat, 27 Apr 2024 14:46:06 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] expand: Fix naked backslah leakage
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: DASH Mailing List <dash@vger.kernel.org>
References: <ZizbYRti9EydVOg4@gondor.apana.org.au>
 <000d8fe0-2898-49cc-a841-a78ae7292f6a@gigawatt.nl>
 <Zizt6ZdJrdSFVBhT@gondor.apana.org.au>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Zizt6ZdJrdSFVBhT@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/04/2024 13:22, Herbert Xu wrote:
> On Sat, Apr 27, 2024 at 01:12:19PM +0100, Harald van Dijk wrote:
>>
>> The correct result here, I believe, is <\*bc>. The backslash means the next
>> character is taken as literal, even if that character is already also taken
>> as literal because of the quoting. There is nothing to cause the backslash
>> to be taken literally. The result should be that only a leading * is removed
>> from $a.
> 
> While I do see the logic in your reasoning, no other shell implements
> this behaviour:

I'm aware this isn't what most shells do, but it's not quite the case 
that no other shell implements this.

> *sh -c 'a="*bc"; b="\\"; c="*"; echo "<${a##$b"$c"}>"'
> 
> always produces <*bc> across all shells on my system.

This produces <bc> with my shell, at least.

If we are comparing what other shells do, it is probably worth pointing 
out that shells disagree on your original example.

   a="\\*bc"; b="\\"; c="*"; echo "<${a##$b"$c"}>"

Many shells share the bug where this prints <>, but of shells that do 
not have this bug, while many print <bc> like what your patch makes dash 
do, the most commonly used one, bash (as of version 4), does not: it 
prints <\*bc>. I am not sure what exactly $b"$c" is trying to strip here.

Cheers,
Harald van Dijk
