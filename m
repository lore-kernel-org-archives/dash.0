Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21613E410
	for <dash@vger.kernel.org>; Thu, 11 Apr 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821577; cv=none; b=oc4mPfS2nXEbzoEvl4FENogpmAjj58HMYHQpA/+PeWNJZ0erSKHUXjtX+qkvvWPnPnycRj5GHeDnWk3KpfS46vJvnAh06vJ4L14JTQ4BNes8A0m/ommXsIP/o83WgbIvyk33bCzGH65fJqMYZSV979kBtnjKbX4sIzWgPPtwXQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821577; c=relaxed/simple;
	bh=p+ijQYwdnU/m1GL4KK4HxGA8VnoXW1GS1/lEF/tLV7s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mV1pevtSa7UOlsjPT1mXzH23TnxBpZglvRde5s8Awrd7L5wh+td67KLdQUCVpNhRsZR7x4zeXi2KgigA3xVN5OGFPydvLcB8oFdFgZCh6S1X+v8a1tXaI62FkbIRb1MWtAtC5nDSEw3NqjvwYtilstVJaChOiNrBEaYoGSPUq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rup8N-000G8u-2S; Thu, 11 Apr 2024 15:46:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Apr 2024 15:46:28 +0800
Date: Thu, 11 Apr 2024 15:46:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dash@vger.kernel.org
Subject: [PATCH] var: Remove unused VNOSET
Message-ID: <ZheVVMDfOsWg/Ihu@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The bit VNOSET is no longer used.  Remove it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/var.c b/src/var.c
index 6f85be3..895eabc 100644
--- a/src/var.c
+++ b/src/var.c
@@ -267,9 +267,6 @@ struct var *setvareq(char *s, int flags)
 				 n);
 		}
 
-		if (flags & VNOSET)
-			goto out;
-
 		if (vp->func && (flags & VNOFUNC) == 0)
 			(*vp->func)(varnull(s));
 
@@ -291,8 +288,6 @@ out_free:
 
 		flags |= vp->flags & bits;
 	} else {
-		if (flags & VNOSET)
-			goto out;
 		if ((flags & (VEXPORT|VREADONLY|VSTRFIXED|VUNSET)) == VUNSET)
 			goto out_free;
 		/* not found */
diff --git a/src/var.h b/src/var.h
index aa7575a..953a694 100644
--- a/src/var.h
+++ b/src/var.h
@@ -48,7 +48,7 @@
 #define VSTACK		0x10	/* text is allocated on the stack */
 #define VUNSET		0x20	/* the variable is not set */
 #define VNOFUNC		0x40	/* don't call the callback function */
-#define VNOSET		0x80	/* do not set variable - just readonly test */
+/* #define VNOSET	0x80	   do not set variable - just readonly test */
 #define VNOSAVE		0x100	/* when text is on the heap before setvareq */
 
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
