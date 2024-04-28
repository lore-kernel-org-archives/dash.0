Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC62900
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714276617; cv=none; b=KyvoSDL7ByzIR9c+cTtNVAUdeicR0j8JA+qAURnIaHDUETDquZ6t4hGkXFg4MuZCqJ+JsHOZO42fPLR2tuZTE3V3ThFsYErBCL80b2KE/xV6LsFGbeiKLrY44bQLUk8QK+QzaDMSG+2Vffwr4zu4869QvyfrEXcJ6lzIRzWZ808=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714276617; c=relaxed/simple;
	bh=qd9G7hnmDp8igWOW5LymgjpCbWab9ETYgYteQgf2G8Y=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=gd3c/a3SkPeBvAVPeNU+1tEwEEg6ul4L337XWQ0h+UJtJ6rCfrNIhBUqx2+HCZ/4YZWerxInQIjB755xcP4aM3rJogx3PpdOMQC8LX8wXypQ733hGa5xqkK3D9hqxtHurGnp8sFj2UO4LilgjCbEUZacJenQEUXhxHbayYkjv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0vel-007PaZ-1i;
	Sun, 28 Apr 2024 11:56:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Apr 2024 11:57:09 +0800
Date: Sun, 28 Apr 2024 11:57:09 +0800
Message-Id: <ffd890700a18b9beaad65e26876b1d7932b0d018.1714276539.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714276539.git.herbert@gondor.apana.org.au>
References: <cover.1714276539.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 6/8] expand: Support multi-byte characters during field
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
 src/expand.c | 201 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 140 insertions(+), 61 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 0e85025..dd2b71e 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -54,6 +54,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <wchar.h>
+#include <wctype.h>
 
 /*
  * Routines to expand arguments to commands.  We have to deal with
@@ -164,6 +165,30 @@ esclen(const char *start, const char *p) {
 	return esc;
 }
 
+static __attribute__((noinline)) unsigned mbnext(const char *p)
+{
+	unsigned start = 0;
+	unsigned end = 0;
+	unsigned ml;
+	int c;
+
+	c = p[end++];
+
+	switch (c) {
+	case CTLMBCHAR:
+		if (p[end] == CTLESC)
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
@@ -552,6 +577,7 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
 	loc2 = rmesc;
 	do {
 		const char *s = loc2;
+		unsigned mb;
 		unsigned ml;
 		int match;
 
@@ -568,19 +594,9 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
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
@@ -930,18 +946,22 @@ static size_t strtodest(const char *p, int flags)
 STATIC ssize_t
 varvalue(char *name, int varflags, int flags, int quoted)
 {
+	int subtype = varflags & VSTYPE;
+	const char *seps;
+	ssize_t len = 0;
+	unsigned seplen;
+	size_t start;
+	int discard;
+	char sepc;
+	char **ap;
+	int sep;
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
+	int c;
+
+	discard = (subtype == VSPLUS || subtype == VSLENGTH) |
+		  (flags & EXP_DISCARD);
 
 	if (!subtype) {
 		if (discard)
@@ -1004,15 +1024,27 @@ numvar:
 		sep &= ~quoted;
 		sep |= ifsset() ? (unsigned char)(c & ifsval()[0]) : ' ';
 param:
-		sepc = sep;
 		if (!(ap = shellparam.p))
 			return -1;
+		sepc = sep;
+		seps = &sepc;
+		seplen = 1;
+		if (sepc < 0) {
+			mbstate_t mbs = {};
+			size_t ml;
+
+			ml = mbrlen(ifsval(), strlen(ifsval()), &mbs);
+			if (ml != -1 && ml != -2 && ml > 1) {
+				seps = ifsval();
+				seplen = ml;
+			}
+		}
 		while ((p = *ap++)) {
 			len += strtodest(p, flags);
 
 			if (*ap && sep) {
 				len++;
-				memtodest(&sepc, 1, flags | EXP_KEEPNUL);
+				memtodest(seps, seplen, flags | EXP_KEEPNUL);
 			}
 		}
 		break;
@@ -1074,7 +1106,54 @@ recordregion(int start, int end, int nulonly)
 	ifslastp->nulonly = nulonly;
 }
 
+static __attribute__((noinline)) unsigned ifsisifs(
+	const char *p, unsigned ml, const char *ifs, size_t ifslen)
+{
+	bool isdefifs = false;
+	size_t slen = ifslen;
+	const char *s = ifs;
+	wchar_t c = *p;
+	bool isifs;
 
+	isifs = !c;
+	if (isifs) {
+		p = ifs;
+		c = *p;
+		slen = 0;
+	}
+
+	while (slen) {
+		mbstate_t mbst = {};
+		size_t ifsml;
+		wchar_t c2;
+
+		if ((signed char)*s > 0 ||
+		    (ifsml = mbrtowc(&c2, s, slen, &mbst),
+		     ifsml == -2 || ifsml == -1 || ifsml < 2)) {
+			if (c == *s) {
+				isifs = true;
+				break;
+			}
+			s++;
+			slen--;
+			continue;
+		}
+
+		if (ifsml == ml && !memcmp(p, s, ifsml)) {
+			isifs = true;
+			c = c2;
+			break;
+		}
+
+		s += ifsml;
+		slen -= ifsml;
+	}
+
+	if (isifs)
+		isdefifs = iswspace(c);
+
+	return isifs | isdefifs << 1;
+}
 
 /*
  * Break the argument string into pieces based upon IFS and add the
@@ -1086,16 +1165,16 @@ recordregion(int start, int end, int nulonly)
 void
 ifsbreakup(char *string, int maxargs, struct arglist *arglist)
 {
+	const char *ifs, *realifs;
 	struct ifsregion *ifsp;
 	struct strlist *sp;
+	char *r = NULL;
+	size_t ifslen;
 	char *start;
+	int nulonly;
+	int ifsspc;
 	char *p;
 	char *q;
-	char *r = NULL;
-	const char *ifs, *realifs;
-	int ifsspc;
-	int nulonly;
-
 
 	start = string;
 	if (ifslastp != NULL) {
@@ -1110,21 +1189,27 @@ ifsbreakup(char *string, int maxargs, struct arglist *arglist)
 			afternul = nulonly;
 			nulonly = ifsp->nulonly;
 			ifs = nulonly ? nullstr : realifs;
+			ifslen = strlen(ifs);
 			ifsspc = 0;
 			while (p < string + ifsp->endoff) {
-				int c;
-				bool isifs;
+				unsigned ifschar;
+				unsigned sisifs;
 				bool isdefifs;
+				unsigned ml;
+				bool isifs;
 
 				q = p;
-				c = *p++;
-				if (c == (char)CTLESC)
-					c = *p++;
 
-				isifs = strchr(ifs, c);
-				isdefifs = false;
-				if (isifs)
-					isdefifs = strchr(defifs, c);
+				ifschar = mbnext(p);
+				p += ifschar & 0xff;
+				ml = (ifschar >> 8) > 3 ?
+				     (ifschar >> 8) - 2 : 0;
+
+				sisifs = ifsisifs(p, ml, ifs, ifslen);
+				p += ifschar >> 8;
+
+				isifs = sisifs & 1;
+				isdefifs = sisifs >> 1;
 
 				/* If only reading one more argument:
 				 * If we have exactly one field,
@@ -1380,32 +1465,24 @@ static void expmeta_rmescapes(char *enddir, char *name)
 	preglob(strcpy(enddir, name), RMESCAPE_EMETA);
 }
 
-static unsigned mbcharlen(char *p)
-{
-	int esc = 0;
-
-	if (*++p == (char)CTLESC)
-		esc++;
-
-	return esc + 3 + (unsigned char)p[esc];
-}
-
 static int skipesc(char *p)
 {
+	unsigned short mb;
 	int esc = 0;
 
-	if (p[esc] == (char)CTLMBCHAR)
-		return esc + mbcharlen(p);
+	mb = mbnext(p);
+	if ((mb >> 8) > 3)
+		return (mb & 0xff) + (mb >> 8) - 1;
 
-	if (*p == (char)CTLESC)
-		esc++;
+	esc = mb & 0xff;
 
 	if (p[esc] == '\\' && p[esc + 1]) {
 		esc++;
-		if (p[esc] == (char)CTLMBCHAR)
-			return esc + mbcharlen(p + esc);
-		if (p[esc] == (char)CTLESC)
-			esc++;
+		mb = mbnext(p + esc);
+		if ((mb >> 8) > 3)
+			return esc + (mb & 0xff) + (mb >> 8) - 1;
+
+		esc += mb & 0xff;
 	}
 
 	return esc;
@@ -1813,6 +1890,7 @@ _rmescapes(char *str, int flag)
 	inquotes = 0;
 	notescaped = globbing;
 	while (*p) {
+		unsigned mb;
 		unsigned ml;
 
 		if (*p == (char)CTLQUOTEMARK) {
@@ -1845,13 +1923,14 @@ add_escape:
 		}
 		notescaped = globbing;
 
-		if (*p != (char)CTLMBCHAR)
+		mb = mbnext(p);
+		ml = mb >> 8;
+
+		if (ml <= 3)
 			goto copy;
 
-		if (*++p == (char)CTLESC)
-			p++;
-
-		ml = (unsigned char)*p++;
+		ml -= 2;
+		p += mb & 0xff;
 		q = mempcpy(q, p, ml);
 		p += ml + 2;
 		continue;
-- 
2.39.2

