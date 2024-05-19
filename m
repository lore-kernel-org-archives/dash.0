Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958914437
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096019; cv=none; b=QaqBVmr1GRQtVsHlraYdu1Bn3+Y5L57+N6ov84ATKO1+jkFZc30oTYs89p7CRurfnPAHiFZ51uiKHoY8q0erOdYpC4+o9xMvt9G0apl2T7DoQds+EMtoTMSkVfAkH0/XAznmqt4Y+vLh2x18wDcoWNb+cbOXEpm72+t76lsKz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096019; c=relaxed/simple;
	bh=N7HmBoF6ebGEKvB6WOYYtSMbHYZ4y7BXPR9dum58Yk0=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=nPf1OyDI78E+utCzM2Mqki2zRFQVn8THRkq+dxoOC8IBGLsu7PLFP7+KED+AqiFx1RxOR6GxAicaNr6INBw/rM2pULzHw+j/0vviGrYtm3JVaLqDhg1KBPJu1SdhwH5/l8WUjKRNpK00uoKLskzbMjwKajQn7ziCFXPVfmCq6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Yxx-00HGAL-1O;
	Sun, 19 May 2024 13:20:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:20:14 +0800
Date: Sun, 19 May 2024 13:20:14 +0800
Message-Id: <165ebdcfeeedf01a7f5894c8bea3ea4d002e3866.1716095868.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1716095868.git.herbert@gondor.apana.org.au>
References: <cover.1716095868.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 03/13] expand: Count multi-byte characters for VSLENGTH
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Count multi-byte characters in variables and rather than bytes
and return that as the length expansion.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c   | 105 ++++++++++++++++++++++++++++++++++++++++---------
 src/memalloc.h |  10 ++---
 2 files changed, 92 insertions(+), 23 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 38f8785..5260d16 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -53,6 +53,7 @@
 #endif
 #include <ctype.h>
 #include <stdbool.h>
+#include <wchar.h>
 
 /*
  * Routines to expand arguments to commands.  We have to deal with
@@ -789,6 +790,41 @@ really_record:
 	return p;
 }
 
+static char *chtodest(int c, const char *syntax, char *out)
+{
+	if (syntax[c] == CCTL)
+		USTPUTC(CTLESC, out);
+	USTPUTC(c, out);
+
+	return out;
+}
+
+struct mbpair {
+	unsigned ml;
+	unsigned ql;
+};
+
+static struct mbpair mbtodest(const char *p, char *q, const char *syntax,
+			      size_t len)
+{
+	mbstate_t mbs = {};
+	struct mbpair mbp;
+	char *q0 = q;
+	size_t ml;
+
+	ml = mbrlen(--p, len, &mbs);
+	if (ml == -2 || ml == -1 || ml < 2)
+		ml = 1;
+
+	len = ml;
+	do {
+		q = chtodest((signed char)*p++, syntax, q);
+	} while (--len);
+
+	mbp.ml = ml - 1;
+	mbp.ql = q - q0;
+	return mbp;
+}
 
 /*
  * Put a string on the stack.
@@ -796,38 +832,70 @@ really_record:
 
 static size_t memtodest(const char *p, size_t len, int flags)
 {
-	const char *syntax = flags & EXP_QUOTED ? DQSYNTAX : BASESYNTAX;
+	const char *syntax;
+	size_t count = 0;
 	char *q;
-	char *s;
 
 	if (unlikely(!len))
 		return 0;
 
 	q = makestrspace(len * 2, expdest);
-	s = q;
 
-	do {
+#if QUOTES_ESC != 0x11 || EXP_QUOTED != 0x100
+#error QUOTES_ESC != 0x11 || EXP_QUOTED != 0x100
+#endif
+	if (likely(!(flags & (flags >> 4 | flags >> 8) & QUOTES_ESC))) {
+		while (len >= 8) {
+			uint64_t x = *(uint64_t *)(p + count);
+
+			if ((x | (x - 0x0101010101010101)) &
+			    0x8080808080808080)
+				break;
+
+			*(uint64_t *)(q + count) = x;
+
+			count += 8;
+			len -= 8;
+		}
+
+		q += count;
+		p += count;
+
+		syntax = flags & QUOTES_ESC ? BASESYNTAX : is_type;
+	} else
+		syntax = SQSYNTAX;
+
+	for (; len; len--) {
 		int c = (signed char)*p++;
-		if (c) {
-			if ((flags & QUOTES_ESC) &&
-			    ((syntax[c] == CCTL) ||
-			     (flags & EXP_QUOTED && syntax[c] == CBACK)))
-				USTPUTC(CTLESC, q);
-		} else if (!(flags & EXP_KEEPNUL))
+
+		if (unlikely(!c && !(flags & EXP_KEEPNUL)))
 			continue;
-		USTPUTC(c, q);
-	} while (--len);
+
+		count++;
+
+		if (unlikely(c < 0)) {
+			struct mbpair mbp = mbtodest(p, q, syntax, len);
+			unsigned mlm;
+
+			q += mbp.ql;
+			mlm = mbp.ml;
+			p += mlm;
+			len -= mlm;
+			continue;
+		}
+
+		q = chtodest(c, syntax, q);
+	}
 
 	expdest = q;
-	return q - s;
+	return count;
 }
 
 
 static size_t strtodest(const char *p, int flags)
 {
 	size_t len = strlen(p);
-	memtodest(p, len, flags);
-	return len;
+	return memtodest(p, len, flags);
 }
 
 
@@ -849,6 +917,7 @@ varvalue(char *name, int varflags, int flags, int quoted)
 	int discard = (subtype == VSPLUS || subtype == VSLENGTH) |
 		      (flags & EXP_DISCARD);
 	ssize_t len = 0;
+	size_t start;
 	char c;
 
 	if (!subtype) {
@@ -858,9 +927,9 @@ varvalue(char *name, int varflags, int flags, int quoted)
 		sh_error("Bad substitution");
 	}
 
-	flags |= EXP_KEEPNUL;
 	flags &= discard ? ~QUOTES_ESC : ~0;
 	sep = (flags & EXP_FULL) << CHAR_BIT;
+	start = expdest - (char *)stackblock();
 
 	switch (*name) {
 	case '$':
@@ -920,7 +989,7 @@ param:
 
 			if (*ap && sep) {
 				len++;
-				memtodest(&sepc, 1, flags);
+				memtodest(&sepc, 1, flags | EXP_KEEPNUL);
 			}
 		}
 		break;
@@ -950,7 +1019,7 @@ value:
 	}
 
 	if (discard)
-		STADJUST(-len, expdest);
+		expdest = (char *)stackblock() + start;
 
 	return len;
 }
diff --git a/src/memalloc.h b/src/memalloc.h
index a7f7996..1895c1e 100644
--- a/src/memalloc.h
+++ b/src/memalloc.h
@@ -81,11 +81,11 @@ static inline char *_STPUTC(int c, char *p) {
 #define STPUTC(c, p) ((p) = _STPUTC((c), (p)))
 #define CHECKSTRSPACE(n, p) \
 	({ \
-		char *q = (p); \
-		size_t l = (n); \
-		size_t m = sstrend - q; \
-		if (l > m) \
-			(p) = makestrspace(l, q); \
+		char *_q = (p); \
+		size_t _l = (n); \
+		size_t _m = sstrend - _q; \
+		if (_l > _m) \
+			(p) = makestrspace(_l, _q); \
 		0; \
 	})
 #define USTPUTC(c, p)	(*p++ = (c))
-- 
2.39.2

