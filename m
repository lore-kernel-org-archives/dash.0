Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31733D5
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096027; cv=none; b=hb7UGkp1pGWVU5pVJKyZsJ+GEne/RchloAD7Sg028gr0wu3vdqHEE8kAbugLojoZy/S+BnPJbOYlV0tBX7j2v0fGRVg87Ajr1TtgrEBg6Yl4BZH8fU2epanhooCUxI8b4jQbQkr8TX002mbQMZiyXxiXxB/Y8Yvpk45OIFwh9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096027; c=relaxed/simple;
	bh=8WMDiRmmgwaw32K/e3v/EM/rYzbhUoi6WnORt0TXZ8o=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=giqMolQQC4hmkpH9kdpCw5Kr30yr2c5w10JV74ZGFEQoFmIyWXHct5BiVIpKOgfbYnwQO3L8+iwBdHEj2+4vf7q/Mf0S4y5v97VM/DZitBQ00pj6Pv2UYR4qMSoWBLDZztL8HJhUg7b0BUclshCyaViTsBI97Bn+w1CLBh9ClwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Yy4-00HGBR-10;
	Sun, 19 May 2024 13:20:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:20:21 +0800
Date: Sun, 19 May 2024 13:20:21 +0800
Message-Id: <94990e2a097cc2b8f1fed8e179e4db455c1b4935.1716095868.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1716095868.git.herbert@gondor.apana.org.au>
References: <cover.1716095868.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 06/13] expand: Support multi-byte characters during field
 splitting
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

When multi-byte characters are used in IFS, they will be used
for field splitting.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c | 455 ++++++++++++++++++++++++++++++++++-----------------
 src/expand.h |   1 +
 src/var.c    |  12 +-
 3 files changed, 309 insertions(+), 159 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 714eae9..8f30e46 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -54,6 +54,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <wchar.h>
+#include <wctype.h>
 
 /*
  * Routines to expand arguments to commands.  We have to deal with
@@ -101,6 +102,14 @@ struct ifsregion {
 	int nulonly;		/* search for nul bytes only */
 };
 
+struct ifs_state {
+	const char *ifs;
+	char *start;
+	char *r;
+	int maxargs;
+	int ifsspc;
+};
+
 /* output of current string */
 static char *expdest;
 /* list of back quote expressions */
@@ -112,6 +121,11 @@ static struct ifsregion *ifslastp;
 /* holds expanded arg list */
 static struct arglist exparg;
 
+static char ifsmap[128];
+static const char *ncifs;
+static size_t ifsmb0len;
+static wchar_t *wcifs;
+
 static char *argstr(char *p, int flag);
 static char *exptilde(char *startp, int flag);
 static char *expari(char *start, int flag);
@@ -119,7 +133,7 @@ STATIC void expbackq(union node *, int);
 STATIC char *evalvar(char *, int);
 static size_t strtodest(const char *p, int flags);
 static size_t memtodest(const char *p, size_t len, int flags);
-STATIC ssize_t varvalue(char *, int, int, int);
+STATIC ssize_t varvalue(char *, int, unsigned);
 STATIC void expandmeta(struct strlist *);
 static void addglob(const glob64_t *);
 STATIC void expmeta(char *, unsigned, unsigned);
@@ -157,6 +171,30 @@ esclen(const char *start, const char *p) {
 	return esc;
 }
 
+static __attribute__((noinline)) unsigned mbnext(const char *p)
+{
+	unsigned start = 0;
+	unsigned end = 0;
+	unsigned ml;
+	int c;
+
+	c = (signed char)p[end++];
+
+	switch (__builtin_expect(c, 0)) {
+	case CTLMBCHAR:
+		if ((signed char)p[end] == CTLESC)
+			end++;
+		ml = (unsigned char)p[end++];
+		start = end;
+		end = ml + 2;
+		break;
+	case CTLESC:
+		start++;
+		break;
+	}
+
+	return start | end << 8;
+}
 
 static inline const char *getpwhome(const char *name)
 {
@@ -545,6 +583,7 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
 	loc2 = rmesc;
 	do {
 		const char *s = loc2;
+		unsigned mb;
 		unsigned ml;
 		int match;
 
@@ -561,19 +600,9 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
 		if (!c)
 			break;
 
-		if (*loc != (char)CTLMBCHAR) {
-			if (*loc == (char)CTLESC)
-				loc++;
-			loc++;
-			loc2++;
-			continue;
-		}
-
-		if (*++loc == (char)CTLESC)
-			loc++;
-
-		ml = (unsigned char)*loc;
-		loc += ml + 3;
+		mb = mbnext(loc);
+		loc += (mb & 0xff) + (mb >> 8);
+		ml = (mb >> 8) > 3 ? (mb >> 8) - 2 : 1;
 		loc2 += ml;
 	} while (1);
 	return 0;
@@ -753,7 +782,7 @@ evalvar(char *p, int flag)
 	}
 
 again:
-	varlen = varvalue(var, varflags, flag | mbchar, quoted);
+	varlen = varvalue(var, varflags, flag | mbchar);
 	if (varflags & VSNUL)
 		varlen--;
 
@@ -970,23 +999,23 @@ static size_t strtodest(const char *p, int flags)
  * Add the value of a specialized variable to the stack string.
  */
 
-STATIC ssize_t
-varvalue(char *name, int varflags, int flags, int quoted)
+static ssize_t varvalue(char *name, int varflags, unsigned flags)
 {
+	int subtype = varflags & VSTYPE;
+	unsigned long seplen;
+	const char *seps;
+	ssize_t len = 0;
+	size_t start;
+	int discard;
+	char **ap;
 	int num;
 	char *p;
 	int i;
-	int sep;
-	char sepc;
-	char **ap;
-	int subtype = varflags & VSTYPE;
-	int discard = (subtype == VSPLUS || subtype == VSLENGTH) |
-		      (flags & EXP_DISCARD);
-	ssize_t len = 0;
-	size_t start;
-	char c;
 
-	if (!subtype) {
+	discard = (subtype == VSPLUS || subtype == VSLENGTH) |
+		  (flags & EXP_DISCARD);
+
+	if (unlikely(!subtype)) {
 		if (discard)
 			return -1;
 
@@ -994,7 +1023,8 @@ varvalue(char *name, int varflags, int flags, int quoted)
 	}
 
 	flags &= discard ? ~QUOTES_ESC : ~0;
-	sep = (flags & EXP_FULL) << CHAR_BIT;
+	seps = nullstr;
+	seplen = flags & EXP_FULL;
 	start = expdest - (char *)stackblock();
 
 	switch (*name) {
@@ -1025,13 +1055,14 @@ numvar:
 		expdest = p;
 		break;
 	case '@':
-		if (quoted && sep)
+		if ((flags & (EXP_QUOTED | EXP_FULL)) ==
+		    (EXP_QUOTED | EXP_FULL))
 			goto param;
 		/* fall through */
 	case '*':
-		/* We will set c to 0 or ~0 depending on whether
+		/* We will set seplen to 0 or !0 depending on whether
 		 * we're doing field splitting.  We won't do field
-		 * splitting if either we're quoted or sep is zero.
+		 * splitting if either we're quoted or seplen is zero.
 		 *
 		 * Instead of testing (quoted || !sep) the following
 		 * trick optimises away any branches by using the
@@ -1043,20 +1074,22 @@ numvar:
 #if EXP_QUOTED >> CHAR_BIT != EXP_FULL
 #error The following two lines expect EXP_QUOTED == EXP_FULL << CHAR_BIT
 #endif
-		c = !((quoted | ~sep) & EXP_QUOTED) - 1;
-		sep &= ~quoted;
-		sep |= ifsset() ? (unsigned char)(c & ifsval()[0]) : ' ';
+		seplen &= ~(flags >> CHAR_BIT);
+		if (!seplen)
+			seps = ncifs;
+		seplen = ((seplen - 1) & (ifsmb0len - 1)) + 1;
 param:
-		sepc = sep;
 		if (!(ap = shellparam.p))
 			return -1;
-		while ((p = *ap++)) {
+		if (!(p = *ap))
+			break;
+		for (;;) {
 			len += strtodest(p, flags);
 
-			if (*ap && sep) {
-				len++;
-				memtodest(&sepc, 1, flags | EXP_KEEPNUL);
-			}
+			if (!(p = *++ap))
+				break;
+
+			len += memtodest(seps, seplen, flags | EXP_KEEPNUL);
 		}
 		break;
 	case '0':
@@ -1117,7 +1150,126 @@ recordregion(int start, int end, int nulonly)
 	ifslastp->nulonly = nulonly;
 }
 
+static unsigned ifsisifs(const char *p, unsigned ml, const char *ifs)
+{
+	bool isdefifs = false;
+	bool isifs = false;
+	wchar_t wc = *p;
+	wchar_t ifs0;
 
+	if (likely(ifs[0]) && unlikely(wcifs)) {
+		if (wc & 0x80) {
+			mbstate_t mbst = {};
+			wchar_t wc2;
+
+			if (mbrtowc(&wc2, p, ml, &mbst) != ml)
+				goto out;
+			wc = wc2;
+		}
+
+		isifs = wcschr(wcifs, wc);
+		ifs0 = wcifs[0];
+	} else if (likely(!ml)) {
+		isifs = strchr(ifs, wc);
+		ifs0 = ifs[0];
+	}
+
+	if (isifs)
+		isdefifs = iswspace(wc ?: ifs0);
+
+out:
+	return isifs << 1 | isdefifs;
+}
+
+static char *ifsbreakup_slow(struct ifs_state *ifst, struct arglist *arglist,
+			     int nulonly, char *p)
+{
+	struct strlist *sp;
+	unsigned ifschar;
+	unsigned sisifs;
+	bool isdefifs;
+	unsigned ml;
+	bool isifs;
+	char *q;
+
+	q = p;
+
+	ifschar = mbnext(p);
+	p += ifschar & 0xff;
+	ml = (ifschar >> 8) > 3 ?
+	     (ifschar >> 8) - 2 : 0;
+
+	sisifs = ifsisifs(p, ml, ifst->ifs);
+	p += ifschar >> 8;
+
+	isifs = sisifs >> 1;
+	isdefifs = sisifs & 1;
+
+	/* If only reading one more argument:
+	 * If we have exactly one field,
+	 * read that field without its terminator.
+	 * If we have more than one field,
+	 * read all fields including their terminators,
+	 * except for trailing IFS whitespace.
+	 *
+	 * This means that if we have only IFS
+	 * characters left, and at most one
+	 * of them is non-whitespace, we stop
+	 * reading here.
+	 * Otherwise, we read all the remaining
+	 * characters except for trailing
+	 * IFS whitespace.
+	 *
+	 * In any case, r indicates the start
+	 * of the characters to remove, or NULL
+	 * if no characters should be removed.
+	 */
+	if (!ifst->maxargs) {
+		if (isdefifs) {
+			if (!ifst->r)
+				ifst->r = q;
+			return p;
+		}
+
+		if (!(isifs && ifst->ifsspc))
+			ifst->r = NULL;
+	} else if (ifst->ifsspc) {
+		if (isifs)
+			q = p;
+
+		ifst->start = q;
+
+		if (isdefifs)
+			return p;
+	} else if (isifs) {
+		int ifsspc = ifst->ifsspc;
+
+		if (!nulonly) {
+			ifsspc = isdefifs;
+			ifst->ifsspc = ifsspc;
+		}
+
+		/* Ignore IFS whitespace at start */
+		if (q == ifst->start && ifsspc) {
+			ifst->start = p;
+			return p;
+		}
+		if (ifst->maxargs > 0 && !--ifst->maxargs) {
+			ifst->r = q;
+			return p;
+		}
+		*q = '\0';
+		sp = (struct strlist *)stalloc(sizeof *sp);
+		sp->text = ifst->start;
+		*arglist->lastp = sp;
+		arglist->lastp = &sp->next;
+		ifst->start = p;
+		return p;
+	}
+
+	ifst->ifsspc = 0;
+	return p;
+}
 
 /*
  * Break the argument string into pieces based upon IFS and add the
@@ -1130,21 +1282,19 @@ void
 ifsbreakup(char *string, int maxargs, struct arglist *arglist)
 {
 	struct ifsregion *ifsp;
+	struct ifs_state ifst;
+	const char *realifs;
 	struct strlist *sp;
-	char *start;
-	char *p;
-	char *q;
-	char *r = NULL;
-	const char *ifs, *realifs;
-	int ifsspc;
 	int nulonly;
+	char *p;
 
-
-	start = string;
+	ifst.r = NULL;
+	ifst.start = string;
+	ifst.maxargs = maxargs;
 	if (ifslastp != NULL) {
-		ifsspc = 0;
+		ifst.ifsspc = 0;
 		nulonly = 0;
-		realifs = ifsset() ? ifsval() : defifs;
+		realifs = ncifs;
 		ifsp = &ifsfirst;
 		do {
 			int afternul;
@@ -1152,106 +1302,60 @@ ifsbreakup(char *string, int maxargs, struct arglist *arglist)
 			p = string + ifsp->begoff;
 			afternul = nulonly;
 			nulonly = ifsp->nulonly;
-			ifs = nulonly ? nullstr : realifs;
-			ifsspc = 0;
-			while (p < string + ifsp->endoff) {
-				int c;
-				bool isifs;
-				bool isdefifs;
+			ifst.ifs = nulonly ? nullstr : realifs;
+			ifst.ifsspc = 0;
+			for (;;) {
+				char *p0 = p;
 
-				q = p;
-				c = *p++;
-				if (c == (char)CTLESC)
-					c = *p++;
+				while (string + ifsp->endoff - p >= 8) {
+					union {
+						uint64_t qw;
+						unsigned char b[8];
+					} x;
 
-				isifs = strchr(ifs, c);
-				isdefifs = false;
-				if (isifs)
-					isdefifs = strchr(defifs, c);
+					x.qw = *(uint64_t *)p;
 
-				/* If only reading one more argument:
-				 * If we have exactly one field,
-				 * read that field without its terminator.
-				 * If we have more than one field,
-				 * read all fields including their terminators,
-				 * except for trailing IFS whitespace.
-				 *
-				 * This means that if we have only IFS
-				 * characters left, and at most one
-				 * of them is non-whitespace, we stop
-				 * reading here.
-				 * Otherwise, we read all the remaining
-				 * characters except for trailing
-				 * IFS whitespace.
-				 *
-				 * In any case, r indicates the start
-				 * of the characters to remove, or NULL
-				 * if no characters should be removed.
-				 */
-				if (!maxargs) {
-					if (isdefifs) {
-						if (!r)
-							r = q;
-						continue;
-					}
-
-					if (!(isifs && ifsspc))
-						r = NULL;
-
-					ifsspc = 0;
-					continue;
+					if ((x.qw & 0x8080808080808080))
+						break;
+					if (ifsmap[x.b[0]] |
+					    ifsmap[x.b[1]] |
+					    ifsmap[x.b[2]] |
+					    ifsmap[x.b[3]] |
+					    ifsmap[x.b[4]] |
+					    ifsmap[x.b[5]] |
+					    ifsmap[x.b[6]] |
+					    ifsmap[x.b[7]])
+						break;
+					p += 8;
 				}
 
-				if (ifsspc) {
-					if (isifs)
-						q = p;
-
-					start = q;
-
-					if (isdefifs)
-						continue;
-
-					isifs = false;
+				if (p != p0) {
+					if (!ifst.maxargs)
+						ifst.r = NULL;
+					else if (ifst.ifsspc)
+						ifst.start = p0;
+					ifst.ifsspc = 0;
 				}
 
-				if (isifs) {
-					if (!(afternul || nulonly))
-						ifsspc = isdefifs;
-					/* Ignore IFS whitespace at start */
-					if (q == start && ifsspc) {
-						start = p;
-						ifsspc = 0;
-						continue;
-					}
-					if (maxargs > 0 && !--maxargs) {
-						r = q;
-						continue;
-					}
-					*q = '\0';
-					sp = (struct strlist *)stalloc(sizeof *sp);
-					sp->text = start;
-					*arglist->lastp = sp;
-					arglist->lastp = &sp->next;
-					start = p;
-					continue;
-				}
+				if (p >= string + ifsp->endoff)
+					break;
 
-				ifsspc = 0;
+				p = ifsbreakup_slow(&ifst, arglist,
+						    afternul | nulonly, p);
 			}
 		} while ((ifsp = ifsp->next) != NULL);
 		if (nulonly)
 			goto add;
+		if (ifst.r)
+			*ifst.r = '\0';
 	}
 
-	if (r)
-		*r = '\0';
-
-	if (!*start)
+	if (!*ifst.start)
 		return;
 
 add:
 	sp = (struct strlist *)stalloc(sizeof *sp);
-	sp->text = start;
+	sp->text = ifst.start;
 	*arglist->lastp = sp;
 	arglist->lastp = &sp->next;
 }
@@ -1277,7 +1381,56 @@ out:
 	ifslastp = NULL;
 }
 
+void changeifs(const char *ifs)
+{
+	mbstate_t mbs = {};
+	wchar_t *nwcifs;
+	unsigned mb = 0;
+	size_t len = 0;
+	const char *p;
+	size_t ml;
 
+	if (!ifsset())
+		ifs = defifs;
+	ncifs = ifs;
+
+	memset(ifsmap, 0, sizeof(ifsmap));
+
+	for (p = ifs;; p++) {
+		unsigned c = (unsigned char)*p;
+
+		mb |= c >> 7;
+		if (!(c >> 7))
+			ifsmap[c] = 1;
+
+		if (c == 0)
+			break;
+
+		len++;
+	}
+
+	nwcifs = NULL;
+
+	ifsmb0len = !!len;
+
+	if (!mb)
+		goto out;
+
+	ml = mbrlen(ifs, len, &mbs);
+	if (ml == -2 || ml == -1)
+		ml = 1;
+	ifsmb0len = ml;
+
+	nwcifs = ckmalloc((len + 1) * sizeof(*wcifs));
+	memset(nwcifs, 0, (len + 1) * sizeof(*wcifs));
+
+	p = ifs;
+	mbsrtowcs(nwcifs, &p, len + 1, &mbs);
+
+out:
+	ckfree(wcifs);
+	wcifs = nwcifs;
+}
 
 /*
  * Expand shell metacharacters.  At this point, the only control characters
@@ -1420,31 +1573,25 @@ static void expmeta_rmescapes(char *enddir, char *name)
 	preglob(strcpy(enddir, name), RMESCAPE_EMETA);
 }
 
-static unsigned mbcharlen(char *p)
+static int skipesc(char *p)
 {
+	unsigned short mb;
 	int esc = 0;
 
-	if (*++p == (char)CTLESC)
-		esc++;
+	mb = mbnext(p);
+	if ((mb >> 8) > 3)
+		return (mb & 0xff) + (mb >> 8) - 1;
 
-	return esc + 3 + (unsigned char)p[esc];
-}
+	esc = mb & 0xff;
 
-static size_t skipesc(char *p)
-{
-	size_t esc = 0;
-
-	if (p[esc] == (char)CTLMBCHAR)
-		esc += mbcharlen(p);
-	else if (p[esc] == (char)CTLESC)
-		esc++;
-	else if (p[esc] == '\\' && p[esc + 1]) {
+	if (!esc && p[esc] == '\\' && p[esc + 1]) {
 		while (p[++esc] == (char)CTLQUOTEMARK)
 			;
-		if (p[esc] == (char)CTLMBCHAR)
-			esc += mbcharlen(p + esc);
-		else if (p[esc] == (char)CTLESC)
-			esc++;
+		mb = mbnext(p + esc);
+		esc += mb & 0xff;
+
+		if ((mb >> 8) > 3)
+			esc += (mb >> 8) - 1;
 	}
 
 	return esc;
@@ -1845,6 +1992,7 @@ _rmescapes(char *str, int flag)
 	inquotes = 0;
 	notescaped = globbing;
 	while (*p) {
+		unsigned mb;
 		unsigned ml;
 		int newnesc = globbing;
 
@@ -1862,10 +2010,11 @@ _rmescapes(char *str, int flag)
 				goto setnesc;
 			}
 		} else if (*p == (char)CTLMBCHAR) {
-			if (*++p == (char)CTLESC)
-				p++;
+			mb = mbnext(p);
+			ml = mb >> 8;
 
-			ml = (unsigned char)*p++;
+			ml -= 2;
+			p += mb & 0xff;
 			q = mempcpy(q, p, ml);
 			p += ml + 2;
 			goto setnesc;
diff --git a/src/expand.h b/src/expand.h
index a78564f..7bcff75 100644
--- a/src/expand.h
+++ b/src/expand.h
@@ -75,6 +75,7 @@ void removerecordregions(int);
 void ifsbreakup(char *, int, struct arglist *);
 void ifsfree(void);
 void restore_handler_expandarg(struct jmploc *savehandler, int err);
+void changeifs(const char *);
 
 /* From arith.y */
 intmax_t arith(const char *);
diff --git a/src/var.c b/src/var.c
index 35ea7c6..df432b5 100644
--- a/src/var.c
+++ b/src/var.c
@@ -86,7 +86,7 @@ struct var varinit[] = {
 #if ATTY
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"ATTY\0",	0 },
 #endif
-	{ 0,	VSTRFIXED|VTEXTFIXED,		defifsvar,	0 },
+	{ 0,	VSTRFIXED|VTEXTFIXED,		defifsvar,	changeifs },
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"MAIL\0",	changemail },
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"MAILPATH\0",	changemail },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		defpathvar,	changepath },
@@ -267,9 +267,6 @@ struct var *setvareq(char *s, int flags)
 				 n);
 		}
 
-		if (vp->func && (flags & VNOFUNC) == 0)
-			(*vp->func)(varnull(s));
-
 		if ((vp->flags & (VTEXTFIXED|VSTACK)) == 0)
 			ckfree(vp->text);
 
@@ -301,6 +298,9 @@ out_free:
 	vp->text = s;
 	vp->flags = flags;
 
+	if (vp->func && (flags & VNOFUNC) == 0)
+		(*vp->func)(varnull(s));
+
 out:
 	return vp;
 }
@@ -531,12 +531,12 @@ poplocalvars(void)
 			vp->flags &= ~(VSTRFIXED|VREADONLY);
 			unsetvar(vp->text);
 		} else {
-			if (vp->func)
-				(*vp->func)(varnull(lvp->text));
 			if ((vp->flags & (VTEXTFIXED|VSTACK)) == 0)
 				ckfree(vp->text);
 			vp->flags = lvp->flags;
 			vp->text = lvp->text;
+			if (vp->func)
+				(*vp->func)(varnull(vp->text));
 		}
 		ckfree(lvp);
 	}
-- 
2.39.2

