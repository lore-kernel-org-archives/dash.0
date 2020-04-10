From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: jobs: Fix infinite loop in waitproc
Date: Fri, 10 Apr 2020 21:03:09 +1000
Message-ID: <20200410110309.GA13801@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:48170 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDJLDM (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 10 Apr 2020 07:03:12 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, Harald van Dijk <harald@gigawatt.nl>

After we changed the resetting of gotsigchld so that it is only
done if jp is NULL, we can now get an infinite loop in waitproc
if gotsigchld is set but there is no outstanding child because
everything had been waited for previously without gotsigchld being
zeroed.

This patch fixes it by always zeroing gotsigchld as we did before.
The bug that the previous patch was trying to fix is now resolved
by switching the blocking mode to DOWAIT_NORMAL after the specified
job has been completed so that we really do wait for all outstanding
dead children.

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Fixes: 6c691b3e5099 ("jobs: Only clear gotsigchld when waiting...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 26a6248..72e7aa9 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1123,15 +1123,28 @@ out:
 
 static int dowait(int block, struct job *jp)
 {
-	int pid = block == DOWAIT_NORMAL ? gotsigchld : 1;
+	int gotchld = *(volatile int *)&gotsigchld;
+	int rpid;
+	int pid;
+
+	if (jp && jp->state != JOBRUNNING)
+		block = DOWAIT_NORMAL;
+
+	if (block == DOWAIT_NORMAL && !gotchld)
+		return 1;
 
-	while (jp ? jp->state == JOBRUNNING : pid > 0) {
-		if (!jp)
-			gotsigchld = 0;
+	rpid = 1;
+
+	do {
+		gotsigchld = 0;
 		pid = waitone(block, jp);
-	}
+		rpid &= !!pid;
 
-	return pid;
+		if (!pid || (jp && jp->state != JOBRUNNING))
+			block = DOWAIT_NORMAL;
+	} while (pid >= 0);
+
+	return rpid;
 }
 
 /*
@@ -1163,7 +1176,10 @@ waitproc(int block, int *status)
 #endif
 
 	do {
-		err = wait3(status, flags, NULL);
+		do
+			err = wait3(status, flags, NULL);
+		while (err < 0 && errno == EINTR);
+
 		if (err || (err = -!block))
 			break;
 
@@ -1173,8 +1189,6 @@ waitproc(int block, int *status)
 			sigsuspend(&oldmask);
 
 		sigclearmask();
-
-		err = 0;
 	} while (gotsigchld);
 
 	return err;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
