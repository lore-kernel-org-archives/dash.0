From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] Improved LINENO support
Date: Fri, 11 Mar 2011 22:56:49 +0100
Message-ID: <1299880609.408.9.camel@gentoo>
References: <4CD85E90.6000308@gigawatt.nl> <20101110220008.GC17871@stack.nl>
	 <4CDD8481.1060306@gigawatt.nl> <4CDD8908.9010206@redhat.com>
	 <4CDD9095.5070106@gigawatt.nl> <20101112212932.GB57806@stack.nl>
	 <4CF1380D.8000509@gigawatt.nl> <20110310081027.GA10360@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Ov0Zl028Scy1x76gM98C"
Return-path: <dash-owner@vger.kernel.org>
Received: from relay.csv-networks.nl ([84.244.151.248]:4692 "EHLO
	relay.csv-networks.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab1CKWdU (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 11 Mar 2011 17:33:20 -0500
In-Reply-To: <20110310081027.GA10360@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>


--=-Ov0Zl028Scy1x76gM98C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-03-10 at 16:10 +0800, Herbert Xu wrote:
> On Sat, Nov 27, 2010 at 04:56:17PM +0000, Harald van Dijk wrote:
> >
> > Again, comments are welcome.
> 
> Thanks for working on this! Just a few minor problems to correct.
> Oh and please add a changelog + sign-off.

Done.

> Please don't add any new uses of STATIC.  I'm fine with leaving
> existing ones in place though.

Changed to static.

> I like this bit :)

Thanks :)

> Please separate out unrelated changes like this into distinct
> patches.

It is not unrelated: I changed the meaning of struct funcnode's field n
to refer to the function definition, rather than the list of the
function's commands, because I needed to refer to the function
definition node from evalfun, which only gets passed a funcnode. But it
is something that could be applied independently (without being useful
by itself), so I've attached it as a separate patch for easier review.

> Please use fmtstr instead of sprintf for consistency.

Done.

Cheers,
Harald

--=-Ov0Zl028Scy1x76gM98C
Content-Disposition: attachment; filename="dash-funcnode.patch"
Content-Type: text/x-patch; name="dash-funcnode.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Harald van Dijk <harald@gigawatt.nl>

diff --git a/ChangeLog b/ChangeLog
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2011-03-11  Harald van Dijk <harald@gigawatt.nl>
+
+	* Let funcnode refer to a function definition, not its first command.
+
 2011-03-10  Jonathan Nieder <jrnieder@gmail.com>
 
 	* Dotcmd should exit with zero when doing nothing.
diff --git a/src/eval.c b/src/eval.c
--- a/src/eval.c
+++ b/src/eval.c
@@ -296,7 +296,7 @@ calleval:
 		}
 		goto success;
 	case NDEFUN:
-		defun(n->narg.text, n->narg.next);
+		defun(n);
 success:
 		status = 0;
 setstatus:
@@ -954,7 +954,7 @@ evalfun(struct funcnode *func, int argc,
 	shellparam.optind = 1;
 	shellparam.optoff = -1;
 	pushlocalvars();
-	evaltree(&func->n, flags & EV_TESTED);
+	evaltree(func->n.narg.next, flags & EV_TESTED);
 	poplocalvars(0);
 funcdone:
 	INTOFF;
diff --git a/src/exec.c b/src/exec.c
--- a/src/exec.c
+++ b/src/exec.c
@@ -688,14 +688,14 @@ addcmdentry(char *name, struct cmdentry 
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
+	addcmdentry(func->narg.text, &entry);
 	INTON;
 }
 
diff --git a/src/exec.h b/src/exec.h
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

--=-Ov0Zl028Scy1x76gM98C
Content-Disposition: attachment; filename="dash-lineno-4.patch"
Content-Type: text/x-patch; name="dash-lineno-4.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Harald van Dijk <harald@gigawatt.nl>

diff -r 772aea7ed8c5 ChangeLog
--- a/ChangeLog	Fri Mar 11 22:39:28 2011 +0100
+++ b/ChangeLog	Fri Mar 11 22:45:57 2011 +0100
@@ -1,3 +1,7 @@
+2011-03-11  Harald van Dijk <harald@gigawatt.nl>
+
+	* Improve LINENO support.
+
 2011-03-11  Harald van Dijk <harald@gigawatt.nl>
 
 	* Let funcnode refer to a function definition, not its first command.
diff -r 772aea7ed8c5 src/error.c
--- a/src/error.c	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/error.c	Fri Mar 11 22:45:57 2011 +0100
@@ -62,6 +62,7 @@
 int exception;
 int suppressint;
 volatile sig_atomic_t intpending;
+int errlinno;
 
 
 static void exverror(int, const char *, va_list)
@@ -116,13 +117,12 @@
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
diff -r 772aea7ed8c5 src/error.h
--- a/src/error.h	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/error.h	Fri Mar 11 22:45:57 2011 +0100
@@ -120,6 +120,7 @@
 #else
 void onint(void);
 #endif
+extern int errlinno;
 void sh_error(const char *, ...) __attribute__((__noreturn__));
 void exerror(int, const char *, ...) __attribute__((__noreturn__));
 const char *errmsg(int, int);
diff -r 772aea7ed8c5 src/eval.c
--- a/src/eval.c	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/eval.c	Fri Mar 11 22:45:57 2011 +0100
@@ -73,7 +73,7 @@
 int evalskip;			/* set if we are skipping commands */
 STATIC int skipcount;		/* number of levels to skip */
 MKINIT int loopnest;		/* current loop nesting level */
-static int funcnest;		/* depth of function calls */
+static int funcline;		/* starting line number of current function, or 0 if not in a function */
 
 
 char *commandname;
@@ -218,6 +218,9 @@
 		status = !exitstatus;
 		goto setstatus;
 	case NREDIR:
+		errlinno = lineno = n->nredir.linno;
+		if (funcline)
+			lineno -= funcline - 1;
 		expredir(n->nredir.redirect);
 		pushredir(n->nredir.redirect);
 		status = redirectsafe(n->nredir.redirect, REDIR_PUSH);
@@ -376,6 +379,10 @@
 	struct strlist *sp;
 	struct stackmark smark;
 
+	errlinno = lineno = n->nfor.linno;
+	if (funcline)
+		lineno -= funcline - 1;
+
 	setstackmark(&smark);
 	arglist.lastp = &arglist.list;
 	for (argp = n->nfor.args ; argp ; argp = argp->narg.next) {
@@ -417,6 +424,10 @@
 	struct arglist arglist;
 	struct stackmark smark;
 
+	errlinno = lineno = n->ncase.linno;
+	if (funcline)
+		lineno -= funcline - 1;
+
 	setstackmark(&smark);
 	arglist.lastp = &arglist.list;
 	expandarg(n->ncase.expr, &arglist, EXP_TILDE);
@@ -448,6 +459,10 @@
 	int backgnd = (n->type == NBACKGND);
 	int status;
 
+	errlinno = lineno = n->nredir.linno;
+	if (funcline)
+		lineno -= funcline - 1;
+
 	expredir(n->nredir.redirect);
 	if (!backgnd && flags & EV_EXIT && !have_traps())
 		goto nofork;
@@ -704,6 +719,10 @@
 	int status;
 	char **nargv;
 
+	errlinno = lineno = cmd->ncmd.linno;
+	if (funcline)
+		lineno -= funcline - 1;
+
 	/* First expand the arguments. */
 	TRACE(("evalcommand(0x%lx, %d) called\n", (long)cmd, flags));
 	setstackmark(&smark);
@@ -737,7 +756,7 @@
 	*nargv = NULL;
 
 	lastarg = NULL;
-	if (iflag && funcnest == 0 && argc > 0)
+	if (iflag && funcline == 0 && argc > 0)
 		lastarg = nargv[-1];
 
 	preverrout.fd = 2;
@@ -937,8 +956,10 @@
 	struct jmploc *volatile savehandler;
 	struct jmploc jmploc;
 	int e;
+	int savefuncline;
 
 	saveparam = shellparam;
+	savefuncline = funcline;
 	if ((e = setjmp(jmploc.loc))) {
 		goto funcdone;
 	}
@@ -947,18 +968,18 @@
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
-	evaltree(func->n.narg.next, flags & EV_TESTED);
+	evaltree(func->n.ndefun.body, flags & EV_TESTED);
 	poplocalvars(0);
 funcdone:
 	INTOFF;
-	funcnest--;
+	funcline = savefuncline;
 	freefunc(func);
 	freeparam(&shellparam);
 	shellparam = saveparam;
@@ -1048,7 +1069,7 @@
 	 * If called outside a function, do what ksh does;
 	 * skip the rest of the file.
 	 */
-	evalskip = funcnest ? SKIPFUNC : SKIPFILE;
+	evalskip = funcline ? SKIPFUNC : SKIPFILE;
 	return argv[1] ? number(argv[1]) : exitstatus;
 }
 
diff -r 772aea7ed8c5 src/exec.c
--- a/src/exec.c	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/exec.c	Fri Mar 11 22:45:57 2011 +0100
@@ -695,7 +695,7 @@
 	INTOFF;
 	entry.cmdtype = CMDFUNCTION;
 	entry.u.func = copyfunc(func);
-	addcmdentry(func->narg.text, &entry);
+	addcmdentry(func->ndefun.text, &entry);
 	INTON;
 }
 
diff -r 772aea7ed8c5 src/input.c
--- a/src/input.c	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/input.c	Fri Mar 11 22:45:57 2011 +0100
@@ -54,7 +54,6 @@
 #include "alias.h"
 #include "parser.h"
 #include "main.h"
-#include "var.h"
 #ifndef SMALL
 #include "myhistedit.h"
 #endif
@@ -531,12 +530,3 @@
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
diff -r 772aea7ed8c5 src/input.h
--- a/src/input.h	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/input.h	Fri Mar 11 22:45:57 2011 +0100
@@ -61,7 +61,6 @@
 void popfile(void);
 void popallfiles(void);
 void closescript(void);
-int lineno_inc(void);
 
 #define pgetc_macro() \
 	(--parsenleft >= 0 ? (signed char)*parsenextc++ : preadbuffer())
diff -r 772aea7ed8c5 src/jobs.c
--- a/src/jobs.c	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/jobs.c	Fri Mar 11 22:45:57 2011 +0100
@@ -1286,7 +1286,7 @@
 		p = "; done";
 		goto dodo;
 	case NDEFUN:
-		cmdputs(n->narg.text);
+		cmdputs(n->ndefun.text);
 		p = "() { ... }";
 		goto dotail2;
 	case NCMD:
diff -r 772aea7ed8c5 src/nodetypes
--- a/src/nodetypes	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/nodetypes	Fri Mar 11 22:45:57 2011 +0100
@@ -51,6 +51,7 @@
 
 NCMD ncmd			# a simple command
 	type	  int
+	linno	  int
 	assign    nodeptr		# variable assignments
 	args	  nodeptr		# the arguments
 	redirect  nodeptr		# list of file redirections
@@ -62,6 +63,7 @@
 
 NREDIR nredir			# redirection (of a complex command)
 	type	  int
+	linno	  int
 	n	  nodeptr		# the command
 	redirect  nodeptr		# list of file redirections
 
@@ -87,12 +89,14 @@
 
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
 
@@ -103,8 +107,11 @@
 	body	  nodeptr		# code to execute for this case
 
 
-NDEFUN narg			# define a function.  The "next" field contains
-				# the body of the function.
+NDEFUN ndefun			# a function
+	type	  int
+	linno	  int
+	text	  string
+	body	  nodeptr
 
 NARG narg			# represents a word
 	type	  int
diff -r 772aea7ed8c5 src/parser.c
--- a/src/parser.c	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/parser.c	Fri Mar 11 22:45:57 2011 +0100
@@ -93,7 +93,6 @@
 union node *redirnode;
 struct heredoc *heredoc;
 int quoteflag;			/* set if (part of) last token was quoted */
-int startlinno;			/* line # where last token started */
 
 
 STATIC union node *list(int);
@@ -304,10 +303,13 @@
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
@@ -356,6 +358,7 @@
 			synerror("Bad for loop variable");
 		n1 = (union node *)stalloc(sizeof (struct nfor));
 		n1->type = NFOR;
+		n1->nfor.linno = savelinno;
 		n1->nfor.var = wordtext;
 		checkkwd = CHKNL | CHKKWD | CHKALIAS;
 		if (readtoken() == TIN) {
@@ -395,6 +398,7 @@
 	case TCASE:
 		n1 = (union node *)stalloc(sizeof (struct ncase));
 		n1->type = NCASE;
+		n1->ncase.linno = savelinno;
 		if (readtoken() != TWORD)
 			synexpect(TWORD);
 		n1->ncase.expr = n2 = (union node *)stalloc(sizeof (struct narg));
@@ -445,6 +449,7 @@
 	case TLP:
 		n1 = (union node *)stalloc(sizeof (struct nredir));
 		n1->type = NSUBSHELL;
+		n1->nredir.linno = savelinno;
 		n1->nredir.n = list(0);
 		n1->nredir.redirect = NULL;
 		t = TRP;
@@ -477,6 +482,7 @@
 		if (n1->type != NSUBSHELL) {
 			n2 = (union node *)stalloc(sizeof (struct nredir));
 			n2->type = NREDIR;
+			n2->nredir.linno = savelinno;
 			n2->nredir.n = n1;
 			n1 = n2;
 		}
@@ -494,6 +500,7 @@
 	union node *vars, **vpp;
 	union node **rpp, *redir;
 	int savecheckkwd;
+	int savelinno;
 
 	args = NULL;
 	app = &args;
@@ -503,6 +510,7 @@
 	rpp = &redir;
 
 	savecheckkwd = CHKALIAS;
+	savelinno = plinno;
 	for (;;) {
 		checkkwd = savecheckkwd;
 		switch (readtoken()) {
@@ -546,7 +554,9 @@
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
@@ -561,6 +571,7 @@
 	*rpp = NULL;
 	n = (union node *)stalloc(sizeof (struct ncmd));
 	n->type = NCMD;
+	n->ncmd.linno = savelinno;
 	n->ncmd.args = args;
 	n->ncmd.assign = vars;
 	n->ncmd.redirect = redir;
@@ -738,8 +749,6 @@
  *	quoted.
  * If the token is TREDIR, then we set redirnode to a structure containing
  *	the redirection.
- * In all cases, the variable startlinno is set to the number of the line
- *	on which the token starts.
  *
  * [Change comment:  here documents and internal procedures]
  * [Readtoken shouldn't have any arguments.  Perhaps we should make the
@@ -763,7 +772,6 @@
 	if (needprompt) {
 		setprompt(2);
 	}
-	startlinno = plinno;
 	for (;;) {	/* until token or start of word found */
 		c = pgetc_macro();
 		switch (c) {
@@ -776,7 +784,7 @@
 			continue;
 		case '\\':
 			if (pgetc() == '\n') {
-				startlinno = lineno_inc();
+				plinno++;
 				if (doprompt)
 					setprompt(2);
 				continue;
@@ -784,7 +792,7 @@
 			pungetc();
 			goto breakloop;
 		case '\n':
-			lineno_inc();
+			plinno++;
 			needprompt = doprompt;
 			RETURN(TNL);
 		case PEOF:
@@ -855,7 +863,6 @@
 	/* syntax before arithmetic */
 	char const *uninitialized_var(prevsyntax);
 
-	startlinno = plinno;
 	dblquote = 0;
 	if (syntax == DQSYNTAX)
 		dblquote = 1;
@@ -886,7 +893,7 @@
 				if (syntax == BASESYNTAX)
 					goto endword;	/* exit outer loop */
 				USTPUTC(c, out);
-				lineno_inc();
+				plinno++;
 				if (doprompt)
 					setprompt(2);
 				c = pgetc();
@@ -907,6 +914,7 @@
 					USTPUTC('\\', out);
 					pungetc();
 				} else if (c == '\n') {
+					plinno++;
 					if (doprompt)
 						setprompt(2);
 				} else {
@@ -1008,7 +1016,6 @@
 	if (syntax != BASESYNTAX && eofmark == NULL)
 		synerror("Unterminated quoted string");
 	if (varnest != 0) {
-		startlinno = plinno;
 		/* { */
 		synerror("Missing '}'");
 	}
@@ -1065,7 +1072,7 @@
 
 		if (c == '\n' || c == PEOF) {
 			c = PEOF;
-			lineno_inc();
+			plinno++;
 			needprompt = doprompt;
 		} else {
 			int len;
@@ -1315,7 +1322,7 @@
 
 			case '\\':
                                 if ((pc = pgetc()) == '\n') {
-					lineno_inc();
+					plinno++;
 					if (doprompt)
 						setprompt(2);
 					/*
@@ -1336,11 +1343,10 @@
 
 			case PEOF:
 			case PEOA:
-			        startlinno = plinno;
 				synerror("EOF in backquote substitution");
 
 			case '\n':
-				lineno_inc();
+				plinno++;
 				needprompt = doprompt;
 				break;
 
@@ -1472,6 +1478,7 @@
 STATIC void
 synerror(const char *msg)
 {
+	errlinno = plinno;
 	sh_error("Syntax error: %s", msg);
 	/* NOTREACHED */
 }
diff -r 772aea7ed8c5 src/parser.h
--- a/src/parser.h	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/parser.h	Fri Mar 11 22:45:57 2011 +0100
@@ -77,7 +77,6 @@
 #define NEOF ((union node *)&tokpushback)
 extern int whichprompt;		/* 1 == PS1, 2 == PS2 */
 extern int checkkwd;
-extern int startlinno;		/* line # where last token started */
 
 
 union node *parsecmd(int);
diff -r 772aea7ed8c5 src/var.c
--- a/src/var.c	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/var.c	Fri Mar 11 22:45:57 2011 +0100
@@ -33,6 +33,7 @@
  */
 
 #include <unistd.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <paths.h>
 
@@ -78,6 +79,9 @@
 const char defifs[] = " \t\n";
 #endif
 
+int lineno;
+char linenovar[sizeof("LINENO=")+sizeof(int)*CHAR_BIT/3+1] = "LINENO=";
+
 /* Some macros in var.h depend on the order, add new variables to the end. */
 struct var varinit[] = {
 #if ATTY
@@ -95,11 +99,11 @@
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
@@ -329,6 +333,9 @@
 	struct var *v;
 
 	if ((v = *findvar(hashvar(name), name)) && !(v->flags & VUNSET)) {
+		if (v == &vlineno && v->text == linenovar) {
+			fmtstr(linenovar+7, sizeof(linenovar)-7, "%d", lineno);
+		}
 		return strchrnul(v->text, '=') + 1;
 	}
 	return NULL;
diff -r 772aea7ed8c5 src/var.h
--- a/src/var.h	Fri Mar 11 22:39:28 2011 +0100
+++ b/src/var.h	Fri Mar 11 22:45:57 2011 +0100
@@ -88,8 +88,9 @@
 #define vps2 (&vps1)[1]
 #define vps4 (&vps2)[1]
 #define voptind (&vps4)[1]
+#define vlineno (&voptind)[1]
 #ifndef SMALL
-#define vterm (&voptind)[1]
+#define vterm (&vlineno)[1]
 #define vhistsize (&vterm)[1]
 #endif
 
@@ -102,6 +103,9 @@
 extern const char defpathvar[];
 #define defpath (defpathvar + 5)
 
+extern int lineno;
+extern char linenovar[];
+
 /*
  * The following macros access the values of the above variables.
  * They have to skip over the name.  They return the null string
@@ -117,6 +121,7 @@
 #define ps2val()	(vps2.text + 4)
 #define ps4val()	(vps4.text + 4)
 #define optindval()	(voptind.text + 7)
+#define linenoval()	(vlineno.text + 7)
 #ifndef SMALL
 #define histsizeval()	(vhistsize.text + 9)
 #define termval()	(vterm.text + 5)

--=-Ov0Zl028Scy1x76gM98C--

