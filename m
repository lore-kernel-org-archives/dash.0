Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB2A34
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291739; cv=none; b=PyCX4iRFsLHsu63/9TIRsxl39/GJk9FJG5zv1PfB9Snq4Yout679dhDY97yLhTMQST8PVVSE19SXIbDvXnQ2CR+R2GgQrmC8a8LXdzVLUFVzqiykBntnNKaGe1GnyrQZJP7DzrtJ7KP78UNpaxsKBP+TCEnQdRBnyOtZy4AR6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291739; c=relaxed/simple;
	bh=qdhWp5k+ojOJdS+VbK/JaDdonYbaQ9ZFAYPPoNAtPwk=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=XUdKYeEYc0X262OEIMwdebRN9m0LRmrkAPA7QKxOwlOWbN1FRuX2RXb0uAW4s1lFKgTR+3Gd6+6mAAT0L9NXoT8JOC/76pgnhc+ypLjnrIZHBKVGczaEjIvjinUZjKVbSZ1ygIwJTcij30TlXEzThFT6ZDbdcRzaTn1NybOOv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa1k-004iRY-2U;
	Sun, 02 Jun 2024 09:28:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:28:54 +0800
Date: Sun, 02 Jun 2024 09:28:54 +0800
Message-Id: <79de110b4ec813753faa4e4971d3d3a5eeaa3601.1717291579.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1717291579.git.herbert@gondor.apana.org.au>
References: <cover.1717291579.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 05/13] expand: Process multi-byte characters in expmeta
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
 src/expand.c | 105 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 33 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 5d73f8e..03eafc2 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -85,6 +85,7 @@
 #define RMESCAPE_GLOB	0x2	/* Add backslashes for glob */
 #define RMESCAPE_GROW	0x8	/* Grow strings instead of stalloc */
 #define RMESCAPE_HEAP	0x10	/* Malloc strings instead of stalloc */
+#define RMESCAPE_EMETA	0x20	/* Remove backslashes too */
 
 /* Add CTLESC when necessary. */
 #define QUOTES_ESC	(EXP_FULL | EXP_CASE)
@@ -1386,12 +1387,10 @@ expandmeta(struct strlist *str)
 		savelastp = exparg.lastp;
 
 		INTOFF;
-		p = preglob(str->text, RMESCAPE_ALLOC | RMESCAPE_HEAP);
+		p = str->text;
 		len = strlen(p);
 
 		expmeta(p, len, 0);
-		if (p != str->text)
-			ckfree(p);
 		INTON;
 		if (exparg.lastp == savelastp) {
 			/*
@@ -1433,6 +1432,41 @@ static char *addfnamealt(char *enddir, size_t expdir_len)
 	return stnputs(name, expdir_len, enddir) - expdir_len;
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
+
 /*
  * Do metacharacter (i.e. *, ?, [...]) expansion.
  */
@@ -1451,12 +1485,14 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 	char *start;
 	size_t len;
 	DIR *dirp;
-	int atend;
+	char *pat;
 	char *cp;
 	char *p;
 	int esc;
+	int c;
 
 	*(DIR *volatile *)&dirp = NULL;
+	*(char *volatile *)&pat = NULL;
 	savehandler = handler;
 	if (unlikely(err = setjmp(jmploc.loc)))
 		goto out;
@@ -1472,11 +1508,8 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
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
@@ -1485,8 +1518,7 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 				}
 			}
 		} else {
-			if (*p == '\\' && p[1])
-				esc++;
+			esc = skipesc(p);
 			if (p[esc] == '/') {
 				if (metaflag)
 					break;
@@ -1497,24 +1529,18 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 	if (metaflag == 0) {	/* we've reached the end of the file name */
 		if (!expdir_len)
 			goto out_opendir;
-		p = name;
-		do {
-			if (*p == '\\' && p[1])
-				p++;
-			*enddir++ = *p;
-		} while (*p++);
+		expmeta_rmescapes(enddir, name);
 		if (lstat64(cp, &statb) >= 0)
-			cp = addfnamealt(enddir, expdir_len);
+			cp = addfnamealt(strchrnul(enddir, 0), expdir_len);
 		goto out_opendir;
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
 	expdir_len = enddir - cp;
@@ -1522,16 +1548,16 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 	*(DIR *volatile *)&dirp = opendir(expdir_len ? cp : dotdir);
 	if (!dirp)
 		goto out_opendir;
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
+	*(char *volatile *)&pat =
+		preglob(start, RMESCAPE_ALLOC | RMESCAPE_HEAP);
+	p = pat;
 	if (*p == '\\')
 		p++;
 	if (*p == '.')
@@ -1539,12 +1565,12 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 	while (! int_pending() && (dp = readdir64(dirp)) != NULL) {
 		if (dp->d_name[0] == '.' && ! matchdot)
 			continue;
-		if (pmatch(start, dp->d_name)) {
+		if (pmatch(pat, dp->d_name)) {
 			len = strlen(dp->d_name) + 1;
 
 			enddir = cp + expdir_len;
 			enddir = stnputs(dp->d_name, len, enddir);
-			if (atend)
+			if (!c)
 				cp = addfnamealt(enddir, expdir_len);
 			else {
 				enddir[-1] = '/';
@@ -1553,10 +1579,13 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 			}
 		}
 	}
-	if (! atend)
-		endname[-esc - 1] = esc ? '\\' : '/';
+	if (c)
+		endname[-esc - 1] = c;
 
 out:
+	pat = *(char *volatile *)&pat;
+	if (pat != start)
+		ckfree(pat);
 	closedir(*(DIR *volatile *)&dirp);
 out_opendir:
 	handler = savehandler;
@@ -1800,6 +1829,7 @@ _rmescapes(char *str, int flag)
 	int notescaped;
 	int globbing;
 	int inquotes;
+	int expmeta;
 
 	p = strpbrk(str, cqchars);
 	if (!p) {
@@ -1808,6 +1838,7 @@ _rmescapes(char *str, int flag)
 	q = p;
 	r = str;
 	globbing = flag & RMESCAPE_GLOB;
+	expmeta = (flag & RMESCAPE_EMETA) ? RMESCAPE_GLOB : 0;
 
 	if (flag & RMESCAPE_ALLOC) {
 		size_t len = p - str;
@@ -1847,6 +1878,12 @@ _rmescapes(char *str, int flag)
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
@@ -1857,7 +1894,9 @@ _rmescapes(char *str, int flag)
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

