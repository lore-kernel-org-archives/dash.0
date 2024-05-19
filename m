Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316633D5
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096184; cv=none; b=N3UNWX8UBMHoCOGGU+zkBcm/EUuk3nSIcGo89+Yk3KKlcU3NoRYalFJ6Lnq5lQRAyh+G5RVX78lVs+p7By9kXHJ4kiLqVyggWrgtzDQ1MKxtbVVIAVJq3QPVlac9QSQnjp2pP57x+B82XWAsj0KR7CTIRlHBH6K1t4E5KXnD11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096184; c=relaxed/simple;
	bh=mBDOtTPhf7fEd0BmhtV5H0CoWd8o9TVHNaJ8pLRp7LM=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=SZnqUYxab/jUjhGUQyzYP4TMFKjNSiuooaWr+T3PkYIpUwAGj4VMjFoTtVpmCJJaBJ3MCg5JoE/KtK5FJ68OaZ4QIJFHpQbJL1CdtsOh7K67v31S8bK5znSg3WjWlrNtOtw7ZRhDXbQMEALocPFZnlP1YH8iQua1soRJER6EXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Z0c-00HGHy-0t;
	Sun, 19 May 2024 13:22:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:22:59 +0800
Date: Sun, 19 May 2024 13:22:59 +0800
Message-Id: <e96be2b4567329a33d3cfba784c3154da8528afb.1716096097.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1716096097.git.herbert@gondor.apana.org.au>
References: <cover.1716096097.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 1/3] input: Move newline loop into preadbuffer
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

As it stands preadfd tries to fetch a whole line when we're reading
one byte at a time.  However, this is wrong because how many bytes
we're trying to read has nothing to do with whether we get a whole
line or not.

Move the loop into preadbuffer alongside the other history support
code.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/input.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/src/input.c b/src/input.c
index 6779069..193235d 100644
--- a/src/input.c
+++ b/src/input.c
@@ -192,16 +192,27 @@ preadfd(void)
 {
 	char *buf = parsefile->buf;
 	int unget;
+	int pnr;
 	int nr;
 
+	nr = input_get_lleft(parsefile);
+
 	unget = parsefile->nextc - buf;
 	if (unget > PUNGETC_MAX)
 		unget = PUNGETC_MAX;
 
-	memmove(buf, parsefile->nextc - unget, unget);
-	parsefile->nextc = buf += unget;
+	memmove(buf, parsefile->nextc - unget, unget + nr);
+	buf += unget;
+	parsefile->nextc = buf;
+	buf += nr;
 
+	nr = BUFSIZ - nr;
+	if (!IS_DEFINED_SMALL && !nr)
+		return nr;
+
+	pnr = nr;
 retry:
+	nr = pnr;
 #ifndef SMALL
 	if (parsefile->fd == 0 && el) {
 		static const char *rl_cp;
@@ -216,9 +227,8 @@ retry:
 		if (rl_cp == NULL)
 			nr = 0;
 		else {
-			nr = el_len;
-			if (nr > BUFSIZ)
-				nr = BUFSIZ;
+			if (nr > el_len)
+				nr = el_len;
 			memcpy(buf, rl_cp, nr);
 			if (nr != el_len) {
 				el_len -= nr;
@@ -230,10 +240,8 @@ retry:
 	} else
 #endif
 	if (parsefile->fd)
-		nr = read(parsefile->fd, buf, BUFSIZ);
+		nr = read(parsefile->fd, buf, nr);
 	else {
-		unsigned len = BUFSIZ;
-
 		nr = 0;
 
 		do {
@@ -255,7 +263,7 @@ retry:
 			}
 
 			nr++;
-		} while (!IS_DEFINED_SMALL && *buf++ != '\n' && --len);
+		} while (0);
 	}
 
 	if (nr < 0) {
@@ -290,19 +298,26 @@ static int preadbuffer(void)
 		return PEOF;
 	flushall();
 
+	q = parsefile->nextc;
+	something = !first;
+
 	more = input_get_lleft(parsefile);
 	if (more <= 0) {
+		int nr;
+
 again:
-		if ((more = preadfd()) <= 0) {
+		nr = q - parsefile->nextc;
+		more = preadfd();
+		q = parsefile->nextc + nr;
+		if (more <= 0) {
 			input_set_lleft(parsefile, parsefile->nleft = 0);
+			if (!IS_DEFINED_SMALL && nr > 0)
+				goto save;
 			return PEOF;
 		}
 	}
 
-	q = parsefile->nextc;
-
 	/* delete nul characters */
-	something = !first;
 	for (;;) {
 		int c;
 
@@ -321,7 +336,6 @@ again:
 
 		switch (c) {
 		case '\n':
-			parsefile->nleft = q - parsefile->nextc - 1;
 			goto done;
 
 		default:
@@ -335,8 +349,7 @@ again:
 
 check:
 		if (more <= 0) {
-			parsefile->nleft = q - parsefile->nextc - 1;
-			if (parsefile->nleft < 0)
+			if (!IS_DEFINED_SMALL)
 				goto again;
 			break;
 		}
@@ -344,6 +357,8 @@ check:
 done:
 	input_set_lleft(parsefile, more);
 
+save:
+	parsefile->nleft = q - parsefile->nextc - 1;
 	if (!IS_DEFINED_SMALL)
 		savec = *q;
 	*q = '\0';
-- 
2.39.2

