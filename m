From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/4] [EVAL] Remove unused EV_BACKCMD flag
Date: Sun, 10 Apr 2011 02:38:37 -0500
Message-ID: <20110410073837.GE17649@elie>
References: <20110410071734.GA16736@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58944 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab1DJHim (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 10 Apr 2011 03:38:42 -0400
Received: by iwn34 with SMTP id 34so4682001iwn.19
        for <dash@vger.kernel.org>; Sun, 10 Apr 2011 00:38:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110410071734.GA16736@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

The original ash defered forking commands in backquotes so builtins
could be run in the same context as the shell.  This behavior was
controlled using the EV_BACKCMD to evaltree.

Unfortunately, as Matthias Scheler noticed in 1999 (NetBSD PR/7814),
the result was counterintuitive; for example, echo "`cd /`" would
change the cwd.  So ash 0.3.5 left out that optimization.  The
EV_BACKCMD codepath stayed around, unused.

Some time between ash 0.3.5-11 and ash 0.3.8-37, Debian ash omitted
the EV_BACKCMD pathway by guarding it with #ifdef notyet.  In dash
0.5.1 and later, the commented code is no more.  Let's finish the job
and remove the last vestiges.  If someone wants to work on omitting
the fork in backcmd, the remaining hints are not going to be very
helpful, anyway.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.  Thoughts?

The new sizes in the cover letter are overestimated by 16 bytes.
Sorry about that.

 src/eval.c |   63 ++++++++++++++++++-----------------------------------------
 src/eval.h |    1 -
 2 files changed, 19 insertions(+), 45 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 77a9d00..120e186 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -592,6 +592,9 @@ evalpipe(union node *n, int flags)
 void
 evalbackcmd(union node *n, struct backcmd *result)
 {
+	int pip[2];
+	struct job *jp;
+
 	result->fd = -1;
 	result->buf = NULL;
 	result->nleft = 0;
@@ -600,52 +603,24 @@ evalbackcmd(union node *n, struct backcmd *result)
 		goto out;
 	}
 
-#ifdef notyet
-	/*
-	 * For now we disable executing builtins in the same
-	 * context as the shell, because we are not keeping
-	 * enough state to recover from changes that are
-	 * supposed only to affect subshells. eg. echo "`cd /`"
-	 */
-	if (n->type == NCMD) {
-		struct ifsregion saveifs;
-		struct ifsregion *savelastp;
-		struct nodelist *saveargbackq;
-
-		saveifs = ifsfirst;
-		savelastp = ifslastp;
-		saveargbackq = argbackq;
-
-		exitstatus = oexitstatus;
-		evalcommand(n, EV_BACKCMD, result);
-
-		ifsfirst = saveifs;
-		ifslastp = savelastp;
-		argbackq = saveargbackq;
-	} else
-#endif
-	{
-		int pip[2];
-		struct job *jp;
-
-		if (pipe(pip) < 0)
-			sh_error("Pipe call failed");
-		jp = makejob(n, 1);
-		if (forkshell(jp, n, FORK_NOJOB) == 0) {
-			FORCEINTON;
-			close(pip[0]);
-			if (pip[1] != 1) {
-				dup2(pip[1], 1);
-				close(pip[1]);
-			}
-			ifsfree();
-			evaltreenr(n, EV_EXIT);
-			/* NOTREACHED */
+	if (pipe(pip) < 0)
+		sh_error("Pipe call failed");
+	jp = makejob(n, 1);
+	if (forkshell(jp, n, FORK_NOJOB) == 0) {
+		FORCEINTON;
+		close(pip[0]);
+		if (pip[1] != 1) {
+			dup2(pip[1], 1);
+			close(pip[1]);
 		}
-		close(pip[1]);
-		result->fd = pip[0];
-		result->jp = jp;
+		ifsfree();
+		evaltreenr(n, EV_EXIT);
+		/* NOTREACHED */
 	}
+	close(pip[1]);
+	result->fd = pip[0];
+	result->jp = jp;
+
 out:
 	TRACE(("evalbackcmd done: fd=%d buf=0x%x nleft=%d jp=0x%x\n",
 		result->fd, result->buf, result->nleft, result->jp));
diff --git a/src/eval.h b/src/eval.h
index b1b13f5..4e4de30 100644
--- a/src/eval.h
+++ b/src/eval.h
@@ -49,7 +49,6 @@ struct backcmd {		/* result of evalbackcmd */
 /* flags in argument to evaltree */
 #define EV_EXIT 01		/* exit after evaluating tree */
 #define EV_TESTED 02		/* exit status is checked; ignore -e flag */
-#define EV_BACKCMD 04		/* command executing within back quotes */
 
 int evalstring(char *, int);
 union node;	/* BLETCH for ansi C */
-- 
1.7.5.rc0

