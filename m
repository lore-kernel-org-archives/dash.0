Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D59637
	for <dash@vger.kernel.org>; Sat, 18 May 2024 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715993067; cv=none; b=cWYq0SFGoT+4EdooqJLG7RxKXRSb7jHw7bmHRYyLlrTLXt5FRMDkU7dyiOmLchHDA6wWvwEPBr8NbMwRKmj6lYqVr1gytM4T5Y06ShtqI7ORdVLnj7nxMQqkR4SMdXbrLW8ZdwtTuCA3PHFII+ml0ny0iJ+naQixpj9vAeqoPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715993067; c=relaxed/simple;
	bh=Z9DJwiUNv/ENN3Pzc/o56KknTZK54imxt5NBLSh3d8Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OfZXqHmNyKCtvvl1LqNKvGqPRiAUI38UuotYGBEfcBd7Ej1eXGKRzOUKyVCYJRSfoWzhekRMHb+FwUSq3yefVN9i82Mcsai2/1OdlWjV10ZvT0IFCoNJeQwwqVU9Uytk7mTV+E/T5s1KVamTK6fkihmvOML0R6eoO9CYyIQudOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s88BQ-00Gz0W-09;
	Sat, 18 May 2024 08:44:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 18 May 2024 08:44:21 +0800
Date: Sat, 18 May 2024 08:44:21 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] memalloc: Use void * instead of pointer
Message-ID: <Zkf55VZPwtlhGYDQ@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
