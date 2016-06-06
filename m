From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] eval: Return status in eval functions
Date: Mon, 6 Jun 2016 18:13:37 +0800
Message-ID: <20160606101337.GA21441@gondor.apana.org.au>
References: <5663058B.1030809@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:33009 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbcFFKNq (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Jun 2016 06:13:46 -0400
Content-Disposition: inline
In-Reply-To: <5663058B.1030809@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Gioele Barabucci <gioele@svario.it>, dash@vger.kernel.org

On Sat, Dec 05, 2015 at 04:40:59PM +0100, Harald van Dijk wrote:
> 
> used to print Fail, and needed the same modification in the evalstring 
> function to make that print OK (included in the attached patch). There 
> may be other similar bugs lurking.

Not exactly similar but there are a bunch of bugs caused by setting
exitstatus too early (i.e., before $? has been expanded).

This patch should fix those problems plus the one that you fixed.

Thanks!

---8<---
Harald van Dijk sent a ptch to fix a bug where an empty parse tree
may not set the exit status correctly in some contexts.

This in turn uncovered other bugs where the exit status is clobbered
in places such case case statements and loops.

This patch attempts to address all of them by making the eval
functions return the current status.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/eval.c b/src/eval.c
index 071fb1b..6f47562 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -81,16 +81,16 @@ int savestatus = -1;		/* exit status of last command outside traps */
 STATIC
 #endif
 void evaltreenr(union node *, int) __attribute__ ((__noreturn__));
-STATIC void evalloop(union node *, int);
-STATIC void evalfor(union node *, int);
-STATIC void evalcase(union node *, int);
-STATIC void evalsubshell(union node *, int);
+STATIC int evalloop(union node *, int);
+STATIC int evalfor(union node *, int);
+STATIC int evalcase(union node *, int);
+STATIC int evalsubshell(union node *, int);
 STATIC void expredir(union node *);
-STATIC void evalpipe(union node *, int);
+STATIC int evalpipe(union node *, int);
 #ifdef notyet
-STATIC void evalcommand(union node *, int, struct backcmd *);
+STATIC int evalcommand(union node *, int, struct backcmd *);
 #else
-STATIC void evalcommand(union node *, int);
+STATIC int evalcommand(union node *, int);
 #endif
 STATIC int evalbltin(const struct builtincmd *, int, char **, int);
 STATIC int evalfun(struct funcnode *, int, char **, int);
@@ -171,8 +171,7 @@ evalstring(char *s, int flags)
 
 	status = 0;
 	while ((n = parsecmd(0)) != NEOF) {
-		evaltree(n, flags & ~(parser_eof() ? 0 : EV_EXIT));
-		status = exitstatus;
+		status = evaltree(n, flags & ~(parser_eof() ? 0 : EV_EXIT));
 		popstackmark(&smark);
 		if (evalskip)
 			break;
@@ -191,13 +190,13 @@ evalstring(char *s, int flags)
  * exitstatus.
  */
 
-void
+int
 evaltree(union node *n, int flags)
 {
 	int checkexit = 0;
-	void (*evalfn)(union node *, int);
+	int (*evalfn)(union node *, int);
 	unsigned isor;
-	int status;
+	int status = 0;
 	if (n == NULL) {
 		TRACE(("evaltree(NULL) called\n"));
 		goto out;
@@ -220,8 +219,7 @@ evaltree(union node *n, int flags)
 		break;
 #endif
 	case NNOT:
-		evaltree(n->nnot.com, EV_TESTED);
-		status = !exitstatus;
+		status = !evaltree(n->nnot.com, EV_TESTED);
 		goto setstatus;
 	case NREDIR:
 		errlinno = lineno = n->nredir.linno;
@@ -229,11 +227,8 @@ evaltree(union node *n, int flags)
 			lineno -= funcline - 1;
 		expredir(n->nredir.redirect);
 		pushredir(n->nredir.redirect);
-		status = redirectsafe(n->nredir.redirect, REDIR_PUSH);
-		if (!status) {
-			evaltree(n->nredir.n, flags & EV_TESTED);
-			status = exitstatus;
-		}
+		status = redirectsafe(n->nredir.redirect, REDIR_PUSH) ?:
+			 evaltree(n->nredir.n, flags & EV_TESTED);
 		if (n->nredir.redirect)
 			popredir(0);
 		goto setstatus;
@@ -241,8 +236,8 @@ evaltree(union node *n, int flags)
 #ifdef notyet
 		if (eflag && !(flags & EV_TESTED))
 			checkexit = ~0;
-		evalcommand(n, flags, (struct backcmd *)NULL);
-		break;
+		status = evalcommand(n, flags, (struct backcmd *)NULL);
+		goto setstatus;
 #else
 		evalfn = evalcommand;
 checkexit:
@@ -277,43 +272,39 @@ checkexit:
 #error NOR + 1 != NSEMI
 #endif
 		isor = n->type - NAND;
-		evaltree(
-			n->nbinary.ch1,
-			(flags | ((isor >> 1) - 1)) & EV_TESTED
-		);
-		if (!exitstatus == isor)
+		status = evaltree(n->nbinary.ch1,
+				  (flags | ((isor >> 1) - 1)) & EV_TESTED);
+		if (!status == isor)
 			break;
 		if (!evalskip) {
 			n = n->nbinary.ch2;
 evaln:
 			evalfn = evaltree;
 calleval:
-			evalfn(n, flags);
-			break;
+			status = evalfn(n, flags);
 		}
-		break;
+		goto setstatus;
 	case NIF:
-		evaltree(n->nif.test, EV_TESTED);
+		status = evaltree(n->nif.test, EV_TESTED);
 		if (evalskip)
 			break;
-		if (exitstatus == 0) {
+		if (!status) {
 			n = n->nif.ifpart;
 			goto evaln;
 		} else if (n->nif.elsepart) {
 			n = n->nif.elsepart;
 			goto evaln;
 		}
-		goto success;
+		status = 0;
+		goto setstatus;
 	case NDEFUN:
 		defun(n);
-success:
-		status = 0;
 setstatus:
 		exitstatus = status;
 		break;
 	}
 out:
-	if (checkexit & exitstatus)
+	if (checkexit & status)
 		goto exexit;
 
 	dotrap();
@@ -322,6 +313,8 @@ out:
 exexit:
 		exraise(EXEXIT);
 	}
+
+	return status;
 }
 
 
@@ -362,7 +355,7 @@ static int skiploop(void)
 }
 
 
-STATIC void
+STATIC int
 evalloop(union node *n, int flags)
 {
 	int skip;
@@ -374,33 +367,34 @@ evalloop(union node *n, int flags)
 	do {
 		int i;
 
-		evaltree(n->nbinary.ch1, EV_TESTED);
+		i = evaltree(n->nbinary.ch1, EV_TESTED);
 		skip = skiploop();
+		if (skip == SKIPFUNC)
+			status = i;
 		if (skip)
 			continue;
-		i = exitstatus;
 		if (n->type != NWHILE)
 			i = !i;
 		if (i != 0)
 			break;
-		evaltree(n->nbinary.ch2, flags);
-		status = exitstatus;
+		status = evaltree(n->nbinary.ch2, flags);
 		skip = skiploop();
 	} while (!(skip & ~SKIPCONT));
-	if (skip != SKIPFUNC)
-		exitstatus = status;
 	loopnest--;
+
+	return status;
 }
 
 
 
-STATIC void
+STATIC int
 evalfor(union node *n, int flags)
 {
 	struct arglist arglist;
 	union node *argp;
 	struct strlist *sp;
 	struct stackmark smark;
+	int status;
 
 	errlinno = lineno = n->nfor.linno;
 	if (funcline)
@@ -413,28 +407,31 @@ evalfor(union node *n, int flags)
 	}
 	*arglist.lastp = NULL;
 
-	exitstatus = 0;
+	status = 0;
 	loopnest++;
 	flags &= EV_TESTED;
 	for (sp = arglist.list ; sp ; sp = sp->next) {
 		setvar(n->nfor.var, sp->text, 0);
-		evaltree(n->nfor.body, flags);
+		status = evaltree(n->nfor.body, flags);
 		if (skiploop() & ~SKIPCONT)
 			break;
 	}
 	loopnest--;
 	popstackmark(&smark);
+
+	return status;
 }
 
 
 
-STATIC void
+STATIC int
 evalcase(union node *n, int flags)
 {
 	union node *cp;
 	union node *patp;
 	struct arglist arglist;
 	struct stackmark smark;
+	int status = 0;
 
 	errlinno = lineno = n->ncase.linno;
 	if (funcline)
@@ -443,12 +440,12 @@ evalcase(union node *n, int flags)
 	setstackmark(&smark);
 	arglist.lastp = &arglist.list;
 	expandarg(n->ncase.expr, &arglist, EXP_TILDE);
-	exitstatus = 0;
 	for (cp = n->ncase.cases ; cp && evalskip == 0 ; cp = cp->nclist.next) {
 		for (patp = cp->nclist.pattern ; patp ; patp = patp->narg.next) {
 			if (casematch(patp, arglist.list->text)) {
 				if (evalskip == 0) {
-					evaltree(cp->nclist.body, flags);
+					status = evaltree(cp->nclist.body,
+							  flags);
 				}
 				goto out;
 			}
@@ -456,6 +453,8 @@ evalcase(union node *n, int flags)
 	}
 out:
 	popstackmark(&smark);
+
+	return status;
 }
 
 
@@ -464,7 +463,7 @@ out:
  * Kick off a subshell to evaluate a tree.
  */
 
-STATIC void
+STATIC int
 evalsubshell(union node *n, int flags)
 {
 	struct job *jp;
@@ -493,8 +492,8 @@ nofork:
 	status = 0;
 	if (! backgnd)
 		status = waitforjob(jp);
-	exitstatus = status;
 	INTON;
+	return status;
 }
 
 
@@ -540,7 +539,7 @@ expredir(union node *n)
  * of all the rest.)
  */
 
-STATIC void
+STATIC int
 evalpipe(union node *n, int flags)
 {
 	struct job *jp;
@@ -548,6 +547,7 @@ evalpipe(union node *n, int flags)
 	int pipelen;
 	int prevfd;
 	int pip[2];
+	int status = 0;
 
 	TRACE(("evalpipe(0x%lx) called\n", (long)n));
 	pipelen = 0;
@@ -588,10 +588,12 @@ evalpipe(union node *n, int flags)
 		close(pip[1]);
 	}
 	if (n->npipe.backgnd == 0) {
-		exitstatus = waitforjob(jp);
+		status = waitforjob(jp);
 		TRACE(("evalpipe:  job done exit status %d\n", exitstatus));
 	}
 	INTON;
+
+	return status;
 }
 
 
@@ -678,7 +680,7 @@ parse_command_args(char **argv, const char **path)
  * Execute a simple command.
  */
 
-STATIC void
+STATIC int
 #ifdef notyet
 evalcommand(union node *cmd, int flags, struct backcmd *backcmd)
 #else
@@ -848,7 +850,7 @@ bail:
 			INTOFF;
 			jp = makejob(cmd, 1);
 			if (forkshell(jp, cmd, FORK_FG) != 0) {
-				exitstatus = waitforjob(jp);
+				status = waitforjob(jp);
 				INTON;
 				break;
 			}
@@ -867,17 +869,19 @@ bail:
 		if (evalbltin(cmdentry.u.cmd, argc, argv, flags)) {
 			if (exception == EXERROR && spclbltin <= 0) {
 				FORCEINTON;
-				break;
+				goto readstatus;
 			}
 raise:
 			longjmp(handler->loc, 1);
 		}
-		break;
+		goto readstatus;
 
 	case CMDFUNCTION:
 		poplocalvars(1);
 		if (evalfun(cmdentry.u.func, argc, argv, flags))
 			goto raise;
+readstatus:
+		status = exitstatus;
 		break;
 	}
 
@@ -893,6 +897,8 @@ out:
 		 */
 		setvar("_", lastarg, 0);
 	popstackmark(&smark);
+
+	return status;
 }
 
 STATIC int
diff --git a/src/eval.h b/src/eval.h
index 6e8acda..63e7d86 100644
--- a/src/eval.h
+++ b/src/eval.h
@@ -53,7 +53,7 @@ struct backcmd {		/* result of evalbackcmd */
 
 int evalstring(char *, int);
 union node;	/* BLETCH for ansi C */
-void evaltree(union node *, int);
+int evaltree(union node *, int);
 void evalbackcmd(union node *, struct backcmd *);
 
 extern int evalskip;
diff --git a/src/main.c b/src/main.c
index bedb663..580dbea 100644
--- a/src/main.c
+++ b/src/main.c
@@ -227,8 +227,7 @@ cmdloop(int top)
 		} else if (nflag == 0) {
 			job_warning = (job_warning == 2) ? 1 : 0;
 			numeof = 0;
-			evaltree(n, 0);
-			status = exitstatus;
+			status = evaltree(n, 0);
 		}
 		popstackmark(&smark);
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
