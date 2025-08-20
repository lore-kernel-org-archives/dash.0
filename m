Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD62F4A
	for <dash@vger.kernel.org>; Wed, 20 Aug 2025 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719521; cv=none; b=nuHVGaha2MRhYKNZklLtAp6MVJNIld56ubU01vu/G0ILFBsfUSeREE+b3ylrRS7vtd1qj/MoF33szlVoEMHv4Asq9QctxlqHTp5wwER3Zrw9WEYY5+ePu3Bv5lADUNKk6IE9tc+Unbuzdr9WbLPtdYL0UfIEWsb2gScIdVBocqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719521; c=relaxed/simple;
	bh=QKSkyC3sTptQ2gXKQ64cyCstCTk0HkvWRArsK54+KM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEWVPAPaQz8Nf05yGdvRqDdOYFoUQbnCIy0G6KGBrPWqrnLZGVO2nr+J2dUHSo+46kTPhh+jzjpV7/82f8lP8BjKikSeFVGMvZ9A+MWl7x+4WSKn+2gfjhg3JzPBtAo7Xxe96IBZxCYm/QT7f7gPAx6DPEchRGc8Jmxa8BkNmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=FUE6pz22; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="FUE6pz22"
Received: from [192.168.178.21] (unknown [31.94.20.39])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 9A297420;
	Wed, 20 Aug 2025 20:51:54 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 9A297420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1755719514;
	bh=5AmerAj6xRuqj8YjShEXGraX+FJohp6D/ucUxX8eUME=; l=1875;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FUE6pz226Mu6Y7b9yFYDKgoPrz2LvxbNwOXN8UlyvF8s/miFy+5siQqT3e83G9FAA
	 i/zdbwOLx83kc8EKtTxZOHZnCGiaN9OXMSBG+Cu2/ZFJ3RmuXx/33EgMSrl/p+5MOl
	 tahoY96gz9CWgT8uScZet11DL6ESv1cNR0KgNPKw=
Message-ID: <3bd5ca92-d09f-440f-ba0e-8e67d36dad50@gigawatt.nl>
Date: Wed, 20 Aug 2025 20:51:52 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
To: Steffen Nurpmeso <steffen@sdaoden.eu>
Cc: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
 <3a37b273-3da1-45f6-a303-3c0796bd0532@gigawatt.nl>
 <024b5e9f-6112-4224-b095-f7e54b8971b4@astralinux.ru>
 <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>
 <20250820112753.FJo-4m6j@steffen%sdaoden.eu>
 <20250820113344.cw2oHltI@steffen%sdaoden.eu>
 <20250820121405.UGuB1dZ3@steffen%sdaoden.eu>
 <29c58d93-1b11-4a6b-a78f-774dc33b9cf8@gigawatt.nl>
 <20250820144912.gzw-kNXj@steffen%sdaoden.eu>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20250820144912.gzw-kNXj@steffen%sdaoden.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2025 15:49, Steffen Nurpmeso wrote:
> Harald van Dijk wrote in
>   <29c58d93-1b11-4a6b-a78f-774dc33b9cf8@gigawatt.nl>:
>   |This is what I was referring to with "subtly changing behaviour that
>   |differed across architectures". This behaved differently across
>   |architectures, taking only the low bits of the shift count is what x86
>   |does but is not universal, and I did not think it would be sensible to
>   |implement that on other platforms where it never worked that way. The
>   |behaviour I picked is what would have been the result if excessive shift
>   |counts hadn't been explicitly undefined, it's simply that e.g. a shift
>   |by 123 is equivalent to 123 shifts by 1.
> 
> Ok, but i am not with you regarding that then.  (Do you can name
> "other platforms"?)

It has been about six years since I looked at that so I don't remember 
exactly. I think it was most likely 32-bit ARM where $(( 1 << 65 )) 
would result in 0.

>                      I think the other shells are not either.
> As a little bit laxe one regarding all that i want to point to
> the email [1] (thread start [2], if you really want and do not
> read it anyway), especially
> 
>    I hear and understand what you're saying. I think what I'm
>    trying to point out, is that in C, as it was originally
>    implemented, in expressions "a + b", "a >> 1", "++a", C
>    "does what the machine does".  That's a very different thing
>    from having rational, safe, predictable language semantics
>    for operations on types - but it was also a strength, and a
>    simple way to describe what C would do, deferring to machine
>    semantics. I believe one place in C89/C90 where this is stated
>    explicitly, as "do what the machine does"

If I had seen any way to implement that, I would have. But I saw no such 
way, so went with the behaviour that I felt was easiest to justify.

Cheers,
Harald van Dijk
