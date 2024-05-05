Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B5748F
	for <dash@vger.kernel.org>; Sun,  5 May 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714900481; cv=none; b=ip5xbyDafHAJbrMf+VM99mgWKgRm8Iz1L6n7EMQ3DOUcjZm/IcttTuK76GqfOpIDgrT5KhiS74sNrlKOgfTkVpZkudzbwYhN3fekLiy1dZBlspouJsg5iJaHkbxM+FMEHBVBqr7Bp6yEHk0FZtTmVbEHvAYc2v3wAPiJ0EFD9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714900481; c=relaxed/simple;
	bh=+o2MMlHVZgTfWjXs652tU8pzdcHBFnXBRWwTu28m+Vc=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=FqarBuXHB06ms+lLdyNhEig27I3aFJKMlqCFmYEIBCMiyTQJfxX6w967YKHw4x701lle/2Injn6aUuWj6I2wI3aMlWc5SKV8XAiwX1HyKCCVwElHL1X360S47Cx0ahYeUg3qTnXVJ7bHV3ewM8ELSNa1XsxIiwaMd8eZdNZz1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s3Xx5-00AaWI-0Z;
	Sun, 05 May 2024 17:14:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 May 2024 17:14:35 +0800
Date: Sun, 05 May 2024 17:14:35 +0800
Message-Id: <3245a4aa0efcb3f503d6974ec63ba822a5d9e288.1714900377.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714900377.git.herbert@gondor.apana.org.au>
References: <cover.1714900377.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 05/13] expand: Process multi-byte characters in expmeta
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
 src/expand.c | 107 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 73 insertions(+), 34 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 60a51b1..0e85025 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -84,6 +84,7 @@
 #define RMESCAPE_GLOB	0x2	/* Add backslashes for glob */
 #define RMESCAPE_GROW	0x8	/* Grow strings instead of stalloc */
 #define RMESCAPE_HEAP	0x10	/* Malloc strings instead of stalloc */
+#define RMESCAPE_EMETA	0x20	/* Remove backslashes too */
 
 /* Add CTLESC when necessary. */
 #define QUOTES_ESC	(EXP_FULL | EXP_CASE)
@@ -1347,15 +1348,13 @@ expandmeta(struct strlist *str)
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
@@ -1376,6 +1375,41 @@ nometa:
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
+static int skipesc(char *p)
+{
+	int esc = 0;
+
+	if (p[esc] == (char)CTLMBCHAR)
+		return esc + mbcharlen(p);
+
+	if (*p == (char)CTLESC)
+		esc++;
+
+	if (p[esc] == '\\' && p[esc + 1]) {
+		esc++;
+		if (p[esc] == (char)CTLMBCHAR)
+			return esc + mbcharlen(p + esc);
+		if (p[esc] == (char)CTLESC)
+			esc++;
+	}
+
+	return esc;
+}
 
 /*
  * Do metacharacter (i.e. *, ?, [...]) expansion.
@@ -1385,17 +1419,18 @@ STATIC void
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
@@ -1407,8 +1442,7 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 			if (*q == '!')
 				q++;
 			for (;;) {
-				if (*q == '\\')
-					q++;
+				q += skipesc(q);
 				if (*q == '/' || *q == '\0')
 					break;
 				if (*++q == ']') {
@@ -1417,8 +1451,8 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 				}
 			}
 		} else {
-			if (*p == '\\' && p[1])
-				esc++;
+			esc = skipesc(p);
+
 			if (p[esc] == '/') {
 				if (metaflag)
 					break;
@@ -1429,24 +1463,18 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
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
@@ -1455,25 +1483,26 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
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
 	p = start;
+	if (*p == (char)CTLESC)
+		p++;
 	if (*p == '\\')
 		p++;
 	if (*p == '.')
 		matchdot++;
+	pat = preglob(start, RMESCAPE_ALLOC | RMESCAPE_HEAP);
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
@@ -1496,9 +1525,11 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
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
 #endif	/* HAVE_GLOB */
 
@@ -1743,6 +1774,7 @@ _rmescapes(char *str, int flag)
 	int notescaped;
 	int globbing;
 	int inquotes;
+	int expmeta;
 
 	p = strpbrk(str, cqchars);
 	if (!p) {
@@ -1751,6 +1783,7 @@ _rmescapes(char *str, int flag)
 	q = p;
 	r = str;
 	globbing = flag & RMESCAPE_GLOB;
+	expmeta = (flag & RMESCAPE_EMETA) ? RMESCAPE_GLOB : 0;
 
 	if (flag & RMESCAPE_ALLOC) {
 		size_t len = p - str;
@@ -1790,6 +1823,10 @@ _rmescapes(char *str, int flag)
 		if (*p == '\\') {
 			/* naked back slash */
 			notescaped ^= globbing;
+			if (expmeta & ~notescaped) {
+				p++;
+				continue;
+			}
 			goto copy;
 		}
 		if (FNMATCH_IS_ENABLED && *p == '^')
@@ -1797,7 +1834,9 @@ _rmescapes(char *str, int flag)
 		if (*p == (char)CTLESC) {
 			p++;
 add_escape:
-			if (notescaped)
+			if (expmeta)
+				;
+			else if (notescaped)
 				*q++ = '\\';
 			else if (inquotes) {
 				*q++ = '\\';
-- 
2.39.2

