From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] Improved LINENO support
Date: Sat, 27 Nov 2010 17:55:17 +0059
Message-ID: <4CF1380D.8000509@gigawatt.nl>
References: <4CD85E90.6000308@gigawatt.nl> <20101110220008.GC17871@stack.nl> <4CDD8481.1060306@gigawatt.nl> <4CDD8908.9010206@redhat.com> <4CDD9095.5070106@gigawatt.nl> <20101112212932.GB57806@stack.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070906020501090308010804"
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.141]:33208 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab0K0QyR (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 27 Nov 2010 11:54:17 -0500
In-Reply-To: <20101112212932.GB57806@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>

This is a multi-part message in MIME format.
--------------070906020501090308010804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/10 22:29, Jilles Tjoelker wrote:
> So some more ideas:
>
> A per-command LINENO does not require adding the number to all of the
> node types. Only node types that are commands that perform expansions
> need it: NCMD, NREDIR, NBACKGND, NSUBSHELL, NFOR, NCASE.

This makes sense, and I've tried this with good results. I added NDEFUN 
to the list, to get the source to function line number mapping correct.

I noticed when wrapping half-parsed commands in an NREDIR, I got the 
line number wrong (not necessarily nonconforming, but different from 
what I had intended). I changed it in this patch by saving the line 
number in a variable before starting the parsing of the command.

> NFOR and NCASE may be wrapped in an NREDIR node to hold the line number.
> This simplifies the code a bit at the cost of some extra memory usage.

That's possible. I have not used that idea in this patch, but it should 
be an easy change.

Your other suggestions would work, but I am not able to say whether they 
form an improvement, so I did not use those for now.

Again, comments are welcome.

--------------070906020501090308010804
Content-Type: text/plain;
 name="dash-improved-lineno-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-improved-lineno-3.diff"

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
index b966749..d85f66f 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -73,7 +73,7 @@
 int evalskip;			/* set if we are skipping commands */
 STATIC int skipcount;		/* number of levels to skip */
 MKINIT int loopnest;		/* current loop nesting level */
-static int funcnest;		/* depth of function calls */
+STATIC int funcline;		/* starting line number of current function, or 0 if not in a function */
 
 
 char *commandname;
@@ -218,6 +218,9 @@ evaltree(union node *n, int flags)
 		status = !exitstatus;
 		goto setstatus;
 	case NREDIR:
+		errlinno = lineno = n->nredir.linno;
+		if (funcline)
+			lineno -= funcline - 1;
 		expredir(n->nredir.redirect);
 		pushredir(n->nredir.redirect);
 		status = redirectsafe(n->nredir.redirect, REDIR_PUSH);
@@ -296,7 +299,7 @@ calleval:
 		}
 		goto success;
 	case NDEFUN:
-		defun(n->narg.text, n->narg.next);
+		defun(n);
 success:
 		status = 0;
 setstatus:
@@ -370,6 +373,10 @@ evalfor(union node *n, int flags)
 	struct strlist *sp;
 	struct stackmark smark;
 
+	errlinno = lineno = n->nfor.linno;
+	if (funcline)
+		lineno -= funcline - 1;
+
 	setstackmark(&smark);
 	arglist.lastp = &arglist.list;
 	for (argp = n->nfor.args ; argp ; argp = argp->narg.next) {
@@ -411,6 +418,10 @@ evalcase(union node *n, int flags)
 	struct arglist arglist;
 	struct stackmark smark;
 
+	errlinno = lineno = n->ncase.linno;
+	if (funcline)
+		lineno -= funcline - 1;
+
 	setstackmark(&smark);
 	arglist.lastp = &arglist.list;
 	expandarg(n->ncase.expr, &arglist, EXP_TILDE);
@@ -442,6 +453,10 @@ evalsubshell(union node *n, int flags)
 	int backgnd = (n->type == NBACKGND);
 	int status;
 
+	errlinno = lineno = n->nredir.linno;
+	if (funcline)
+		lineno -= funcline - 1;
+
 	expredir(n->nredir.redirect);
 	if (!backgnd && flags & EV_EXIT && !have_traps())
 		goto nofork;
@@ -697,6 +712,10 @@ evalcommand(union node *cmd, int flags)
 	int status;
 	char **nargv;
 
+	errlinno = lineno = cmd->ncmd.linno;
+	if (funcline)
+		lineno -= funcline - 1;
+
 	/* First expand the arguments. */
 	TRACE(("evalcommand(0x%lx, %d) called\n", (long)cmd, flags));
 	setstackmark(&smark);
@@ -730,7 +749,7 @@ evalcommand(union node *cmd, int flags)
 	*nargv = NULL;
 
 	lastarg = NULL;
-	if (iflag && funcnest == 0 && argc > 0)
+	if (iflag && funcline == 0 && argc > 0)
 		lastarg = nargv[-1];
 
 	preverrout.fd = 2;
@@ -928,8 +947,10 @@ evalfun(struct funcnode *func, int argc, char **argv, int flags)
 	struct jmploc *volatile savehandler;
 	struct jmploc jmploc;
 	int e;
+	int savefuncline;
 
 	saveparam = shellparam;
+	savefuncline = funcline;
 	if ((e = setjmp(jmploc.loc))) {
 		goto funcdone;
 	}
@@ -938,18 +959,18 @@ evalfun(struct funcnode *func, int argc, char **argv, int flags)
 	handler = &jmploc;
 	shellparam.malloc = 0;
 	func->count++;
-	funcnest++;
+	funcline = func->n.ndefun.linno;
 	INTON;
 	shellparam.nparam = argc - 1;
 	shellparam.p = argv + 1;
 	shellparam.optind = 1;
 	shellparam.optoff = -1;
 	pushlocalvars();
-	evaltree(&func->n, flags & EV_TESTED);
+	evaltree(func->n.ndefun.body, flags & EV_TESTED);
 	poplocalvars(0);
 funcdone:
 	INTOFF;
-	funcnest--;
+	funcline = savefuncline;
 	freefunc(func);
 	freeparam(&shellparam);
 	shellparam = saveparam;
@@ -1039,7 +1060,7 @@ returncmd(int argc, char **argv)
 	 * If called outside a function, do what ksh does;
 	 * skip the rest of the file.
 	 */
-	evalskip = funcnest ? SKIPFUNC : SKIPFILE;
+	evalskip = funcline ? SKIPFUNC : SKIPFILE;
 	return argv[1] ? number(argv[1]) : exitstatus;
 }
 
diff --git a/src/exec.c b/src/exec.c
index 42299ea..959b9f4 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -688,14 +688,14 @@ addcmdentry(char *name, struct cmdentry *entry)
  */
 
 void
-defun(char *name, union node *func)
+defun(union node *func)
 {
 	struct cmdentry entry;
 
 	INTOFF;
 	entry.cmdtype = CMDFUNCTION;
 	entry.u.func = copyfunc(func);
-	addcmdentry(name, &entry);
+	addcmdentry(func->ndefun.text, &entry);
 	INTON;
 }
 
diff --git a/src/exec.h b/src/exec.h
index daa6f10..9ccb305 100644
--- a/src/exec.h
+++ b/src/exec.h
@@ -71,7 +71,7 @@ void changepath(const char *);
 #ifdef notdef
 void getcmdentry(char *, struct cmdentry *);
 #endif
-void defun(char *, union node *);
+void defun(union node *);
 void unsetfunc(const char *);
 int typecmd(int, char **);
 int commandcmd(int, char **);
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
index 17a7b3c..f7a2873 100644
--- a/src/nodetypes
+++ b/src/nodetypes
@@ -51,6 +51,7 @@
 
 NCMD ncmd			# a simple command
 	type	  int
+	linno	  int
 	assign    nodeptr		# variable assignments
 	args	  nodeptr		# the arguments
 	redirect  nodeptr		# list of file redirections
@@ -62,6 +63,7 @@ NPIPE npipe			# a pipeline
 
 NREDIR nredir			# redirection (of a complex command)
 	type	  int
+	linno	  int
 	n	  nodeptr		# the command
 	redirect  nodeptr		# list of file redirections
 
@@ -87,12 +89,14 @@ NUNTIL nbinary			# the until statement
 
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
 
@@ -102,9 +106,11 @@ NCLIST nclist			# a case
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
diff --git a/src/parser.c b/src/parser.c
index be20ff7..2f839f5 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -93,7 +93,6 @@ struct nodelist *backquotelist;
 union node *redirnode;
 struct heredoc *heredoc;
 int quoteflag;			/* set if (part of) last token was quoted */
-int startlinno;			/* line # where last token started */
 
 
 STATIC union node *list(int);
@@ -304,10 +303,13 @@ command(void)
 	union node *redir, **rpp;
 	union node **rpp2;
 	int t;
+	int savelinno;
 
 	redir = NULL;
 	rpp2 = &redir;
 
+	savelinno = plinno;
+
 	switch (readtoken()) {
 	default:
 		synexpect(-1);
@@ -356,6 +358,7 @@ TRACE(("expecting DO got %s %s\n", tokname[got], got == TWORD ? wordtext : ""));
 			synerror("Bad for loop variable");
 		n1 = (union node *)stalloc(sizeof (struct nfor));
 		n1->type = NFOR;
+		n1->nfor.linno = savelinno;
 		n1->nfor.var = wordtext;
 		checkkwd = CHKNL | CHKKWD | CHKALIAS;
 		if (readtoken() == TIN) {
@@ -395,6 +398,7 @@ TRACE(("expecting DO got %s %s\n", tokname[got], got == TWORD ? wordtext : ""));
 	case TCASE:
 		n1 = (union node *)stalloc(sizeof (struct ncase));
 		n1->type = NCASE;
+		n1->ncase.linno = savelinno;
 		if (readtoken() != TWORD)
 			synexpect(TWORD);
 		n1->ncase.expr = n2 = (union node *)stalloc(sizeof (struct narg));
@@ -445,6 +449,7 @@ next_case:
 	case TLP:
 		n1 = (union node *)stalloc(sizeof (struct nredir));
 		n1->type = NSUBSHELL;
+		n1->nredir.linno = savelinno;
 		n1->nredir.n = list(0);
 		n1->nredir.redirect = NULL;
 		t = TRP;
@@ -477,6 +482,7 @@ redir:
 		if (n1->type != NSUBSHELL) {
 			n2 = (union node *)stalloc(sizeof (struct nredir));
 			n2->type = NREDIR;
+			n2->nredir.linno = savelinno;
 			n2->nredir.n = n1;
 			n1 = n2;
 		}
@@ -494,6 +500,7 @@ simplecmd(void) {
 	union node *vars, **vpp;
 	union node **rpp, *redir;
 	int savecheckkwd;
+	int savelinno;
 
 	args = NULL;
 	app = &args;
@@ -503,6 +510,7 @@ simplecmd(void) {
 	rpp = &redir;
 
 	savecheckkwd = CHKALIAS;
+	savelinno = plinno;
 	for (;;) {
 		checkkwd = savecheckkwd;
 		switch (readtoken()) {
@@ -531,7 +539,7 @@ simplecmd(void) {
 				!vars && !redir
 			) {
 				struct builtincmd *bcmd;
-				const char *name;
+				char *name;
 
 				/* We have a function */
 				if (readtoken() != TRP)
@@ -546,7 +554,9 @@ simplecmd(void) {
 					synerror("Bad function name");
 				n->type = NDEFUN;
 				checkkwd = CHKNL | CHKKWD | CHKALIAS;
-				n->narg.next = command();
+				n->ndefun.text = n->narg.text;
+				n->ndefun.linno = plinno;
+				n->ndefun.body = command();
 				return n;
 			}
 			/* fall through */
@@ -561,6 +571,7 @@ out:
 	*rpp = NULL;
 	n = (union node *)stalloc(sizeof (struct ncmd));
 	n->type = NCMD;
+	n->ncmd.linno = savelinno;
 	n->ncmd.args = args;
 	n->ncmd.assign = vars;
 	n->ncmd.redirect = redir;
@@ -738,8 +749,6 @@ out:
  *	quoted.
  * If the token is TREDIR, then we set redirnode to a structure containing
  *	the redirection.
- * In all cases, the variable startlinno is set to the number of the line
- *	on which the token starts.
  *
  * [Change comment:  here documents and internal procedures]
  * [Readtoken shouldn't have any arguments.  Perhaps we should make the
@@ -763,7 +772,6 @@ xxreadtoken(void)
 	if (needprompt) {
 		setprompt(2);
 	}
-	startlinno = plinno;
 	for (;;) {	/* until token or start of word found */
 		c = pgetc_macro();
 		switch (c) {
@@ -776,7 +784,7 @@ xxreadtoken(void)
 			continue;
 		case '\\':
 			if (pgetc() == '\n') {
-				startlinno = lineno_inc();
+				plinno++;
 				if (doprompt)
 					setprompt(2);
 				continue;
@@ -784,7 +792,7 @@ xxreadtoken(void)
 			pungetc();
 			goto breakloop;
 		case '\n':
-			lineno_inc();
+			plinno++;
 			needprompt = doprompt;
 			RETURN(TNL);
 		case PEOF:
@@ -855,7 +863,6 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 	/* syntax before arithmetic */
 	char const *uninitialized_var(prevsyntax);
 
-	startlinno = plinno;
 	dblquote = 0;
 	if (syntax == DQSYNTAX)
 		dblquote = 1;
@@ -886,7 +893,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 				if (syntax == BASESYNTAX)
 					goto endword;	/* exit outer loop */
 				USTPUTC(c, out);
-				lineno_inc();
+				plinno++;
 				if (doprompt)
 					setprompt(2);
 				c = pgetc();
@@ -907,6 +914,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 					USTPUTC('\\', out);
 					pungetc();
 				} else if (c == '\n') {
+					plinno++;
 					if (doprompt)
 						setprompt(2);
 				} else {
@@ -1008,7 +1016,6 @@ endword:
 	if (syntax != BASESYNTAX && eofmark == NULL)
 		synerror("Unterminated quoted string");
 	if (varnest != 0) {
-		startlinno = plinno;
 		/* { */
 		synerror("Missing '}'");
 	}
@@ -1065,7 +1072,7 @@ checkend: {
 
 		if (c == '\n' || c == PEOF) {
 			c = PEOF;
-			lineno_inc();
+			plinno++;
 			needprompt = doprompt;
 		} else {
 			int len;
@@ -1315,7 +1322,7 @@ parsebackq: {
 
 			case '\\':
                                 if ((pc = pgetc()) == '\n') {
-					lineno_inc();
+					plinno++;
 					if (doprompt)
 						setprompt(2);
 					/*
@@ -1336,11 +1343,10 @@ parsebackq: {
 
 			case PEOF:
 			case PEOA:
-			        startlinno = plinno;
 				synerror("EOF in backquote substitution");
 
 			case '\n':
-				lineno_inc();
+				plinno++;
 				needprompt = doprompt;
 				break;
 
@@ -1472,6 +1478,7 @@ synexpect(int token)
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
index 25c2216..7e05e3d 100644
--- a/src/var.c
+++ b/src/var.c
@@ -33,6 +33,7 @@
  */
 
 #include <unistd.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <paths.h>
 
@@ -78,6 +79,9 @@ const char defifsvar[] = "IFS= \t\n";
 const char defifs[] = " \t\n";
 #endif
 
+int lineno;
+char linenovar[sizeof("LINENO=")+sizeof(int)*CHAR_BIT/3+1] = "LINENO=";
+
 /* Some macros in var.h depend on the order, add new variables to the end. */
 struct var varinit[] = {
 #if ATTY
@@ -95,11 +99,11 @@ struct var varinit[] = {
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS2=> ",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS4=+ ",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"OPTIND=1",	getoptsreset },
+	{ 0,	VSTRFIXED|VTEXTFIXED,		linenovar,	0 },
 #ifndef SMALL
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"TERM\0",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"HISTSIZE\0",	sethistsize },
 #endif
-	{ 0,	VSTRFIXED|VTEXTFIXED,		"LINENO=1",	0 },
 };
 
 STATIC struct var *vartab[VTABSIZE];
@@ -329,6 +333,9 @@ lookupvar(const char *name)
 	struct var *v;
 
 	if ((v = *findvar(hashvar(name), name)) && !(v->flags & VUNSET)) {
+		if (v == &vlineno && v->text == linenovar) {
+			sprintf(linenoval(), "%d", lineno);
+		}
 		return strchrnul(v->text, '=') + 1;
 	}
 	return NULL;
diff --git a/src/var.h b/src/var.h
index 7aa051f..3d2c2cb 100644
--- a/src/var.h
+++ b/src/var.h
@@ -88,8 +88,9 @@ extern struct var varinit[];
 #define vps2 (&vps1)[1]
 #define vps4 (&vps2)[1]
 #define voptind (&vps4)[1]
+#define vlineno (&voptind)[1]
 #ifndef SMALL
-#define vterm (&voptind)[1]
+#define vterm (&vlineno)[1]
 #define vhistsize (&vterm)[1]
 #endif
 
@@ -102,6 +103,9 @@ extern const char defifs[];
 extern const char defpathvar[];
 #define defpath (defpathvar + 5)
 
+extern int lineno;
+extern char linenovar[];
+
 /*
  * The following macros access the values of the above variables.
  * They have to skip over the name.  They return the null string
@@ -117,6 +121,7 @@ extern const char defpathvar[];
 #define ps2val()	(vps2.text + 4)
 #define ps4val()	(vps4.text + 4)
 #define optindval()	(voptind.text + 7)
+#define linenoval()	(vlineno.text + 7)
 #ifndef SMALL
 #define histsizeval()	(vhistsize.text + 9)
 #define termval()	(vterm.text + 5)

--------------070906020501090308010804--
