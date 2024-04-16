Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934AC42062
	for <dash@vger.kernel.org>; Sat, 27 Apr 2024 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216028; cv=none; b=TuRVM9bPDr6H09f0ly+/pM9RM4ufe/+cyR2iwwgszFSiIeRwC2VECA0mkLyb9ZUz56V2LkhgNEXwIzM9J+ruXCUGokdKbjqnw2sHPBl+hX69qo0cUJcmRH+uihd52SrglEHpXPjcC/MTVndMI5zI/HqH896GOGc12TlPvfI3zUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216028; c=relaxed/simple;
	bh=WM4K4qsej20xU9qC+ULpNgYM938hmoTCpH8V5sWVgEA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To; b=WJ+3fuo3RTOQ+8mj06K/VUr7jjraDPXrF14As14SRzL04p/ZT7qKCEPkVYatZCaNh7u/dQm4WQPcMCJ5r3QZ2uOuMOfDdAZABhtMyzUu9hHYxJahgyFjoZ8ERoszwMRmYDyoISG1Dsb6h6kWDt4UZDdTbPddCk0m6tHgKvld5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0ftW-0079mE-2f;
	Sat, 27 Apr 2024 19:07:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 27 Apr 2024 19:07:20 +0800
Message-Id: <edd263ecc3cc833eee1d44b10a0e3cbb74c64edd.1714215826.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714215826.git.herbert@gondor.apana.org.au>
References: <cover.1714215826.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 17 Apr 2024 07:13:16 +0800
Subject: [PATCH 3/8] expand: Count multi-byte characters for VSLENGTH
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
 src/expand.c | 62 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 9ac981e..ad186b0 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -53,6 +53,7 @@
 #endif
 #include <ctype.h>
 #include <stdbool.h>
+#include <wchar.h>
 
 /*
  * Routines to expand arguments to commands.  We have to deal with
@@ -796,6 +797,18 @@ really_record:
 	return p;
 }
 
+static char *chtodest(int c, int flags, char *out)
+{
+	const char *syntax = flags & EXP_QUOTED ? DQSYNTAX : BASESYNTAX;
+
+	if ((flags & QUOTES_ESC) &&
+	    ((syntax[c] == CCTL) ||
+	     (flags & EXP_QUOTED && syntax[c] == CBACK)))
+		USTPUTC(CTLESC, out);
+	USTPUTC(c, out);
+
+	return out;
+}
 
 /*
  * Put a string on the stack.
@@ -803,38 +816,48 @@ really_record:
 
 static size_t memtodest(const char *p, size_t len, int flags)
 {
-	const char *syntax = flags & EXP_QUOTED ? DQSYNTAX : BASESYNTAX;
+	size_t count = 0;
 	char *q;
-	char *s;
+	int c;
 
 	if (unlikely(!len))
 		return 0;
 
 	q = makestrspace(len * 2, expdest);
-	s = q;
 
 	do {
-		int c = (signed char)*p++;
-		if (c) {
-			if ((flags & QUOTES_ESC) &&
-			    ((syntax[c] == CCTL) ||
-			     (flags & EXP_QUOTED && syntax[c] == CBACK)))
-				USTPUTC(CTLESC, q);
-		} else if (!(flags & EXP_KEEPNUL))
+		c = (signed char)*p++;
+
+		if (c)
+			count++;
+		else if (!(flags & EXP_KEEPNUL))
 			continue;
-		USTPUTC(c, q);
+
+		if (c < 0) {
+			mbstate_t mbs = {};
+
+			p--;
+			do {
+				q = chtodest(c, flags, q);
+			} while (mbrlen(p++, 1, &mbs) == -2 &&
+				 (c = *p, --len));
+			if (!len)
+				break;
+			continue;
+		}
+
+		q = chtodest(c, flags, q);
 	} while (--len);
 
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
 
 
@@ -856,6 +879,7 @@ varvalue(char *name, int varflags, int flags, int quoted)
 	int discard = (subtype == VSPLUS || subtype == VSLENGTH) |
 		      (flags & EXP_DISCARD);
 	ssize_t len = 0;
+	size_t start;
 	char c;
 
 	if (!subtype) {
@@ -865,9 +889,9 @@ varvalue(char *name, int varflags, int flags, int quoted)
 		sh_error("Bad substitution");
 	}
 
-	flags |= EXP_KEEPNUL;
 	flags &= discard ? ~QUOTES_ESC : ~0;
 	sep = (flags & EXP_FULL) << CHAR_BIT;
+	start = expdest - (char *)stackblock();
 
 	switch (*name) {
 	case '$':
@@ -927,7 +951,7 @@ param:
 
 			if (*ap && sep) {
 				len++;
-				memtodest(&sepc, 1, flags);
+				memtodest(&sepc, 1, flags | EXP_KEEPNUL);
 			}
 		}
 		break;
@@ -957,7 +981,7 @@ value:
 	}
 
 	if (discard)
-		STADJUST(-len, expdest);
+		expdest = (char *)stackblock() + start;
 
 	return len;
 }
@@ -1758,11 +1782,13 @@ casematch(union node *pattern, char *val)
 
 static size_t cvtnum(intmax_t num, int flags)
 {
+	size_t start = expdest - (char *)stackblock();
 	int len = max_int_length(sizeof(num));
 	char buf[len];
 
 	len = fmtstr(buf, len, "%" PRIdMAX, num);
-	return memtodest(buf, len, flags);
+	memtodest(buf, len, flags);
+	return (expdest - (char *)stackblock()) - start;
 }
 
 STATIC void
-- 
2.39.2

