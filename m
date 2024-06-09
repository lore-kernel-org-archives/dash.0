Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2418C3D
	for <dash@vger.kernel.org>; Sun,  9 Jun 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921132; cv=none; b=FfeysSI2m8vFzEKiIlxJyU50/yMEkQNHN8UI9NSfN9CC+sx+8rzIE3XXWzykgzp5bUKrz/9+xM26ItWVxqrRGizn1RqJWFeFuBiT4iUb3LERdJr+8AyGEk3t8nn+h8RLwiREhWnTKUjHaVzzkVNeU8lv01lqbw9mN73eEzxf1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921132; c=relaxed/simple;
	bh=BS3B8V4SeTQqpGhYONtMI5A7MR1b0MtazMz2/jsmiSI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jF1bdJIvC7FchFyNJyXO0reShIroRm+VAp/68ZnkAmW2bHAQUTomDLsU8TbjxAmei3SY770dsQ36hPLpwRA4EzvYiSQqWxJlRClYqVJh7lW5y09U1JNfEF1fYeGa3w7Q9OUvplbmM7wT2q6PgKjMMSKP6WgfOtOm8HInXntC0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sGDl7-007IK4-1N;
	Sun, 09 Jun 2024 16:18:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Jun 2024 16:18:40 +0800
Date: Sun, 9 Jun 2024 16:18:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] input: Fix pungetc on PEOF
Message-ID: <ZmVlYHu-Vs_srGX-@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Calling pungetc upon PEOF must cause the next pgetc call to return
PEOF.  This was broken by the multi-byte pungetc patch.  Fix it by
adding the EOF logic to pgetc.

Note that pungetn will always disregard the PEOF.

Fixes: 2c92409145d0 ("input: Allow MB_LEN_MAX calls to pungetc")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/input.c | 32 ++++++++++++++------------------
 src/input.h |  8 +++++---
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/src/input.c b/src/input.c
index 8f8c173..6388b83 100644
--- a/src/input.c
+++ b/src/input.c
@@ -224,15 +224,13 @@ static int __pgetc(void)
 	if (parsefile->unget) {
 		long unget = -(long)(unsigned)parsefile->unget--;
 
-		if (parsefile->nleft < 0)
-			return preadbuffer();
-
 		return parsefile->nextc[unget];
 	}
 
-	if (--parsefile->nleft >= 0)
+	if (parsefile->nleft > 0) {
+		parsefile->nleft--;
 		c = (signed char)*parsefile->nextc++;
-	else
+	} else
 		c = preadbuffer();
 
 	return c;
@@ -372,8 +370,11 @@ static int preadbuffer(void)
 		popstring();
 		return __pgetc();
 	}
-	if (parsefile->buf == NULL)
+	if (parsefile->eof & 2) {
+eof:
+		parsefile->eof = 3;
 		return PEOF;
+	}
 	flushall();
 
 	q = parsefile->nextc;
@@ -394,7 +395,7 @@ again:
 			if (!IS_DEFINED_SMALL && nr > 0)
 				goto save;
 			INTON;
-			return PEOF;
+			goto eof;
 		}
 	}
 
@@ -477,7 +478,8 @@ void pungetn(int n)
 void
 pungetc(void)
 {
-	pungetn(1);
+	pungetn(1 - (parsefile->eof & 1));
+	parsefile->eof &= ~1;
 }
 
 /*
@@ -575,8 +577,6 @@ setinputfd(int fd, int push)
 		toppf = parsefile;
 	parsefile->fd = fd;
 	parsefile->nextc = parsefile->buf = ckmalloc(IBUFSIZ);
-	input_set_lleft(parsefile, parsefile->nleft = 0);
-	plinno = 1;
 }
 
 
@@ -591,8 +591,7 @@ setinputstring(char *string)
 	pushfile();
 	parsefile->nextc = string;
 	parsefile->nleft = strlen(string);
-	parsefile->buf = NULL;
-	plinno = 1;
+	parsefile->eof = 2;
 	INTON;
 }
 
@@ -609,12 +608,10 @@ pushfile(void)
 	struct parsefile *pf;
 
 	pf = (struct parsefile *)ckmalloc(sizeof (struct parsefile));
+	memset(pf, 0, sizeof(*pf));
 	pf->prev = parsefile;
+	pf->linno = 1;
 	pf->fd = -1;
-	pf->strpush = NULL;
-	pf->spfree = NULL;
-	pf->basestrpush.prev = NULL;
-	pf->unget = 0;
 	parsefile = pf;
 }
 
@@ -639,8 +636,7 @@ popfile(void)
 
 	if (pf->fd >= 0)
 		close(pf->fd);
-	if (pf->buf)
-		ckfree(pf->buf);
+	ckfree(pf->buf);
 	if (parsefile->spfree)
 		freestrings(parsefile->spfree);
 	while (pf->strpush) {
diff --git a/src/input.h b/src/input.h
index af1c1be..706ac73 100644
--- a/src/input.h
+++ b/src/input.h
@@ -79,9 +79,7 @@ struct parsefile {
 	int linno;		/* current line */
 	int fd;			/* file descriptor (or -1 if string) */
 	int nleft;		/* number of chars left in this line */
-#ifndef SMALL
-	int lleft;		/* number of chars left in this buffer */
-#endif
+	int eof;		/* do not read again once we hit EOF */
 	char *nextc;		/* next char in buffer */
 	char *buf;		/* input buffer */
 	struct strpush *strpush; /* for pushing strings at this level */
@@ -90,6 +88,10 @@ struct parsefile {
 	/* Delay freeing so we can stop nested aliases. */
 	struct strpush *spfree;
 
+#ifndef SMALL
+	int lleft;		/* number of chars left in this buffer */
+#endif
+
 	/* Number of outstanding calls to pungetc. */
 	int unget;
 };
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
