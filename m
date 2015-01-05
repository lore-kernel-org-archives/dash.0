From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 3/4] input: Move all input state into parsefile
Date: Mon, 05 Jan 2015 23:01:54 +1100
Message-ID: <E1Y86M6-0001n0-OX@gondolin.me.apana.org.au>
References: <20150105120030.GA6101@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:40720 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbbAEMCG (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 5 Jan 2015 07:02:06 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>, Eric Blake <eblake@redhat.com>, Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org, Juergen Daubert <jue@jue.li>

Currently we maintain a copy of the input state outside of parsefile.
This is redundant and makes reentrancy difficult.  This patch kills
the duplicate global states and now everyone simply uses parsefile.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 src/input.c |  107 ++++++++++++++++++++----------------------------------------
 src/input.h |   33 ++++++++++++++++--
 2 files changed, 67 insertions(+), 73 deletions(-)

diff --git a/src/input.c b/src/input.c
index 232bb9c..6223a73 100644
--- a/src/input.c
+++ b/src/input.c
@@ -61,38 +61,7 @@
 #define EOF_NLEFT -99		/* value of parsenleft when EOF pushed back */
 #define IBUFSIZ (BUFSIZ + 1)
 
-MKINIT
-struct strpush {
-	struct strpush *prev;	/* preceding string on stack */
-	char *prevstring;
-	int prevnleft;
-	struct alias *ap;	/* if push was associated with an alias */
-	char *string;		/* remember the string since it may change */
-};
 
-/*
- * The parsefile structure pointed to by the global variable parsefile
- * contains information about the current file being read.
- */
-
-MKINIT
-struct parsefile {
-	struct parsefile *prev;	/* preceding file on stack */
-	int linno;		/* current line */
-	int fd;			/* file descriptor (or -1 if string) */
-	int nleft;		/* number of chars left in this line */
-	int lleft;		/* number of chars left in this buffer */
-	char *nextc;		/* next char in buffer */
-	char *buf;		/* input buffer */
-	struct strpush *strpush; /* for pushing strings at this level */
-	struct strpush basestrpush; /* so pushing one is fast */
-};
-
-
-int plinno = 1;			/* input line number */
-int parsenleft;			/* copy of parsefile->nleft */
-MKINIT int parselleft;		/* copy of parsefile->lleft */
-char *parsenextc;		/* copy of parsefile->nextc */
 MKINIT struct parsefile basepf;	/* top level input file */
 MKINIT char basebuf[IBUFSIZ];	/* buffer for top level input file */
 struct parsefile *parsefile = &basepf;	/* current input file */
@@ -114,10 +83,12 @@ INCLUDE "error.h"
 
 INIT {
 	basepf.nextc = basepf.buf = basebuf;
+	basepf.linno = 1;
 }
 
 RESET {
-	parselleft = parsenleft = 0;	/* clear input buffer */
+	/* clear input buffer */
+	basepf.lleft = basepf.nleft = 0;
 	popallfiles();
 }
 #endif
@@ -131,8 +102,8 @@ RESET {
 int
 pgetc(void)
 {
-	if (--parsenleft >= 0)
-		return (signed char)*parsenextc++;
+	if (--parsefile->nleft >= 0)
+		return (signed char)*parsefile->nextc++;
 	else
 		return preadbuffer();
 }
@@ -158,7 +129,7 @@ preadfd(void)
 {
 	int nr;
 	char *buf =  parsefile->buf;
-	parsenextc = buf;
+	parsefile->nextc = buf;
 
 retry:
 #ifndef SMALL
@@ -225,29 +196,32 @@ static int preadbuffer(void)
 
 	while (unlikely(parsefile->strpush)) {
 		if (
-			parsenleft == -1 && parsefile->strpush->ap &&
-			parsenextc[-1] != ' ' && parsenextc[-1] != '\t'
+			parsefile->nleft == -1 &&
+			parsefile->strpush->ap &&
+			parsefile->nextc[-1] != ' ' &&
+			parsefile->nextc[-1] != '\t'
 		) {
 			return PEOA;
 		}
 		popstring();
-		if (--parsenleft >= 0)
-			return (signed char)*parsenextc++;
+		if (--parsefile->nleft >= 0)
+			return (signed char)*parsefile->nextc++;
 	}
-	if (unlikely(parsenleft == EOF_NLEFT || parsefile->buf == NULL))
+	if (unlikely(parsefile->nleft == EOF_NLEFT ||
+		     parsefile->buf == NULL))
 		return PEOF;
 	flushall();
 
-	more = parselleft;
+	more = parsefile->lleft;
 	if (more <= 0) {
 again:
 		if ((more = preadfd()) <= 0) {
-			parselleft = parsenleft = EOF_NLEFT;
+			parsefile->lleft = parsefile->nleft = EOF_NLEFT;
 			return PEOF;
 		}
 	}
 
-	q = parsenextc;
+	q = parsefile->nextc;
 
 	/* delete nul characters */
 #ifndef SMALL
@@ -265,7 +239,7 @@ again:
 			q++;
 
 			if (c == '\n') {
-				parsenleft = q - parsenextc - 1;
+				parsefile->nleft = q - parsefile->nextc - 1;
 				break;
 			}
 
@@ -282,13 +256,13 @@ again:
 		}
 
 		if (more <= 0) {
-			parsenleft = q - parsenextc - 1;
-			if (parsenleft < 0)
+			parsefile->nleft = q - parsefile->nextc - 1;
+			if (parsefile->nleft < 0)
 				goto again;
 			break;
 		}
 	}
-	parselleft = more;
+	parsefile->lleft = more;
 
 	savec = *q;
 	*q = '\0';
@@ -298,13 +272,13 @@ again:
 		HistEvent he;
 		INTOFF;
 		history(hist, &he, whichprompt == 1? H_ENTER : H_APPEND,
-		    parsenextc);
+			parsefile->nextc);
 		INTON;
 	}
 #endif
 
 	if (vflag) {
-		out2str(parsenextc);
+		out2str(parsefile->nextc);
 #ifdef FLUSHERR
 		flushout(out2);
 #endif
@@ -312,7 +286,7 @@ again:
 
 	*q = savec;
 
-	return (signed char)*parsenextc++;
+	return (signed char)*parsefile->nextc++;
 }
 
 /*
@@ -323,8 +297,8 @@ again:
 void
 pungetc(void)
 {
-	parsenleft++;
-	parsenextc--;
+	parsefile->nleft++;
+	parsefile->nextc--;
 }
 
 /*
@@ -346,15 +320,15 @@ pushstring(char *s, void *ap)
 		parsefile->strpush = sp;
 	} else
 		sp = parsefile->strpush = &(parsefile->basestrpush);
-	sp->prevstring = parsenextc;
-	sp->prevnleft = parsenleft;
+	sp->prevstring = parsefile->nextc;
+	sp->prevnleft = parsefile->nleft;
 	sp->ap = (struct alias *)ap;
 	if (ap) {
 		((struct alias *)ap)->flag |= ALIASINUSE;
 		sp->string = s;
 	}
-	parsenextc = s;
-	parsenleft = len;
+	parsefile->nextc = s;
+	parsefile->nleft = len;
 	INTON;
 }
 
@@ -365,7 +339,8 @@ popstring(void)
 
 	INTOFF;
 	if (sp->ap) {
-		if (parsenextc[-1] == ' ' || parsenextc[-1] == '\t') {
+		if (parsefile->nextc[-1] == ' ' ||
+		    parsefile->nextc[-1] == '\t') {
 			checkkwd |= CHKALIAS;
 		}
 		if (sp->string != sp->ap->val) {
@@ -376,8 +351,8 @@ popstring(void)
 			unalias(sp->ap->name);
 		}
 	}
-	parsenextc = sp->prevstring;
-	parsenleft = sp->prevnleft;
+	parsefile->nextc = sp->prevstring;
+	parsefile->nleft = sp->prevnleft;
 /*dprintf("*** calling popstring: restoring to '%s'\n", parsenextc);*/
 	parsefile->strpush = sp->prev;
 	if (sp != &(parsefile->basestrpush))
@@ -426,7 +401,7 @@ setinputfd(int fd, int push)
 	parsefile->fd = fd;
 	if (parsefile->buf == NULL)
 		parsefile->buf = ckmalloc(IBUFSIZ);
-	parselleft = parsenleft = 0;
+	parsefile->lleft = parsefile->nleft = 0;
 	plinno = 1;
 }
 
@@ -440,8 +415,8 @@ setinputstring(char *string)
 {
 	INTOFF;
 	pushfile();
-	parsenextc = string;
-	parsenleft = strlen(string);
+	parsefile->nextc = string;
+	parsefile->nleft = strlen(string);
 	parsefile->buf = NULL;
 	plinno = 1;
 	INTON;
@@ -459,10 +434,6 @@ pushfile(void)
 {
 	struct parsefile *pf;
 
-	parsefile->nleft = parsenleft;
-	parsefile->lleft = parselleft;
-	parsefile->nextc = parsenextc;
-	parsefile->linno = plinno;
 	pf = (struct parsefile *)ckmalloc(sizeof (struct parsefile));
 	pf->prev = parsefile;
 	pf->fd = -1;
@@ -486,10 +457,6 @@ popfile(void)
 		popstring();
 	parsefile = pf->prev;
 	ckfree(pf);
-	parsenleft = parsefile->nleft;
-	parselleft = parsefile->lleft;
-	parsenextc = parsefile->nextc;
-	plinno = parsefile->linno;
 	INTON;
 }
 
diff --git a/src/input.h b/src/input.h
index 90ff6c3..ad8b463 100644
--- a/src/input.h
+++ b/src/input.h
@@ -41,14 +41,41 @@ enum {
 	INPUT_NOFILE_OK = 2,
 };
 
+struct alias;
+
+struct strpush {
+	struct strpush *prev;	/* preceding string on stack */
+	char *prevstring;
+	int prevnleft;
+	struct alias *ap;	/* if push was associated with an alias */
+	char *string;		/* remember the string since it may change */
+};
+
+/*
+ * The parsefile structure pointed to by the global variable parsefile
+ * contains information about the current file being read.
+ */
+
+struct parsefile {
+	struct parsefile *prev;	/* preceding file on stack */
+	int linno;		/* current line */
+	int fd;			/* file descriptor (or -1 if string) */
+	int nleft;		/* number of chars left in this line */
+	int lleft;		/* number of chars left in this buffer */
+	char *nextc;		/* next char in buffer */
+	char *buf;		/* input buffer */
+	struct strpush *strpush; /* for pushing strings at this level */
+	struct strpush basestrpush; /* so pushing one is fast */
+};
+
+extern struct parsefile *parsefile;
+
 /*
  * The input line number.  Input.c just defines this variable, and saves
  * and restores it when files are pushed and popped.  The user of this
  * package must set its value.
  */
-extern int plinno;
-extern int parsenleft;		/* number of characters left in input buffer */
-extern char *parsenextc;	/* next character in input buffer */
+#define plinno (parsefile->linno)
 
 int pgetc(void);
 int pgetc2(void);
