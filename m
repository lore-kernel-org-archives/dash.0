From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: job control (Re: dash race)
Date: Sun, 22 Feb 2009 18:19:01 +0800
Message-ID: <20090222101901.GA2484@gondor.apana.org.au>
References: <20080427114917.GN24008@flower.upol.cz> <E1JqqRh-0005R5-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:51643 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753221AbZBVKTM (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 22 Feb 2009 05:19:12 -0500
Content-Disposition: inline
In-Reply-To: <E1JqqRh-0005R5-00@gondolin.me.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: gladkov.alexey@gmail.com, dash@vger.kernel.org

On Tue, Apr 29, 2008 at 10:04:37PM +0800, Herbert Xu wrote:
> 
> Unfortunately I'm awfully busy right now but I'll try to reproduce
> it once I get a chance.  If anyone can get me a patch before then
> it'd be much appreciated :)

OK, I finally got to playing with this and here is the patch to
fix it:

commit ed25e9f97e007f684146f729bb5cdeaf91b668b6
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Feb 22 18:16:13 2009 +0800

    [SIGNAL] Remove EXSIG
    
    Now that waitcmd no longer uses EXSIG we can remove it.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 8f58d96..d87e5d4 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2009-02-22  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix dowait signal race.
+	* Remove EXSIG.
 
 2009-01-14  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/error.c b/src/error.c
index 7f165c1..e304d3d 100644
--- a/src/error.c
+++ b/src/error.c
@@ -51,7 +51,6 @@
 #include "show.h"
 #include "eval.h"
 #include "parser.h"
-#include "trap.h"
 #include "system.h"
 
 
@@ -98,19 +97,14 @@ exraise(int e)
 
 void
 onint(void) {
-	int i;
 
 	intpending = 0;
 	sigclearmask();
-	i = EXSIG;
-	if (gotsig[SIGINT - 1] && !trap[SIGINT]) {
-		if (!(rootshell && iflag)) {
-			signal(SIGINT, SIG_DFL);
-			raise(SIGINT);
-		}
-		i = EXINT;
+	if (!(rootshell && iflag)) {
+		signal(SIGINT, SIG_DFL);
+		raise(SIGINT);
 	}
-	exraise(i);
+	exraise(EXINT);
 	/* NOTREACHED */
 }
 
diff --git a/src/error.h b/src/error.h
index dd1fc3f..3162e15 100644
--- a/src/error.h
+++ b/src/error.h
@@ -69,7 +69,6 @@ extern int exception;
 #define EXSHELLPROC 2	/* execute a shell procedure */
 #define EXEXEC 3	/* command execution failed */
 #define EXEXIT 4	/* exit the shell */
-#define EXSIG 5		/* trapped signal in wait(1) */
 
 
 /*
@@ -81,7 +80,6 @@ extern int exception;
 
 extern int suppressint;
 extern volatile sig_atomic_t intpending;
-extern int exsig;
 
 #define barrier() ({ __asm__ __volatile__ ("": : :"memory"); })
 #define INTOFF \
@@ -117,15 +115,6 @@ void __inton(void);
 	})
 #define CLEAR_PENDING_INT intpending = 0
 #define int_pending() intpending
-#define EXSIGON() \
-	({ \
-		exsig++; \
-		barrier(); \
-		if (pendingsigs) \
-			exraise(EXSIG); \
-		0; \
-	})
-/* EXSIG is turned off by evalbltin(). */
 
 void exraise(int) __attribute__((__noreturn__));
 #ifdef USE_NORETURN
diff --git a/src/eval.c b/src/eval.c
index 0b449ee..b90a354 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -863,20 +863,13 @@ bail:
 		}
 		if (evalbltin(cmdentry.u.cmd, argc, argv)) {
 			int status;
-			int i, j;
+			int i;
 
 			i = exception;
 			if (i == EXEXIT)
 				goto raise;
 
-			status = 2;
-			j = 0;
-			if (i == EXINT)
-				j = SIGINT;
-			if (i == EXSIG)
-				j = pendingsigs;
-			if (j)
-				status = j + 128;
+			status = (i == EXINT) ? SIGINT + 128 : 2;
 			exitstatus = status;
 
 			if (i == EXINT || spclbltin > 0) {
@@ -926,7 +919,6 @@ cmddone:
 	exitstatus |= outerr(out1);
 	freestdout();
 	commandname = savecmdname;
-	exsig = 0;
 	handler = savehandler;
 
 	return i;
diff --git a/src/trap.c b/src/trap.c
index 53663ae..5b8b046 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -73,11 +73,9 @@ char *trap[NSIG];
 /* current value of signal */
 char sigmode[NSIG - 1];
 /* indicates specified signal received */
-char gotsig[NSIG - 1];
+static char gotsig[NSIG - 1];
 /* last pending signal */
 volatile sig_atomic_t pendingsigs;
-/* do we generate EXSIG events */
-int exsig;
 
 extern char *signal_names[];
 
@@ -278,7 +276,7 @@ onsig(int signo)
 	gotsig[signo - 1] = 1;
 	pendingsigs = signo;
 
-	if (exsig || (signo == SIGINT && !trap[SIGINT])) {
+	if (signo == SIGINT && !trap[SIGINT]) {
 		if (!suppressint)
 			onint();
 		intpending = 1;
diff --git a/src/trap.h b/src/trap.h
index 50c1587..f19a66b 100644
--- a/src/trap.h
+++ b/src/trap.h
@@ -37,7 +37,6 @@
 #include <signal.h>
 
 extern char *trap[];
-extern char gotsig[];
 extern char sigmode[];
 extern volatile sig_atomic_t pendingsigs;
 

commit 3800d4934391b144fd261a7957aea72ced7d47ea
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Feb 22 18:10:01 2009 +0800

    [JOBS] Fix dowait signal race
    
    This test program by Alexey Gladkov can cause dash to enter an
    infinite loop in waitcmd.
    
    #!/bin/dash
    trap "echo TRAP" USR1
    stub() {
    echo ">>> STUB $1" >&2
    sleep $1
    echo "<<< STUB $1" >&2
    kill -USR1 $$
    }
    stub 3 &
    stub 2 &
    until { echo "###"; wait; } do
    echo "*** $?"
    done
    
    The problem is that if we get a signal after the wait3 system
    call has returned but before we get to INTON in dowait, then
    we can jump back up to the top and lose the exit status.  So
    if we then wait for the job that has just exited, then it'll
    stay there forever.
    
    I made the original change that caused this bug to fix pretty
    much the same bug but in the opposite direction.  That is, if
    we get a signal after we enter wait3 but before we hit the kernel
    then it too can cause the wait to go on forever (assuming the
    child doesn't exit).
    
    In fact this is pretty much exactly the scenario that you'll
    find in glibc's documentation on pause().  The solution is given
    there too, in the form of sigsuspend, which is the only way to
    do the check and wait atomically.
    
    So this patch fixes Alexey's race without reintroducing the old
    bug by converting the blocking wait3 to a sigsuspend.
    
    In order to do this we need to set a signal handler for SIGCHLD,
    so the code has been modified to always do that.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 1d18cbf..8f58d96 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2009-02-22  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix dowait signal race.
+
 2009-01-14  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Add arith_yacc.h to dash_SOURCES.
diff --git a/src/jobs.c b/src/jobs.c
index 2b6a752..69a84f7 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -75,6 +75,7 @@
 /* mode flags for dowait */
 #define DOWAIT_NORMAL 0
 #define DOWAIT_BLOCK 1
+#define DOWAIT_WAITCMD 2
 
 /* array of jobs */
 static struct job *jobtab;
@@ -589,8 +590,6 @@ waitcmd(int argc, char **argv)
 	int retval;
 	struct job *jp;
 
-	EXSIGON();
-
 	nextopt(nullstr);
 	retval = 0;
 
@@ -609,7 +608,8 @@ waitcmd(int argc, char **argv)
 				jp->waited = 1;
 				jp = jp->prev_job;
 			}
-			dowait(DOWAIT_BLOCK, 0);
+			if (dowait(DOWAIT_WAITCMD, 0) <= 0)
+				goto sigout;
 		}
 	}
 
@@ -631,7 +631,8 @@ start:
 			job = getjob(*argv, 0);
 		/* loop until process terminated or stopped */
 		while (job->state == JOBRUNNING)
-			dowait(DOWAIT_BLOCK, 0);
+			if (dowait(DOWAIT_WAITCMD, 0) <= 0)
+				goto sigout;
 		job->waited = 1;
 		retval = getstatus(job);
 repeat:
@@ -640,6 +641,10 @@ repeat:
 
 out:
 	return retval;
+
+sigout:
+	retval = 128 + pendingsigs;
+	goto out;
 }
 
 
@@ -998,16 +1003,16 @@ dowait(int block, struct job *job)
 	int pid;
 	int status;
 	struct job *jp;
-	struct job *thisjob;
+	struct job *thisjob = NULL;
 	int state;
 
+	INTOFF;
 	TRACE(("dowait(%d) called\n", block));
 	pid = waitproc(block, &status);
 	TRACE(("wait returns pid %d, status=%d\n", pid, status));
 	if (pid <= 0)
-		return pid;
-	INTOFF;
-	thisjob = NULL;
+		goto out;
+
 	for (jp = curjob; jp; jp = jp->prev_job) {
 		struct procstat *sp;
 		struct procstat *spend;
@@ -1115,34 +1120,33 @@ STATIC int onsigchild() {
 STATIC int
 waitproc(int block, int *status)
 {
-#ifdef BSD
-	int flags = 0;
+	sigset_t mask, oldmask;
+	int flags = block == DOWAIT_BLOCK ? 0 : WNOHANG;
+	int err;
+	int sig;
 
 #if JOBS
 	if (jobctl)
 		flags |= WUNTRACED;
 #endif
-	if (block == 0)
-		flags |= WNOHANG;
-	return wait3(status, flags, (struct rusage *)NULL);
-#else
-#ifdef SYSV
-	int (*save)();
 
-	if (block == 0) {
-		gotsigchild = 0;
-		save = signal(SIGCLD, onsigchild);
-		signal(SIGCLD, save);
-		if (gotsigchild == 0)
-			return 0;
-	}
-	return wait(status);
-#else
-	if (block == 0)
-		return 0;
-	return wait(status);
-#endif
-#endif
+	do {
+		err = wait3(status, flags, NULL);
+		if (err || !block)
+			break;
+
+		block = 0;
+
+		sigfillset(&mask);
+		sigprocmask(SIG_SETMASK, &mask, &oldmask);
+
+		while (!(sig = pendingsigs))
+			sigsuspend(&oldmask);
+
+		sigclearmask();
+	} while (sig == SIGCHLD);
+
+	return err;
 }
 
 /*
diff --git a/src/trap.c b/src/trap.c
index 58cd0cc..53663ae 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -71,7 +71,7 @@
 /* trap handler commands */
 char *trap[NSIG];
 /* current value of signal */
-static char sigmode[NSIG - 1];
+char sigmode[NSIG - 1];
 /* indicates specified signal received */
 char gotsig[NSIG - 1];
 /* last pending signal */
@@ -82,9 +82,10 @@ int exsig;
 extern char *signal_names[];
 
 #ifdef mkinit
-INCLUDE <signal.h>
+INCLUDE "trap.h"
 INIT {
-	signal(SIGCHLD, SIG_DFL);
+	sigmode[SIGCHLD - 1] = S_DFL;
+	setsignal(SIGCHLD);
 }
 #endif
 
@@ -207,6 +208,9 @@ setsignal(int signo)
 		}
 	}
 
+	if (signo == SIGCHLD)
+		action = S_CATCH;
+
 	t = &sigmode[signo - 1];
 	tsig = *t;
 	if (tsig == 0) {
diff --git a/src/trap.h b/src/trap.h
index e889136..50c1587 100644
--- a/src/trap.h
+++ b/src/trap.h
@@ -38,6 +38,7 @@
 
 extern char *trap[];
 extern char gotsig[];
+extern char sigmode[];
 extern volatile sig_atomic_t pendingsigs;
 
 int trapcmd(int, char **);

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
