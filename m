Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D812ED848
	for <dash@vger.kernel.org>; Wed, 20 Aug 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696366; cv=none; b=YQOPjCQDrXDnLToWXvNyPPhzQ+OJc5r3NWYm2HKfbswFSeMha9OdjzndvnLZvs8x/7/01yHaHULLpZmpGXWrJ1nLgiREJVpta9dXQeFkH8ld7NkpbqprO7bRk++fGPGkIh3CEdd4cUJJi3YKnhmamkV/CZxEHZh2x0J5c5vEGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696366; c=relaxed/simple;
	bh=30MNaCHw1Xh+gs/NQWG6e+Ct250RAXIuODtEapkysYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9NdqbzCmJBZuKGhtLJTXF32VjOJjQNDQfzVcRpBA/NrVp8L/PgRpW9AJV3Baj55y/IXkcz+aEGNSJ5BEgCRCePXddwx3f0hGj5+oSA2ycG4HkZb7zYVg4tdAibkhX+UHWELmjFOlkG+cyGUrfYJ7msgskw8prZpcYKC5ftXBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=VfVT9vP5; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="VfVT9vP5"
Received: from [192.168.178.21] (unknown [31.94.20.39])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 27A9B140;
	Wed, 20 Aug 2025 14:26:00 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 27A9B140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1755696360;
	bh=FsaABsL3/zXfY8FTf2kUUDMTLoja3pGceXQ+t9bMLB4=; l=2113;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VfVT9vP5kxPy9PoKMuJSpJPAyQ3LDr6ZYYewlttAduUNx6FlEZFVhNHxguSqgVyo8
	 2gK+G/UgJWSwGb4CpHwVeVPkOQkPNW+vhP4IGKaIDaJrew3sEV7wm6KYIBzQ0raCEb
	 z8mpVADhPvE2HmEhMP/5KQzhQSKPiKXizwJUtY2g=
Message-ID: <29c58d93-1b11-4a6b-a78f-774dc33b9cf8@gigawatt.nl>
Date: Wed, 20 Aug 2025 14:25:57 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Content-Language: en-GB
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
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20250820121405.UGuB1dZ3@steffen%sdaoden.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2025 13:14, Steffen Nurpmeso wrote:
> Steffen Nurpmeso wrote in
>   <20250820113344.cw2oHltI@steffen%sdaoden.eu>:
>   |Steffen Nurpmeso wrote in
>   | <20250820112753.FJo-4m6j@steffen%sdaoden.eu>:
>   ||Harald van Dijk wrote in
>   || <ef041d50-cb3b-44be-aa81-402912b42997@gigawatt.nl>:
>   |||On 20/08/2025 01:33, Aleksander Ushakov wrote:
>   |||> Well, if we take bash with UBSAN instrumentation and try to use a
>   | ...
>   |||I did that in my own version back in 2019, with the exception of subtly
>   | ...
>   |||<https://github.com/hvdijk/gwsh/commit/c4d6f1b1613c228db1e157a2136c53f55\
>   |||b4530c8>.
>   |||As those commits show, there are quite a few more cases to consider than
>   |||left shifts of negative values.
>   ||
>   ||We (i am only a MUA though, since busybox did not take the code,
>   ||and kept their broken implemenation; will try again at some time)
>   ||all return -2 for "-1 << 1", at least on this hardware etc etc.
>   ||You then return 0 from looking at the commitdiff!?!
>   |
>   |ah no forget that rubbish, the test is about rval.
> 
> Ah.  However, may i suggest one thing?  You test against
> "(uintmax_t) b >= INTMAX_WIDTH)" and say "excessive
> shift counts do not lose the high bits".
> On at least x86 (where i have been educated) excessive shift
> counts are reduced to &(bits-1) aka %BITS_OF_XY_INT.  I have no
> overview on how other platforms do it, plus i have forgotten
> whether that behaviour is possibly standardized by any language.
> But i am used to that, and am possibly not alone with this.
This is what I was referring to with "subtly changing behaviour that 
differed across architectures". This behaved differently across 
architectures, taking only the low bits of the shift count is what x86 
does but is not universal, and I did not think it would be sensible to 
implement that on other platforms where it never worked that way. The 
behaviour I picked is what would have been the result if excessive shift 
counts hadn't been explicitly undefined, it's simply that e.g. a shift 
by 123 is equivalent to 123 shifts by 1.

Cheers,
Harald van Dijk
