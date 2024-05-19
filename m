Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025A4437
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096024; cv=none; b=a/spJhmwvAKU+hig6ga6ROKfaAY3i7dYAjcBCVgBVOOubns3/yduZWUKo06ty3iWC/Yhitpown7at1YXxQAkZxAYlGNsN0R3UbHS5Tp0+I0tXPvQlOO5cvsk4/kxiKoAslCEbzVzJHyptRbJ8LQDP/Lo9izIboxD84bbPfwPGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096024; c=relaxed/simple;
	bh=nh5M77j97n58tWm+CMchhUBZZ/aiUXAvssszTTitQ9A=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=iF+aAxAi7+rYCOGmiS/rtZAYJ1xqCrfIWy9oh1z/GOf+1yZbzTgYPx3XFg412X2X0FeI+HBRmQ2uZJ8xghCGTaoHDt6m8IeWAHoSQpY/VwMBnIwk9H3I3obTGj+rNJdQc/L2dUKpiJLzJWCmVg7XDsX8i6PzLI2VPA4H2KKdNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Yy2-00HGAh-09;
	Sun, 19 May 2024 13:20:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:20:19 +0800
Date: Sun, 19 May 2024 13:20:19 +0800
Message-Id: <34f30d88b665583154bd20b833d99efb40847815.1716095868.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1716095868.git.herbert@gondor.apana.org.au>
References: <cover.1716095868.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 05/13] expand: Process multi-byte characters in expmeta
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

When glob(3) is not in use, make sure that expmeta processes
multi-byte characters correctly.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c | 109 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 37 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index b627c7a..714eae9 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -84,6 +84,7 @@
 #define RMESCAPE_GLOB	0x2	/* Add backslashes for glob */
 #define RMESCAPE_GROW	0x8	/* Grow strings instead of stalloc */
 #define RMESCAPE_HEAP	0x10	/* Malloc strings instead of stalloc */
+#define RMESCAPE_EMETA	0x20	/* Remove backslashes too */
 
 /* Add CTLESC when necessary. */
 #define QUOTES_ESC	(EXP_FULL | EXP_CASE)
@@ -1387,15 +1388,13 @@ expandmeta(struct strlist *str)
 		savelastp = exparg.lastp;
 
 		INTOFF;
-		p = preglob(str->text, RMESCAPE_ALLOC | RMESCAPE_HEAP);
+		p = str->text;
 		len = strlen(p);
 		expdir_max = len + PATH_MAX;
 		expdir = ckmalloc(expdir_max);
 
 		expmeta(p, len, 0);
 		ckfree(expdir);
-		if (p != str->text)
-			ckfree(p);
 		INTON;
 		if (exparg.lastp == savelastp) {
 			/*
@@ -1416,6 +1415,40 @@ nometa:
 	}
 }
 
+static void expmeta_rmescapes(char *enddir, char *name)
+{
+	preglob(strcpy(enddir, name), RMESCAPE_EMETA);
+}
+
+static unsigned mbcharlen(char *p)
+{
+	int esc = 0;
+
+	if (*++p == (char)CTLESC)
+		esc++;
+
+	return esc + 3 + (unsigned char)p[esc];
+}
+
+static size_t skipesc(char *p)
+{
+	size_t esc = 0;
+
+	if (p[esc] == (char)CTLMBCHAR)
+		esc += mbcharlen(p);
+	else if (p[esc] == (char)CTLESC)
+		esc++;
+	else if (p[esc] == '\\' && p[esc + 1]) {
+		while (p[++esc] == (char)CTLQUOTEMARK)
+			;
+		if (p[esc] == (char)CTLMBCHAR)
+			esc += mbcharlen(p + esc);
+		else if (p[esc] == (char)CTLESC)
+			esc++;
+	}
+
+	return esc;
+}
 
 /*
  * Do metacharacter (i.e. *, ?, [...]) expansion.
@@ -1425,17 +1458,18 @@ STATIC void
 expmeta(char *name, unsigned name_len, unsigned expdir_len)
 {
 	char *enddir = expdir + expdir_len;
-	char *p;
+	struct stat64 statb;
+	struct dirent64 *dp;
 	const char *cp;
-	char *start;
 	char *endname;
 	int metaflag;
-	struct stat64 statb;
-	DIR *dirp;
-	struct dirent64 *dp;
-	int atend;
 	int matchdot;
+	char *start;
+	DIR *dirp;
+	char *pat;
+	char *p;
 	int esc;
+	int c;
 
 	metaflag = 0;
 	start = name;
@@ -1444,11 +1478,8 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 			metaflag = 1;
 		else if (*p == '[') {
 			char *q = p + 1;
-			if (*q == '!')
-				q++;
 			for (;;) {
-				if (*q == '\\')
-					q++;
+				q += skipesc(q);
 				if (*q == '/' || *q == '\0')
 					break;
 				if (*++q == ']') {
@@ -1457,8 +1488,7 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 				}
 			}
 		} else {
-			if (*p == '\\' && p[1])
-				esc++;
+			esc = skipesc(p);
 			if (p[esc] == '/') {
 				if (metaflag)
 					break;
@@ -1469,24 +1499,18 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 	if (metaflag == 0) {	/* we've reached the end of the file name */
 		if (!expdir_len)
 			return;
-		p = name;
-		do {
-			if (*p == '\\' && p[1])
-				p++;
-			*enddir++ = *p;
-		} while (*p++);
+		expmeta_rmescapes(enddir, name);
 		if (lstat64(expdir, &statb) >= 0)
 			addfname(expdir);
 		return;
 	}
 	endname = p;
 	if (name < start) {
-		p = name;
-		do {
-			if (*p == '\\' && p[1])
-				p++;
-			*enddir++ = *p++;
-		} while (p < start);
+		c = *start;
+		*start = 0;
+		expmeta_rmescapes(enddir, name);
+		*start = c;
+		enddir += strlen(enddir);
 	}
 	*enddir = 0;
 	cp = expdir;
@@ -1495,16 +1519,15 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 		cp = ".";
 	if ((dirp = opendir(cp)) == NULL)
 		return;
-	if (*endname == 0) {
-		atend = 1;
-	} else {
-		atend = 0;
+	c = *endname;
+	if (c) {
 		*endname = '\0';
 		endname += esc + 1;
 	}
 	name_len -= endname - name;
 	matchdot = 0;
-	p = start;
+	pat = preglob(start, RMESCAPE_ALLOC | RMESCAPE_HEAP);
+	p = pat;
 	if (*p == '\\')
 		p++;
 	if (*p == '.')
@@ -1512,8 +1535,8 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 	while (! int_pending() && (dp = readdir64(dirp)) != NULL) {
 		if (dp->d_name[0] == '.' && ! matchdot)
 			continue;
-		if (pmatch(start, dp->d_name)) {
-			if (atend) {
+		if (pmatch(pat, dp->d_name)) {
+			if (!c) {
 				scopy(dp->d_name, enddir);
 				addfname(expdir);
 			} else {
@@ -1536,9 +1559,11 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 			}
 		}
 	}
+	if (pat != start)
+		ckfree(pat);
 	closedir(dirp);
-	if (! atend)
-		endname[-esc - 1] = esc ? '\\' : '/';
+	if (c)
+		endname[-esc - 1] = c;
 }
 
 
@@ -1781,6 +1806,7 @@ _rmescapes(char *str, int flag)
 	int notescaped;
 	int globbing;
 	int inquotes;
+	int expmeta;
 
 	p = strpbrk(str, cqchars);
 	if (!p) {
@@ -1789,6 +1815,7 @@ _rmescapes(char *str, int flag)
 	q = p;
 	r = str;
 	globbing = flag & RMESCAPE_GLOB;
+	expmeta = (flag & RMESCAPE_EMETA) ? RMESCAPE_GLOB : 0;
 
 	if (flag & RMESCAPE_ALLOC) {
 		size_t len = p - str;
@@ -1828,6 +1855,12 @@ _rmescapes(char *str, int flag)
 		} else if (*p == '\\') {
 			/* naked back slash */
 			newnesc ^= notescaped;
+			/* naked backslashes can only occur outside quotes */
+			inquotes = 0;
+			if (expmeta & ~newnesc) {
+				p++;
+				goto setnesc;
+			}
 		} else if (*p == (char)CTLMBCHAR) {
 			if (*++p == (char)CTLESC)
 				p++;
@@ -1838,7 +1871,9 @@ _rmescapes(char *str, int flag)
 			goto setnesc;
 		} else if (*p == (char)CTLESC) {
 			p++;
-			if (notescaped)
+			if (expmeta)
+				;
+			else if (notescaped)
 				*q++ = '\\';
 			else if (inquotes) {
 				*q++ = '\\';
-- 
2.39.2

