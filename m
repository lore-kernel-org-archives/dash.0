Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE6522F
	for <dash@vger.kernel.org>; Sun, 26 May 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716720137; cv=none; b=aIiuM48c3Nyl3TUjOwcxEMEYxUwym7x7p3sGxB1ky2KlEF3xGEMg5LSvFtcbcjfXRp23QTM9IvxiJuM7UZ4BsbRZpoJru7qEKWFl3qpmeciPKSz+b+1XPCP84VO7xqWa5X/Lqt5o5lwvixIbMMDbsL4sReRZdLP5KXqzS2xGIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716720137; c=relaxed/simple;
	bh=7nSvQoJtdfkGTUYfDSFR61/fu6FCGS9/pF1HUPmno3k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J0c/usIq+5LSzNIaMBshvbQum03yUaDWMRDk2wMgBa58sK/BnIhxA0Ssw/X6FBe0rpHqsrHKebCvAu3IsYQNHYO3Ppf5Mp5SJ0yjupgmsiz4XuNn9ejbWD2zyhp4cF4v9VW63LOeRiMfalVEIluc6k9R+1zdVY+SDcptritLx+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sBBKJ-002Dxv-07;
	Sun, 26 May 2024 18:42:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 26 May 2024 18:42:08 +0800
Date: Sun, 26 May 2024 18:42:08 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] memalloc: Force functions to be out-of-line
Message-ID: <ZlMSAJdFkyBx4ZUN@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Force gcc to build library functions out-of-line, even if they
happen to be in the same file.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/memalloc.c | 59 ++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/src/memalloc.c b/src/memalloc.c
index 7aa8c58..3275e51 100644
--- a/src/memalloc.c
+++ b/src/memalloc.c
@@ -43,18 +43,28 @@
 #include "mystring.h"
 #include "system.h"
 
+static __attribute__((__always_inline__)) inline void outofspace(void)
+{
+	sh_error("Out of space");
+}
+
+static void *checknull(void *p)
+{
+	if (!p)
+		outofspace();
+	return p;
+}
+
 /*
  * Like malloc, but returns an error when out of space.
  */
 
-void *ckmalloc(size_t nbytes)
+__attribute__((__noinline__)) void *ckmalloc(size_t nbytes)
 {
 	void *p;
 
 	p = malloc(nbytes);
-	if (p == NULL)
-		sh_error("Out of space");
-	return p;
+	return checknull(p);
 }
 
 
@@ -62,12 +72,10 @@ void *ckmalloc(size_t nbytes)
  * Same for realloc.
  */
 
-void *ckrealloc(void *p, size_t nbytes)
+__attribute__((__noinline__)) void *ckrealloc(void *p, size_t nbytes)
 {
 	p = realloc(p, nbytes);
-	if (p == NULL)
-		sh_error("Out of space");
-	return p;
+	return checknull(p);
 }
 
 
@@ -78,10 +86,7 @@ void *ckrealloc(void *p, size_t nbytes)
 char *
 savestr(const char *s)
 {
-	char *p = strdup(s);
-	if (!p)
-		sh_error("Out of space");
-	return p;
+	return checknull(strdup(s));
 }
 
 
@@ -124,7 +129,7 @@ void *stalloc(size_t nbytes)
 			blocksize = MINSIZE;
 		len = sizeof(struct stack_block) - MINSIZE + blocksize;
 		if (len < blocksize)
-			sh_error("Out of space");
+			outofspace();
 		INTOFF;
 		sp = ckmalloc(len);
 		sp->prev = stackp;
@@ -155,7 +160,8 @@ void stunalloc(void *p)
 
 
 
-void pushstackmark(struct stackmark *mark, size_t len)
+__attribute__((__noinline__)) void pushstackmark(struct stackmark *mark,
+						 size_t len)
 {
 	mark->stackp = stackp;
 	mark->stacknxt = stacknxt;
@@ -197,13 +203,14 @@ popstackmark(struct stackmark *mark)
  * part of the block that has been used.
  */
 
-static void growstackblock(size_t min)
+static char *growstackblock(size_t min)
 {
 	size_t newlen;
+	char *p;
 
 	newlen = stacknleft * 2;
 	if (newlen < stacknleft)
-		sh_error("Out of space");
+		outofspace();
 	min = SHELL_ALIGN(min | 128);
 	if (newlen < min)
 		newlen += min;
@@ -220,19 +227,22 @@ static void growstackblock(size_t min)
 		sp = ckrealloc(sp, grosslen);
 		sp->prev = prevstackp;
 		stackp = sp;
-		stacknxt = sp->space;
+		p = stacknxt = sp->space;
 		stacknleft = newlen;
 		sstrend = sp->space + newlen;
 		INTON;
 	} else {
 		char *oldspace = stacknxt;
 		int oldlen = stacknleft;
-		char *p = stalloc(newlen);
+
+		p = stalloc(newlen);
 
 		/* free the space we just allocated */
 		stacknxt = memcpy(p, oldspace, oldlen);
 		stacknleft += newlen;
 	}
+
+	return p;
 }
 
 /*
@@ -258,14 +268,13 @@ growstackstr(void)
 {
 	size_t len = stackblocksize();
 
-	growstackblock(0);
-	return stackblock() + len;
+	return growstackblock(0) + len;
 }
 
-char *growstackto(size_t len)
+__attribute__((__noinline__)) char *growstackto(size_t len)
 {
 	if (stackblocksize() < len)
-		growstackblock(len);
+		return growstackblock(len);
 	return stackblock();
 }
 
@@ -273,16 +282,14 @@ char *growstackto(size_t len)
  * Called from CHECKSTRSPACE.
  */
 
-char *
-makestrspace(size_t newlen, char *p)
+__attribute__((__noinline__)) char *makestrspace(size_t newlen, char *p)
 {
 	size_t len = p - stacknxt;
 
 	return growstackto(len + newlen) + len;
 }
 
-char *
-stnputs(const char *s, size_t n, char *p)
+__attribute__((__noinline__)) char *stnputs(const char *s, size_t n, char *p)
 {
 	p = makestrspace(n, p);
 	p = mempcpy(p, s, n);
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
