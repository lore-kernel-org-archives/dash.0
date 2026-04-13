Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF635959
	for <dash@vger.kernel.org>; Mon, 13 Apr 2026 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776047316; cv=none; b=EEs2t7CyfBdZdZezEl7dFj8Hvb/MY6O9r0eFxatchFOYmVgwf+oyIu9RrSTZDwSw4A9BKFOfLP77DL8YPgUhZ7vjzz1L0LSUuQHLDXd7IGHQCuUXCnnBTrsaOqBEiRwVYDmkt9tx2b3Do2OutzsTMw8PaGj5TBqXZSHC7aF2OdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776047316; c=relaxed/simple;
	bh=G22R5zOyTKs0hq239ETuv+L0WNdVU1LzgHZC6fhrNTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyX0YBk1MsX40gCN5lgtZJpNYR1J97VCKzQTA/4++ZN561FhEZdiuV3gJtBrD+bsjMH6lrdstKjFEgwqyIEUWo41O5jKxK2h8Tq737bn599DZHGzebmMc9BvmuKUJyy4ppIH/aA5yTCNupBqST4Zgf7cUp8mJTwELig+KuWHEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Heh0nSnb; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Heh0nSnb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=6tNxLSMdEaIRwQy1x8Zb6Vmj7TJK2yA6gIjVsUzN7jE=; 
	b=Heh0nSnb1bqF9Mp0qwxkdV0NyNMf17WDxK5zDgJYhPVro+kpySIDmCO5LKPID2UKn+pVJD6AUG8
	DBv2SYsCN4rVtXiH6WJZv2LCnuXxJLEe7AuOr/ygBojsgekxZIhA2wquOOmk2f+BHARxZ6PMlZrfS
	WNphD3kJ6dsxkwHq5KFHwK2TZjl0Mn2Qna6CgkVMgsJp5HOZjfBqED8kHT/0xDDfYAbSIPd3AvxQi
	FQBP4wgZj2I1eiRn9gasfyaxVaXAnoeaZVOIFnYOQ8ZkeXN3dXqt6+FqFuaehSaUCmkAIVgrp7x/L
	2tbfffGytp9FuRFgIqbmyU8GEw5Ad98CMxeg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wC6cs-005cxD-20;
	Mon, 13 Apr 2026 10:28:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 13 Apr 2026 10:28:29 +0800
Date: Mon, 13 Apr 2026 10:28:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?utf-8?B?6YO96KeJ5b6X5bCx5Yiw5a62?= <996029583@qq.com>
Cc: dash <dash@vger.kernel.org>
Subject: [v2 PATCH] arith: Fix CVE-2026-31323 INTMAX_MIN / -1 overflow
Message-ID: <adxUzanDodYsFi_M@gondor.apana.org.au>
References: <tencent_89DCD1FDB501CE100F1C73E55F82BA80B109@qq.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_89DCD1FDB501CE100F1C73E55F82BA80B109@qq.com>

On Wed, Apr 08, 2026 at 04:47:10PM +0800, 都觉得就到家 wrote:
> Division and remainder currently guard against division by zero, but not
> against the signed overflow case INTMAX_MIN / -1. On affected systems
> this can trigger SIGFPE during arithmetic expansion.
> 
> Add an explicit guard before evaluating division or remainder.
> 
> Signed-off-by: Muchen Hou <996029583@qq.com&gt;

Thanks for the patch.  For future submissions please send your
email as plain-text, as otherwise it will be rejected by the
mailing list.

I'm resending your patch with an additional change to combine it
with the existing divide by zero check:

---8<---
From: Muchen Hou <996029583@qq.com>

Division and remainder currently guard against division by zero, but not
against the signed overflow case INTMAX_MIN / -1. On affected systems
this can trigger SIGFPE during arithmetic expansion.

Add an explicit guard before evaluating division or remainder.

Signed-off-by: Muchen Hou <996029583@qq.com>

Merge the overflow check with the zero division check.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/arith_yacc.c b/src/arith_yacc.c
index 1a087c3..b978ef0 100644
--- a/src/arith_yacc.c
+++ b/src/arith_yacc.c
@@ -98,8 +98,8 @@ static intmax_t do_binop(int op, intmax_t a, intmax_t b)
 	default:
 	case ARITH_REM:
 	case ARITH_DIV:
-		if (!b)
-			yyerror("division by zero");
+		if (!b || (a == INTMAX_MIN && b == -1))
+			yyerror("division error");
 		return op == ARITH_REM ? a % b : a / b;
 	case ARITH_MUL:
 		return a * b;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
