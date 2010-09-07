From: Jilles Tjoelker <jilles@stack.nl>
Subject: [PATCH] [BUILTIN] Fix various issues with read by importing the
 NetBSD/FreeBSD code.
Date: Wed, 8 Sep 2010 00:17:20 +0200
Message-ID: <20100907221720.GA18839@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:63839 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756026Ab0IGWRW (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 7 Sep 2010 18:17:22 -0400
Received: from turtle.stack.nl (turtle.stack.nl [IPv6:2001:610:1108:5010::132])
	by mx1.stack.nl (Postfix) with ESMTP id BC7591DD657
	for <dash@vger.kernel.org>; Wed,  8 Sep 2010 00:17:20 +0200 (CEST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This reverts the change to make read use the code from expand.c.
Although read's splitting is similar to the splitting done as part of
word expansions, the differences appear to add more complexity than the
common code saves.

The new code is from FreeBSD (which was originally taken from NetBSD).
The -e and -t options have been left out. Some special handling for
EINTR which is not necessary in FreeBSD sh has been retained from the
older dash code.

We now pass FreeBSD's builtins/read1.0 test, posh's mksh.t:read-IFS-1
test and gsf's ifs.sh.
---
 src/miscbltin.c |  170 ++++++++++++++++++++++++++++++-------------------------
 1 files changed, 92 insertions(+), 78 deletions(-)

diff --git a/src/miscbltin.c b/src/miscbltin.c
index 5ab1648..fc6e8d4 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -62,69 +62,22 @@
 #undef rflag
 
 
-/** handle one line of the read command.
- *  more fields than variables -> remainder shall be part of last variable.
- *  less fields than variables -> remaining variables unset.
- *
- *  @param line complete line of input
- *  @param ap argument (variable) list
- *  @param len length of line including trailing '\0'
- */
-static void
-readcmd_handle_line(char *line, char **ap, size_t len)
-{
-	struct arglist arglist;
-	struct strlist *sl;
-	char *s, *backup;
-
-	/* ifsbreakup will fiddle with stack region... */
-	s = grabstackstr(line + len);
-
-	/* need a copy, so that delimiters aren't lost
-	 * in case there are more fields than variables */
-	backup = sstrdup(line);
-
-	arglist.lastp = &arglist.list;
-	recordregion(0, len - 1, 0);
-	
-	ifsbreakup(s, &arglist);
-	*arglist.lastp = NULL;
-	removerecordregions(0);
-
-	for (sl = arglist.list; sl; sl = sl->next) {
-		/* remaining fields present, but no variables left. */
-		if (!ap[1]) {
-			size_t offset;
-			char *remainder;
-
-			/* FIXME little bit hacky, assuming that ifsbreakup 
-			 * will not modify the length of the string */
-			offset = sl->text - s;
-			remainder = backup + offset;
-			rmescapes(remainder);
-			setvar(*ap, remainder, 0);
-
-			return;
-		}
-		
-		/* set variable to field */
-		rmescapes(sl->text);
-		setvar(*ap, sl->text, 0);
-		ap++;
-	}
-
-	/* nullify remaining arguments */
-	do {
-		setvar(*ap, nullstr, 0);
-	} while (*++ap);
-}
-
 /*
- * The read builtin.  The -e option causes backslashes to escape the
- * following character. The -p option followed by an argument prompts
+ * The read builtin.  The -r option causes backslashes to be treated like
+ * ordinary characters. The -p option followed by an argument prompts
  * with the argument.
  *
  * This uses unbuffered input, which may be avoidable in some cases.
+ *
+ * Note that if IFS=' :' then read x y should work so that:
+ * 'a b'	x='a', y='b'
+ * ' a b '	x='a', y='b'
+ * ':b'		x='',  y='b'
+ * ':'		x='',  y=''
+ * '::'		x='',  y=''
+ * ': :'	x='',  y=''
+ * ':::'	x='',  y='::'
+ * ':b c:'	x='',  y='b c:'
  */
 
 int
@@ -135,9 +88,14 @@ readcmd(int argc, char **argv)
 	char c;
 	int rflag;
 	char *prompt;
+	const char *ifs;
 	char *p;
+	int startword;
 	int status;
 	int i;
+	int is_ifs;
+	int saveall = 0;
+	ssize_t n;
 
 	rflag = 0;
 	prompt = NULL;
@@ -155,28 +113,28 @@ readcmd(int argc, char **argv)
 	}
 	if (*(ap = argptr) == NULL)
 		sh_error("arg count");
+	if ((ifs = bltinlookup("IFS")) == NULL)
+		ifs = " \t\n";
+
 	status = 0;
+	startword = 2;
 	backslash = 0;
 	STARTSTACKSTR(p);
 	for (;;) {
-		switch (read(0, &c, 1)) {
-		case 1:
-			break;
-		default:
-			if (errno == EINTR && !pendingsigs)
-				continue;
-				/* fall through */
-		case 0:
+		do
+			n = read(STDIN_FILENO, &c, 1);
+		while (n == -1 && errno == EINTR && !pendingsigs);
+		if (n != 1) {
 			status = 1;
-			goto out;
+			break;
 		}
 		if (c == '\0')
 			continue;
 		if (backslash) {
-			if (c == '\n')
-				goto resetbs;
-			STPUTC(CTLESC, p);
-			goto put;
+			backslash = 0;
+			if (c != '\n')
+				STPUTC(c, p);
+			continue;
 		}
 		if (!rflag && c == '\\') {
 			backslash++;
@@ -184,14 +142,70 @@ readcmd(int argc, char **argv)
 		}
 		if (c == '\n')
 			break;
-put:
-		STPUTC(c, p);
-resetbs:
-		backslash = 0;
+		if (strchr(ifs, c))
+			is_ifs = strchr(" \t\n", c) ? 1 : 2;
+		else
+			is_ifs = 0;
+
+		if (startword != 0) {
+			if (is_ifs == 1) {
+				/* Ignore leading IFS whitespace */
+				if (saveall)
+					STPUTC(c, p);
+				continue;
+			}
+			if (is_ifs == 2 && startword == 1) {
+				/* Only one non-whitespace IFS per word */
+				startword = 2;
+				if (saveall)
+					STPUTC(c, p);
+				continue;
+			}
+		}
+
+		if (is_ifs == 0) {
+			/* append this character to the current variable */
+			startword = 0;
+			if (saveall)
+				/* Not just a spare terminator */
+				saveall++;
+			STPUTC(c, p);
+			continue;
+		}
+
+		/* end of variable... */
+		startword = is_ifs;
+
+		if (ap[1] == NULL) {
+			/* Last variable needs all IFS chars */
+			saveall++;
+			STPUTC(c, p);
+			continue;
+		}
+
+		STACKSTRNUL(p);
+		setvar(*ap, stackblock(), 0);
+		ap++;
+		STARTSTACKSTR(p);
 	}
-out:
 	STACKSTRNUL(p);
-	readcmd_handle_line(stackblock(), ap, p + 1 - (char *)stackblock());
+
+	/* Remove trailing IFS chars */
+	for (; (char *)stackblock() <= --p; *p = 0) {
+		if (!strchr(ifs, *p))
+			break;
+		if (strchr(" \t\n", *p))
+			/* Always remove whitespace */
+			continue;
+		if (saveall > 1)
+			/* Don't remove non-whitespace unless it was naked */
+			break;
+	}
+	setvar(*ap, stackblock(), 0);
+
+	/* Set any remaining args to "" */
+	while (*++ap != NULL)
+		setvar(*ap, nullstr, 0);
 	return status;
 }
 
-- 
1.7.2.2

