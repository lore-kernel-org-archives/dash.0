From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH] redir: Clear saved redirections in subshell
Date: Sun, 19 Jan 2020 18:21:59 +0800
Message-ID: <20200119102159.vh54dcliaxgz2k5o@gondor.apana.org.au>
References: <c1a9c062-0917-d3f3-8826-811b5a4fd802@gigawatt.nl>
 <20200117085124.ub53qala7c636owf@gondor.apana.org.au>
 <20200117095755.y6mwflmqqw7zeegh@gondor.apana.org.au>
 <20200117152825.ll4kge4ehy36xhxw@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:39636 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgASKWC (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 19 Jan 2020 05:22:02 -0500
Content-Disposition: inline
In-Reply-To: <20200117152825.ll4kge4ehy36xhxw@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: DASH shell mailing list <dash@vger.kernel.org>

On Fri, Jan 17, 2020 at 11:28:25PM +0800, Herbert Xu wrote:
> 
> Here is a new version that adds a forkreset hook to mkinit so
> that we do the clearing even when we enter a subshell without
> forking.

Slight update to remove the reset_handler prototype.

---8<---
When we enter a subshell we need to drop the saved redirections
as otherwise a subsequent unwindredir could produce incorrect
results.

This patch does this by simply clearing redirlist.  While we
could actually free the memory underneath for subshells it isn't
really worth the trouble for now.

In order to ensure that this is done in every place where we enter
a subshell, this patch adds a new mkinit hook called forkreset.
The calls closescript, clear_traps and reset_handler are also added
to the forkreset hook.

This fixes a bug where the first two functions weren't called
if we enter a subshell without forking.

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/eval.c b/src/eval.c
index 6ee2e1a..1b5d61d 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -41,6 +41,7 @@
  * Evaluate a command.
  */
 
+#include "init.h"
 #include "main.h"
 #include "shell.h"
 #include "nodes.h"
@@ -483,17 +484,18 @@ evalsubshell(union node *n, int flags)
 		lineno -= funcline - 1;
 
 	expredir(n->nredir.redirect);
-	if (!backgnd && flags & EV_EXIT && !have_traps())
-		goto nofork;
 	INTOFF;
+	if (!backgnd && flags & EV_EXIT && !have_traps()) {
+		forkreset();
+		goto nofork;
+	}
 	jp = makejob(n, 1);
 	if (forkshell(jp, n, backgnd) == 0) {
-		INTON;
 		flags |= EV_EXIT;
 		if (backgnd)
 			flags &=~ EV_TESTED;
 nofork:
-		reset_handler();
+		INTON;
 		redirect(n->nredir.redirect, 0);
 		evaltreenr(n->nredir.n, flags);
 		/* never returns */
@@ -576,7 +578,6 @@ evalpipe(union node *n, int flags)
 			}
 		}
 		if (forkshell(jp, lp->n, n->npipe.backgnd) == 0) {
-			reset_handler();
 			INTON;
 			if (pip[1] >= 0) {
 				close(pip[0]);
@@ -633,7 +634,6 @@ evalbackcmd(union node *n, struct backcmd *result)
 		sh_error("Pipe call failed");
 	jp = makejob(n, 1);
 	if (forkshell(jp, n, FORK_NOJOB) == 0) {
-		reset_handler();
 		FORCEINTON;
 		close(pip[0]);
 		if (pip[1] != 1) {
diff --git a/src/init.h b/src/init.h
index 49791a0..d56fb28 100644
--- a/src/init.h
+++ b/src/init.h
@@ -36,4 +36,5 @@
 
 void init(void);
 void exitreset(void);
+void forkreset(void);
 void reset(void);
diff --git a/src/input.c b/src/input.c
index ae0c4c8..177fd0a 100644
--- a/src/input.c
+++ b/src/input.c
@@ -78,6 +78,7 @@ static int preadbuffer(void);
 
 #ifdef mkinit
 INCLUDE <stdio.h>
+INCLUDE <unistd.h>
 INCLUDE "input.h"
 INCLUDE "error.h"
 
@@ -91,6 +92,14 @@ RESET {
 	basepf.lleft = basepf.nleft = 0;
 	popallfiles();
 }
+
+FORKRESET {
+	popallfiles();
+	if (parsefile->fd > 0) {
+		close(parsefile->fd);
+		parsefile->fd = 0;
+	}
+}
 #endif
 
 
@@ -495,20 +504,3 @@ popallfiles(void)
 {
 	unwindfiles(&basepf);
 }
-
-
-
-/*
- * Close the file(s) that the shell is reading commands from.  Called
- * after a fork is done.
- */
-
-void
-closescript(void)
-{
-	popallfiles();
-	if (parsefile->fd > 0) {
-		close(parsefile->fd);
-		parsefile->fd = 0;
-	}
-}
diff --git a/src/input.h b/src/input.h
index a9c0517..8acc6e9 100644
--- a/src/input.h
+++ b/src/input.h
@@ -99,4 +99,3 @@ void setinputstring(char *);
 void popfile(void);
 void unwindfiles(struct parsefile *);
 void popallfiles(void);
-void closescript(void);
diff --git a/src/jobs.c b/src/jobs.c
index 26a6248..f377d8c 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -55,6 +55,7 @@
 #endif
 #include "exec.h"
 #include "eval.h"
+#include "init.h"
 #include "redir.h"
 #include "show.h"
 #include "main.h"
@@ -857,8 +858,7 @@ static void forkchild(struct job *jp, union node *n, int mode)
 	if (!lvforked) {
 		shlvl++;
 
-		closescript();
-		clear_traps();
+		forkreset();
 
 #if JOBS
 		/* do job control only in root shell */
diff --git a/src/main.c b/src/main.c
index b2712cb..36431fc 100644
--- a/src/main.c
+++ b/src/main.c
@@ -71,7 +71,7 @@ int *dash_errno;
 short profile_buf[16384];
 extern int etext();
 #endif
-static struct jmploc main_handler;
+MKINIT struct jmploc main_handler;
 
 STATIC void read_profile(const char *);
 STATIC char *find_dot_file(char *);
@@ -354,7 +354,10 @@ exitcmd(int argc, char **argv)
 	/* NOTREACHED */
 }
 
-void reset_handler(void)
-{
+#ifdef mkinit
+INCLUDE "error.h"
+
+FORKRESET {
 	handler = &main_handler;
 }
+#endif
diff --git a/src/main.h b/src/main.h
index 51f1604..19e4983 100644
--- a/src/main.h
+++ b/src/main.h
@@ -52,4 +52,3 @@ extern int *dash_errno;
 void readcmdfile(char *);
 int dotcmd(int, char **);
 int exitcmd(int, char **);
-void reset_handler(void);
diff --git a/src/memalloc.h b/src/memalloc.h
index b9c63da..b9adf76 100644
--- a/src/memalloc.h
+++ b/src/memalloc.h
@@ -35,6 +35,7 @@
  */
 
 #include <stddef.h>
+#include <stdlib.h>
 
 struct stackmark {
 	struct stack_block *stackp;
diff --git a/src/mkinit.c b/src/mkinit.c
index 5bca9ee..9025862 100644
--- a/src/mkinit.c
+++ b/src/mkinit.c
@@ -113,6 +113,11 @@ char exitreset[] = "\
  * but prior to exitshell. \n\
  */\n";
 
+char forkreset[] = "\
+/*\n\
+ * This routine is called when we enter a subshell.\n\
+ */\n";
+
 char reset[] = "\
 /*\n\
  * This routine is called when an error or an interrupt occurs in an\n\
@@ -123,6 +128,7 @@ char reset[] = "\
 struct event event[] = {
 	{"INIT", "init", init},
 	{"EXITRESET", "exitreset", exitreset},
+	{"FORKRESET", "forkreset", forkreset},
 	{"RESET", "reset", reset},
 	{NULL, NULL}
 };
diff --git a/src/redir.c b/src/redir.c
index 6c81dd0..895140c 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -401,6 +401,10 @@ EXITRESET {
 	unwindredir(0);
 }
 
+FORKRESET {
+	redirlist = NULL;
+}
+
 #endif
 
 
diff --git a/src/redir.h b/src/redir.h
index 8e56995..1cf2761 100644
--- a/src/redir.h
+++ b/src/redir.h
@@ -45,7 +45,6 @@ struct redirtab;
 union node;
 void redirect(union node *, int);
 void popredir(int);
-void clearredir(void);
 int savefd(int, int);
 int redirectsafe(union node *, int);
 void unwindredir(struct redirtab *stop);
diff --git a/src/trap.c b/src/trap.c
index 58a7c60..82e7ece 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -66,7 +66,7 @@
 
 
 /* trap handler commands */
-static char *trap[NSIG];
+MKINIT char *trap[NSIG];
 /* number of non-null traps */
 int trapcnt;
 /* current value of signal */
@@ -83,11 +83,29 @@ extern char *signal_names[];
 static int decode_signum(const char *);
 
 #ifdef mkinit
+INCLUDE "memalloc.h"
 INCLUDE "trap.h"
+
 INIT {
 	sigmode[SIGCHLD - 1] = S_DFL;
 	setsignal(SIGCHLD);
 }
+
+FORKRESET {
+	char **tp;
+
+	INTOFF;
+	for (tp = trap ; tp < &trap[NSIG] ; tp++) {
+		if (*tp && **tp) {	/* trap not NULL or SIG_IGN */
+			ckfree(*tp);
+			*tp = NULL;
+			if (tp != &trap[0])
+				setsignal(tp - trap);
+		}
+	}
+	trapcnt = 0;
+	INTON;
+}
 #endif
 
 /*
@@ -151,30 +169,6 @@ trapcmd(int argc, char **argv)
 
 
 /*
- * Clear traps on a fork.
- */
-
-void
-clear_traps(void)
-{
-	char **tp;
-
-	INTOFF;
-	for (tp = trap ; tp < &trap[NSIG] ; tp++) {
-		if (*tp && **tp) {	/* trap not NULL or SIG_IGN */
-			ckfree(*tp);
-			*tp = NULL;
-			if (tp != &trap[0])
-				setsignal(tp - trap);
-		}
-	}
-	trapcnt = 0;
-	INTON;
-}
-
-
-
-/*
  * Set the signal handler for the specified signal.  The routine figures
  * out what it should be set to.
  */
diff --git a/src/trap.h b/src/trap.h
index 5fd65af..4c455a8 100644
--- a/src/trap.h
+++ b/src/trap.h
@@ -42,7 +42,6 @@ extern volatile sig_atomic_t pending_sig;
 extern int gotsigchld;
 
 int trapcmd(int, char **);
-void clear_traps(void);
 void setsignal(int);
 void ignoresig(int);
 void onsig(int);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
