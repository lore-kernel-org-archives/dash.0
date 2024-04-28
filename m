Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C822F43
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 03:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714276613; cv=none; b=n53ZQe0jgmUD67Ez4L4POVwwXI187aiEFsZxBWkqQxD+Jnvsd4vfzNKcUcTuRKRh1vNzf0cHrvYSnI0L5PCWyQBNKF6fInZq542F4BvlO3+BZ7b2idAGaG2kPQdMb9yLGaJyAf+SSEO1tj7qMBguqiI7CY53ThHelf0xkz2K3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714276613; c=relaxed/simple;
	bh=pNKNV+W2oj7oHc53rjrXu/H5VZuqawu5yMMwiCJx1Dk=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=s7aOSpACERjPd9r0uVkx++u1W2C1m4kkk4F1qJ2LCUvRunCEYdy4E+dCcyKrDkfKbXcY9ug4vKuiNv7nZZt1nYMilHfVNVqCnN4PtqXo03fzxljeeWKI9ifd8uWCGX/ilZXtVDkF3jKF9SNJW0WOON/Vs2HysOKXdjKg8GLsbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0veg-007PZl-2w;
	Sun, 28 Apr 2024 11:56:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Apr 2024 11:57:05 +0800
Date: Sun, 28 Apr 2024 11:57:05 +0800
Message-Id: <008ebecbab03a2504589f69ae9c2ed1353f7b6a3.1714276539.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714276539.git.herbert@gondor.apana.org.au>
References: <cover.1714276539.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 4/8] expand: Process multi-byte characters in subevalvar
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
 src/expand.c   | 192 ++++++++++++++++++++++++++++++++++---------------
 src/expand.h   |   1 +
 src/mystring.c |   2 +-
 src/parser.h   |   1 +
 4 files changed, 136 insertions(+), 60 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index ad186b0..60a51b1 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -32,27 +32,27 @@
  * SUCH DAMAGE.
  */
 
-#include <sys/types.h>
-#include <sys/time.h>
-#include <sys/stat.h>
+#include <ctype.h>
 #include <dirent.h>
-#include <unistd.h>
-#ifdef HAVE_GETPWNAM
-#include <pwd.h>
-#endif
-#include <stdlib.h>
-#include <stdio.h>
-#include <inttypes.h>
-#include <limits.h>
-#include <string.h>
 #ifdef HAVE_FNMATCH
 #include <fnmatch.h>
 #endif
 #ifdef HAVE_GLOB
 #include <glob.h>
 #endif
-#include <ctype.h>
+#include <inttypes.h>
+#include <limits.h>
+#ifdef HAVE_GETPWNAM
+#include <pwd.h>
+#endif
+#include <string.h>
 #include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <sys/stat.h>
+#include <unistd.h>
 #include <wchar.h>
 
 /*
@@ -550,8 +550,10 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
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
@@ -560,12 +562,26 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
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
 
@@ -573,14 +589,16 @@ static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
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
@@ -588,17 +606,23 @@ static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
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
@@ -652,14 +676,11 @@ static char *subevalvar(char *start, char *str, int strloc, int startloc,
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
@@ -669,16 +690,29 @@ static char *subevalvar(char *start, char *str, int strloc, int startloc,
 
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
 
@@ -704,6 +738,7 @@ evalvar(char *p, int flag)
 	ssize_t varlen;
 	int discard;
 	int quoted;
+	int mbchar;
 
 	varflags = *p++ & ~VSBIT;
 	subtype = varflags & VSTYPE;
@@ -713,8 +748,18 @@ evalvar(char *p, int flag)
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
 
@@ -801,7 +846,7 @@ static char *chtodest(int c, int flags, char *out)
 {
 	const char *syntax = flags & EXP_QUOTED ? DQSYNTAX : BASESYNTAX;
 
-	if ((flags & QUOTES_ESC) &&
+	if ((flags & (QUOTES_ESC | EXP_MBCHAR)) &&
 	    ((syntax[c] == CCTL) ||
 	     (flags & EXP_QUOTED && syntax[c] == CBACK)))
 		USTPUTC(CTLESC, out);
@@ -823,9 +868,13 @@ static size_t memtodest(const char *p, size_t len, int flags)
 	if (unlikely(!len))
 		return 0;
 
-	q = makestrspace(len * 2, expdest);
+	/* CTLMBCHAR, 2, c, c, 2, CTLMBCHAR */
+	q = makestrspace(len * 3, expdest);
 
 	do {
+		mbstate_t mbs = {};
+		size_t ml;
+
 		c = (signed char)*p++;
 
 		if (c)
@@ -833,19 +882,30 @@ static size_t memtodest(const char *p, size_t len, int flags)
 		else if (!(flags & EXP_KEEPNUL))
 			continue;
 
-		if (c < 0) {
-			mbstate_t mbs = {};
+		if (c >= 0)
+			goto copy;
 
-			p--;
-			do {
-				q = chtodest(c, flags, q);
-			} while (mbrlen(p++, 1, &mbs) == -2 &&
-				 (c = *p, --len));
-			if (!len)
-				break;
-			continue;
+		ml = mbrlen(p - 1, len, &mbs);
+		if (ml == -1 || ml == -2 || ml < 2 || ml > MB_LEN_MAX)
+			goto copy;
+
+		if ((flags & (QUOTES_ESC | EXP_MBCHAR))) {
+			USTPUTC(CTLMBCHAR, q);
+			USTPUTC(ml, q);
 		}
 
+		q = mempcpy(q, p - 1, ml);
+
+		if ((flags & (QUOTES_ESC | EXP_MBCHAR))) {
+			USTPUTC(ml, q);
+			USTPUTC(CTLMBCHAR, q);
+		}
+
+		p += ml - 1;
+		len -= ml - 1;
+		continue;
+
+copy:
 		q = chtodest(c, flags, q);
 	} while (--len);
 
@@ -1720,6 +1780,8 @@ _rmescapes(char *str, int flag)
 	inquotes = 0;
 	notescaped = globbing;
 	while (*p) {
+		unsigned ml;
+
 		if (*p == (char)CTLQUOTEMARK) {
 			p++;
 			inquotes ^= globbing;
@@ -1743,6 +1805,18 @@ add_escape:
 			}
 		}
 		notescaped = globbing;
+
+		if (*p != (char)CTLMBCHAR)
+			goto copy;
+
+		if (*++p == (char)CTLESC)
+			p++;
+
+		ml = (unsigned char)*p++;
+		q = mempcpy(q, p, ml);
+		p += ml + 2;
+		continue;
+
 copy:
 		*q++ = *p++;
 	}
diff --git a/src/expand.h b/src/expand.h
index 49a18f9..e5a990e 100644
--- a/src/expand.h
+++ b/src/expand.h
@@ -60,6 +60,7 @@ struct arglist {
 #define EXP_QUOTED	0x100	/* expand word in double quotes */
 #define EXP_KEEPNUL	0x200	/* do not skip NUL characters */
 #define EXP_DISCARD	0x400	/* discard result of expansion */
+#define EXP_MBCHAR	0x800	/* mark multi-byte characters */
 
 
 struct jmploc;
diff --git a/src/mystring.c b/src/mystring.c
index 5eace6c..77b457c 100644
--- a/src/mystring.c
+++ b/src/mystring.c
@@ -67,7 +67,7 @@ const char cqchars[] = {
 #ifdef HAVE_FNMATCH
 	'^',
 #endif
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

