From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2] eval: Return status in eval functions
Date: Tue, 7 Jun 2016 16:47:59 +0800
Message-ID: <20160607084759.GA30183@gondor.apana.org.au>
References: <5663058B.1030809@gigawatt.nl>
 <20160606101337.GA21441@gondor.apana.org.au>
 <5755E7C0.8010309@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:40324 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbcFGIs3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 7 Jun 2016 04:48:29 -0400
Content-Disposition: inline
In-Reply-To: <5755E7C0.8010309@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Gioele Barabucci <gioele@svario.it>

On Mon, Jun 06, 2016 at 11:14:40PM +0200, Harald van Dijk wrote:
>
> Nice! It does indeed fix additional problems. It also introduces a
> few new bugs though (modified from the FreeBSD testsuite):
> 
> src/dash -c 'eval "false
> 
> "'; echo $?
> 
> This should print 1 and used to print 1, but with this patch
> applied, it prints 0. The parsing here adds a null commands, which
> shouldn't affect the exit status.

OK, I have applied your original patch with some formatting fixes.

> Unfortunately, attempting to fix this by simply setting
> status = exitstatus for null commands breaks other things: given
> 
> src/dash -c 'false; case x in *) esac'; echo $?

This is actually the result of the nofork path created for -c.
I'll fix it using the same method as you used in the original patch.

> Another one modified from the FreeBSD testsuite:
> 
> src/dash -xc 'f() {
>   trap "return 1" USR1
>   kill -USR1 $$
> }
> f'; echo $?
> 
> This should print 1 and used to print 1, but with this patch
> applied, it prints 0.

I have fixed this by rereading exitstatus after dotrap.

> >@@ -588,10 +588,12 @@ evalpipe(union node *n, int flags)
> >  		close(pip[1]);
> >  	}
> >  	if (n->npipe.backgnd == 0) {
> >-		exitstatus = waitforjob(jp);
> >+		status = waitforjob(jp);
> >  		TRACE(("evalpipe:  job done exit status %d\n", exitstatus));
> 
> This line looks like it should be updated to print status rather
> than exitstatus when tracing is enabled. :)

Fixed too.

---8<--
The exit status is currently clobbered too early for case statements
and loops.  This patch fixes it by making the eval functions return
the current exit status and setting them in one place -- evaltree.

Harald van Dijk pointed out a number of bugs in the original patch.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/eval.c b/src/eval.c
index 30c05f9..7498f9d 100644
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
@@ -170,11 +170,13 @@ evalstring(char *s, int flags)
 	setstackmark(&smark);
 
 	status = 0;
-	while ((n = parsecmd(0)) != NEOF) {
-		evaltree(n, flags & ~(parser_eof() ? 0 : EV_EXIT));
+	for (; (n = parsecmd(0)) != NEOF; popstackmark(&smark)) {
+		int i;
+
+		i = evaltree(n, flags & ~(parser_eof() ? 0 : EV_EXIT));
 		if (n)
-			status = exitstatus;
-		popstackmark(&smark);
+			status = i;
+
 		if (evalskip)
 			break;
 	}
@@ -192,13 +194,13 @@ evalstring(char *s, int flags)
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
@@ -221,8 +223,7 @@ evaltree(union node *n, int flags)
 		break;
 #endif
 	case NNOT:
-		evaltree(n->nnot.com, EV_TESTED);
-		status = !exitstatus;
+		status = !evaltree(n->nnot.com, EV_TESTED);
 		goto setstatus;
 	case NREDIR:
 		errlinno = lineno = n->nredir.linno;
@@ -230,11 +231,8 @@ evaltree(union node *n, int flags)
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
@@ -242,8 +240,8 @@ evaltree(union node *n, int flags)
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
@@ -278,43 +276,37 @@ checkexit:
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
+		if (!status == isor || evalskip)
 			break;
-		if (!evalskip) {
-			n = n->nbinary.ch2;
+		n = n->nbinary.ch2;
 evaln:
-			evalfn = evaltree;
+		evalfn = evaltree;
 calleval:
-			evalfn(n, flags);
-			break;
-		}
-		break;
+		status = evalfn(n, flags);
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
@@ -323,6 +315,8 @@ out:
 exexit:
 		exraise(EXEXIT);
 	}
+
+	return exitstatus;
 }
 
 
@@ -363,7 +357,7 @@ static int skiploop(void)
 }
 
 
-STATIC void
+STATIC int
 evalloop(union node *n, int flags)
 {
 	int skip;
@@ -375,33 +369,34 @@ evalloop(union node *n, int flags)
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
@@ -414,28 +409,31 @@ evalfor(union node *n, int flags)
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
@@ -444,12 +442,16 @@ evalcase(union node *n, int flags)
 	setstackmark(&smark);
 	arglist.lastp = &arglist.list;
 	expandarg(n->ncase.expr, &arglist, EXP_TILDE);
-	exitstatus = 0;
 	for (cp = n->ncase.cases ; cp && evalskip == 0 ; cp = cp->nclist.next) {
 		for (patp = cp->nclist.pattern ; patp ; patp = patp->narg.next) {
 			if (casematch(patp, arglist.list->text)) {
-				if (evalskip == 0) {
-					evaltree(cp->nclist.body, flags);
+				/* Ensure body is non-empty as otherwise
+				 * EV_EXIT may prevent us from setting the
+				 * exit status.
+				 */
+				if (evalskip == 0 && cp->nclist.body) {
+					status = evaltree(cp->nclist.body,
+							  flags);
 				}
 				goto out;
 			}
@@ -457,6 +459,8 @@ evalcase(union node *n, int flags)
 	}
 out:
 	popstackmark(&smark);
+
+	return status;
 }
 
 
@@ -465,7 +469,7 @@ out:
  * Kick off a subshell to evaluate a tree.
  */
 
-STATIC void
+STATIC int
 evalsubshell(union node *n, int flags)
 {
 	struct job *jp;
@@ -494,8 +498,8 @@ nofork:
 	status = 0;
 	if (! backgnd)
 		status = waitforjob(jp);
-	exitstatus = status;
 	INTON;
+	return status;
 }
 
 
@@ -541,7 +545,7 @@ expredir(union node *n)
  * of all the rest.)
  */
 
-STATIC void
+STATIC int
 evalpipe(union node *n, int flags)
 {
 	struct job *jp;
@@ -549,6 +553,7 @@ evalpipe(union node *n, int flags)
 	int pipelen;
 	int prevfd;
 	int pip[2];
+	int status = 0;
 
 	TRACE(("evalpipe(0x%lx) called\n", (long)n));
 	pipelen = 0;
@@ -589,10 +594,12 @@ evalpipe(union node *n, int flags)
 		close(pip[1]);
 	}
 	if (n->npipe.backgnd == 0) {
-		exitstatus = waitforjob(jp);
-		TRACE(("evalpipe:  job done exit status %d\n", exitstatus));
+		status = waitforjob(jp);
+		TRACE(("evalpipe:  job done exit status %d\n", status));
 	}
 	INTON;
+
+	return status;
 }
 
 
@@ -679,7 +686,7 @@ parse_command_args(char **argv, const char **path)
  * Execute a simple command.
  */
 
-STATIC void
+STATIC int
 #ifdef notyet
 evalcommand(union node *cmd, int flags, struct backcmd *backcmd)
 #else
@@ -849,7 +856,7 @@ bail:
 			INTOFF;
 			jp = makejob(cmd, 1);
 			if (forkshell(jp, cmd, FORK_FG) != 0) {
-				exitstatus = waitforjob(jp);
+				status = waitforjob(jp);
 				INTON;
 				break;
 			}
@@ -868,17 +875,19 @@ bail:
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
 
@@ -894,6 +903,8 @@ out:
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
index 497ac16..fcd3e7d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -225,11 +225,13 @@ cmdloop(int top)
 			}
 			numeof++;
 		} else if (nflag == 0) {
+			int i;
+
 			job_warning = (job_warning == 2) ? 1 : 0;
 			numeof = 0;
-			evaltree(n, 0);
+			i = evaltree(n, 0);
 			if (n)
-				status = exitstatus;
+				status = i;
 		}
 		popstackmark(&smark);
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
