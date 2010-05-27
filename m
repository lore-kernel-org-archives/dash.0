From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: wait regression in 3800d4
Date: Thu, 27 May 2010 21:39:36 +1000
Message-ID: <20100527113936.GA9668@gondor.apana.org.au>
References: <20100522212852.GA36029@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:49772 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755219Ab0E0Ljl (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 27 May 2010 07:39:41 -0400
Content-Disposition: inline
In-Reply-To: <20100522212852.GA36029@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
> On Wed, May 19, 2010 at 07:08:56PM +0000, Gerrit Pape wrote:
>> Hi, since commit 3800d49 the wait builtin shows some unexpected
>> behavior, see http://bugs.debian.org/581425
> 
>> To reproduce:
> 
>>  $ dash -c '
>>  for i in 1 2 3; do
>>    (sleep $i; echo $i) &
>>  done
>>  wait
>>  echo all done
>>  sleep 2'
>>  1
>>  all done
>>  2
>>  3
>>  $ 
> 
> This patch is not correct as it makes dash busy-wait for the second and
> further processes to terminate. Also, I think aborting the wait builtin
> with 128+SIGCHLD is the correct behaviour if a trap on CHLD is active
> (like any other trap). This requires a more sophisticated handling of
> pendingsigs so that an untrapped SIGCHLD does not overwrite a trapped
> signal.

Ouch, this is indeed a serious bug!

Anyway, the following patch fixes it for me.

commit 207e4c2a322fe0f928944f7004b5b17ae2dceaaa
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu May 27 21:37:14 2010 +1000

    [JOBS] Fix wait regression where it does not wait for all jobs
    
    The sigsuspend patch broke wait by making it return after just
    one job has completed.  This is because we rely on pendingsigs
    to signal work and never clear it until waitcmd finishes.
    
    This patch adds a separate gotsigchld for this purpose so we
    can clear it before we start waiting.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 164eb2e..54d2972 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -9,6 +9,7 @@
 	* Do not poplocalvars prematurely on regular utilities.
 	* Move null redirect checks into caller.
 	* Fix popredir on abnormal exit from built-in.
+	* Fix wait regression where it does not wait for all jobs.
 
 2010-05-26  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/jobs.c b/src/jobs.c
index a4fada0..060187c 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1124,7 +1124,6 @@ waitproc(int block, int *status)
 	sigset_t mask, oldmask;
 	int flags = block == DOWAIT_BLOCK ? 0 : WNOHANG;
 	int err;
-	int sig;
 
 #if JOBS
 	if (jobctl)
@@ -1132,6 +1131,7 @@ waitproc(int block, int *status)
 #endif
 
 	do {
+		gotsigchld = 0;
 		err = wait3(status, flags, NULL);
 		if (err || !block)
 			break;
@@ -1141,11 +1141,11 @@ waitproc(int block, int *status)
 		sigfillset(&mask);
 		sigprocmask(SIG_SETMASK, &mask, &oldmask);
 
-		while (!(sig = pendingsigs))
+		while (!gotsigchld && !pendingsigs)
 			sigsuspend(&oldmask);
 
 		sigclearmask();
-	} while (sig == SIGCHLD);
+	} while (gotsigchld);
 
 	return err;
 }
diff --git a/src/trap.c b/src/trap.c
index ba32da6..7bd60ab 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -78,6 +78,8 @@ char sigmode[NSIG - 1];
 static char gotsig[NSIG - 1];
 /* last pending signal */
 volatile sig_atomic_t pendingsigs;
+/* received SIGCHLD */
+int gotsigchld;
 
 extern char *signal_names[];
 
@@ -284,6 +286,12 @@ ignoresig(int signo)
 void
 onsig(int signo)
 {
+	if (signo == SIGCHLD) {
+		gotsigchld = 1;
+		if (!trap[SIGCHLD])
+			return;
+	}
+
 	gotsig[signo - 1] = 1;
 	pendingsigs = signo;
 
diff --git a/src/trap.h b/src/trap.h
index 50fc3ed..bdd7944 100644
--- a/src/trap.h
+++ b/src/trap.h
@@ -39,6 +39,7 @@
 extern int trapcnt;
 extern char sigmode[];
 extern volatile sig_atomic_t pendingsigs;
+extern int gotsigchld;
 
 int trapcmd(int, char **);
 void clear_traps(void);

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
