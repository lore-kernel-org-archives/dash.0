From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [ERROR] Set exitstatus in onint
Date: Thu, 2 Oct 2014 21:10:42 +0800
Message-ID: <20141002131041.GA28312@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:43046 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaJBNKp (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 2 Oct 2014 09:10:45 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

commit b4ce4120f87d89476b2d6ab31df43900d2f5ce89
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu Oct 2 21:07:55 2014 +0800

    [ERROR] Set exitstatus in onint
    
    Currently the exit status when we receive SIGINT is set in evalcommand
    which means that it doesn't always get set.  For example, if you press
    CTRL-C at the prompt of an interactive dash, the exit status is not
    set to 130 as it is in many other Bourne shells.
    
    This patch fixes this by moving the setting of the exit status into
    onint which also simplifies evalcommand.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 81aba60..9a601df 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -2,6 +2,7 @@
 
 	* Fix use-after-free in dotrap/evalstring.
 	* Make sure evalskip is zero before running traps.
+	* Set exitstatus in onint.
 
 2014-09-29  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/error.c b/src/error.c
index 9d31989..f9ea919 100644
--- a/src/error.c
+++ b/src/error.c
@@ -105,6 +105,7 @@ onint(void) {
 		signal(SIGINT, SIG_DFL);
 		raise(SIGINT);
 	}
+	exitstatus = SIGINT + 128;
 	exraise(EXINT);
 	/* NOTREACHED */
 }
diff --git a/src/eval.c b/src/eval.c
index 7f06931..0708bf5 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -853,21 +853,15 @@ bail:
 				listsetvar(varlist.list, VEXPORT);
 		}
 		if (evalbltin(cmdentry.u.cmd, argc, argv, flags)) {
-			int status;
-			int i;
-
-			i = exception;
-			if (i == EXEXIT)
-				goto raise;
-
-			status = (i == EXINT) ? SIGINT + 128 : 2;
-			exitstatus = status;
