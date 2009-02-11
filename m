From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] [SHELL] execute EXIT trap if the shell is killed through a signal
Date: Wed, 11 Feb 2009 14:55:08 +0000
Message-ID: <20090211145509.21298.qmail@bfa063280f4838.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([212.42.242.37]:3831 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754852AbZBKOzL (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Feb 2009 09:55:11 -0500
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

From: Chris Lamb <chris@chris-lamb.co.uk>

dash used to print the following output when running this test script

 $ dash -c 'trap "echo EXIT trap executed" EXIT; kill -HUP $$'
 Hangup
 $

With this commit, it properly executes the EXIT trap defined

 $ dash -c 'trap "echo EXIT trap executed" EXIT; kill -HUP $$'
 EXIT trap executed
 $

The missing trap handling was reported by Martin Dickopp through
 http://bugs.debian.org/390433

Patch is from Chris Lamb.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 src/trap.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/src/trap.c b/src/trap.c
index 58cd0cc..732fd41 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -67,6 +67,8 @@
 #define S_HARD_IGN 4		/* signal is ignored permenantly */
 #define S_RESET 5		/* temporary - to reset a hard ignored sig */
 
+#define SIGEXIT 0
+#define DUMMY_ACTION savestr(":")
 
 /* trap handler commands */
 char *trap[NSIG];
@@ -97,7 +99,7 @@ trapcmd(int argc, char **argv)
 {
 	char *action;
 	char **ap;
-	int signo;
+	int signo, dummysig;
 
 	nextopt(nullstr);
 	ap = argptr;
@@ -122,16 +124,32 @@ trapcmd(int argc, char **argv)
 			sh_error("%s: bad trap", *ap);
 		INTOFF;
 		if (action) {
-			if (action[0] == '-' && action[1] == '\0')
-				action = NULL;
-			else
+			if (action[0] == '-' && action[1] == '\0') {
+				if (signo != SIGEXIT && trap[0] != NULL)
+					/* Reset dummy handler */
+					action = DUMMY_ACTION;
+				else
+					action = NULL;
+			} else {
 				action = savestr(action);
+			}
+		} else {
+			action = DUMMY_ACTION;
 		}
 		if (trap[signo])
 			ckfree(trap[signo]);
 		trap[signo] = action;
-		if (signo != 0)
+		if (signo == SIGEXIT) {
+			/* Set dummy handlers */
+			for (dummysig = 1 ; dummysig < NSIG ; dummysig++) {
+				if (trap[dummysig] == NULL) {
+					trap[dummysig] = DUMMY_ACTION;
+					setsignal(dummysig);
+				}
+			}
+		} else {
 			setsignal(signo);
+		}
 		INTON;
 		ap++;
 	}
-- 
1.6.1.2.346.g8600b3.dirty

