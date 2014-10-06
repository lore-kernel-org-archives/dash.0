From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [BUILTIN] Exit without arguments in a trap should use status outside
 traps
Date: Mon, 6 Oct 2014 10:40:58 +0800
Message-ID: <20141006024058.GA19450@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:56683 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbaJFClD (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 5 Oct 2014 22:41:03 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Please review:

commit da30b4b787695fbf77e5d941ff350a66ca572bcb
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Oct 6 10:39:47 2014 +0800

    [BUILTIN] Exit without arguments in a trap should use status outside traps
    
    POSIX now requires that exit without arguments in a trap should
    return the last command status prior to executing traps.  This
    patch implements this behaviour.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 4dc8fa3..d0ec202 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-10-06  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Exit without arguments in a trap should use status outside traps.
+
 2014-10-03  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Do not clobber exitstatus in evalcommand.
diff --git a/src/eval.c b/src/eval.c
index 3f4d957..51a900d 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -74,6 +74,7 @@ static int funcline;		/* starting line number of current function, or 0 if not i
 char *commandname;
 int exitstatus;			/* exit status of last command */
 int back_exitstatus;		/* exit status of backquoted command */
+int savestatus = -1;		/* exit status of last command outside traps */
 
 
 #if !defined(__alpha__) || (defined(__GNUC__) && __GNUC__ >= 3)
@@ -114,6 +115,10 @@ INCLUDE "eval.h"
 RESET {
 	evalskip = 0;
 	loopnest = 0;
+	if (savestatus >= 0) {
+		exitstatus = savestatus;
+		savestatus = -1;
+	}
 }
 #endif
 
diff --git a/src/eval.h b/src/eval.h
index dc8acd2..6e62137 100644
--- a/src/eval.h
+++ b/src/eval.h
@@ -37,6 +37,7 @@
 extern char *commandname;	/* currently executing command */
 extern int exitstatus;		/* exit status of last command */
 extern int back_exitstatus;	/* exit status of backquoted command */
+extern int savestatus;		/* exit status of last command outside traps */
 
 
 struct backcmd {		/* result of evalbackcmd */
diff --git a/src/main.c b/src/main.c
index f79ad7d..29a258d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -339,8 +339,15 @@ exitcmd(int argc, char **argv)
 {
 	if (stoppedjobs())
 		return 0;
-	if (argc > 1)
-		exitstatus = number(argv[1]);
+
+	if (argc > 1) {
+		int status = number(argv[1]);
+
+		exitstatus = status;
+		if (savestatus >= 0)
+			savestatus = status;
+	}
+
 	exraise(EXEXIT);
 	/* NOTREACHED */
 }
diff --git a/src/trap.c b/src/trap.c
index e34e0f8..15faeff 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -314,12 +314,17 @@ void dotrap(void)
 	char *p;
 	char *q;
 	int i;
-	int savestatus;
+	int status, last_status;
 
 	if (!pendingsigs)
 		return;
 
-	savestatus = exitstatus;
+	status = savestatus;
+	last_status = status;
+	if (likely(status < 0)) {
+		status = exitstatus;
+		savestatus = status;
+	}
 	pendingsigs = 0;
 	barrier();
 
@@ -338,8 +343,10 @@ void dotrap(void)
 		if (!p)
 			continue;
 		evalstring(p, 0);
-		exitstatus = savestatus;
+		exitstatus = status;
 	}
+
+	savestatus = last_status;
 }
 
 
@@ -373,18 +380,14 @@ exitshell(void)
 {
 	struct jmploc loc;
 	char *p;
-	volatile int status;
 
 #ifdef HETIO
 	hetio_reset_term();
 #endif
-	status = exitstatus;
-	TRACE(("pid %d, exitshell(%d)\n", getpid(), status));
-	if (setjmp(loc.loc)) {
-		if (exception == EXEXIT)
-			status = exitstatus;
+	savestatus = exitstatus;
+	TRACE(("pid %d, exitshell(%d)\n", getpid(), savestatus));
+	if (setjmp(loc.loc))
 		goto out;
-	}
 	handler = &loc;
 	if ((p = trap[0])) {
 		trap[0] = NULL;
@@ -399,7 +402,7 @@ out:
 	if (likely(!setjmp(loc.loc)))
 		setjobctl(0);
 	flushall();
-	_exit(status);
+	_exit(savestatus);
 	/* NOTREACHED */
 }

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
