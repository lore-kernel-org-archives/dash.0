From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH] Globally rename pendingsigs to pending_sig
Date: Wed, 26 Oct 2016 19:28:29 +0200
Message-ID: <20161026172829.16405-1-dvlasenk@redhat.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754731AbcJZR2l (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 26 Oct 2016 13:28:41 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org

This variable does not contain "sigs" (plural).
It contains either 0 or (one) signal number of a pending signal.

For someone unfamiliar with this code, "pendingsigs" name is confusing -
it hints at being an array or bit mask of pending singnals.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: dash@vger.kernel.org
---
"pending_sig" is the name in use in another ash derivative, busybox's ash.
I would like to ask you to use exactly this name (not, say, "pendingsig"),
if possible, so that our code does not needlessly diverge further.

 src/jobs.c      |  4 ++--
 src/miscbltin.c |  2 +-
 src/trap.c      | 10 +++++-----
 src/trap.h      |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index 4f02e38..f0d34ab 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -648,7 +648,7 @@ out:
 	return retval;
 
 sigout:
-	retval = 128 + pendingsigs;
+	retval = 128 + pending_sig;
 	goto out;
 }
 
@@ -1147,7 +1147,7 @@ waitproc(int block, int *status)
 		sigfillset(&mask);
 		sigprocmask(SIG_SETMASK, &mask, &oldmask);
 
-		while (!gotsigchld && !pendingsigs)
+		while (!gotsigchld && !pending_sig)
 			sigsuspend(&oldmask);
 
 		sigclearmask();
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 39b9c47..5ccbbcb 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -152,7 +152,7 @@ readcmd(int argc, char **argv)
 		case 1:
 			break;
 		default:
-			if (errno == EINTR && !pendingsigs)
+			if (errno == EINTR && !pending_sig)
 				continue;
 				/* fall through */
 		case 0:
diff --git a/src/trap.c b/src/trap.c
index edb9938..69eb8ab 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -73,7 +73,7 @@ char sigmode[NSIG - 1];
 /* indicates specified signal received */
 static char gotsig[NSIG - 1];
 /* last pending signal */
-volatile sig_atomic_t pendingsigs;
+volatile sig_atomic_t pending_sig;
 /* received SIGCHLD */
 int gotsigchld;
 
@@ -291,7 +291,7 @@ onsig(int signo)
 	}
 
 	gotsig[signo - 1] = 1;
-	pendingsigs = signo;
+	pending_sig = signo;
 
 	if (signo == SIGINT && !trap[SIGINT]) {
 		if (!suppressint)
@@ -314,7 +314,7 @@ void dotrap(void)
 	int i;
 	int status, last_status;
 
-	if (!pendingsigs)
+	if (!pending_sig)
 		return;
 
 	status = savestatus;
@@ -323,7 +323,7 @@ void dotrap(void)
 		status = exitstatus;
 		savestatus = status;
 	}
-	pendingsigs = 0;
+	pending_sig = 0;
 	barrier();
 
 	for (i = 0, q = gotsig; i < NSIG - 1; i++, q++) {
@@ -331,7 +331,7 @@ void dotrap(void)
 			continue;
 
 		if (evalskip) {
-			pendingsigs = i + 1;
+			pending_sig = i + 1;
 			break;
 		}
 
diff --git a/src/trap.h b/src/trap.h
index 7573fd7..b9dfcf2 100644
--- a/src/trap.h
+++ b/src/trap.h
@@ -38,7 +38,7 @@
 
 extern int trapcnt;
 extern char sigmode[];
-extern volatile sig_atomic_t pendingsigs;
+extern volatile sig_atomic_t pending_sig;
 extern int gotsigchld;
 
 int trapcmd(int, char **);
-- 
2.9.2

