Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2BA2A
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291744; cv=none; b=jpQWgVdqSJrRei5RITYqjVRE3vNUUnQdwWnpBnrFaE6pupxdAUQLGVmrn4mw6npzr84ghY81VOh4qcCKcVmeOQ2ikK8Y5h6y50XSL/AcnfmVvHnBdgycCohLp15CXBzfYh3yn4GgBJjnEyuyE5MNSLuBbmGAZzfyMCsAq16w/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291744; c=relaxed/simple;
	bh=lOAJ8e48eKTCKYUVmBL11jRvzH0lDOL2NDX0ojFLtro=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=C+XuarmwQ+4r7cQviusEML5SzBrC7eQU2g2BYIgGWgLtk+mkbsC+3MCLuLIr28d8t4ihTCrhHgKp/fQhDqyPt2hO6VbWyG/8GQfDyU3XBiUgXDLPbM7uSv5GazdLbPIdzGavOHV2n2bHPBfrpsVgWswLo1uT2Wy7O6y5AeL4fQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa1p-004iRw-1J;
	Sun, 02 Jun 2024 09:28:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:28:59 +0800
Date: Sun, 02 Jun 2024 09:28:59 +0800
Message-Id: <b7884558b508e15f9bb486dc3549b279ad53d5af.1717291579.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1717291579.git.herbert@gondor.apana.org.au>
References: <cover.1717291579.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 07/13] expand: Add multi-byte support to pmatch
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Add CTLMBCHAR support to pmatch.

POSIX equivalence classes and collating symbols are not unsupported.

Enable CTLMBCHAR generation in mbtodest.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/eval.c   |   3 +-
 src/expand.c | 371 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 227 insertions(+), 147 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 1839623..140a734 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -457,7 +457,8 @@ evalcase(union node *n, int flags)
 		lineno -= funcline - 1;
 
 	arglist.lastp = &arglist.list;
-	expandarg(n->ncase.expr, &arglist, EXP_TILDE);
+	expandarg(n->ncase.expr, &arglist, FNMATCH_IS_ENABLED ? EXP_TILDE :
+					   EXP_TILDE | EXP_MBCHAR);
 	for (cp = n->ncase.cases ; cp && evalskip == 0 ; cp = cp->nclist.next) {
 		for (patp = cp->nclist.pattern ; patp ; patp = patp->narg.next) {
 			if (casematch(patp, arglist.list->text)) {
diff --git a/src/expand.c b/src/expand.c
index 2223045..ec408fd 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -86,7 +86,6 @@
 #define RMESCAPE_GLOB	0x2	/* Add backslashes for glob */
 #define RMESCAPE_GROW	0x8	/* Grow strings instead of stalloc */
 #define RMESCAPE_HEAP	0x10	/* Malloc strings instead of stalloc */
-#define RMESCAPE_EMETA	0x20	/* Remove backslashes too */
 
 /* Add CTLESC when necessary. */
 #define QUOTES_ESC	(EXP_FULL | EXP_CASE)
@@ -142,7 +141,7 @@ STATIC struct strlist *expsort(struct strlist *);
 STATIC struct strlist *msort(struct strlist *, int);
 STATIC void addfname(char *);
 STATIC int patmatch(char *, const char *);
-STATIC int pmatch(const char *, const char *);
+STATIC int pmatch(char *, const char *);
 static size_t cvtnum(intmax_t num, int flags);
 STATIC size_t esclen(const char *, const char *);
 STATIC void varunset(const char *, const char *, const char *, int)
@@ -157,6 +156,11 @@ STATIC void varunset(const char *, const char *, const char *, int)
 
 STATIC inline char *
 preglob(const char *pattern, int flag) {
+	if (FNMATCH_IS_ENABLED) {
+		if (!flag)
+			flag = RMESCAPE_GROW;
+		flag |= RMESCAPE_ALLOC;
+	}
 	flag |= RMESCAPE_GLOB;
 	return _rmescapes((char *)pattern, flag);
 }
@@ -583,28 +587,31 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
 	loc = startp;
 	loc2 = rmesc;
 	do {
-		const char *s = loc2;
+		char *s = FNMATCH_IS_ENABLED ? loc2 : loc;
 		unsigned mb;
 		unsigned ml;
 		int match;
 
-		c = *loc2;
+		c = *s;
 		if (zero) {
-			*loc2 = '\0';
-			s = rmesc;
+			*s = '\0';
+			s = FNMATCH_IS_ENABLED ? rmesc : startp;
 		}
 		match = pmatch(str, s);
-		*loc2 = c;
+		*(FNMATCH_IS_ENABLED ? loc2 : loc) = c;
 		if (match)
-			return quotes ? loc : loc2;
+			return FNMATCH_IS_ENABLED && quotes ? loc : loc2;
 
 		if (!c)
 			break;
 
 		mb = mbnext(loc);
 		loc += (mb & 0xff) + (mb >> 8);
-		ml = (mb >> 8) > 3 ? (mb >> 8) - 2 : 1;
-		loc2 += ml;
+		if (unlikely(FNMATCH_IS_ENABLED || !quotes)) {
+			ml = (mb >> 8) > 3 ? (mb >> 8) - 2 : 1;
+			loc2 += ml;
+		} else
+			loc2 = loc;
 	} while (1);
 	return 0;
 }
@@ -617,21 +624,23 @@ static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
 	char *loc;
 	char *loc2;
 
-	for (loc = endp, loc2 = rmescend; loc >= startp; loc2--) {
-		const char *s = loc2;
-		char c = *loc2;
+	for (loc = endp, loc2 = rmescend;;
+	     FNMATCH_IS_ENABLED ? loc2-- : (loc2 = loc)) {
+		char *s = FNMATCH_IS_ENABLED ? loc2 : loc;
+		char c = *s;
 		unsigned ml;
 		int match;
 
 		if (zero) {
-			*loc2 = '\0';
+			*s = '\0';
 			s = rmesc;
 		}
 		match = pmatch(str, s);
-		*loc2 = c;
+		*(FNMATCH_IS_ENABLED ? loc2 : loc) = c;
 		if (match)
-			return quotes ? loc : loc2;
-		loc--;
+			return FNMATCH_IS_ENABLED && quotes ? loc : loc2;
+		if (--loc < startp)
+			break;
 		if (!esc--)
 			esc = esclen(startp, loc);
 		if (esc % 2) {
@@ -646,7 +655,8 @@ static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
 		loc -= ml + 2;
 		if (*loc == (char)CTLESC)
 			loc--;
-		loc2 -= ml - 1;
+		if (FNMATCH_IS_ENABLED)
+			loc2 -= ml - 1;
 	}
 	return 0;
 }
@@ -692,19 +702,21 @@ static char *subevalvar(char *start, char *str, int strloc, int startloc,
 #endif
 
 	rmescend = stackblock() + strloc;
-	str = preglob(rmescend, FNMATCH_IS_ENABLED ?
-				RMESCAPE_ALLOC | RMESCAPE_GROW : 0);
+	str = preglob(rmescend, 0);
 	if (FNMATCH_IS_ENABLED) {
 		startp = stackblock() + startloc;
 		rmescend = stackblock() + strloc;
 		nstrloc = str - (char *)stackblock();
 	}
 
-	rmesc = _rmescapes(startp, RMESCAPE_ALLOC | RMESCAPE_GROW);
-	if (rmesc != startp)
-		rmescend = expdest;
-	startp = stackblock() + startloc;
-	str = stackblock() + nstrloc;
+	rmesc = startp;
+	if (FNMATCH_IS_ENABLED || !quotes) {
+		rmesc = _rmescapes(startp, RMESCAPE_ALLOC | RMESCAPE_GROW);
+		if (rmesc != startp)
+			rmescend = expdest;
+		startp = stackblock() + startloc;
+		str = stackblock() + nstrloc;
+	}
 	rmescend--;
 
 	/* zero = subtype == VSTRIMLEFT || subtype == VSTRIMLEFTMAX */
@@ -895,12 +907,6 @@ static struct mbpair mbtodest(const char *p, char *q, const char *syntax,
 		goto out;
 	}
 
-	len = ml;
-	do {
-		q = chtodest((signed char)*p++, syntax, q);
-	} while (--len);
-	goto out;
-
 	if (syntax[CTLMBCHAR] == CCTL) {
 		USTPUTC(CTLMBCHAR, q);
 		USTPUTC(ml, q);
@@ -1473,7 +1479,7 @@ static void expandmeta_glob(struct strlist *str)
 #endif
 
 		INTOFF;
-		p = preglob(str->text, RMESCAPE_ALLOC | RMESCAPE_HEAP);
+		p = preglob(str->text, RMESCAPE_HEAP);
 		i = glob64(p, GLOB_ALTDIRFUNC | GLOB_NOMAGIC, 0, &pglob);
 		if (p != str->text)
 			ckfree(p);
@@ -1540,10 +1546,12 @@ expandmeta(struct strlist *str)
 		savelastp = exparg.lastp;
 
 		INTOFF;
-		p = str->text;
+		p = preglob(str->text, RMESCAPE_ALLOC | RMESCAPE_HEAP);
 		len = strlen(p);
 
 		expmeta(p, len, 0);
+		if (p != str->text)
+			ckfree(p);
 		INTON;
 		if (exparg.lastp == savelastp) {
 			/*
@@ -1585,9 +1593,26 @@ static char *addfnamealt(char *enddir, size_t expdir_len)
 	return stnputs(name, expdir_len, enddir) - expdir_len;
 }
 
-static void expmeta_rmescapes(char *enddir, char *name)
+static char *expmeta_rmescapes(char *enddir, const char *name)
 {
-	preglob(strcpy(enddir, name), RMESCAPE_EMETA);
+	const char *p;
+
+	if (!FNMATCH_IS_ENABLED)
+		return strchrnul(rmescapes(strcpy(enddir, name)), 0);
+
+	p = name;
+	do {
+		char *q = strchrnul(p, '\\');
+
+		enddir = mempcpy(enddir, p, q - p + 1);
+		p = q;
+		if (!*p)
+			break;
+		if (*++p)
+			enddir[-1] = *p++;
+	} while (1);
+
+	return enddir - 1;
 }
 
 static int skipesc(char *p)
@@ -1602,8 +1627,7 @@ static int skipesc(char *p)
 	esc = mb & 0xff;
 
 	if (!esc && p[esc] == '\\' && p[esc + 1]) {
-		while (p[++esc] == (char)CTLQUOTEMARK)
-			;
+		esc++;
 		mb = mbnext(p + esc);
 		esc += mb & 0xff;
 
@@ -1639,7 +1663,6 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 	int c;
 
 	*(DIR *volatile *)&dirp = NULL;
-	*(char *volatile *)&pat = NULL;
 	savehandler = handler;
 	if (unlikely(err = setjmp(jmploc.loc)))
 		goto out;
@@ -1676,18 +1699,17 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 	if (metaflag == 0) {	/* we've reached the end of the file name */
 		if (!expdir_len)
 			goto out_opendir;
-		expmeta_rmescapes(enddir, name);
+		enddir = expmeta_rmescapes(enddir, name);
 		if (lstat64(cp, &statb) >= 0)
-			cp = addfnamealt(strchrnul(enddir, 0), expdir_len);
+			cp = addfnamealt(enddir, expdir_len);
 		goto out_opendir;
 	}
 	endname = p;
 	if (name < start) {
 		c = *start;
 		*start = 0;
-		expmeta_rmescapes(enddir, name);
+		enddir = expmeta_rmescapes(enddir, name);
 		*start = c;
-		enddir += strlen(enddir);
 	}
 	*enddir = 0;
 	expdir_len = enddir - cp;
@@ -1702,21 +1724,28 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 	}
 	name_len -= endname - name;
 	matchdot = 0;
-	*(char *volatile *)&pat =
-		preglob(start, RMESCAPE_ALLOC | RMESCAPE_HEAP);
+	pat = start;
 	p = pat;
-	if (*p == '\\')
+	if (*p == (FNMATCH_IS_ENABLED ? '\\' : (char)CTLESC))
 		p++;
 	if (*p == '.')
 		matchdot++;
 	while (! int_pending() && (dp = readdir64(dirp)) != NULL) {
-		if (dp->d_name[0] == '.' && ! matchdot)
-			continue;
-		if (pmatch(pat, dp->d_name)) {
-			len = strlen(dp->d_name) + 1;
+		char *dname = dp->d_name;
 
+		if (*dname == '.' && !matchdot)
+			continue;
+		len = strlen(dname) + 1;
+		p = dname;
+		if (!FNMATCH_IS_ENABLED) {
+			expdest = enddir;
+			memtodest(p, len, EXP_MBCHAR | EXP_KEEPNUL);
+			cp = stackblock();
 			enddir = cp + expdir_len;
-			enddir = stnputs(dp->d_name, len, enddir);
+			p = enddir;
+		}
+		if (pmatch(pat, p)) {
+			enddir = stnputs(dname, len, enddir);
 			if (!c)
 				cp = addfnamealt(enddir, expdir_len);
 			else {
@@ -1724,15 +1753,13 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
 				len += expdir_len;
 				cp = expmeta(endname, name_len, len);
 			}
+			enddir = cp + expdir_len;
 		}
 	}
 	if (c)
 		endname[-esc - 1] = c;
 
 out:
-	pat = *(char *volatile *)&pat;
-	if (pat != start)
-		ckfree(pat);
 	closedir(*(DIR *volatile *)&dirp);
 out_opendir:
 	handler = savehandler;
@@ -1820,52 +1847,48 @@ msort(struct strlist *list, int len)
 STATIC inline int
 patmatch(char *pattern, const char *string)
 {
-	return pmatch(preglob(pattern, FNMATCH_IS_ENABLED ?
-				       RMESCAPE_ALLOC | RMESCAPE_GROW : 0),
-		      string);
+	return pmatch(preglob(pattern, 0), string);
 }
 
 
-STATIC int ccmatch(const char *p, int chr, const char **r)
+static __attribute__((noinline)) int ccmatch(char *p, const char *mbc, int ml,
+					     char **r)
 {
-	static const struct class {
-		char name[10];
-		int (*fn)(int);
-	} classes[] = {
-		{ .name = ":alnum:]", .fn = isalnum },
-		{ .name = ":cntrl:]", .fn = iscntrl },
-		{ .name = ":lower:]", .fn = islower },
-		{ .name = ":space:]", .fn = isspace },
-		{ .name = ":alpha:]", .fn = isalpha },
-		{ .name = ":digit:]", .fn = isdigit },
-		{ .name = ":print:]", .fn = isprint },
-		{ .name = ":upper:]", .fn = isupper },
-		{ .name = ":blank:]", .fn = isblank },
-		{ .name = ":graph:]", .fn = isgraph },
-		{ .name = ":punct:]", .fn = ispunct },
-		{ .name = ":xdigit:]", .fn = isxdigit },
-	};
-	const struct class *class, *end;
-
-	end = classes + sizeof(classes) / sizeof(classes[0]);
-	for (class = classes; class < end; class++) {
-		const char *q;
-
-		q = prefix(p, class->name);
-		if (!q)
-			continue;
-		*r = q;
-		return class->fn(chr);
-	}
+	mbstate_t mbst = {};
+	wctype_t type;
+	wchar_t wc;
+	char *q;
 
 	*r = 0;
-	return 0;
+
+	if (*p++ != ':')
+		return 0;
+
+	q = strstr(p, ":]");
+	if (!q)
+		return 0;
+
+	*q = 0;
+	type = wctype(p);
+	*q = ':';
+
+	if (!type)
+		return 0;
+
+	*r = q + 2;
+
+	if (mbrtowc(&wc, mbc, ml, &mbst) != ml)
+		return 0;
+
+	return iswctype(wc, type);
 }
 
-STATIC int
-pmatch(const char *pattern, const char *string)
+static int pmatch(char *pattern, const char *string)
 {
-	const char *p, *q;
+	char stop[] = { 0, CTLESC, CTLMBCHAR };
+	const char *q;
+	unsigned mb;
+	char *p;
 	char c;
 
 	if (FNMATCH_IS_ENABLED)
@@ -1874,36 +1897,43 @@ pmatch(const char *pattern, const char *string)
 	p = pattern;
 	q = string;
 	for (;;) {
-		switch (c = *p++) {
+		switch ((signed char)(c = *p++)) {
 		case '\0':
 			goto breakloop;
-		case '\\':
-			if (*p) {
-				c = *p++;
-			}
-			goto dft;
-		case '?':
-			if (*q++ == '\0')
-				return 0;
+		case CTLESC:
+			c = *p++;
 			break;
+		case '?':
+			if (*q == '\0')
+				return 0;
+			mb = mbnext(q);
+			q += (mb >> 8) + (mb & 0xff);
+			continue;
 		case '*':
 			c = *p;
 			while (c == '*')
 				c = *++p;
-			if (c != '\\' && c != '?' && c != '*' && c != '[') {
-				while (*q != c) {
-					if (*q == '\0')
+			if (!c)
+				return 1;
+			stop[0] = CTLESC;
+			if (c != '?' && c != '[')
+				stop[0] = c;
+			for (;;) {
+				if (stop[0] != (char)CTLESC) {
+					q = strpbrk(q, stop);
+					if (!q)
 						return 0;
-					q++;
 				}
-			}
-			do {
 				if (pmatch(p, q))
 					return 1;
-			} while (*q++ != '\0');
+				if (!*q)
+					break;
+				mb = mbnext(q);
+				q += (mb >> 8) + (mb & 0xff);
+			}
 			return 0;
 		case '[': {
-			const char *startp;
+			char *startp;
 			int invert, found;
 			char chr;
 
@@ -1914,48 +1944,85 @@ pmatch(const char *pattern, const char *string)
 				p++;
 			}
 			found = 0;
+			mb = mbnext(q);
+			q += mb & 0xff;
+			mb >>= 8;
 			chr = *q;
 			if (chr == '\0')
 				return 0;
 			c = *p++;
 			do {
+				unsigned mbp = 0;
+				const char *mbs = &c;
+
 				if (!c) {
 					p = startp;
 					c = '[';
 					goto dft;
 				}
 				if (c == '[') {
-					const char *r;
+					char *r;
 
-					found |= !!ccmatch(p, chr, &r);
+					found |= !!ccmatch(p, q, mb > 1 ?
+								 mb - 2 : mb,
+							   &r);
 					if (r) {
 						p = r;
 						continue;
 					}
-				} else if (c == '\\')
+				} else if (c == (char)CTLESC)
 					c = *p++;
+				else if (c == (char)CTLMBCHAR) {
+					mbp = mbnext(--p);
+					p += mbp & 0xff;
+					mbs = p;
+					mbp >>= 8;
+					p += mbp;
+				}
 				if (*p == '-' && p[1] != ']') {
 					p++;
-					if (*p == '\\')
+					if (*p == (char)CTLESC)
 						p++;
-					if (chr >= c && chr <= *p)
+					else if (*p == CTLMBCHAR) {
+						mbp = mbnext(p);
+						p += mbp & 0xff;
+						p += mbp >> 8;
+						continue;
+					}
+					if (!(mbp | (mb - 1)) &&
+					    chr >= c && chr <= *p)
 						found = 1;
 					p++;
-				} else {
-					if (chr == c)
-						found = 1;
-				}
+				} else if (!memcmp(mbs, q, mb))
+					found = 1;
 			} while ((c = *p++) != ']');
 			if (found == invert)
 				return 0;
-			q++;
-			break;
+			q += mb;
+			continue;
 		}
-dft:	        default:
-			if (*q++ != c)
+		case CTLMBCHAR:
+			mb = mbnext(--p);
+			p += mb & 0xff;
+			mb = mbnext(q);
+			q += mb & 0xff;
+			mb >>= 8;
+
+			if (memcmp(p - 1, q - 1, mb + 1))
 				return 0;
-			break;
+
+			p += mb;
+			q += mb;
+			continue;
 		}
+dft:
+		mb = mbnext(q);
+		if ((mb >> 8) > 1)
+			return 0;
+		q += mb & 0xff;
+		if (*q != c)
+			return 0;
+		q += mb >> 8;
 	}
 breakloop:
 	if (*q != '\0')
@@ -1976,7 +2043,6 @@ _rmescapes(char *str, int flag)
 	int notescaped;
 	int globbing;
 	int inquotes;
-	int expmeta;
 
 	p = strpbrk(str, cqchars);
 	if (!p) {
@@ -1985,7 +2051,6 @@ _rmescapes(char *str, int flag)
 	q = p;
 	r = str;
 	globbing = flag & RMESCAPE_GLOB;
-	expmeta = (flag & RMESCAPE_EMETA) ? RMESCAPE_GLOB : 0;
 
 	if (flag & RMESCAPE_ALLOC) {
 		size_t len = p - str;
@@ -2015,50 +2080,64 @@ _rmescapes(char *str, int flag)
 	inquotes = 0;
 	notescaped = globbing;
 	while (*p) {
+		int c = (signed char)*p;
+		int newnesc = globbing;
 		unsigned mb;
 		unsigned ml;
-		int newnesc = globbing;
 
-		if (*p == (char)CTLQUOTEMARK) {
+		if (c == CTLQUOTEMARK) {
 			p++;
 			inquotes ^= globbing;
 			continue;
-		} else if (*p == '\\') {
+		} else if (c == '\\') {
 			/* naked back slash */
 			newnesc ^= notescaped;
 			/* naked backslashes can only occur outside quotes */
 			inquotes = 0;
-			if (expmeta & ~newnesc) {
-				p++;
-				goto setnesc;
+			if (!FNMATCH_IS_ENABLED && notescaped)
+				c = CTLESC;
+		} else if (c == CTLESC) {
+			if ((notescaped ^ inquotes) & inquotes) {
+				if (FNMATCH_IS_ENABLED)
+					*q++ = '\\';
+				else
+					q[-1] = '\\';
 			}
-		} else if (*p == (char)CTLMBCHAR) {
+			if (globbing)
+				*q++ = FNMATCH_IS_ENABLED ? '\\' : CTLESC;
+
+			c = *++p;
+		} else if (c == CTLMBCHAR) {
+			unsigned tail = 2;
+
+			if (!FNMATCH_IS_ENABLED && (globbing ^ notescaped))
+				q--;
+
 			mb = mbnext(p);
 			ml = mb >> 8;
 
-			ml -= 2;
-			p += mb & 0xff;
-			q = mempcpy(q, p, ml);
-			p += ml + 2;
-			goto setnesc;
-		} else if (*p == (char)CTLESC) {
-			p++;
-			if (expmeta)
-				;
-			else if (notescaped)
-				*q++ = '\\';
-			else if (inquotes) {
-				*q++ = '\\';
-				*q++ = '\\';
+			if (!globbing || FNMATCH_IS_ENABLED) {
+				p += mb & 0xff;
+				ml -= 2;
+			} else {
+				ml += mb & 0xff;
+				tail = 0;
 			}
+
+			q = mempcpy(q, p, ml);
+			p += ml + tail;
+			goto setnesc;
 		}
 
-		*q++ = *p++;
+		*q++ = c;
+		p++;
 setnesc:
 		notescaped = newnesc;
 	}
+	if (!FNMATCH_IS_ENABLED && (globbing ^ notescaped))
+		q[-1] = '\\';
 	*q = '\0';
-	if (flag & RMESCAPE_GROW) {
+	if (flag & (RMESCAPE_ALLOC | RMESCAPE_GROW)) {
 		expdest = r;
 		STADJUST(q - r + 1, expdest);
 	}
-- 
2.39.2

