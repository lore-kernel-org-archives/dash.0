Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853CB6FC5
	for <dash@vger.kernel.org>; Sun,  5 May 2024 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714900490; cv=none; b=P2b9hD+VMzFS/BWWZFHkl2QNlfCv6hfK+4T58Vh6leXk0bYN8poQ4syUxELa74rQqMjzMSfptY6c0VNw92iBIsn5v7faJLGR4tHCXE24fHzzvD75sopZWNVtHG3KV8rZbM4YFyJSAPLBNmeazl9AM/RUEUVznRiIsu1Q7CaGd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714900490; c=relaxed/simple;
	bh=QmHsZph8Q1wX9NCW6D8ApcTfhqAcnMzCtdkS7qRSe64=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=pPPWmnS7sgb6bMsYl3gSkWIAIuswB3qs4+o6fg+JJDB3EPEUeqsoCQGdzkV3mHn70R4R8okmDyl160gn20Zcl+H+9ozQx0qHMJVchZxuVwqN1TlGc3VA+lE3/e1F0riEwY0t5w3+fKHsMD9CXXFknG0zAqym8NTiliQb68anfxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s3XxE-00AaXT-2A;
	Sun, 05 May 2024 17:14:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 May 2024 17:14:45 +0800
Date: Sun, 05 May 2024 17:14:45 +0800
Message-Id: <c943cd4d1e762ad7a48fb8697aacbd037a5fba69.1714900377.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714900377.git.herbert@gondor.apana.org.au>
References: <cover.1714900377.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 09/13] parser: Add support for multi-byte characters
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Add the requisite markers for multi-byte characters so that the
expansion code can recognise them.  Also allow wide blank characters
to terminate words.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/expand.c |  19 +++++++
 src/mktokens |   1 +
 src/parser.c | 136 +++++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 129 insertions(+), 27 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index dd2b71e..402289f 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -265,6 +265,7 @@ static char *argstr(char *p, int flag)
 		CTLESC,
 		CTLVAR,
 		CTLBACKQ,
+		CTLMBCHAR,
 		CTLARI,
 		CTLENDARI,
 		0
@@ -289,6 +290,8 @@ tilde:
 start:
 	startloc = expdest - (char *)stackblock();
 	for (;;) {
+		unsigned ml;
+		unsigned mb;
 		int end;
 
 		length += strcspn(p + length, reject);
@@ -351,6 +354,22 @@ addquote:
 				startloc++;
 			}
 			break;
+		case CTLMBCHAR:
+			c = (signed char)*p--;
+			mb = mbnext(p);
+			ml = (mb >> 8) - 2;
+			if (flag & QUOTES_ESC) {
+				length = (mb >> 8) + (mb & 0xff);
+				if (c == (char)CTLESC)
+					startloc += length;
+				break;
+			}
+			if (c == CTLESC)
+				startloc += ml;
+			p += mb & 0xff;
+			expdest = stnputs(p, ml, expdest);
+			p += mb >> 8;
+			break;
 		case CTLESC:
 			startloc++;
 			length++;
diff --git a/src/mktokens b/src/mktokens
index 78055be..dcef676 100644
--- a/src/mktokens
+++ b/src/mktokens
@@ -41,6 +41,7 @@
 
 cat > "${TMPDIR}"/ka$$ <<\!
 TEOF	1	end of file
+TBLANK	0	blank
 TNL	0	newline
 TSEMI	0	";"
 TBACKGND 0	"&"
diff --git a/src/parser.c b/src/parser.c
index 27611f0..71d61f3 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -36,7 +36,11 @@
 #include <alloca.h>
 #endif
 
+#include <limits.h>
+#include <stdbool.h>
 #include <stdlib.h>
+#include <wchar.h>
+#include <wctype.h>
 
 #include "shell.h"
 #include "parser.h"
@@ -801,6 +805,8 @@ xxreadtoken(void)
 		setprompt(2);
 	}
 	for (;;) {	/* until token or start of word found */
+		int tok;
+
 		c = pgetc_eatbnl();
 		switch (c) {
 		case ' ': case '\t':
@@ -834,9 +840,10 @@ xxreadtoken(void)
 		case ')':
 			RETURN(TRP);
 		}
-		break;
+		tok = readtoken1(c, BASESYNTAX, (char *)NULL, 0);
+		if (tok != TBLANK)
+			return tok;
 	}
-	return readtoken1(c, BASESYNTAX, (char *)NULL, 0);
 #undef RETURN
 }
 
@@ -876,7 +883,53 @@ static void synstack_pop(struct synstack **stack)
 	*stack = (*stack)->next;
 }
 
+static unsigned getmbc(int c, char *out, int mode)
+{
+	char *const start = out;
+	mbstate_t mbst = {};
+	unsigned ml = 0;
+	size_t ml2;
+	wchar_t wc;
+	char *mbc;
 
+	if (likely(c >= 0))
+		return 0;
+
+	mbc = (mode & 3) < 2 ? out + 2 + (mode == 1) : out;
+	mbc[ml] = c;
+	while ((ml2 = mbrtowc(&wc, mbc + ml++, 1, &mbst)) == -2) {
+		if (ml >= MB_LEN_MAX)
+			break;
+		c = pgetc_eoa();
+		if (c == PEOA || c == PEOF)
+			break;
+		mbc[ml] = c;
+	}
+
+	if (ml2 == 1 && ml > 1) {
+		if (mode == 4 && iswblank(wc))
+			return 1;
+
+		if ((mode & 3) < 2) {
+			USTPUTC(CTLMBCHAR, out);
+			if (mode == 1)
+				USTPUTC(CTLESC, out);
+			USTPUTC(ml, out);
+		}
+		STADJUST(ml, out);
+		if ((mode & 3) < 2) {
+			USTPUTC(ml, out);
+			USTPUTC(CTLMBCHAR, out);
+		}
+
+		return out - start;
+	}
+
+	if (ml > 1)
+		pungetn(ml - 1);
+
+	return 0;
+}
 
 /*
  * If eofmark is NULL, read a word or a redirection symbol.  If eofmark
@@ -929,12 +982,29 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 		}
 #endif
 		CHECKEND();	/* set c to PEOF if at end of here document */
-		for (;;) {	/* until end of line or end of word */
-			CHECKSTRSPACE(4, out);	/* permit 4 calls to USTPUTC */
+		/* Until end of line or end of word */
+		for (;; c = pgetc_top(synstack)) {
+			int fieldsplitting;
+			unsigned ml;
+
+			/* Permit max(MB_LEN_MAX, 23) calls to USTPUTC. */
+			CHECKSTRSPACE((MB_LEN_MAX > 16 ? MB_LEN_MAX : 16) + 7,
+				      out);
+			fieldsplitting = synstack->syntax == BASESYNTAX &&
+					 !synstack->varnest ? 4 : 0;
+			ml = getmbc(c, out, fieldsplitting);
+			if (ml == 1) {
+				if (out == stackblock())
+					return TBLANK;
+				c = pgetc();
+				break;
+			}
+			out += ml;
+			if (ml)
+				continue;
 			switch(synstack->syntax[c]) {
 			case CNL:	/* '\n' */
-				if (synstack->syntax == BASESYNTAX &&
-				    !synstack->varnest)
+				if (fieldsplitting)
 					goto endword;	/* exit outer loop */
 				USTPUTC(c, out);
 				nlprompt();
@@ -956,26 +1026,33 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 					USTPUTC(CTLESC, out);
 					USTPUTC('\\', out);
 					pungetc();
-				} else {
-					if (
-						synstack->dblquote &&
-						c != '\\' && c != '`' &&
-						c != '$' && (
-							c != '"' ||
-							(eofmark != NULL &&
-							 !synstack->varnest)
-						) && (
-							c != '}' ||
-							!synstack->varnest
-						)
-					) {
-						USTPUTC(CTLESC, out);
-						USTPUTC('\\', out);
-					}
-					USTPUTC(CTLESC, out);
-					USTPUTC(c, out);
-					quotef++;
+					break;
 				}
+
+				if (
+					synstack->dblquote &&
+					c != '\\' && c != '`' &&
+					c != '$' && (
+						c != '"' ||
+						(eofmark != NULL &&
+						 !synstack->varnest)
+					) && (
+						c != '}' ||
+						!synstack->varnest
+					)
+				) {
+					USTPUTC(CTLESC, out);
+					USTPUTC('\\', out);
+				}
+				quotef++;
+
+				ml = getmbc(c, out, 1);
+				out += ml;
+				if (ml)
+					break;
+
+				USTPUTC(CTLESC, out);
+				USTPUTC(c, out);
 				break;
 			case CSQUOTE:
 				synstack->syntax = SQSYNTAX;
@@ -1053,11 +1130,10 @@ toggledq:
 			case CEOF:
 				goto endword;		/* exit outer loop */
 			default:
-				if (synstack->varnest == 0)
+				if (fieldsplitting)
 					goto endword;	/* exit outer loop */
 				USTPUTC(c, out);
 			}
-			c = pgetc_top(synstack);
 		}
 	}
 endword:
@@ -1384,6 +1460,7 @@ parsebackq: {
 	size_t psavelen;
 	size_t savelen;
 	union node *n;
+	unsigned ml;
 	char *pstr;
 	char *str;
 
@@ -1415,6 +1492,11 @@ parsebackq: {
                                 if (pc != '\\' && pc != '`' && pc != '$'
                                     && (!synstack->dblquote || pc != '"'))
                                         STPUTC('\\', pout);
+				CHECKSTRSPACE(MB_LEN_MAX, pout);
+				ml = getmbc(pc, pout, 2);
+				pout += ml;
+				if (ml)
+					continue;
 				break;
 
 			case PEOF:
-- 
2.39.2

