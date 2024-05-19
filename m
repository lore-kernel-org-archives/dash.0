Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949D9450
	for <dash@vger.kernel.org>; Sun, 19 May 2024 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716092821; cv=none; b=qAUQOlVlHbIVslk4YrU/7jrvV1O8tmx/AzD4oeJQ9/sako/KQuL1pmFAQBlDoKazGU/3K96Psl4CPNDAj2SrGqNm8FLNdMyh2W4BaanqcQT1JwXrNtpj+hqZ/E/LTFsGTCz1ov05q8uYiY+FVl6byCApYiaVnlhcdoi1JHAaoKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716092821; c=relaxed/simple;
	bh=n8YJXh9Dc7jxZrZ543pt8OjNtyKNxRJAApyGeGuYNgk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J3mPZuqqUw5C8hyNT/n3DJoidsaX50eX+yvXPncTTV22+IrpgmXVYwQ6uARGkDeFDSy3MQmbvSXp1fbCLdAB/nlibb2NBTgl/TMID3HDWAGvZpYO19yVVFGMD9DCuZPEfWwEw+E9/eBbyHIeGizBZVYLLAmdjuG491CvG8o2bOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Y8L-00HFgP-2J;
	Sun, 19 May 2024 12:26:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 12:26:55 +0800
Date: Sun, 19 May 2024 12:26:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] expand: Always compile test fnmatch and glob
Message-ID: <Zkl_j0SD3cyagtqB@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Always compile test code paths with and without fnmatch and glob by
avoiding the use of ifdefs.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c   | 28 +++++++-----------------
 src/mystring.h |  6 ++++++
 src/system.h   | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 0db2b29..399a9e6 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -119,20 +119,13 @@ static size_t strtodest(const char *p, int flags);
 static size_t memtodest(const char *p, size_t len, int flags);
 STATIC ssize_t varvalue(char *, int, int, int);
 STATIC void expandmeta(struct strlist *);
-#ifdef HAVE_GLOB
 static void addglob(const glob64_t *);
-#else
 STATIC void expmeta(char *, unsigned, unsigned);
 STATIC struct strlist *expsort(struct strlist *);
 STATIC struct strlist *msort(struct strlist *, int);
-#endif
 STATIC void addfname(char *);
 STATIC int patmatch(char *, const char *);
-#ifndef HAVE_FNMATCH
 STATIC int pmatch(const char *, const char *);
-#else
-#define pmatch(a, b) !fnmatch((a), (b), 0)
-#endif
 static size_t cvtnum(intmax_t num, int flags);
 STATIC size_t esclen(const char *, const char *);
 STATIC void varunset(const char *, const char *, const char *, int)
@@ -1156,9 +1149,8 @@ out:
  * should be escapes.  The results are stored in the list exparg.
  */
 
-#ifdef HAVE_GLOB
 #ifdef __GLIBC__
-void *opendir_interruptible(const char *pathname)
+static void *opendir_interruptible(const char *pathname)
 {
 	if (int_pending()) {
 		suppressint = 0;
@@ -1171,11 +1163,8 @@ void *opendir_interruptible(const char *pathname)
 #define GLOB_ALTDIRFUNC 0
 #endif
 
-STATIC void
-expandmeta(struct strlist *str)
+static void expandmeta_glob(struct strlist *str)
 {
-	/* TODO - EXP_REDIR */
-
 	while (str) {
 		const char *p;
 		glob64_t pglob;
@@ -1236,8 +1225,6 @@ static void addglob(const glob64_t *pglob)
 	} while (*++p);
 }
 
-
-#else	/* HAVE_GLOB */
 STATIC char *expdir;
 STATIC unsigned expdir_max;
 
@@ -1250,6 +1237,9 @@ expandmeta(struct strlist *str)
 	};
 	/* TODO - EXP_REDIR */
 
+	if (GLOB_IS_ENABLED)
+		return expandmeta_glob(str);
+
 	while (str) {
 		struct strlist **savelastp;
 		struct strlist *sp;
@@ -1416,7 +1406,6 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 	if (! atend)
 		endname[-esc - 1] = esc ? '\\' : '/';
 }
-#endif	/* HAVE_GLOB */
 
 
 /*
@@ -1435,7 +1424,6 @@ addfname(char *name)
 }
 
 
-#ifndef HAVE_GLOB
 /*
  * Sort the results of file name expansion.  It calculates the number of
  * strings to sort and then calls msort (short for merge sort) to do the
@@ -1494,7 +1482,6 @@ msort(struct strlist *list, int len)
 	}
 	return list;
 }
-#endif
 
 
 /*
@@ -1510,7 +1497,6 @@ patmatch(char *pattern, const char *string)
 }
 
 
-#ifndef HAVE_FNMATCH
 STATIC int ccmatch(const char *p, int chr, const char **r)
 {
 	static const struct class {
@@ -1553,6 +1539,9 @@ pmatch(const char *pattern, const char *string)
 	const char *p, *q;
 	char c;
 
+	if (FNMATCH_IS_ENABLED)
+		return !fnmatch(pattern, string, 0);
+
 	p = pattern;
 	q = string;
 	for (;;) {
@@ -1644,7 +1633,6 @@ breakloop:
 		return 0;
 	return 1;
 }
-#endif
 
 
 
diff --git a/src/mystring.h b/src/mystring.h
index d0ec9dd..07d0c73 100644
--- a/src/mystring.h
+++ b/src/mystring.h
@@ -39,8 +39,14 @@
 
 #ifdef HAVE_FNMATCH
 #define FNMATCH_IS_ENABLED 1
+#ifdef HAVE_GLOB
+#define GLOB_IS_ENABLED 1
+#else
+#define GLOB_IS_ENABLED 0
+#endif
 #else
 #define FNMATCH_IS_ENABLED 0
+#define GLOB_IS_ENABLED 0
 #endif
 
 extern const char snlfmt[];
diff --git a/src/system.h b/src/system.h
index 371c64b..6b31d52 100644
--- a/src/system.h
+++ b/src/system.h
@@ -118,6 +118,64 @@ long sysconf(int) __attribute__((__noreturn__));
 int isblank(int c);
 #endif
 
+#ifndef HAVE_FNMATCH
+static inline int fnmatch(const char *pattern, const char *string, int flags)
+{
+	return -1;
+}
+#endif
+
+#ifndef HAVE_GLOB
+#define GLOB_ERR	(1 << 0)/* Return on read errors.  */
+#define GLOB_MARK	(1 << 1)/* Append a slash to each name.  */
+#define GLOB_NOSORT	(1 << 2)/* Don't sort the names.  */
+#define GLOB_DOOFFS	(1 << 3)/* Insert PGLOB->gl_offs NULLs.  */
+#define GLOB_NOCHECK	(1 << 4)/* If nothing matches, return the pattern.  */
+#define GLOB_APPEND	(1 << 5)/* Append to results of a previous call.  */
+#define GLOB_NOESCAPE	(1 << 6)/* Backslashes don't quote metacharacters.  */
+#define GLOB_PERIOD	(1 << 7)/* Leading `.' can be matched by metachars.  */
+#define GLOB_MAGCHAR	(1 << 8)/* Set in gl_flags if any metachars seen.  */
+#define GLOB_ALTDIRFUNC (1 << 9)/* Use gl_opendir et al functions.  */
+#define GLOB_BRACE	(1 << 10)/* Expand "{a,b}" to "a" "b".  */
+#define GLOB_NOMAGIC	(1 << 11)/* If no magic chars, return the pattern.  */
+#define GLOB_TILDE	(1 << 12)/* Expand ~user and ~ to home directories. */
+#define GLOB_ONLYDIR	(1 << 13)/* Match only directories.  */
+#define GLOB_TILDE_CHECK (1 << 14)/* Like GLOB_TILDE but return an error
+				     if the user name is not available.  */
+
+#define GLOB_NOSPACE	1	/* Ran out of memory.  */
+#define GLOB_ABORTED	2	/* Read error.  */
+#define GLOB_NOMATCH	3	/* No matches found.  */
+#define GLOB_NOSYS	4	/* Not implemented.  */
+
+struct dirent64;
+struct stat64;
+
+typedef struct {
+	size_t gl_pathc;
+	char **gl_pathv;
+	size_t gl_offs;
+	int gl_flags;
+
+	void (*gl_closedir)(void *);
+	struct dirent64 *(*gl_readdir)(void *);
+	void *(*gl_opendir)(const char *);
+	int (*gl_lstat)(const char *, struct stat64 *);
+	int (*gl_stat)(const char *, struct stat64 *);
+} glob64_t;
+
+static inline int glob64(const char *pattern, int flags,
+			 int (*errfunc)(const char *epath, int eerrno),
+			 glob64_t *restrict pglob)
+{
+	return -1;
+}
+
+static inline void globfree64(glob64_t *pglob)
+{
+}
+#endif
+
 /*
  * A trick to suppress uninitialized variable warning without generating any
  * code
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
