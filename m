From: Harald van Dijk <harald@gigawatt.nl>
Subject: [PATCH] Improved LINENO support
Date: Mon, 08 Nov 2010 21:32:56 +0059
Message-ID: <4CD85E90.6000308@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030105000208040101040106"
Return-path: <dash-owner@vger.kernel.org>
Received: from 541F7301.cm-5-8b.dynamic.ziggo.nl ([84.31.115.1]:50863 "HELO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752373Ab0KHUjJ (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Nov 2010 15:39:09 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------030105000208040101040106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch improves LINENO support by storing line numbers in the parse 
tree, for commands as well as for function definitions. It makes LINENO 
behaves properly when calling functions, and has the added benefit of 
improved line numbers in error messages when the last-parsed command is 
not the last-executed one. It removes the earlier LINENO support, and 
instead sets LINENO from evaltree when a command is executed. I have 
used it for a while, and have seen correct line numbers in basic testing 
and in error messages in fairly large and complicated autoconf-generated 
shell scripts. Does this look good enough to add to dash? If there are 
any problems with it, please let me know, I will be happy to look at 
this further.

Cheers,
Harald

--------------030105000208040101040106
Content-Type: text/plain;
 name="dash-improved-lineno.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-improved-lineno.diff"

diff --git a/src/error.c b/src/error.c
index e304d3d..e60e430 100644
--- a/src/error.c
+++ b/src/error.c
@@ -62,6 +62,7 @@ struct jmploc *handler;
 int exception;
 int suppressint;
 volatile sig_atomic_t intpending;
+int errlinno;
 
 
 static void exverror(int, const char *, va_list)
@@ -116,13 +117,12 @@ exvwarning2(const char *msg, va_list ap)
 	const char *fmt;
 
 	errs = out2;
-	name = arg0 ?: "sh";
-	fmt = "%s: ";
-	if (commandname) {
-		name = commandname;
+	name = arg0 ? arg0 : "sh";
+	if (!commandname)
 		fmt = "%s: %d: ";
-	}
-	outfmt(errs, fmt, name, startlinno);
+	else
+		fmt = "%s: %d: %s: ";
+	outfmt(errs, fmt, name, errlinno, commandname);
 	doformat(errs, msg, ap);
 #if FLUSHERR
 	outc('\n', errs);
diff --git a/src/error.h b/src/error.h
index 3162e15..08f96e9 100644
--- a/src/error.h
+++ b/src/error.h
@@ -122,6 +122,7 @@ void onint(void) __attribute__((__noreturn__));
 #else
 void onint(void);
 #endif
+extern int errlinno;
 void sh_error(const char *, ...) __attribute__((__noreturn__));
 void exerror(int, const char *, ...) __attribute__((__noreturn__));
 const char *errmsg(int, int);
diff --git a/src/eval.c b/src/eval.c
index b966749..8c5f82c 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -32,6 +32,7 @@
  * SUCH DAMAGE.
  */
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
 #include <unistd.h>
@@ -73,7 +74,7 @@
 int evalskip;			/* set if we are skipping commands */
 STATIC int skipcount;		/* number of levels to skip */
 MKINIT int loopnest;		/* current loop nesting level */
-static int funcnest;		/* depth of function calls */
+STATIC int funcline;		/* starting line number of current function, or 0 if not in a function */
 
 
 char *commandname;
@@ -191,6 +192,9 @@ evalstring(char *s, int flags)
 void
 evaltree(union node *n, int flags)
 {
+	static char linenoeq[7+(sizeof(int)*CHAR_BIT/3)+2] = "LINENO=";
+	char *lineno = linenoeq+7;
+
 	int checkexit = 0;
 	void (*evalfn)(union node *, int);
 	unsigned isor;
@@ -204,6 +208,12 @@ evaltree(union node *n, int flags)
 #endif
 	TRACE(("pid %d, evaltree(%p: %d, %d) called\n",
 	    getpid(), n, n->type, flags));
+	/* In a function, LINENO must refer to the line number from the start
+	 * of the function. However, errlinno contains the source line number,
+	 * used in error messages. */
+	errlinno = n->ncmd.linno;
+	sprintf(lineno, "%d", n->ncmd.linno - (funcline ? funcline-1 : 0));
+	setvareq(linenoeq, VTEXTFIXED);
 	switch (n->type) {
 	default:
 #ifdef DEBUG
@@ -296,7 +306,7 @@ calleval:
 		}
 		goto success;
 	case NDEFUN:
-		defun(n->narg.text, n->narg.next);
+		defun(n->ndefun.text, n->ndefun.body);
 success:
 		status = 0;
 setstatus:
@@ -730,7 +740,7 @@ evalcommand(union node *cmd, int flags)
 	*nargv = NULL;
 
 	lastarg = NULL;
-	if (iflag && funcnest == 0 && argc > 0)
+	if (iflag && funcline == 0 && argc > 0)
 		lastarg = nargv[-1];
 
 	preverrout.fd = 2;
@@ -928,8 +938,10 @@ evalfun(struct funcnode *func, int argc, char **argv, int flags)
 	struct jmploc *volatile savehandler;
 	struct jmploc jmploc;
 	int e;
+	int savefuncline;
 
 	saveparam = shellparam;
+	savefuncline = funcline;
 	if ((e = setjmp(jmploc.loc))) {
 		goto funcdone;
 	}
@@ -938,7 +950,7 @@ evalfun(struct funcnode *func, int argc, char **argv, int flags)
 	handler = &jmploc;
 	shellparam.malloc = 0;
 	func->count++;
-	funcnest++;
+	funcline = func->n.ndefun.linno;
 	INTON;
 	shellparam.nparam = argc - 1;
 	shellparam.p = argv + 1;
@@ -949,7 +961,7 @@ evalfun(struct funcnode *func, int argc, char **argv, int flags)
 	poplocalvars(0);
 funcdone:
 	INTOFF;
-	funcnest--;
+	funcline = savefuncline;
 	freefunc(func);
 	freeparam(&shellparam);
 	shellparam = saveparam;
@@ -1039,7 +1051,7 @@ returncmd(int argc, char **argv)
 	 * If called outside a function, do what ksh does;
 	 * skip the rest of the file.
 	 */
-	evalskip = funcnest ? SKIPFUNC : SKIPFILE;
+	evalskip = funcline ? SKIPFUNC : SKIPFILE;
 	return argv[1] ? number(argv[1]) : exitstatus;
 }
 
diff --git a/src/input.c b/src/input.c
index e57ad76..1e198e9 100644
--- a/src/input.c
+++ b/src/input.c
@@ -53,7 +53,6 @@
 #include "alias.h"
 #include "parser.h"
 #include "main.h"
-#include "var.h"
 #ifndef SMALL
 #include "myhistedit.h"
 #endif
@@ -529,12 +528,3 @@ closescript(void)
 		parsefile->fd = 0;
 	}
 }
-
-
-int lineno_inc(void)
-{
-	int lineno = plinno++;
-
-	setvarint("LINENO", lineno, 0);
-	return lineno;
-}
diff --git a/src/input.h b/src/input.h
index bdf8857..50a7797 100644
--- a/src/input.h
+++ b/src/input.h
@@ -61,7 +61,6 @@ void setinputstring(char *);
 void popfile(void);
 void popallfiles(void);
 void closescript(void);
-int lineno_inc(void);
 
 #define pgetc_macro() \
 	(--parsenleft >= 0 ? (signed char)*parsenextc++ : preadbuffer())
diff --git a/src/jobs.c b/src/jobs.c
index 826a9af..3d7ce93 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1284,7 +1284,7 @@ dotail:
 		p = "; done";
 		goto dodo;
 	case NDEFUN:
-		cmdputs(n->narg.text);
+		cmdputs(n->ndefun.text);
 		p = "() { ... }";
 		goto dotail2;
 	case NCMD:
diff --git a/src/nodetypes b/src/nodetypes
index 17a7b3c..ae467cb 100644
--- a/src/nodetypes
+++ b/src/nodetypes
@@ -51,17 +51,20 @@
 
 NCMD ncmd			# a simple command
 	type	  int
+	linno	  int
 	assign    nodeptr		# variable assignments
 	args	  nodeptr		# the arguments
 	redirect  nodeptr		# list of file redirections
 
 NPIPE npipe			# a pipeline
 	type	  int
+	linno	  int
 	backgnd	  int			# set to run pipeline in background
 	cmdlist	  nodelist		# the commands in the pipeline
 
 NREDIR nredir			# redirection (of a complex command)
 	type	  int
+	linno	  int
 	n	  nodeptr		# the command
 	redirect  nodeptr		# list of file redirections
 
@@ -73,11 +76,13 @@ NOR nbinary			# the || operator
 
 NSEMI nbinary			# two commands separated by a semicolon
 	type	  int
+	linno	  int
 	ch1	  nodeptr		# the first child
 	ch2	  nodeptr		# the second child
 
 NIF nif				# the if statement.  Elif clauses are handled
 	type	  int		    # using multiple if nodes.
+	linno	  int
 	test	  nodeptr		# if test
 	ifpart	  nodeptr		# then ifpart
 	elsepart  nodeptr		# else elsepart
@@ -87,12 +92,14 @@ NUNTIL nbinary			# the until statement
 
 NFOR nfor			# the for statement
 	type	  int
+	linno	  int
 	args	  nodeptr		# for var in args
 	body	  nodeptr		# do body; done
 	var	  string		# the for variable
 
 NCASE ncase			# a case statement
 	type	  int
+	linno	  int
 	expr	  nodeptr		# the word to switch on
 	cases	  nodeptr		# the list of cases (NCLIST nodes)
 
@@ -102,9 +109,11 @@ NCLIST nclist			# a case
 	pattern	  nodeptr		# list of patterns for this case
 	body	  nodeptr		# code to execute for this case
 
-
-NDEFUN narg			# define a function.  The "next" field contains
-				# the body of the function.
+NDEFUN ndefun			# a function
+	type	  int
+	linno	  int
+	text	  string
+	body	  nodeptr
 
 NARG narg			# represents a word
 	type	  int
@@ -140,5 +149,6 @@ NXHERE nhere			# fd<<!
 	doc	  nodeptr		# input to command (NARG node)
 
 NNOT nnot			# ! command  (actually pipeline)
-	type	int
-	com	nodeptr
+	type	  int
+	linno	  int
+	com	  nodeptr
diff --git a/src/parser.c b/src/parser.c
index be20ff7..1881114 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -93,7 +93,6 @@ struct nodelist *backquotelist;
 union node *redirnode;
 struct heredoc *heredoc;
 int quoteflag;			/* set if (part of) last token was quoted */
-int startlinno;			/* line # where last token started */
 
 
 STATIC union node *list(int);
@@ -185,6 +184,7 @@ list(int nlflag)
 		else {
 			n3 = (union node *)stalloc(sizeof (struct nbinary));
 			n3->type = NSEMI;
+			n3->nbinary.linno = n1->ncmd.linno;
 			n3->nbinary.ch1 = n1;
 			n3->nbinary.ch2 = n2;
 			n1 = n3;
@@ -243,6 +243,7 @@ andor(void)
 		n2 = pipeline();
 		n3 = (union node *)stalloc(sizeof (struct nbinary));
 		n3->type = t;
+		n3->nbinary.linno = n1->ncmd.linno;
 		n3->nbinary.ch1 = n1;
 		n3->nbinary.ch2 = n2;
 		n1 = n3;
@@ -269,6 +270,7 @@ pipeline(void)
 	if (readtoken() == TPIPE) {
 		pipenode = (union node *)stalloc(sizeof (struct npipe));
 		pipenode->type = NPIPE;
+		pipenode->npipe.linno = n1->ncmd.linno;
 		pipenode->npipe.backgnd = 0;
 		lp = (struct nodelist *)stalloc(sizeof (struct nodelist));
 		pipenode->npipe.cmdlist = lp;
@@ -315,6 +317,7 @@ command(void)
 	case TIF:
 		n1 = (union node *)stalloc(sizeof (struct nif));
 		n1->type = NIF;
+		n1->nif.linno = plinno;
 		n1->nif.test = list(0);
 		if (readtoken() != TTHEN)
 			synexpect(TTHEN);
@@ -324,6 +327,7 @@ command(void)
 			n2->nif.elsepart = (union node *)stalloc(sizeof (struct nif));
 			n2 = n2->nif.elsepart;
 			n2->type = NIF;
+			n2->nif.linno = plinno;
 			n2->nif.test = list(0);
 			if (readtoken() != TTHEN)
 				synexpect(TTHEN);
@@ -342,6 +346,7 @@ command(void)
 		int got;
 		n1 = (union node *)stalloc(sizeof (struct nbinary));
 		n1->type = (lasttoken == TWHILE)? NWHILE : NUNTIL;
+		n1->nbinary.linno = plinno;
 		n1->nbinary.ch1 = list(0);
 		if ((got=readtoken()) != TDO) {
 TRACE(("expecting DO got %s %s\n", tokname[got], got == TWORD ? wordtext : ""));
@@ -356,6 +361,7 @@ TRACE(("expecting DO got %s %s\n", tokname[got], got == TWORD ? wordtext : ""));
 			synerror("Bad for loop variable");
 		n1 = (union node *)stalloc(sizeof (struct nfor));
 		n1->type = NFOR;
+		n1->nfor.linno = plinno;
 		n1->nfor.var = wordtext;
 		checkkwd = CHKNL | CHKKWD | CHKALIAS;
 		if (readtoken() == TIN) {
@@ -395,6 +401,7 @@ TRACE(("expecting DO got %s %s\n", tokname[got], got == TWORD ? wordtext : ""));
 	case TCASE:
 		n1 = (union node *)stalloc(sizeof (struct ncase));
 		n1->type = NCASE;
+		n1->ncase.linno = plinno;
 		if (readtoken() != TWORD)
 			synexpect(TWORD);
 		n1->ncase.expr = n2 = (union node *)stalloc(sizeof (struct narg));
@@ -445,6 +452,7 @@ next_case:
 	case TLP:
 		n1 = (union node *)stalloc(sizeof (struct nredir));
 		n1->type = NSUBSHELL;
+		n1->nredir.linno = plinno;
 		n1->nredir.n = list(0);
 		n1->nredir.redirect = NULL;
 		t = TRP;
@@ -477,6 +485,7 @@ redir:
 		if (n1->type != NSUBSHELL) {
 			n2 = (union node *)stalloc(sizeof (struct nredir));
 			n2->type = NREDIR;
+			n2->nredir.linno = plinno;
 			n2->nredir.n = n1;
 			n1 = n2;
 		}
@@ -494,6 +503,7 @@ simplecmd(void) {
 	union node *vars, **vpp;
 	union node **rpp, *redir;
 	int savecheckkwd;
+	int savelinno = plinno;
 
 	args = NULL;
 	app = &args;
@@ -531,7 +541,7 @@ simplecmd(void) {
 				!vars && !redir
 			) {
 				struct builtincmd *bcmd;
-				const char *name;
+				char *name;
 
 				/* We have a function */
 				if (readtoken() != TRP)
@@ -546,7 +556,9 @@ simplecmd(void) {
 					synerror("Bad function name");
 				n->type = NDEFUN;
 				checkkwd = CHKNL | CHKKWD | CHKALIAS;
-				n->narg.next = command();
+				n->ndefun.linno = plinno;
+				n->ndefun.text = name;
+				n->ndefun.body = command();
 				return n;
 			}
 			/* fall through */
@@ -561,6 +573,7 @@ out:
 	*rpp = NULL;
 	n = (union node *)stalloc(sizeof (struct ncmd));
 	n->type = NCMD;
+	n->ncmd.linno = savelinno;
 	n->ncmd.args = args;
 	n->ncmd.assign = vars;
 	n->ncmd.redirect = redir;
@@ -738,8 +751,6 @@ out:
  *	quoted.
  * If the token is TREDIR, then we set redirnode to a structure containing
  *	the redirection.
- * In all cases, the variable startlinno is set to the number of the line
- *	on which the token starts.
  *
  * [Change comment:  here documents and internal procedures]
  * [Readtoken shouldn't have any arguments.  Perhaps we should make the
@@ -763,7 +774,6 @@ xxreadtoken(void)
 	if (needprompt) {
 		setprompt(2);
 	}
-	startlinno = plinno;
 	for (;;) {	/* until token or start of word found */
 		c = pgetc_macro();
 		switch (c) {
@@ -776,7 +786,7 @@ xxreadtoken(void)
 			continue;
 		case '\\':
 			if (pgetc() == '\n') {
-				startlinno = lineno_inc();
+				plinno++;
 				if (doprompt)
 					setprompt(2);
 				continue;
@@ -784,7 +794,7 @@ xxreadtoken(void)
 			pungetc();
 			goto breakloop;
 		case '\n':
-			lineno_inc();
+			plinno++;
 			needprompt = doprompt;
 			RETURN(TNL);
 		case PEOF:
@@ -855,7 +865,6 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 	/* syntax before arithmetic */
 	char const *uninitialized_var(prevsyntax);
 
-	startlinno = plinno;
 	dblquote = 0;
 	if (syntax == DQSYNTAX)
 		dblquote = 1;
@@ -886,7 +895,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 				if (syntax == BASESYNTAX)
 					goto endword;	/* exit outer loop */
 				USTPUTC(c, out);
-				lineno_inc();
+				plinno++;
 				if (doprompt)
 					setprompt(2);
 				c = pgetc();
@@ -907,6 +916,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 					USTPUTC('\\', out);
 					pungetc();
 				} else if (c == '\n') {
+					plinno++;
 					if (doprompt)
 						setprompt(2);
 				} else {
@@ -1008,7 +1018,6 @@ endword:
 	if (syntax != BASESYNTAX && eofmark == NULL)
 		synerror("Unterminated quoted string");
 	if (varnest != 0) {
-		startlinno = plinno;
 		/* { */
 		synerror("Missing '}'");
 	}
@@ -1065,7 +1074,7 @@ checkend: {
 
 		if (c == '\n' || c == PEOF) {
 			c = PEOF;
-			lineno_inc();
+			plinno++;
 			needprompt = doprompt;
 		} else {
 			int len;
@@ -1315,7 +1324,7 @@ parsebackq: {
 
 			case '\\':
                                 if ((pc = pgetc()) == '\n') {
-					lineno_inc();
+					plinno++;
 					if (doprompt)
 						setprompt(2);
 					/*
@@ -1336,11 +1345,10 @@ parsebackq: {
 
 			case PEOF:
 			case PEOA:
-			        startlinno = plinno;
 				synerror("EOF in backquote substitution");
 
 			case '\n':
-				lineno_inc();
+				plinno++;
 				needprompt = doprompt;
 				break;
 
@@ -1472,6 +1480,7 @@ synexpect(int token)
 STATIC void
 synerror(const char *msg)
 {
+	errlinno = plinno;
 	sh_error("Syntax error: %s", msg);
 	/* NOTREACHED */
 }
diff --git a/src/parser.h b/src/parser.h
index 6bdf1c9..e6caed6 100644
--- a/src/parser.h
+++ b/src/parser.h
@@ -77,7 +77,6 @@ extern int tokpushback;
 #define NEOF ((union node *)&tokpushback)
 extern int whichprompt;		/* 1 == PS1, 2 == PS2 */
 extern int checkkwd;
-extern int startlinno;		/* line # where last token started */
 
 
 union node *parsecmd(int);
diff --git a/src/var.c b/src/var.c
index 25c2216..6be9ab4 100644
--- a/src/var.c
+++ b/src/var.c
@@ -99,7 +99,6 @@ struct var varinit[] = {
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"TERM\0",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"HISTSIZE\0",	sethistsize },
 #endif
-	{ 0,	VSTRFIXED|VTEXTFIXED,		"LINENO=1",	0 },
 };
 
 STATIC struct var *vartab[VTABSIZE];

--------------030105000208040101040106--
