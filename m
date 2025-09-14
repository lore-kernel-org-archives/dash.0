Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0B22D4DC
	for <dash@vger.kernel.org>; Sun, 14 Sep 2025 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757813885; cv=none; b=EWcp5XOaEPNcKdjJ/z769WBmlgkev6SxP3c4COpR8KcGsmBBufI2r7YBnViA9Ki3VTJ+UEFEYvE+GSeO1Kf8hj9BRdCUohq5aQXNNbvS0pzDkA5SK6dPDs28TzTLD7kDturfBx+OP0yciqofjB8tIrxfCgycY0qetEMRMymuUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757813885; c=relaxed/simple;
	bh=6YIsBwkmS2cHvuZsIkjsoHRShxEaqBUslMHBkHNVGTY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KpNWbyUPhyE+bc2SKcqt793LDoJLG1ZCwnZZSJqRw5HC3mzE1p3vMXufB24uY0+/m+4Hg76bHIyOzIHTPRH2QV4AThmcbDrbEyhI4BoICApQclFbW7abea/RWcOLBRGLJe/gJ6V863QWa3jXfpkn+zMEtlCLHwf4CgVPMWpj2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=LTY8abDz; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="LTY8abDz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f8FSpgS5NV7fMNWugYLmZZoN27wp7xcHAB2E9WyK5gM=; b=LTY8abDzfviixubPeo8c+HdKRd
	G++qr6Tnwmr0Jy+moEvYTqPovtlRdaaR/wX/xt7U4QHRzwWa/zl31gbQdK+tFhUalAU7MDmSnaMAQ
	n7KtDnz0OrQVvEySirIhn+Wqk2dbhyuT97nTXcc/E8vlWe6+6GyZ7hDlXSH5dMsl49XR9CgxezVlb
	xm7C80RgU18EVI9+SJTS4IGjjsIWohngbBWyjYLLfHKr0QOHPoQRfWpUyOgCvQMOddNVuzLF5mbvN
	4umJj7OVHQ1rDjB8Fej1tK5/lAqRoI+I2ZwKg5dghPaAy2ZyakkZPCrXDso/TzPIHpI9wMfLdB0xz
	efP3nZQw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uxbRD-005FDz-0i;
	Sun, 14 Sep 2025 09:37:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 14 Sep 2025 09:37:51 +0800
Date: Sun, 14 Sep 2025 09:37:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?iso-8859-1?Q?Sz=E1sz?= Gergely <szaszg@hu.inter.net>
Cc: dash@vger.kernel.org
Subject: [PATCH] mystring: Ignore ERANGE errors in atomax
Message-ID: <aMYcb8Bd7BrZEMoR@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213160055.ymjwvpbwsgpvif3p@stanc>
X-Newsgroups: apana.lists.os.linux.dash

Szász Gergely <szaszg@hu.inter.net> wrote:
> Hello,
> 
> $ dash
> $ echo $((0x8000000000000000))
> 9223372036854775807
> $ printf %x\\n $((0x8000000000000000))
> 7fffffffffffffff
> $ printf "%x %x\n" $((0x8000000000000000)) $((0x8000000000000000-1))
> 7fffffffffffffff 7ffffffffffffffe
> $ echo $((-9223372036854775808))
> -9223372036854775807
> $ x=0x8000000000000000
> $ echo $((x))
> dash: 6: Illegal number: 0x8000000000000000
> $ exit

So the only inconsistency here is that $((x)) does a range check
while the others don't.  I looked into the history and the range
check came from the built-in test(1) utility.  In that case other
shells (ksh93) don't necessarily do a range check.

So I've decided to simply remove the range check for consistency.

---8<---
Remove ERANGE check in atomax for consistency as other direct calls
to strtoimax do not perform the range check.

Reported-by: Szász Gergely <szaszg@hu.inter.net>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/mystring.c b/src/mystring.c
index ca0cd39..97e240c 100644
--- a/src/mystring.c
+++ b/src/mystring.c
@@ -129,9 +129,6 @@ intmax_t atomax(const char *s, int base)
 	errno = 0;
 	r = strtoimax(s, &p, base);
 
-	if (errno == ERANGE)
-		badnum(s);
-
 	/*
 	 * Disallow completely blank strings in non-arithmetic (base != 0)
 	 * contexts.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
