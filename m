Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B0635
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753989472; cv=none; b=nJoxRm9stH2Fo4fnjUuFPRuER5kiJv06ui/S/zINTNpC0hgtecKcqdGqZ21ILefJts9DLUbzevhOC2Mx3ULBUhkLSdzUReWFe1csCqZ57ExFxyxhs083/F37sZSvLvqVQ9GoVCDNOyK7ZfFFKjLB1E1BwhC0Q1s3MEtxJ9QrBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753989472; c=relaxed/simple;
	bh=dvanVbXmcvDWoyNpYzwbmp2gYM49fHcxLrAAW/JFCZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=pWm26/UjIVAUTYXgqOgqs4l/PAH7qvwRTXAdl/K/o/FdFfqOnEC6Q5Av3Ys7Qpc7tzndC7p9lhwLv+uELci1hwYLwmT3gnhHB0Yjh6QAnCY5fxCrwj1QK/qigKWw3aSBOwyEjNw4RHhzC3OWcBHV2HRd/hLNyrg1auE+O2CJ2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=YWrGF8Kj; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="YWrGF8Kj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1753988873; x=1754655539; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=rnXAVexONbx7tFwD/PHM5o+mmtamsba5k/tULbbkAz0=;
 b=YWrGF8KjcmV1K8SKwoQfxs4XwuDqFNIi60S76esuVQplDsaOuswrJvqfxNFLcJwRRlI6uZGJ
  UGSW7sWgGzqu/84+vhmfHu9By2AXXoz2Oh5r/V13BkpSJNYdwrgON6/SXV0dsx2VtoC73R16EY
  HjamC7cOSC+TixUXC4rpYDhfsuBtuy1Khn2NDRxYCFQyO6/A2GFKhjtqEHb9UulvNb0AqsxCkL
  WcS84xvcIh1ewQIoJOdihQmQwAKcEimvWiqMbbUKuQim/5m48y8VwX5GuZwjvZk77n7UXMNMq+
  aHDdmCFtZmy6ZUhUxud8oKLMFt/kfWW++0Ds6nv15k0qP2sw==
Date: Thu, 31 Jul 2025 21:07:52 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Aleksander Ushakov <aushakov@astralinux.ru>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Message-ID: <20250731190752.qd9B7w_u@steffen%sdaoden.eu>
In-Reply-To: <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
User-Agent: s-nail v14.9.25-685-gb8145b40c4
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Aleksander Ushakov wrote in
 <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>:
 ..
 |> SUMMARY: UndefinedBehaviorSanitizer: invalid-shift-base arith_yacc.c:111\
 |> :12
 |> Aborted (core dumped)
 ...
 |> echo -ne '$((0|~0<<(0)))' | ./dash
 |
 |There is a fix of the problem:
 |
 |diff --git a/src/arith_yacc.c b/src/arith_yacc.c
 |index 1a087c3..e23060d 100644
 |--- a/src/arith_yacc.c
 |+++ b/src/arith_yacc.c
 |@@ -108,7 +108,9 @@ static intmax_t do_binop(int op, intmax_t a, intmax_t \
 |b)
 |         case ARITH_SUB:
 |                 return a - b;
 |         case ARITH_LSHIFT:
 |-               return a << b;
 |+               if (a < 0)
 |+                       yyerror("left shift of negative value");

imho -- gah, just cast and do it!?!

 |+               return (intmax_t)a << b;
 |         case ARITH_RSHIFT:
 |                 return a >> b;
 |         case ARITH_LT:
 |
 |Same case is placed in DIV branch (when divide on zero). I think it is 
 |analogue.

Btw for div/mod i would take note on

        /* For /,%, avoid lvh=S64_MIN, rhv=-1:
         * CHANGES, bash 4.3 [ac50fbac377e32b98d2de396f016ea81e8ee9961]:
         *   Fixed a bug that caused floating-point exceptions and
         *   overflow errors for the / and % arithmetic operators when
         *   using INTMAX_MIN and -1. */

Aka i have DIV/MOD:

          if(rval == 0){
                  self->sac_error = a_SHEXP_ARITH_ERR_DIV_BY_ZERO;
                  goto jleave;
          }else if(val != S64_MIN || rval != -1)
                  val /= rval;
...
          if(rval == 0){
                  self->sac_error = a_SHEXP_ARITH_ERR_DIV_BY_ZERO;
                  goto jleave;
          }else if(val == S64_MIN && rval == -1)
                  val = 0;
          else
                  val %= rval;
          break;

 --End of <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>

Greetings and Ciao from, ..sorry.., Germany,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
|
|During summer's humble, here's David Leonard's grumble
|
|The black bear,          The black bear,
|blithely holds his own   holds himself at leisure
|beating it, up and down  tossing over his ups and downs with pleasure
|
|Farewell, dear collar bear
