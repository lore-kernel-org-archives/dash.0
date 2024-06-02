Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA34EC7
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291737; cv=none; b=fsWnjIem8OaQ5mE29lHEov9kfVTeicCFnyldjkMEhAyOhbaRrEqhB0DmDI7DzXrpvM6cqDOJjK5HRJhveJ3M2cfmaOYSSdtAneu6mtbR+EK/5if/vIblDAr05WqvhjYKDV/kapCasKjKg5mGkolrrfQeDIApPK8pe7Z9sjnzVrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291737; c=relaxed/simple;
	bh=zgKcMnjm1etEVcv8CRIaaAmM8IwoMY5TtLobyIVfdWc=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=ItP91GpsDXuZ9ooPcqFM6StzS88onIbQq27jKrEc6mwbXivtT5yyKcstFRnt58FzXtVnDa04iGZQBrMe5qJajVCEZp1FE0slNTT0SIMM/SujBpeR9BEtIYP8Eeq90AuapFE54RHpA3j57/XH8g6UPsmUon9TlxSbhS/RcZW/bXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa1i-004iRN-1T;
	Sun, 02 Jun 2024 09:28:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:28:52 +0800
Date: Sun, 02 Jun 2024 09:28:52 +0800
Message-Id: <54022459d1aca75f6baebd23377cdf03252e6d69.1717291579.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1717291579.git.herbert@gondor.apana.org.au>
References: <cover.1717291579.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 04/13] expand: Process multi-byte characters in subevalvar
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

When trimming variables in subevalvar, process multi-byte characters
as one unit instead of their constituent bytes.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c   | 170 +++++++++++++++++++++++++++++++++++--------------
 src/expand.h   |   1 +
 src/mystring.c |   2 +-
 src/parser.h   |   1 +
 4 files changed, 125 insertions(+), 49 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 0a868d5..5d73f8e 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -544,8 +544,10 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
 	loc = startp;
 	loc2 = rmesc;
 	do {
-		int match;
 		const char *s = loc2;
+		unsigned ml;
+		int match;
+
 		c = *loc2;
 		if (zero) {
 			*loc2 = '\0';
@@ -554,12 +556,26 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
 		match = pmatch(str, s);
 		*loc2 = c;
 		if (match)
-			return loc;
-		if (quotes && *loc == (char)CTLESC)
+			return quotes ? loc : loc2;
+
+		if (!c)
+			break;
+
+		if (*loc != (char)CTLMBCHAR) {
+			if (*loc == (char)CTLESC)
+				loc++;
 			loc++;
-		loc++;
-		loc2++;
-	} while (c);
+			loc2++;
+			continue;
+		}
+
+		if (*++loc == (char)CTLESC)
+			loc++;
+
+		ml = (unsigned char)*loc;
+		loc += ml + 3;
+		loc2 += ml;
+	} while (1);
 	return 0;
 }
 
@@ -567,14 +583,16 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
 static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
 		       char *str, int quotes, int zero
 ) {
-	int esc = 0;
+	size_t esc = 0;
 	char *loc;
 	char *loc2;
 
 	for (loc = endp, loc2 = rmescend; loc >= startp; loc2--) {
-		int match;
-		char c = *loc2;
 		const char *s = loc2;
+		char c = *loc2;
+		unsigned ml;
+		int match;
+
 		if (zero) {
 			*loc2 = '\0';
 			s = rmesc;
@@ -582,17 +600,23 @@ static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
 		match = pmatch(str, s);
 		*loc2 = c;
 		if (match)
-			return loc;
+			return quotes ? loc : loc2;
 		loc--;
-		if (quotes) {
-			if (--esc < 0) {
-				esc = esclen(startp, loc);
-			}
-			if (esc % 2) {
-				esc--;
-				loc--;
-			}
+		if (!esc--)
+			esc = esclen(startp, loc);
+		if (esc % 2) {
+			esc--;
+			loc--;
+			continue;
 		}
+		if (*loc != (char)CTLMBCHAR)
+			continue;
+
+		ml = (unsigned char)*--loc;
+		loc -= ml + 2;
+		if (*loc == (char)CTLESC)
+			loc--;
+		loc2 -= ml - 1;
 	}
 	return 0;
 }
@@ -646,14 +670,11 @@ static char *subevalvar(char *start, char *str, int strloc, int startloc,
 		nstrloc = str - (char *)stackblock();
 	}
 
-	rmesc = startp;
-	if (quotes) {
-		rmesc = _rmescapes(startp, RMESCAPE_ALLOC | RMESCAPE_GROW);
-		if (rmesc != startp)
-			rmescend = expdest;
-		startp = stackblock() + startloc;
-		str = stackblock() + nstrloc;
-	}
+	rmesc = _rmescapes(startp, RMESCAPE_ALLOC | RMESCAPE_GROW);
+	if (rmesc != startp)
+		rmescend = expdest;
+	startp = stackblock() + startloc;
+	str = stackblock() + nstrloc;
 	rmescend--;
 
 	/* zero = subtype == VSTRIMLEFT || subtype == VSTRIMLEFTMAX */
@@ -663,16 +684,29 @@ static char *subevalvar(char *start, char *str, int strloc, int startloc,
 
 	endp = stackblock() + strloc - 1;
 	loc = scan(startp, endp, rmesc, rmescend, str, quotes, zero);
-	if (loc) {
-		if (zero) {
-			memmove(startp, loc, endp - loc);
-			loc = startp + (endp - loc);
+	if (!loc) {
+		if (quotes) {
+			rmesc = startp;
+			rmescend = endp;
 		}
-		*loc = '\0';
-	} else
-		loc = endp;
+	} else if (!quotes) {
+		if (zero)
+			rmesc = loc;
+		else
+			rmescend = loc;
+	} else if (zero) {
+		rmesc = loc;
+		rmescend = endp;
+	} else {
+		rmesc = startp;
+		rmescend = loc;
+	}
+
+	memmove(startp, rmesc, rmescend - rmesc);
+	loc = startp + (rmescend - rmesc);
 
 out:
+	*loc = '\0';
 	amount = loc - expdest;
 	STADJUST(amount, expdest);
 
@@ -698,6 +732,7 @@ evalvar(char *p, int flag)
 	ssize_t varlen;
 	int discard;
 	int quoted;
+	int mbchar;
 
 	varflags = *p++ & ~VSBIT;
 	subtype = varflags & VSTYPE;
@@ -707,8 +742,18 @@ evalvar(char *p, int flag)
 	startloc = expdest - (char *)stackblock();
 	p = strchr(p, '=') + 1;
 
+	mbchar = 0;
+	switch (subtype) {
+	case VSTRIMLEFT:
+	case VSTRIMLEFTMAX:
+	case VSTRIMRIGHT:
+	case VSTRIMRIGHTMAX:
+		mbchar = EXP_MBCHAR;
+		break;
+	}
+
 again:
-	varlen = varvalue(var, varflags, flag, quoted);
+	varlen = varvalue(var, varflags, flag | mbchar, quoted);
 	if (varflags & VSNUL)
 		varlen--;
 
@@ -814,14 +859,31 @@ static struct mbpair mbtodest(const char *p, char *q, const char *syntax,
 	size_t ml;
 
 	ml = mbrlen(--p, len, &mbs);
-	if (ml == -2 || ml == -1 || ml < 2)
+	if (ml == -2 || ml == -1 || ml < 2) {
+		q = chtodest((signed char)*p, syntax, q);
 		ml = 1;
+		goto out;
+	}
 
 	len = ml;
 	do {
 		q = chtodest((signed char)*p++, syntax, q);
 	} while (--len);
+	goto out;
 
+	if (syntax[CTLMBCHAR] == CCTL) {
+		USTPUTC(CTLMBCHAR, q);
+		USTPUTC(ml, q);
+	}
+
+	q = mempcpy(q, p, ml);
+
+	if (syntax[CTLMBCHAR] == CCTL) {
+		USTPUTC(ml, q);
+		USTPUTC(CTLMBCHAR, q);
+	}
+
+out:
 	mbp.ml = ml - 1;
 	mbp.ql = q - q0;
 	return mbp;
@@ -841,13 +903,15 @@ static size_t memtodest(const char *p, size_t len, int flags)
 	if (unlikely(!len))
 		return 0;
 
-	q = makestrspace(len * 2, expdest);
+	/* CTLMBCHAR, 2, c, c, 2, CTLMBCHAR */
+	q = makestrspace(len * 3, expdest);
 
-#if QUOTES_ESC != 0x11 || EXP_QUOTED != 0x100
-#error QUOTES_ESC != 0x11 || EXP_QUOTED != 0x100
+#if QUOTES_ESC != 0x11 || EXP_MBCHAR != 0x20 || EXP_QUOTED != 0x100
+#error QUOTES_ESC != 0x11 || EXP_MBCHAR != 0x20 || EXP_QUOTED != 0x100
 #endif
 	expq = flags & EXP_QUOTED;
-	if (likely(!(flags & (expq >> 4 | expq >> 8) & QUOTES_ESC))) {
+	if (likely(!(flags & (expq >> 3 | expq >> 4 | expq >> 8) &
+		     (QUOTES_ESC | EXP_MBCHAR)))) {
 		while (len >= 8) {
 			uint64_t x = *(uint64_t *)(p + count);
 
@@ -864,7 +928,8 @@ static size_t memtodest(const char *p, size_t len, int flags)
 		q += count;
 		p += count;
 
-		syntax = flags & QUOTES_ESC ? BASESYNTAX : is_type;
+		syntax = flags & (QUOTES_ESC | EXP_MBCHAR) ?
+			 BASESYNTAX : is_type;
 	} else
 		syntax = SQSYNTAX;
 
@@ -1772,17 +1837,25 @@ _rmescapes(char *str, int flag)
 	inquotes = 0;
 	notescaped = globbing;
 	while (*p) {
+		unsigned ml;
+		int newnesc = globbing;
+
 		if (*p == (char)CTLQUOTEMARK) {
 			p++;
 			inquotes ^= globbing;
 			continue;
-		}
-		if (*p == '\\') {
+		} else if (*p == '\\') {
 			/* naked back slash */
-			notescaped ^= globbing;
-			goto copy;
-		}
-		if (*p == (char)CTLESC) {
+			newnesc ^= notescaped;
+		} else if (*p == (char)CTLMBCHAR) {
+			if (*++p == (char)CTLESC)
+				p++;
+
+			ml = (unsigned char)*p++;
+			q = mempcpy(q, p, ml);
+			p += ml + 2;
+			goto setnesc;
+		} else if (*p == (char)CTLESC) {
 			p++;
 			if (notescaped)
 				*q++ = '\\';
@@ -1791,9 +1864,10 @@ _rmescapes(char *str, int flag)
 				*q++ = '\\';
 			}
 		}
-		notescaped = globbing;
-copy:
+
 		*q++ = *p++;
+setnesc:
+		notescaped = newnesc;
 	}
 	*q = '\0';
 	if (flag & RMESCAPE_GROW) {
diff --git a/src/expand.h b/src/expand.h
index 49a18f9..a78564f 100644
--- a/src/expand.h
+++ b/src/expand.h
@@ -55,6 +55,7 @@ struct arglist {
 #define	EXP_VARTILDE	0x4	/* expand tildes in an assignment */
 #define	EXP_REDIR	0x8	/* file glob for a redirection (1 match only) */
 #define EXP_CASE	0x10	/* keeps quotes around for CASE pattern */
+#define EXP_MBCHAR	0x20	/* mark multi-byte characters */
 #define EXP_VARTILDE2	0x40	/* expand tildes after colons only */
 #define EXP_WORD	0x80	/* expand word in parameter expansion */
 #define EXP_QUOTED	0x100	/* expand word in double quotes */
diff --git a/src/mystring.c b/src/mystring.c
index 7bf61e3..ca0cd39 100644
--- a/src/mystring.c
+++ b/src/mystring.c
@@ -64,7 +64,7 @@ const char dolatstr[] = { CTLQUOTEMARK, CTLVAR, VSNORMAL | VSBIT, '@', '=',
 			  CTLQUOTEMARK, '\0' };
 const char cqchars[] = {
 	'\\',
-	CTLESC, CTLQUOTEMARK, 0
+	CTLESC, CTLMBCHAR, CTLQUOTEMARK, 0
 };
 const char illnum[] = "Illegal number: %s";
 const char homestr[] = "HOME";
diff --git a/src/parser.h b/src/parser.h
index 433573d..14bfc4f 100644
--- a/src/parser.h
+++ b/src/parser.h
@@ -44,6 +44,7 @@ union node;
 #define CTLVAR -126		/* variable defn */
 #define CTLENDVAR -125
 #define CTLBACKQ -124
+#define CTLMBCHAR -123
 #define	CTLARI -122		/* arithmetic expression */
 #define	CTLENDARI -121
 #define	CTLQUOTEMARK -120
-- 
2.39.2

