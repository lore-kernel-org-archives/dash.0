From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] parser: Get rid of PEOA
Date: Wed, 27 May 2020 12:19:13 +1000
Message-ID: <20200527021913.GA27873@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:57822 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgE0CTQ (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 26 May 2020 22:19:16 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

PEOA is a special character used to mark an alias as being finished
so that we don't enter an infinite loop with nested aliases.  It
complicates the parser because we have to ensure that it is skipped
where necessary and not copied to the resulting token text.

This patch removes it and instead delays the marking of aliases
until the second pgetc.  This has the same effect as the current
PEOA code while keeping the complexities within the input code.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 17544e7..cf4efdc 100644
--- a/src/input.c
+++ b/src/input.c
@@ -68,6 +68,7 @@ struct parsefile *parsefile = &basepf;	/* current input file */
 int whichprompt;		/* 1 == PS1, 2 == PS2 */
 
 STATIC void pushfile(void);
+static void popstring(void);
 static int preadfd(void);
 static void setinputfd(int fd, int push);
 static int preadbuffer(void);
@@ -99,13 +100,32 @@ FORKRESET {
 #endif
 
 
-/*
- * Read a character from the script, returning PEOF on end of file.
- * Nul characters in the input are silently discarded.
- */
+static void freestrings(struct strpush *sp)
+{
+	INTOFF;
+	do {
+		struct strpush *psp;
 
-int
-pgetc(void)
+		if (sp->ap) {
+			sp->ap->flag &= ~ALIASINUSE;
+			if (sp->ap->flag & ALIASDEAD) {
+				unalias(sp->ap->name);
+			}
+		}
+
+		psp = sp;
+		sp = sp->spfree;
+
+		if (psp != &(parsefile->basestrpush))
+			ckfree(psp);
+	} while (sp);
+
+	parsefile->spfree = NULL;
+	INTON;
+}
+
+
+static int __pgetc(void)
 {
 	int c;
 
@@ -125,17 +145,18 @@ pgetc(void)
 
 
 /*
- * Same as pgetc(), but ignores PEOA.
+ * Read a character from the script, returning PEOF on end of file.
+ * Nul characters in the input are silently discarded.
  */
 
-int
-pgetc2()
+int pgetc(void)
 {
-	int c;
-	do {
-		c = pgetc();
-	} while (c == PEOA);
-	return c;
+	struct strpush *sp = parsefile->spfree;
+
+	if (unlikely(sp))
+		freestrings(sp);
+
+	return __pgetc();
 }
 
 
@@ -214,16 +235,8 @@ static int preadbuffer(void)
 	char savec;
 
 	if (unlikely(parsefile->strpush)) {
-		if (
-			parsefile->nleft == -1 &&
-			parsefile->strpush->ap &&
-			parsefile->nextc[-1] != ' ' &&
-			parsefile->nextc[-1] != '\t'
-		) {
-			return PEOA;
-		}
 		popstring();
-		return pgetc();
+		return __pgetc();
 	}
 	if (unlikely(parsefile->nleft == EOF_NLEFT ||
 		     parsefile->buf == NULL))
@@ -331,7 +344,8 @@ pushstring(char *s, void *ap)
 	len = strlen(s);
 	INTOFF;
 /*dprintf("*** calling pushstring: %s, %d\n", s, len);*/
-	if (parsefile->strpush) {
+	if ((unsigned long)parsefile->strpush |
+	    (unsigned long)parsefile->spfree) {
 		sp = ckmalloc(sizeof (struct strpush));
 		sp->prev = parsefile->strpush;
 		parsefile->strpush = sp;
@@ -340,6 +354,7 @@ pushstring(char *s, void *ap)
 	sp->prevstring = parsefile->nextc;
 	sp->prevnleft = parsefile->nleft;
 	sp->unget = parsefile->unget;
+	sp->spfree = parsefile->spfree;
 	memcpy(sp->lastc, parsefile->lastc, sizeof(sp->lastc));
 	sp->ap = (struct alias *)ap;
 	if (ap) {
@@ -349,11 +364,11 @@ pushstring(char *s, void *ap)
 	parsefile->nextc = s;
 	parsefile->nleft = len;
 	parsefile->unget = 0;
+	parsefile->spfree = NULL;
 	INTON;
 }
 
-void
-popstring(void)
+static void popstring(void)
 {
 	struct strpush *sp = parsefile->strpush;
 
@@ -366,10 +381,6 @@ popstring(void)
 		if (sp->string != sp->ap->val) {
 			ckfree(sp->string);
 		}
-		sp->ap->flag &= ~ALIASINUSE;
-		if (sp->ap->flag & ALIASDEAD) {
-			unalias(sp->ap->name);
-		}
 	}
 	parsefile->nextc = sp->prevstring;
 	parsefile->nleft = sp->prevnleft;
@@ -377,8 +388,7 @@ popstring(void)
 	memcpy(parsefile->lastc, sp->lastc, sizeof(sp->lastc));
 /*dprintf("*** calling popstring: restoring to '%s'\n", parsenextc);*/
 	parsefile->strpush = sp->prev;
-	if (sp != &(parsefile->basestrpush))
-		ckfree(sp);
+	parsefile->spfree = sp;
 	INTON;
 }
 
@@ -460,6 +470,7 @@ pushfile(void)
 	pf->prev = parsefile;
 	pf->fd = -1;
 	pf->strpush = NULL;
+	pf->spfree = NULL;
 	pf->basestrpush.prev = NULL;
 	pf->unget = 0;
 	parsefile = pf;
@@ -476,8 +487,12 @@ popfile(void)
 		close(pf->fd);
 	if (pf->buf)
 		ckfree(pf->buf);
-	while (pf->strpush)
+	if (parsefile->spfree)
+		freestrings(parsefile->spfree);
+	while (pf->strpush) {
 		popstring();
+		freestrings(parsefile->spfree);
+	}
 	parsefile = pf->prev;
 	ckfree(pf);
 	INTON;
diff --git a/src/input.h b/src/input.h
index 8acc6e9..8c39f33 100644
--- a/src/input.h
+++ b/src/input.h
@@ -50,6 +50,9 @@ struct strpush {
 	struct alias *ap;	/* if push was associated with an alias */
 	char *string;		/* remember the string since it may change */
 
+	/* Delay freeing so we can stop nested aliases. */
+	struct strpush *spfree;
+
 	/* Remember last two characters for pungetc. */
 	int lastc[2];
 
@@ -73,6 +76,9 @@ struct parsefile {
 	struct strpush *strpush; /* for pushing strings at this level */
 	struct strpush basestrpush; /* so pushing one is fast */
 
+	/* Delay freeing so we can stop nested aliases. */
+	struct strpush *spfree;
+
 	/* Remember last two characters for pungetc. */
 	int lastc[2];
 
@@ -93,7 +99,6 @@ int pgetc(void);
 int pgetc2(void);
 void pungetc(void);
 void pushstring(char *, void *);
-void popstring(void);
 int setinputfile(const char *, int);
 void setinputstring(char *);
 void popfile(void);
diff --git a/src/mksyntax.c b/src/mksyntax.c
index a23c18c..da18f5d 100644
--- a/src/mksyntax.c
+++ b/src/mksyntax.c
@@ -64,7 +64,6 @@ struct synclass synclass[] = {
 	{ "CEOF",	"end of file" },
 	{ "CCTL",	"like CWORD, except it must be escaped" },
 	{ "CSPCL",	"these terminate a word" },
-	{ "CIGN",	"character should be ignored" },
 	{ NULL,		NULL }
 };
 
@@ -145,9 +144,8 @@ main(int argc, char **argv)
 		fprintf(hfile, "/* %s */\n", is_entry[i].comment);
 	}
 	putc('\n', hfile);
-	fprintf(hfile, "#define SYNBASE %d\n", 130);
-	fprintf(hfile, "#define PEOF %d\n\n", -130);
-	fprintf(hfile, "#define PEOA %d\n\n", -129);
+	fprintf(hfile, "#define SYNBASE %d\n", 129);
+	fprintf(hfile, "#define PEOF %d\n\n", -129);
 	putc('\n', hfile);
 	fputs("#define BASESYNTAX (basesyntax + SYNBASE)\n", hfile);
 	fputs("#define DQSYNTAX (dqsyntax + SYNBASE)\n", hfile);
@@ -170,7 +168,6 @@ main(int argc, char **argv)
 	add("$", "CVAR");
 	add("}", "CENDVAR");
 	add("<>();&| \t", "CSPCL");
-	syntax[1] = "CSPCL";
 	print("basesyntax");
 	init();
 	fputs("\n/* syntax table used when in double quotes */\n", cfile);
@@ -223,7 +220,7 @@ filltable(char *dftval)
 {
 	int i;
 
-	for (i = 0 ; i < 258; i++)
+	for (i = 0 ; i < 257; i++)
 		syntax[i] = dftval;
 }
 
@@ -239,9 +236,8 @@ init(void)
 
 	filltable("CWORD");
 	syntax[0] = "CEOF";
-	syntax[1] = "CIGN";
 	for (ctl = CTL_FIRST; ctl <= CTL_LAST; ctl++ )
-		syntax[130 + ctl] = "CCTL";
+		syntax[129 + ctl] = "CCTL";
 }
 
 
@@ -253,7 +249,7 @@ static void
 add(char *p, char *type)
 {
 	while (*p)
-		syntax[(signed char)*p++ + 130] = type;
+		syntax[(signed char)*p++ + 129] = type;
 }
 
 
@@ -271,7 +267,7 @@ print(char *name)
 	fprintf(hfile, "extern const char %s[];\n", name);
 	fprintf(cfile, "const char %s[] = {\n", name);
 	col = 0;
-	for (i = 0 ; i < 258; i++) {
+	for (i = 0 ; i < 257; i++) {
 		if (i == 0) {
 			fputs("      ", cfile);
 		} else if ((i & 03) == 0) {
diff --git a/src/parser.c b/src/parser.c
index 3131045..07ee727 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -796,7 +796,6 @@ xxreadtoken(void)
 		c = pgetc_eatbnl();
 		switch (c) {
 		case ' ': case '\t':
-		case PEOA:
 			continue;
 		case '#':
 			while ((c = pgetc()) != '\n' && c != PEOF);
@@ -838,7 +837,7 @@ static int pgetc_eatbnl(void)
 	int c;
 
 	while ((c = pgetc()) == '\\') {
-		if (pgetc2() != '\n') {
+		if (pgetc() != '\n') {
 			pungetc();
 			break;
 		}
@@ -943,7 +942,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 				break;
 			/* backslash */
 			case CBACK:
-				c = pgetc2();
+				c = pgetc();
 				if (c == PEOF) {
 					USTPUTC(CTLESC, out);
 					USTPUTC('\\', out);
@@ -1048,14 +1047,10 @@ toggledq:
 				break;
 			case CEOF:
 				goto endword;		/* exit outer loop */
-			case CIGN:
-				break;
 			default:
 				if (synstack->varnest == 0)
 					goto endword;	/* exit outer loop */
-				if (c != PEOA) {
-					USTPUTC(c, out);
-				}
+				USTPUTC(c, out);
 			}
 			c = pgetc_top(synstack);
 		}
@@ -1103,13 +1098,9 @@ checkend: {
 		int markloc;
 		char *p;
 
-		if (c == PEOA) {
-			c = pgetc2();
-		}
 		if (striptabs) {
-			while (c == '\t') {
-				c = pgetc2();
-			}
+			while (c == '\t')
+				c = pgetc();
 		}
 
 		markloc = out - (char *)stackblock();
@@ -1117,7 +1108,7 @@ checkend: {
 			if (c != *p)
 				goto more_heredoc;
 
-			c = pgetc2();
+			c = pgetc();
 		}
 
 		if (c == '\n' || c == PEOF) {
@@ -1229,7 +1220,6 @@ parsesub: {
 	c = pgetc_eatbnl();
 	if (
 		(checkkwd & CHKEOFMARK) ||
-		c <= PEOA  ||
 		(c != '(' && c != '{' && !is_name(c) && !is_special(c))
 	) {
 		USTPUTC('$', out);
@@ -1397,13 +1387,9 @@ parsebackq: {
                                 if (pc != '\\' && pc != '`' && pc != '$'
                                     && (!synstack->dblquote || pc != '"'))
                                         STPUTC('\\', pout);
-				if (pc > PEOA) {
-					break;
-				}
-				/* fall through */
+				break;
 
 			case PEOF:
-			case PEOA:
 				synerror("EOF in backquote substitution");
 
 			case '\n':
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
