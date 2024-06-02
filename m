Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576AEBE
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291746; cv=none; b=TjCPZYRe/U1zrlSGv/blhmRm7YthnfT/TrgQBbst98HtJy9pSaqrTBNM7/zGPQtj6UnBwFmKMDMq+XcghYv4ozF7jIFbAL8jM6np3b++mh4UOcjnNb2KcQdUqajkVzf+AVH/gm0KPAeMvKZA4GpuEvieaZmgtssWkRUnl2wMQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291746; c=relaxed/simple;
	bh=e6fMkV1KzRDWE3ia5oUDlujL69MRfZXpp5nblpvJEtA=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=kJOWeI2kJatA+pw2NAuW5hHlq7t4HG8Sg7UwnUtH2yisl1kAdb+tOrVOPdLgLV0bYnI2c+oQyiYpOk/esOCJ29ffeZAIfpOWSIpMYLoESbXQr8nK/mZ1I6ukG5KT0/AVnPPOK3fiwNIpzIHPeN7uQHsYCNqNti4nBssGm6lu59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa1r-004iSo-2J;
	Sun, 02 Jun 2024 09:29:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:29:01 +0800
Date: Sun, 02 Jun 2024 09:29:01 +0800
Message-Id: <c9f7abd8a02b06bab2493e38ba930c3feaa8b890.1717291579.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1717291579.git.herbert@gondor.apana.org.au>
References: <cover.1717291579.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 08/13] input: Allow MB_LEN_MAX calls to pungetc
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

In order to parse multi-byte characters which may be up to MB_LEN_MAX
bytes long, allow enough calls to pungetc to undo a single multi-byte
character.

Also add a function pungetn to do multiple pungetc calls in a row.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/input.c | 58 ++++++++++++++++++++++++++++++++++-------------------
 src/input.h | 11 +++++-----
 2 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/src/input.c b/src/input.c
index 1c598b2..e17e067 100644
--- a/src/input.c
+++ b/src/input.c
@@ -56,7 +56,7 @@
 #include "main.h"
 #include "myhistedit.h"
 
-#define IBUFSIZ (BUFSIZ + 1)
+#define IBUFSIZ (BUFSIZ + PUNGETC_MAX + 1)
 
 
 MKINIT struct parsefile basepf;	/* top level input file */
@@ -83,13 +83,16 @@ INIT {
 }
 
 RESET {
+	int c;
+
 	/* clear input buffer */
 	popallfiles();
-	basepf.unget = 0;
-	while (basepf.lastc[0] != '\n' &&
-	       basepf.lastc[0] != PEOF &&
-	       !int_pending())
-		pgetc();
+
+	c = PEOF;
+	if (basepf.nextc - basebuf > basepf.unget)
+		c = basepf.nextc[-basepf.unget - 1];
+	while (c != '\n' && c != PEOF && !int_pending())
+		c = pgetc();
 }
 
 FORKRESET {
@@ -131,17 +134,20 @@ static int __pgetc(void)
 {
 	int c;
 
-	if (parsefile->unget)
-		return parsefile->lastc[--parsefile->unget];
+	if (parsefile->unget) {
+		long unget = -(long)(unsigned)parsefile->unget--;
+
+		if (parsefile->nleft < 0)
+			return preadbuffer();
+
+		return parsefile->nextc[unget];
+	}
 
 	if (--parsefile->nleft >= 0)
 		c = (signed char)*parsefile->nextc++;
 	else
 		c = preadbuffer();
 
-	parsefile->lastc[1] = parsefile->lastc[0];
-	parsefile->lastc[0] = c;
-
 	return c;
 }
 
@@ -176,9 +182,16 @@ static int stdin_clear_nonblock(void)
 static int
 preadfd(void)
 {
+	char *buf = parsefile->buf;
+	int unget;
 	int nr;
-	char *buf =  parsefile->buf;
-	parsefile->nextc = buf;
+
+	unget = parsefile->nextc - buf;
+	if (unget > PUNGETC_MAX)
+		unget = PUNGETC_MAX;
+
+	memmove(buf, parsefile->nextc - unget, unget);
+	parsefile->nextc = buf += unget;
 
 retry:
 #ifndef SMALL
@@ -196,8 +209,8 @@ retry:
 			nr = 0;
 		else {
 			nr = el_len;
-			if (nr > IBUFSIZ - 1)
-				nr = IBUFSIZ - 1;
+			if (nr > BUFSIZ)
+				nr = BUFSIZ;
 			memcpy(buf, rl_cp, nr);
 			if (nr != el_len) {
 				el_len -= nr;
@@ -209,9 +222,9 @@ retry:
 	} else
 #endif
 	if (parsefile->fd)
-		nr = read(parsefile->fd, buf, IBUFSIZ - 1);
+		nr = read(parsefile->fd, buf, BUFSIZ);
 	else {
-		unsigned len = IBUFSIZ - 1;
+		unsigned len = BUFSIZ;
 
 		nr = 0;
 
@@ -348,6 +361,11 @@ done:
 	return (signed char)*parsefile->nextc++;
 }
 
+void pungetn(int n)
+{
+	parsefile->unget += n;
+}
+
 /*
  * Undo a call to pgetc.  Only two characters may be pushed back.
  * PEOF may be pushed back.
@@ -356,7 +374,7 @@ done:
 void
 pungetc(void)
 {
-	parsefile->unget++;
+	pungetn(1);
 }
 
 /*
@@ -383,7 +401,6 @@ pushstring(char *s, void *ap)
 	sp->prevnleft = parsefile->nleft;
 	sp->unget = parsefile->unget;
 	sp->spfree = parsefile->spfree;
-	memcpy(sp->lastc, parsefile->lastc, sizeof(sp->lastc));
 	sp->ap = (struct alias *)ap;
 	if (ap) {
 		((struct alias *)ap)->flag |= ALIASINUSE;
@@ -413,7 +430,6 @@ static void popstring(void)
 	parsefile->nextc = sp->prevstring;
 	parsefile->nleft = sp->prevnleft;
 	parsefile->unget = sp->unget;
-	memcpy(parsefile->lastc, sp->lastc, sizeof(sp->lastc));
 /*dprintf("*** calling popstring: restoring to '%s'\n", parsenextc);*/
 	parsefile->strpush = sp->prev;
 	parsefile->spfree = sp;
@@ -457,7 +473,7 @@ setinputfd(int fd, int push)
 	}
 	parsefile->fd = fd;
 	if (parsefile->buf == NULL)
-		parsefile->buf = ckmalloc(IBUFSIZ);
+		parsefile->nextc = parsefile->buf = ckmalloc(IBUFSIZ);
 	input_set_lleft(parsefile, parsefile->nleft = 0);
 	plinno = 1;
 }
diff --git a/src/input.h b/src/input.h
index 1ff5773..5b4a045 100644
--- a/src/input.h
+++ b/src/input.h
@@ -34,12 +34,16 @@
  *	@(#)input.h	8.2 (Berkeley) 5/4/95
  */
 
+#include <limits.h>
+
 #ifdef SMALL
 #define IS_DEFINED_SMALL 1
 #else
 #define IS_DEFINED_SMALL 0
 #endif
 
+#define PUNGETC_MAX (MB_LEN_MAX > 16 ? MB_LEN_MAX : 16)
+
 /* PEOF (the end of file marker) is defined in syntax.h */
 
 enum {
@@ -59,9 +63,6 @@ struct strpush {
 	/* Delay freeing so we can stop nested aliases. */
 	struct strpush *spfree;
 
-	/* Remember last two characters for pungetc. */
-	int lastc[2];
-
 	/* Number of outstanding calls to pungetc. */
 	int unget;
 };
@@ -87,9 +88,6 @@ struct parsefile {
 	/* Delay freeing so we can stop nested aliases. */
 	struct strpush *spfree;
 
-	/* Remember last two characters for pungetc. */
-	int lastc[2];
-
 	/* Number of outstanding calls to pungetc. */
 	int unget;
 };
@@ -106,6 +104,7 @@ extern struct parsefile *parsefile;
 int pgetc(void);
 int pgetc2(void);
 void pungetc(void);
+void pungetn(int);
 void pushstring(char *, void *);
 int setinputfile(const char *, int);
 void setinputstring(char *);
-- 
2.39.2

