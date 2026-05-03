Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085238B7C9
	for <dash@vger.kernel.org>; Sun,  3 May 2026 04:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777782652; cv=none; b=u2QTl0K124UhmB7/Sk6PTz8p5amuuL4nnd7mVPRO7MU0fLPUv8ok+p7Th2S50v0P0WSNIX8AzaRp8JChn2DZl/H3cWx6Cv5gLJyce7LtKgA8Rypqw5/bMza7ZWcgtmyGu9kFOWqo7MIynhfna7RhrSyx0StM/QHKlmoY3V4OG1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777782652; c=relaxed/simple;
	bh=6aRJWy7nI9xPKag9Ps1t8C5V1/M2Lkk2xP7pCKN06NE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RNgrf2yGwbyTD3XR5tHx34nTOosBahQoqumg3hjrF7hB9M9BmuyvaPtGobQN62ClrLRWOhv8+AJQZW6G+tPu6B9uzjz3SzRIrUdVA7tXObUhRnXB95W2QHW4TGEq4vpAKzamcLBqW7OyfHfRMFVfTKchv5+Ou4MKUUSg1CbjHrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=rlBjMkJH; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="rlBjMkJH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=gt+f148TK7m8GIioC7zxhOfz0eFBhk7i9O24xTQ8DQI=; b=rlBjM
	kJH+KDGmDeotvifs57M+lQQD0eVkAT2UWKvAm1ZBYqL4ttpubi+N698Bi/TVupGsJuaghqcvTNVRz
	0mjtZ3M4zXpJekWJcnbS4Svwte79ijbRKDwQvwD7tT9qs++Y9Av7gsiaARLb5h2xtzPND3F2fmeIJ
	6rG03NL56AXjAscSqT8bKM+JdiSMB9PKl1AtOvWoBxcigCYoDnQNOzCsZFedQaH64X8i0/U+dt7ar
	EcHqW1SUVh0nBkITx/GKGXK/NRF/ARpWGfwbVtxSmZtMBEJmJ3Nv2HM8SPv4hrLnRQWmCqKqCf8g+
	JQWfaxChKTxGU6eYGaV1VaCl4qulA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wJOTc-00AmaC-1i;
	Sun, 03 May 2026 12:30:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 03 May 2026 12:30:44 +0800
Date: Sun, 3 May 2026 12:30:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] input: Replace stdin_state.canon with bufferable
Message-ID: <afbPdNt3CTnCJrdi@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The field canon is never used except to check whether the fd 0
is bufferable.  Replace it with a bufferable flag instead.

Also move the termios struct onto the stack since it's never used
again after retrieving the canon field.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 591f28a..0fb2f18 100644
--- a/src/input.c
+++ b/src/input.c
@@ -64,11 +64,10 @@
 
 MKINIT
 struct stdin_state {
-	tcflag_t canon;
 	off_t seekable;
-	struct termios tios;
 	int pip[2];
 	int pending;
+	tcflag_t bufferable;
 };
 
 MKINIT struct parsefile basepf;	/* top level input file */
@@ -133,12 +132,17 @@ POSTEXITRESET {
 void input_init(void)
 {
 	struct stdin_state *st = &stdin_state;
+	struct termios tios;
 	int istty;
 
-	istty = tcgetattr(0, &st->tios) + 1;
-	st->seekable = istty ? 0 : lseek(0, 0, SEEK_CUR) + 1;
-	st->canon = istty ? st->tios.c_lflag & ICANON : 0;
+	istty = tcgetattr(0, &tios) + 1;
 	stdin_istty = istty;
+	if (istty)
+		st->bufferable = tios.c_lflag & ICANON;
+	else {
+		st->seekable = lseek(0, 0, SEEK_CUR) + 1;
+		st->bufferable = !!st->seekable;
+	}
 }
 
 static bool stdin_bufferable(void)
@@ -148,7 +152,7 @@ static bool stdin_bufferable(void)
 	if (stdin_istty < 0)
 		input_init();
 
-	return st->canon || st->seekable;
+	return st->bufferable;
 }
 
 static void flush_tee(void *buf, int nr, int pending)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
