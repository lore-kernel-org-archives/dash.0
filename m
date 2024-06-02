Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275353D76
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291970; cv=none; b=L2IsO0L6oq45eJso+/dETbpva/ZfTj5AZEGW6ChvcnAwAWwKX2YbcbB07flrl+2KmA2vJ2BFv5dbTSe7xxB/lYeAoWtOTofJUeaxAkw3x90dOoFQB8C1mxwl4MYyijN8VoJQzMDrKQ3o6NH4wIrjXZsiS1PEcYr7m0CMH124ZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291970; c=relaxed/simple;
	bh=LdUpywI/Lz2CPp/ReNClV6PdoCDm3jUET9v69M8v9f8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q59+oAiNXVGHa7wT0iIU0s9LsGCPXdQlEKqPJaOvjoVkYFVzx9pLvRKA97RpK8XT8NvpbfZ/Mhg6Syfayv625LXYXzXD9vEZVA5UrLHbDk9xv6otSyLSvry/7XMiBR8pX1cYkFkrQEQPrLMx43Mn2GMOMB8jxYK/4xPYxJL4Oo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa5U-004ibu-16;
	Sun, 02 Jun 2024 09:32:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:32:46 +0800
Date: Sun, 2 Jun 2024 09:32:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] expand: Rewrite expmeta meta detection
Message-ID: <ZlvLvnSw-0HcRWNL@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove the meta detection in expandmeta and rely on the detection
in expmeta instead.

Replace the open-coded meta detection with one based on strpbrk.
This is slightly inaccurate with bracket expressions but the
difference is minor (only affecting patterns with an unquoted
']').

Move int_pending to the end of the loop so that it is only executed
after some work has been done.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c | 116 +++++++++++++++++++--------------------------------
 1 file changed, 43 insertions(+), 73 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index cb579df..345c498 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -143,7 +143,6 @@ STATIC void addfname(char *);
 STATIC int patmatch(char *, const char *);
 STATIC int pmatch(char *, const char *);
 static size_t cvtnum(intmax_t num, int flags);
-STATIC size_t esclen(const char *, const char *);
 STATIC void varunset(const char *, const char *, const char *, int)
 	__attribute__((__noreturn__));
 
@@ -166,16 +165,19 @@ preglob(const char *pattern, int flag) {
 }
 
 
-STATIC size_t
-esclen(const char *start, const char *p) {
+static size_t mesclen(const char *start, const char *p, char mesc) {
 	size_t esc = 0;
 
-	while (p > start && *--p == (char)CTLESC) {
+	while (p > start && *--p == mesc) {
 		esc++;
 	}
 	return esc;
 }
 
+static size_t esclen(const char *start, const char *p) {
+	return mesclen(start, p, CTLESC);
+}
+
 static __attribute__((noinline)) unsigned mbnext(const char *p)
 {
 	unsigned start = 0;
@@ -1544,9 +1546,6 @@ static void addglob(const glob64_t *pglob)
 STATIC void
 expandmeta(struct strlist *str)
 {
-	static const char metachars[] = {
-		'*', '?', '[', 0
-	};
 	/* TODO - EXP_REDIR */
 
 	if (GLOB_IS_ENABLED)
@@ -1560,7 +1559,7 @@ expandmeta(struct strlist *str)
 
 		if (fflag)
 			goto nometa;
-		if (!strpbrk(str->text, metachars))
+		if (!strpbrk(str->text, "*?]"))
 			goto nometa;
 		savelastp = exparg.lastp;
 
@@ -1634,51 +1633,29 @@ static char *expmeta_rmescapes(char *enddir, const char *name)
 	return enddir - 1;
 }
 
-static int skipesc(char *p)
-{
-	unsigned short mb;
-	int esc = 0;
-
-	mb = mbnext(p);
-	if ((mb >> 8) > 3)
-		return (mb & 0xff) + (mb >> 8) - 1;
-
-	esc = mb & 0xff;
-
-	if (!esc && p[esc] == '\\' && p[esc + 1]) {
-		esc++;
-		mb = mbnext(p + esc);
-		esc += mb & 0xff;
-
-		if ((mb >> 8) > 3)
-			esc += (mb >> 8) - 1;
-	}
-
-	return esc;
-}
-
 /*
  * Do metacharacter (i.e. *, ?, [...]) expansion.
  */
 
 static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 {
+	const char mesc = FNMATCH_IS_ENABLED ? '\\' : CTLESC;
 	struct jmploc *volatile savehandler;
 	struct jmploc jmploc;
 	struct stat64 statb;
 	struct dirent64 *dp;
 	volatile int err;
 	char *endname;
+	char *zeroedp;
 	char *enddir;
-	int metaflag;
 	int matchdot;
+	unsigned esc;
 	char *start;
 	size_t len;
 	DIR *dirp;
 	char *pat;
 	char *cp;
 	char *p;
-	int esc;
 	int c;
 
 	*(DIR *volatile *)&dirp = NULL;
@@ -1690,32 +1667,16 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 	cp = growstackto(len);
 	enddir = cp + expdir_len;
 
-	metaflag = 0;
-	start = name;
-	for (p = name; esc = 0, *p; p += esc + 1) {
-		if (*p == '*' || *p == '?')
-			metaflag = 1;
-		else if (*p == '[') {
-			char *q = p + 1;
-			for (;;) {
-				q += skipesc(q);
-				if (*q == '/' || *q == '\0')
-					break;
-				if (*++q == ']') {
-					metaflag = 1;
-					break;
-				}
-			}
-		} else {
-			esc = skipesc(p);
-			if (p[esc] == '/') {
-				if (metaflag)
-					break;
-				start = p + esc + 1;
-			}
-		}
-	}
-	if (metaflag == 0) {	/* we've reached the end of the file name */
+	p = name;
+	esc = 0;
+	do {
+		p = strpbrk(p + esc, "*?]");
+		if (!p)
+			break;
+		esc = mesclen(name, p, mesc) & 1;
+	} while (esc);
+	/* No meta characters */
+	if (likely(!p)) {
 		if (!expdir_len)
 			goto out_opendir;
 		enddir = expmeta_rmescapes(enddir, name);
@@ -1723,37 +1684,44 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 			cp = addfnamealt(enddir, expdir_len);
 		goto out_opendir;
 	}
-	endname = p;
-	if (name < start) {
-		c = *start;
+	start = memrchr(name, '/', p - name);
+	if (start) {
+		c = *++start;
 		*start = 0;
 		enddir = expmeta_rmescapes(enddir, name);
 		*start = c;
-	}
+		expdir_len = enddir - cp;
+	} else
+		start = name;
 	*enddir = 0;
-	expdir_len = enddir - cp;
 
 	*(DIR *volatile *)&dirp = opendir(expdir_len ? cp : dotdir);
 	if (!dirp)
 		goto out_opendir;
-	c = *endname;
-	if (c) {
-		*endname = '\0';
-		endname += esc + 1;
+	esc = 0;
+	p = strchrnul(p + 1, '/');
+	zeroedp = p;
+	endname = p;
+	if (*p) {
+		esc = mesclen(name, p, mesc) & 1;
+		zeroedp -= esc;
+		endname++;
 	}
+	c = *zeroedp;
+	*zeroedp = '\0';
 	name_len -= endname - name;
 	matchdot = 0;
 	pat = start;
 	p = pat;
-	if (*p == (FNMATCH_IS_ENABLED ? '\\' : (char)CTLESC))
+	if (*p == mesc)
 		p++;
 	if (*p == '.')
 		matchdot++;
-	while (! int_pending() && (dp = readdir64(dirp)) != NULL) {
+	while ((dp = readdir64(dirp))) {
 		char *dname = dp->d_name;
 
 		if (*dname == '.' && !matchdot)
-			continue;
+			goto check_int;
 		len = strlen(dname) + 1;
 		p = dname;
 		if (!FNMATCH_IS_ENABLED) {
@@ -1774,9 +1742,11 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 			}
 			enddir = cp + expdir_len;
 		}
+check_int:
+		if (int_pending())
+			break;
 	}
-	if (c)
-		endname[-esc - 1] = c;
+	*zeroedp = c;
 
 out:
 	closedir(*(DIR *volatile *)&dirp);
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
