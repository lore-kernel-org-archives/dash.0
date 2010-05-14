From: Jilles Tjoelker <jilles@stack.nl>
Subject: [PATCH] [EVAL] Force fork if any trap is set, not just on EXIT.
Date: Fri, 14 May 2010 23:44:29 +0200
Message-ID: <20100514214429.GA66145@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:60185 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760013Ab0ENVuu (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 14 May 2010 17:50:50 -0400
Received: from turtle.stack.nl (turtle.stack.nl [IPv6:2001:610:1108:5010::132])
	by mx1.stack.nl (Postfix) with ESMTP id 01C611DD655
	for <dash@vger.kernel.org>; Fri, 14 May 2010 23:44:29 +0200 (CEST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

In some cases the shell executes a subshell or an external command in
the current process. This is not done if a trap on EXIT has been set, so
that that trap can execute after the subshell or external command has
finished. Extend that check to all traps. (A trap is "set" if a
non-empty command string has been attached to it.)

Improve encapsulation by exporting an accessor function for this and
making the trap array static again.

This is much like FreeBSD SVN r194127, enhanced to apply to subshells
also (see FreeBSD SVN r194774).

Example:
  dash -c '{ trap "echo moo" TERM; sleep 3; }& sleep 1; kill $!;wait'
This should print "moo" after 3 seconds.

Example:
  dash -c '{ trap "echo moo" TERM; (sleep 3) }& sleep 1; kill $!;wait'
The same.

Example:
  dash -c '{ trap "echo moo" TERM; sleep 3; :; }& sleep 1; kill $!;wait'
This works correctly even without this patch.

Signed-off-by: Jilles Tjoelker <jilles@stack.nl>
---
 src/eval.c |    4 ++--
 src/trap.c |   16 +++++++++++++++-
 src/trap.h |    2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 62d9d5d..e7c95cc 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -448,7 +448,7 @@ evalsubshell(union node *n, int flags)
 	int status;
 
 	expredir(n->nredir.redirect);
-	if (!backgnd && flags & EV_EXIT && !trap[0])
+	if (!backgnd && flags & EV_EXIT && !have_traps())
 		goto nofork;
 	INTOFF;
 	jp = makejob(n, 1);
@@ -829,7 +829,7 @@ bail:
 	switch (cmdentry.cmdtype) {
 	default:
 		/* Fork off a child process if necessary. */
-		if (!(flags & EV_EXIT) || trap[0]) {
+		if (!(flags & EV_EXIT) || have_traps()) {
 			INTOFF;
 			jp = makejob(cmd, 1);
 			if (forkshell(jp, cmd, FORK_FG) != 0) {
diff --git a/src/trap.c b/src/trap.c
index 3f93c46..439b8d2 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -69,7 +69,7 @@
 
 
 /* trap handler commands */
-char *trap[NSIG];
+static char *trap[NSIG];
 /* current value of signal */
 char sigmode[NSIG - 1];
 /* indicates specified signal received */
@@ -163,6 +163,20 @@ clear_traps(void)
 }
 
 
+/*
+ * Check if we have any traps enabled.
+ */
+int
+have_traps(void)
+{
+	char *volatile *tp;
+
+	for (tp = trap ; tp <= &trap[NSIG - 1] ; tp++) {
+		if (*tp && **tp)	/* trap not NULL or SIG_IGN */
+			return 1;
+	}
+	return 0;
+}
 
 /*
  * Set the signal handler for the specified signal.  The routine figures
diff --git a/src/trap.h b/src/trap.h
index f19a66b..4e897a9 100644
--- a/src/trap.h
+++ b/src/trap.h
@@ -36,12 +36,12 @@
 
 #include <signal.h>
 
-extern char *trap[];
 extern char sigmode[];
 extern volatile sig_atomic_t pendingsigs;
 
 int trapcmd(int, char **);
 void clear_traps(void);
+int have_traps(void);
 void setsignal(int);
 void ignoresig(int);
 void onsig(int);
-- 
1.7.1

