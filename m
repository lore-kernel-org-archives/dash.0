Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84537BE89
	for <dash@vger.kernel.org>; Mon, 13 Apr 2026 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075314; cv=none; b=bNjAySav3Hg41k9WcUwnx9phuwCJij7kqyaXrNp42NkTZUbwP8QRRqONcRfaKDdxabIa9MyAnXKAdGso6S6NS8s2Ikv0qeWsoRCiCjCA06YVX9hKcHthRh+QtdOu41O4LYwobGOxFquSKUZ+Y0CSUk7itgn0BKd2B9jAA0SlX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075314; c=relaxed/simple;
	bh=45XY/TlSorf3ceDVfCasmArmprLE4B3UEbgmI4DsyUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntYaIxlPEtR04p+tF/6hBK9HT48A4bVqvPUvrOY9v4SMlrRZGUckZsstqtVsYixP1GmQmiRFxNT5utp5Clk3nQ2Km1GIxQbPuk/BmCG+YqKNMWCQ1G4gGX3KDu1Ot94bqtynQ81NlF98iXfR+sfKFavSUsGNFCZTHbrfCr8S6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=mZbHCvDL; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="mZbHCvDL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1776074843; x=1776741509; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:mime-version:
  content-type:content-transfer-encoding:author:from:subject:date:to:cc:
  resent-author:resent-date:resent-from:resent-sender:resent-to:resent-cc:
  resent-reply-to:resent-message-id:in-reply-to:references:mime-version:
  content-type:content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=fl2f4ooYCIf9bBmS/zgc5PtYbnl/7dAEM9MCI4jK8eg=;
 b=mZbHCvDLOu+4Q8do6ekUkaI2rH3FhmUoqsrqfycbLpiy07rNsqqLlQ8vGXAIYlPf6WI61kb2
  9G9LMDRnkHYxEQjl0uyTxvckTmLcdxRYGrCoxxMURGErV5Tdeh4Eo6UecfsJ2SnVQb6OktBQ23
  6Oxm8WESTHwmYpAAZUM1ol6hriTC0Wcsza59TNWN34MG2oLhR2k/iclGZx8xfbXHElOQ+alCPV
  /QFrKCDOjfKrqtedXdp/VVG5YBF5sSatMbdCrMB9WGRdxqH5I28ofqzKF0Zrr/laHDKr1YcTfX
  syfkMWAwhVCi6uvkSxSLjud8IBvwBxIKJZDQdP8eUq9BVigw==
Date: Mon, 13 Apr 2026 12:07:22 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: dash@vger.kernel.org
Cc: =?utf-8?B?6YO96KeJ5b6X5bCx5Yiw5a62?= <996029583@qq.com>
Subject: Re: [v2 PATCH] arith: Fix CVE-2026-31323 INTMAX_MIN / -1
 overflow
Message-ID: <20260413100722.DTYX8ZTT@steffen%sdaoden.eu>
In-Reply-To: <adxUzanDodYsFi_M@gondor.apana.org.au>
References: <tencent_89DCD1FDB501CE100F1C73E55F82BA80B109@qq.com>
 <adxUzanDodYsFi_M@gondor.apana.org.au>
User-Agent: s-nail v14.10.0-alpha-3-g8d44b101e3
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Herbert Xu wrote in
 <adxUzanDodYsFi_M@gondor.apana.org.au>:
 |On Wed, Apr 08, 2026 at 04:47:10PM +0800, =E9=83=BD=E8=A7=89=E5=BE=97=E5=
=B0=B1=E5=88=B0=E5=AE=B6 wrote:
 |> Division and remainder currently guard against division by zero, but not
 |> against the signed overflow case INTMAX_MIN / -1. On affected systems
 |> this can trigger SIGFPE during arithmetic expansion.
 ...
 |Division and remainder currently guard against division by zero, but not
 |against the signed overflow case INTMAX_MIN / -1. On affected systems
 |this can trigger SIGFPE during arithmetic expansion.
 |
 |Add an explicit guard before evaluating division or remainder.
 ...
 |diff --git a/src/arith_yacc.c b/src/arith_yacc.c
 |index 1a087c3..b978ef0 100644
 |--- a/src/arith_yacc.c
 |+++ b/src/arith_yacc.c
 |@@ -98,8 +98,8 @@ static intmax_t do_binop(int op, intmax_t a, intmax_t b)
 |  default:
 |  case ARITH_REM:
 |  case ARITH_DIV:
 |-             if (!b)
 |-                     yyerror("division by zero");
 |+             if (!b || (a =3D=3D INTMAX_MIN && b =3D=3D -1))
 |+                     yyerror("division error");

Sorry for pissing around, but i said

  Btw for div/mod i would take note on

        /* For /,%, avoid lvh=3DS64_MIN, rhv=3D-1:
         * CHANGES, bash 4.3 [ac50fbac377e32b98d2de396f016ea81e8ee9961]:
         *   Fixed a bug that caused floating-point exceptions and
         *   overflow errors for the / and % arithmetic operators when
         *   using INTMAX_MIN and -1. */
  ...

in 20250731190752.qd9B7w_u@steffen%sdaoden.eu on 2025-07-31, just
to note it.
(Ok i read my "gah just cast and do it" for undefined
behaviour on left shifts that comes earlier with suspicion myself,
especially since i followed Harald van Dijk's excellent approach
on right shift plus now limit anything via &=3D63, after that
lengthy thread that saw me actually searching around hardware
descriptions, which got me .. i think two .. which really do not
mask down themselves.)

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
