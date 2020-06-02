From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] expand: Make glob(3) interruptible by SIGINT
Date: Tue, 2 Jun 2020 21:51:15 +1000
Message-ID: <20200602115115.GA6951@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:56308 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgFBLvT (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:19 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

If glob(3) is used then it can't be interrupted by SIGINT.  This
is bad when an expansion causes a large number of entries to be
generated.  This patch improves things by adding an int_pending
check to gl_opendir call.  Note that this is still not perfect,
e.g., the sort would still be uninterruptible.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/configure.ac b/configure.ac
index ce5feec..955e2bb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -151,6 +151,13 @@ AC_CHECK_FUNC(stat64,, [
 		  [64-bit operations are the same as 32-bit])
 ])
 
+AC_CHECK_FUNC(glob64,, [
+	AC_DEFINE(glob64_t, glob_t, [64-bit operations are the same as 32-bit])
+	AC_DEFINE(glob64, glob, [64-bit operations are the same as 32-bit])
+	AC_DEFINE(globfree64, globfree,
+		  [64-bit operations are the same as 32-bit])
+])
+
 dnl OS X apparently has stat64 but not open64.
 AC_CHECK_FUNC(open64,, [
 	AC_DEFINE(open64, open, [64-bit operations are the same as 32-bit])
diff --git a/src/expand.c b/src/expand.c
index 1730670..aea5cc4 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -120,7 +120,7 @@ static size_t memtodest(const char *p, size_t len, int flags);
 STATIC ssize_t varvalue(char *, int, int, int);
 STATIC void expandmeta(struct strlist *);
 #ifdef HAVE_GLOB
-STATIC void addglob(const glob_t *);
+static void addglob(const glob64_t *);
 #else
 STATIC void expmeta(char *, unsigned, unsigned);
 STATIC struct strlist *expsort(struct strlist *);
@@ -1154,6 +1154,20 @@ out:
  */
 
 #ifdef HAVE_GLOB
+#ifdef __GLIBC__
+void *opendir_interruptible(const char *pathname)
+{
+	if (int_pending()) {
+		suppressint = 0;
+		onint();
+	}
+
+	return opendir(pathname);
+}
+#else
+#define GLOB_ALTDIRFUNC 0
+#endif
+
 STATIC void
 expandmeta(struct strlist *str)
 {
@@ -1161,14 +1175,23 @@ expandmeta(struct strlist *str)
 
 	while (str) {
 		const char *p;
-		glob_t pglob;
+		glob64_t pglob;
 		int i;
 
 		if (fflag)
 			goto nometa;
+
+#ifdef __GLIBC__
+		pglob.gl_closedir = (void *)closedir;
+		pglob.gl_readdir = (void *)readdir64;
+		pglob.gl_opendir = opendir_interruptible;
+		pglob.gl_lstat = lstat64;
+		pglob.gl_stat = stat64;
+#endif
+
 		INTOFF;
 		p = preglob(str->text, RMESCAPE_ALLOC | RMESCAPE_HEAP);
-		i = glob(p, GLOB_NOMAGIC, 0, &pglob);
+		i = glob64(p, GLOB_ALTDIRFUNC | GLOB_NOMAGIC, 0, &pglob);
 		if (p != str->text)
 			ckfree(p);
 		switch (i) {
@@ -1177,12 +1200,12 @@ expandmeta(struct strlist *str)
 			    (GLOB_NOMAGIC | GLOB_NOCHECK))
 				goto nometa2;
 			addglob(&pglob);
-			globfree(&pglob);
+			globfree64(&pglob);
 			INTON;
 			break;
 		case GLOB_NOMATCH:
 nometa2:
-			globfree(&pglob);
+			globfree64(&pglob);
 			INTON;
 nometa:
 			*exparg.lastp = str;
@@ -1201,9 +1224,7 @@ nometa:
  * Add the result of glob(3) to the list.
  */
 
-STATIC void
-addglob(pglob)
-	const glob_t *pglob;
+static void addglob(const glob64_t *pglob)
 {
 	char **p = pglob->gl_pathv;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
