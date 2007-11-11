From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Here-document...
Date: Sun, 11 Nov 2007 14:18:37 +0800
Message-ID: <20071111061837.GA12363@gondor.apana.org.au>
References: <20071030042335.GH22435@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:3285 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750711AbXKKGSk (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 11 Nov 2007 01:18:40 -0500
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1Ir69W-00077n-8Z
	for <dash@vger.kernel.org>; Sun, 11 Nov 2007 17:18:38 +1100
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1Ir69V-0003Dz-00
	for <dash@vger.kernel.org>; Sun, 11 Nov 2007 14:18:37 +0800
Content-Disposition: inline
In-Reply-To: <20071030042335.GH22435@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dAsh <dash@vger.kernel.org>

On Tue, Oct 30, 2007 at 04:23:35AM +0000, Oleg Verych wrote:
>
> } 8<<""
> ======================

Actually this (the empty delim) only works with dash by accident.
I've tried bash and pdksh and they both terminate on the first
empty line which is what you would expect rather than EOF.  The
real Korn shell does something completely different.

I've fixed this in dash to conform to bash/pdksh.
 
> In [0] it's stated, that delimiter isn't evaluated (expanded), only
> quoiting must be checked. That if() seems to be completely bogus.

OK I agree.  The reason it was there is because the parser would
have already replaced the dollar sign by an internal representation.

I've fixed it properly in the patch below.

> Placing binary stuff safely with optimized reading/writing by big
> blocks without parsing, if delimiter is "", are things, that i'd like
> to propose and possibly fix/implement soon.

Sorry but I can't see how we can get this to work in a meaningful
way.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/ChangeLog b/ChangeLog
index d50d36c..ad98810 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2007-11-11  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Removed noexpand/length check on eofmark.
+
 2007-10-20  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Added configure --enable-glob and --enable-fnmatch options.
diff --git a/src/input.c b/src/input.c
index 11f7a3f..bc84e57 100644
--- a/src/input.c
+++ b/src/input.c
@@ -125,33 +125,6 @@ RESET {
 
 
 /*
- * Read a line from the script.
- */
-
-char *
-pfgets(char *line, int len)
-{
-	char *p = line;
-	int nleft = len;
-	int c;
-
-	while (--nleft > 0) {
-		c = pgetc2();
-		if (c == PEOF) {
-			if (p == line)
-				return NULL;
-			break;
-		}
-		*p++ = c;
-		if (c == '\n')
-			break;
-	}
-	*p = '\0';
-	return line;
-}
-
-
-/*
  * Read a character from the script, returning PEOF on end of file.
  * Nul characters in the input are silently discarded.
  */
diff --git a/src/input.h b/src/input.h
index 1ed9ddf..1d6f528 100644
--- a/src/input.h
+++ b/src/input.h
@@ -50,7 +50,6 @@ extern int plinno;
 extern int parsenleft;		/* number of characters left in input buffer */
 extern char *parsenextc;	/* next character in input buffer */
 
-char *pfgets(char *, int);
 int pgetc(void);
 int pgetc2(void);
 int preadbuffer(void);
diff --git a/src/parser.c b/src/parser.c
index 3832f0b..2d20b00 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -59,8 +59,6 @@
  * Shell command parser.
  */
 
-#define EOFMARKLEN 79
-
 /* values returned by readtoken */
 #include "token.h"
 
@@ -101,7 +99,6 @@ STATIC int peektoken(void);
 STATIC int readtoken(void);
 STATIC int xxreadtoken(void);
 STATIC int readtoken1(int, char const *, char *, int);
-STATIC int noexpand(char *);
 STATIC void synexpect(int) __attribute__((__noreturn__));
 STATIC void synerror(const char *) __attribute__((__noreturn__));
 STATIC void setprompt(int);
@@ -596,18 +593,17 @@ parsefname(void)
 {
 	union node *n = redirnode;
 
+	if (n->type == NHERE)
+		checkkwd = CHKEOFMARK;
 	if (readtoken() != TWORD)
 		synexpect(-1);
 	if (n->type == NHERE) {
 		struct heredoc *here = heredoc;
 		struct heredoc *p;
-		int i;
 
 		if (quoteflag == 0)
 			n->type = NXHERE;
 		TRACE(("Here document %d\n", n->type));
-		if (! noexpand(wordtext) || (i = strlen(wordtext)) == 0 || i > EOFMARKLEN)
-			synerror("Illegal eof marker for << redirection");
 		rmescapes(wordtext);
 		here->eofmark = wordtext;
 		here->next = NULL;
@@ -836,7 +832,6 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 	int c = firstc;
 	char *out;
 	int len;
-	char line[EOFMARKLEN + 1];
 	struct nodelist *bqlist;
 	int quotef;
 	int dblquote;
@@ -1036,6 +1031,9 @@ endword:
 
 checkend: {
 	if (eofmark) {
+		int markloc;
+		char *p;
+
 		if (c == PEOA) {
 			c = pgetc2();
 		}
@@ -1044,28 +1042,42 @@ checkend: {
 				c = pgetc2();
 			}
 		}
-		if (c == *eofmark) {
-			if (pfgets(line, sizeof line) != NULL) {
-				char *p, *q;
-				int cc;
-
-				p = line;
-				for (q = eofmark + 1;; p++, q++) {
-					cc = *p;
-					if (cc == '\n')
-						cc = 0;
-					if (!*q || cc != *q)
-						break;
-				}
-				if (cc == *q) {
-					c = PEOF;
-					plinno++;
-					needprompt = doprompt;
-				} else {
-					pushstring(line, NULL);
+
+		markloc = out - (char *)stackblock();
+		for (p = eofmark; STPUTC(c, out), *p; p++) {
+			if (c != *p)
+				goto more_heredoc;
+
+			c = pgetc2();
+		}
+
+		if (c == '\n' || c == PEOF) {
+			c = PEOF;
+			plinno++;
+			needprompt = doprompt;
+		} else {
+			int len;
+
+more_heredoc:
+			p = (char *)stackblock() + markloc + 1;
+			len = out - p;
+
+			if (len) {
+				len -= c < 0;
+				c = p[-1];
+
+				if (len) {
+					char *str;
+
+					str = alloca(len + 1);
+					*(char *)mempcpy(str, p, len) = 0;
+
+					pushstring(str, NULL);
 				}
 			}
 		}
+
+		STADJUST((char *)stackblock() + markloc - out, out);
 	}
 	goto checkend_return;
 }
@@ -1148,6 +1160,7 @@ parsesub: {
 
 	c = pgetc();
 	if (
+		(checkkwd & CHKEOFMARK) ||
 		c <= PEOA  ||
 		(c != '(' && c != '{' && !is_name(c) && !is_special(c))
 	) {
@@ -1400,29 +1413,6 @@ RESET {
 }
 #endif
 
-/*
- * Returns true if the text contains nothing to expand (no dollar signs
- * or backquotes).
- */
-
-STATIC int
-noexpand(char *text)
-{
-	char *p;
-	signed char c;
-
-	p = text;
-	while ((c = *p++) != '\0') {
-		if (c == CTLQUOTEMARK)
-			continue;
-		if (c == CTLESC)
-			p++;
-		else if (BASESYNTAX[(int)c] == CCTL)
-			return 0;
-	}
-	return 1;
-}
-
 
 /*
  * Return of a legal variable name (a letter or underscore followed by zero or
diff --git a/src/parser.h b/src/parser.h
index badbd07..6bdf1c9 100644
--- a/src/parser.h
+++ b/src/parser.h
@@ -65,6 +65,7 @@
 #define CHKALIAS	0x1
 #define CHKKWD		0x2
 #define CHKNL		0x4
+#define CHKEOFMARK	0x8
 
 
 /*
