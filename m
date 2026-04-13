Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE737CD36
	for <dash@vger.kernel.org>; Mon, 13 Apr 2026 04:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053502; cv=none; b=dZ+bG7pjVGg0f8HdixtDp4TAgWA0zQZEKgxFD+P1hU023SxFPcGcw08RY7lhdHQG66fQnU4YMGiC6qgI0w28hLzxcOyeKXPSoESF9bX+sqU75xTZpINoBsZdSoaxrDFPdDu8AgMsIjTUHsr3m2rk+mNQ6nc8ZkcvZe2cpHACr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053502; c=relaxed/simple;
	bh=Ed44qAtnrV2s9LgnhBEUD7ql7+6YNleg2NgL3hFjqrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyJY4SzUoFhKwQZy4LV3MkEyH8gRL+WayHigjb/LFsDjzpLuQ3T6Q8lAUTy5E8mKz+pyToqPtss2iO1xZuCFmaDAl1mSUPWxA9Mr5kW/GzJnqk5L7GD37g9GAxF2ri0//G3wzFzudNkkUCi5qacOKOJmEsyyP2ZPUsypkvaxFJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=NDypDdxx; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="NDypDdxx"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl D3726A01DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1776053492;
	bh=AX/baaS6K+nYZ6MGT2/QMpUEGgqlOanm3jpoSUwkYyI=; l=3283;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NDypDdxxxf1fYhdwHhUo12+3MlYgwcTdR5EXvxLlSN8NiVT4oHenDNO98FgwSKjys
	 WANV09HPFhWasA8zw0hl2khN/R5h8GbMmK6CLAxyfzMSGyr+IB7X7B5HDyWTkHsX0v
	 bKY9K2MnfRdqOs+By6IIHO487QXQNyl23735RUYo=
Received: by mail.gigawatt.nl (Postfix) id D3726A01DD;
	Mon, 13 Apr 2026 04:11:31 +0000 (UTC)
Message-ID: <5d0c907d-28d6-4d07-9c8d-09d5c128373a@gigawatt.nl>
Date: Mon, 13 Apr 2026 05:11:30 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arith: Fix CVE-2026-31323 INTMAX_MIN / -1 overflow
Content-Language: en-GB
To: Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?B?6YO96KeJ5b6X5bCx5Yiw?=
 =?UTF-8?B?5a62?= <996029583@qq.com>
Cc: dash <dash@vger.kernel.org>
References: <tencent_89DCD1FDB501CE100F1C73E55F82BA80B109@qq.com>
 <adxUzanDodYsFi_M@gondor.apana.org.au>
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <adxUzanDodYsFi_M@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/04/2026 03:28, Herbert Xu wrote:
> On Wed, Apr 08, 2026 at 04:47:10PM +0800, 都觉得就到家 wrote:
>> Division and remainder currently guard against division by zero, but not
>> against the signed overflow case INTMAX_MIN / -1. On affected systems
>> this can trigger SIGFPE during arithmetic expansion.
>>
>> Add an explicit guard before evaluating division or remainder.
>>
>> Signed-off-by: Muchen Hou <996029583@qq.com&gt;
> 
> Thanks for the patch.  For future submissions please send your
> email as plain-text, as otherwise it will be rejected by the
> mailing list.
> 
> I'm resending your patch with an additional change to combine it
> with the existing divide by zero check:
> 
> ---8<---
> From: Muchen Hou <996029583@qq.com>
> 
> Division and remainder currently guard against division by zero, but not
> against the signed overflow case INTMAX_MIN / -1. On affected systems
> this can trigger SIGFPE during arithmetic expansion.
> 
> Add an explicit guard before evaluating division or remainder.
> 
> Signed-off-by: Muchen Hou <996029583@qq.com>
> 
> Merge the overflow check with the zero division check.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/src/arith_yacc.c b/src/arith_yacc.c
> index 1a087c3..b978ef0 100644
> --- a/src/arith_yacc.c
> +++ b/src/arith_yacc.c
> @@ -98,8 +98,8 @@ static intmax_t do_binop(int op, intmax_t a, intmax_t b)
>   	default:
>   	case ARITH_REM:
>   	case ARITH_DIV:
> -		if (!b)
> -			yyerror("division by zero");
> +		if (!b || (a == INTMAX_MIN && b == -1))
> +			yyerror("division error");
>   		return op == ARITH_REM ? a % b : a / b;
>   	case ARITH_MUL:
>   		return a * b;

This looks fine if it's a conscious decision, but it differs from what 
dash generally does when the result of arithmetic is not representable 
in intmax_t, and also differs from bash. Depending on the reason there's 
apparently a CVE for this, this may be an issue, see below.

In dash, for arithmetic where the mathematically correct result is 
9223372036854775808, the result is usually converted to 
-9223372036854775808. Division of -9223372036854775808 by -1 is one of 
the few exceptions.

In bash, for arithmetic where the mathematically correct result is 
9223372036854775808, the result is usually converted to 
-9223372036854775808. Division of -9223372036854775808 by -1 follows the 
general rule.

It would be more consistent with dash's general handling to match bash. 
Alternatively, raising errors on all arithmetic overflow would also be 
consistent. But having it differ from one operation to the next is, I 
think, hard to explain.

Looking at the CVE for more context, 
https://www.cve.org/CVERecord?id=CVE-2026-31323 just says "This ID has 
been reserved by a CNA." I'm curious how this is a vulnerability: if you 
can execute arbitrary shell scripts, you can get SIGFPE much easier by 
just doing 'kill -FPE $$'. If that is not the reason for the CVE, if 
instead there are certain shell scripts that can be forced to exit 
unexpectedly that way that do not exit in bash, note that the proposed 
fix *still* forces most of the same shell scripts to exit unexpectedly 
that way, because that is the default handling of arithmetic errors.

Cheers,
Harald van Dijk
