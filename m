Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA89567F
	for <dash@vger.kernel.org>; Sun,  5 May 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714900527; cv=none; b=QUCC6678F0HSDtdRERFIATnyYZbEMcQUegNraoetgUO46DjcpRX3NjRZCblgHI7tT76XnW3u4LB2eTFx1TvTp+dEjS5WEGZobFYwwFEOgsREy2m9xHqpTFO16aZ9mQNpJhfWYJfeSl74tBJItPPD8NDNAtRqRJoCjLQmVgytga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714900527; c=relaxed/simple;
	bh=5R8h8+ULyTNzfFyzruhP+HZUtKmFtp8dJvKJxrOW9h8=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=pQxPj1zwcqCuGTIN07iwLXpCDHO3UlY9KiDgauLgmmMYOWB6a+a193PX7KYXqQQ/wuMACaAsbQfbMRwAZZyTfblqAP94mFgUemBl5aUie3T6EexK9xh2LjtArs3Dyvk7+Yw+ziIkKtJxlkdc7k48wASIahgUNXm2sdwGUmheawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s3Xxp-00AabI-2t;
	Sun, 05 May 2024 17:15:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 May 2024 17:15:22 +0800
Date: Sun, 05 May 2024 17:15:22 +0800
Message-Id: <2c7cd8666ab0880f282e1259ee74adb43754285a.1714900377.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714900377.git.herbert@gondor.apana.org.au>
References: <cover.1714900377.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 11/13] memalloc: Use void * instead of pointer
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Use void * instead of the obsolete pointer typedef.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/memalloc.c | 16 ++++++----------
 src/memalloc.h | 10 +++++-----
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/src/memalloc.c b/src/memalloc.c
index 60637da..7aa8c58 100644
--- a/src/memalloc.c
+++ b/src/memalloc.c
@@ -47,10 +47,9 @@
  * Like malloc, but returns an error when out of space.
  */
 
-pointer
-ckmalloc(size_t nbytes)
+void *ckmalloc(size_t nbytes)
 {
-	pointer p;
+	void *p;
 
 	p = malloc(nbytes);
 	if (p == NULL)
@@ -63,8 +62,7 @@ ckmalloc(size_t nbytes)
  * Same for realloc.
  */
 
-pointer
-ckrealloc(pointer p, size_t nbytes)
+void *ckrealloc(void *p, size_t nbytes)
 {
 	p = realloc(p, nbytes);
 	if (p == NULL)
@@ -110,8 +108,7 @@ char *stacknxt = stackbase.space;
 size_t stacknleft = MINSIZE;
 char *sstrend = stackbase.space + MINSIZE;
 
-pointer
-stalloc(size_t nbytes)
+void *stalloc(size_t nbytes)
 {
 	char *p;
 	size_t aligned;
@@ -144,8 +141,7 @@ stalloc(size_t nbytes)
 }
 
 
-void
-stunalloc(pointer p)
+void stunalloc(void *p)
 {
 #ifdef DEBUG
 	if (!p || (stacknxt < (char *)p) || ((char *)p < stackp->space)) {
@@ -221,7 +217,7 @@ static void growstackblock(size_t min)
 		sp = stackp;
 		prevstackp = sp->prev;
 		grosslen = newlen + sizeof(struct stack_block) - MINSIZE;
-		sp = ckrealloc((pointer)sp, grosslen);
+		sp = ckrealloc(sp, grosslen);
 		sp->prev = prevstackp;
 		stackp = sp;
 		stacknxt = sp->space;
diff --git a/src/memalloc.h b/src/memalloc.h
index b9adf76..a7f7996 100644
--- a/src/memalloc.h
+++ b/src/memalloc.h
@@ -48,11 +48,11 @@ extern char *stacknxt;
 extern size_t stacknleft;
 extern char *sstrend;
 
-pointer ckmalloc(size_t);
-pointer ckrealloc(pointer, size_t);
+void *ckmalloc(size_t);
+void *ckrealloc(void *, size_t);
 char *savestr(const char *);
-pointer stalloc(size_t);
-void stunalloc(pointer);
+void *stalloc(size_t);
+void stunalloc(void *);
 void pushstackmark(struct stackmark *mark, size_t len);
 void setstackmark(struct stackmark *);
 void popstackmark(struct stackmark *);
@@ -98,4 +98,4 @@ static inline char *_STPUTC(int c, char *p) {
 #define ungrabstackstr(s, p) stunalloc((s))
 #define stackstrend() ((void *)sstrend)
 
-#define ckfree(p)	free((pointer)(p))
+#define ckfree(p)	free((void *)(p))
-- 
2.39.2

