Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3917BA6
	for <dash@vger.kernel.org>; Mon, 10 Jun 2024 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001916; cv=none; b=Yz3y6KrEZu9Y/CCzSpG8nxNaa9VYTLxTvNHH+kcd6vadwuBaN2Yh9e3jecULFhWPfp7zjVNbRh15cbrKHLf9VKDgQO6WreSqEM4asbUhPL8aMo+3nc+MS+2ZnaTdIqyPglENK1x9gh0hrKb44jMi+ZiJRCvqWM/cELyTVaVcPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001916; c=relaxed/simple;
	bh=1jEY5rp9UfhHJgvgFtoX7nocpDK8LTULkTmNIpcGdww=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=bMWVcnIv0PCCcZEBrKSY7ysr9xVpcGDcyIwbZasI/jePMQhnuKaUF8eJkqfMlpCSBmaw0XRR5Czl/Q6sj7i4jh1tUC3tH1KlRU5ZARooPchNJBdZRTpbw3KgRFXzc+3I/JYCdviswocuGtXfBid0wjLQtpiUgdVwpZw3MuXmRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sGYmC-007V7q-1B;
	Mon, 10 Jun 2024 14:45:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 10 Jun 2024 14:45:11 +0800
Date: Mon, 10 Jun 2024 14:45:11 +0800
Message-Id: <930b5de9b54892ae2d1eba2e180f29c79646243d.1718001832.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1718001832.git.herbert@gondor.apana.org.au>
References: <cover.1718001832.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 3/3] parser: Add dollar single quote
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Add support for $' quoting, including \u and \U.  The code is shared
with printf, so printf (both format and %b) will recognise the new
escape codes (except \c) too.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/bltin/printf.c | 156 +++++++++++++++++++++++++++++++++++----------
 src/parser.c       |  77 ++++++++++++++++++----
 src/system.h       |   3 +
 3 files changed, 193 insertions(+), 43 deletions(-)

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 7785735..2c18e93 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -29,8 +29,7 @@
  * SUCH DAMAGE.
  */
 
-#include <sys/types.h>
-
+#include <arpa/inet.h>
 #include <ctype.h>
 #include <errno.h>
 #include <inttypes.h>
@@ -38,10 +37,10 @@
 #include <stdarg.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/types.h>
 #include <unistd.h>
 
 static int	 conv_escape_str(char *, char **);
-static char	*conv_escape(char *, int *);
 static int	 getchr(void);
 static double	 getdouble(void);
 static uintmax_t getuintmax(int);
@@ -56,6 +55,7 @@ static char  **gargv;
 #define octtobin(c)	((c) - '0')
 
 #include "bltin.h"
+#include "parser.h"
 #include "system.h"
 
 #define PF(f, func) { \
@@ -164,13 +164,17 @@ int printfcmd(int argc, char *argv[])
 			int *param;
 
 			if (ch == '\\') {
-				int c_ch;
-				fmt = conv_escape(fmt, &c_ch);
-				ch = c_ch;
-				goto pc;
+				unsigned ret;
+				char *cp;
+
+				STARTSTACKSTR(cp);
+				CHECKSTRSPACE(4, cp);
+				ret = conv_escape(fmt, cp, false);
+				fmt += ret >> 4;
+				out1mem(cp, ret & 15);
+				continue;
 			}
 			if (ch != '%' || (*fmt == '%' && (++fmt || 1))) {
-pc:
 				putchar(ch);
 				continue;
 			}
@@ -275,58 +279,69 @@ out:
 static int
 conv_escape_str(char *str, char **sp)
 {
-	int c;
-	int ch;
 	char *cp;
+	int c;
 
 	/* convert string into a temporary buffer... */
 	STARTSTACKSTR(cp);
 
 	do {
-		c = ch = *str++;
-		if (ch != '\\')
-			continue;
+		unsigned ret;
+		int ch;
+
+		CHECKSTRSPACE(4, cp);
 
 		c = *str++;
-		if (c == 'c') {
-			/* \c as in SYSV echo - abort all processing.... */
-			c = ch = 0x100;
+		if (c != '\\') {
+putchar:
+			USTPUTC(c, cp);
 			continue;
 		}
 
+		ch = *str;
+		if (ch == 'c') {
+			/* \c as in SYSV echo - abort all processing.... */
+			c = 0x100;
+			goto putchar;
+		}
+
 		/* 
 		 * %b string octal constants are not like those in C.
 		 * They start with a \0, and are followed by 0, 1, 2, 
 		 * or 3 octal digits. 
 		 */
-		if (c == '0' && isodigit(*str))
+		if (ch == '0' && isodigit(str[1]))
 			str++;
 
 		/* Finally test for sequences valid in the format string */
-		str = conv_escape(str - 1, &c);
-	} while (STPUTC(c, cp), (char)ch);
+		ret = conv_escape(str, cp, false);
+		str += ret >> 4;
+		cp += ret & 15;
+	} while (c & 0xff);
 
 	*sp = cp;
 
-	return ch;
+	return c;
 }
 
 /*
  * Print "standard" escape characters 
  */
-static char *
-conv_escape(char *str, int *conv_ch)
+unsigned conv_escape(char *str0, char *out0, bool mbchar)
 {
-	int value;
+	char *out = out0;
+	char *str = str0;
+	unsigned value;
 	int ch;
 
 	ch = *str;
 
 	switch (ch) {
 	default:
-		if (!isodigit(*str)) {
-			value = '\\';
-			goto out;
+		if (!isodigit(ch)) {
+			value = ch ?: '\\';
+			str -= !ch;
+			break;
 		}
 
 		ch = 3;
@@ -334,12 +349,88 @@ conv_escape(char *str, int *conv_ch)
 		do {
 			value <<= 3;
 			value += octtobin(*str++);
-		} while (isodigit(*str) && --ch);
-		goto out;
+		} while (--ch && isodigit(*str));
+		str--;
+		break;
+
+	case 'x':
+		ch = 2;
+
+hex:
+		value = 0;
+		do {
+			int c = *++str;
+			int d;
+
+			if (c >= '0' && c <= '9')
+				d = c - '0';
+			else {
+				int cl;
+
+				cl = c & ~0x20;
+				if (cl >= 'A' && cl <= 'F')
+					d = cl - 'A' + 10;
+				else {
+					str--;
+					break;
+				}
+			}
+
+			value <<= 4;
+			value += d;
+		} while (--ch);
+
+		if (value < 0x80)
+			break;
+
+		if (value < 0x110000) {
+			int mboff = (mbchar - 1) * 2;
+			unsigned uni = value;
+			int len;
+
+			value = 0x80 << 8 | (value & 0xfc0) << 2 |
+				0x80 | (value & 0x3f);
+
+			if (uni < 0x800) {
+				value |= 0x40 << 8;
+				len = 2;
+			} else {
+				value |= 0x80 << 16 | (uni & 0x3f000) << 4;
+				if (uni < 0x10000) {
+					value |= 0x60 << 16;
+					len = 3;
+				} else {
+					value |= 0xf0 << 24 |
+						 (uni & ~0x3ffff) << 6;
+					len = 4;
+				}
+			}
+
+			value = htonl(value << (4 - len) * 8);
+
+			USTPUTC(CTLMBCHAR, out);
+			USTPUTC(len, out);
+			STADJUST(mboff, out);
+			*(uint32_t *)out = value;
+			STADJUST(len, out);
+			USTPUTC(len, out);
+			USTPUTC(CTLMBCHAR, out);
+			STADJUST(mboff, out);
+		}
+
+		goto out_noput;
+
+	case 'u':
+		ch = 4;
+		goto hex;
+
+	case 'U':
+		ch = 8;
+		goto hex;
 
-	case '\\':	value = '\\';	break;	/* backslash */
 	case 'a':	value = '\a';	break;	/* alert */
 	case 'b':	value = '\b';	break;	/* backspace */
+	case 'e':	value = '\033';	break;	/* <ESC> */
 	case 'f':	value = '\f';	break;	/* form-feed */
 	case 'n':	value = '\n';	break;	/* newline */
 	case 'r':	value = '\r';	break;	/* carriage-return */
@@ -347,10 +438,11 @@ conv_escape(char *str, int *conv_ch)
 	case 'v':	value = '\v';	break;	/* vertical-tab */
 	}
 
+	USTPUTC(value, out);
+
+out_noput:
 	str++;
-out:
-	*conv_ch = value;
-	return str;
+	return (out - out0) | (str - str0) << 4;
 }
 
 static char *
diff --git a/src/parser.c b/src/parser.c
index 2517721..d1bec58 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -931,6 +931,46 @@ unsigned getmbc(int c, char *out, int mode)
 	return 0;
 }
 
+static char *dollarsq_escape(char *out)
+{
+	/* 10 = length of UXXXXXXXX + NUL */
+	char str[10];
+	unsigned len;
+	char *p;
+
+	for (len = 0; len < sizeof(str) - 1; len++) {
+		int c = pgetc();
+
+		if (c <= PEOF)
+			break;
+
+		str[len] = c;
+	}
+	str[len] = 0;
+
+	p = str;
+	if (*p != 'c') {
+		unsigned ret;
+
+		ret = conv_escape(p, out, true);
+		p += ret >> 4;
+		out += ret & 15;
+	} else if (*++p) {
+		int conv_ch;
+		int c;
+
+		c = (unsigned char)*p++;
+
+		p += !((c ^ *p) | (c ^ '\\'));
+
+		conv_ch = (c & ~((c & 0x40) >> 1)) ^ 0x40;
+		USTPUTC(conv_ch, out);
+	}
+
+	pungetn(len - (p - str));
+	return out;
+}
+
 /*
  * If eofmark is NULL, read a word or a redirection symbol.  If eofmark
  * is not NULL, read a here document.  In the latter case, eofmark is the
@@ -953,21 +993,19 @@ unsigned getmbc(int c, char *out, int mode)
 STATIC int
 readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 {
-	int c = firstc;
-	char *out;
-	size_t len;
-	struct nodelist *bqlist;
-	int quotef;
-	int oldstyle;
-	/* syntax stack */
 	struct synstack synbase = { .syntax = syntax };
-	struct synstack *synstack = &synbase;
 	int chkeofmark = checkkwd & CHKEOFMARK;
+	struct synstack *synstack = &synbase;
+	struct nodelist *bqlist = NULL;
+	int dollarsq = 0;
+	int c = firstc;
+	int quotef = 0;
+	int oldstyle;
+	size_t len;
+	char *out;
 
 	if (syntax == DQSYNTAX)
 		synstack->dblquote = 1;
-	quotef = 0;
-	bqlist = NULL;
 
 	STARTSTACKSTR(out);
 	loop: {	/* for each line, until end of word */
@@ -1014,6 +1052,10 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 				USTPUTC(c, out);
 				break;
 			case CCTL:
+				if (c == dollarsq) {
+					out = dollarsq_escape(out);
+					break;
+				}
 				if ((!eofmark) | synstack->dblquote |
 				    synstack->varnest)
 					USTPUTC(CTLESC, out);
@@ -1055,6 +1097,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 				USTPUTC(c, out);
 				break;
 			case CSQUOTE:
+csquote:
 				synstack->syntax = SQSYNTAX;
 quotemark:
 				if (eofmark == NULL) {
@@ -1075,6 +1118,14 @@ toggledq:
 				}
 
 				if (synstack->dqvarnest == 0) {
+					if (likely(dollarsq)) {
+						char *p = stackblock();
+
+						*out = 0;
+						out = p + strlen(p);
+						dollarsq = 0;
+					}
+
 					synstack->syntax = BASESYNTAX;
 					synstack->dblquote = 0;
 				}
@@ -1293,6 +1344,7 @@ parseredir: {
  */
 
 parsesub: {
+	const char *newsyn = synstack->syntax;
 	static const char types[] = "}-+?=";
 	int subtype;
 	char *p;
@@ -1308,9 +1360,12 @@ parsesub: {
 			pungetc();
 			PARSEBACKQNEW();
 		}
+	} else if (c == '\'' && newsyn['&']) {
+		STADJUST(-1, out);
+		dollarsq = '\\';
+		goto csquote;
 	} else if (c == '{' || is_name(c) || is_special(c)) {
 		int typeloc = out - (char *)stackblock();
-		const char *newsyn = synstack->syntax;
 
 		STADJUST(!chkeofmark, out);
 		subtype = VSNORMAL;
diff --git a/src/system.h b/src/system.h
index e7f968b..8cb4726 100644
--- a/src/system.h
+++ b/src/system.h
@@ -28,6 +28,7 @@
 
 #include <limits.h>
 #include <signal.h>
+#include <stdbool.h>
 #include <sys/types.h>
 
 #ifndef SSIZE_MAX
@@ -188,3 +189,5 @@ static inline void globfree64(glob64_t *pglob)
  * code
  */
 #define uninitialized_var(x) x = x
+
+unsigned conv_escape(char *str, char *out, bool mbchar);
-- 
2.39.2

