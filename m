From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] jobs: Fix waitcmd busy loop
Date: Tue, 2 Jun 2020 23:46:48 +1000
Message-ID: <20200602134648.GA17275@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:56392 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgFBNqv (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 2 Jun 2020 09:46:51 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

We need to clear gotsigchld in waitproc because it is used as
a loop conditional for the waitcmd case.  Without it waitcmd
may busy loop after a SIGCHLD.

This patch also changes gotsigchld into a volatile sig_atomic_t
to prevent compilers from optimising its accesses away.

Fixes: 6c691b3e5099 ("jobs: Only clear gotsigchld when waiting...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 94bf47e..3417633 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1135,7 +1135,6 @@ static int dowait(int block, struct job *jp)
 	rpid = 1;
 
 	do {
-		gotsigchld = 0;
 		pid = waitone(block, jp);
 		rpid &= !!pid;
 
@@ -1175,6 +1174,7 @@ waitproc(int block, int *status)
 #endif
 
 	do {
+		gotsigchld = 0;
 		do
 			err = wait3(status, flags, NULL);
 		while (err < 0 && errno == EINTR);
diff --git a/src/trap.c b/src/trap.c
index 82e7ece..cd84814 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -76,7 +76,7 @@ static char gotsig[NSIG - 1];
 /* last pending signal */
 volatile sig_atomic_t pending_sig;
 /* received SIGCHLD */
-int gotsigchld;
+volatile sig_atomic_t gotsigchld;
 
 extern char *signal_names[];
 
diff --git a/src/trap.h b/src/trap.h
index 4c455a8..beaf660 100644
--- a/src/trap.h
+++ b/src/trap.h
@@ -39,7 +39,7 @@
 extern int trapcnt;
 extern char sigmode[];
 extern volatile sig_atomic_t pending_sig;
-extern int gotsigchld;
+extern volatile sig_atomic_t gotsigchld;
 
 int trapcmd(int, char **);
 void setsignal(int);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
