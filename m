Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7921FC54EAA
	for <linux-dash@archiver.kernel.org>; Mon, 30 Jan 2023 21:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjA3VPv (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 30 Jan 2023 16:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjA3VPt (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 30 Jan 2023 16:15:49 -0500
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0917EE8
        for <dash@vger.kernel.org>; Mon, 30 Jan 2023 13:15:46 -0800 (PST)
Date:   Mon, 30 Jan 2023 22:15:42 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     dash@vger.kernel.org
Subject: [PATCH] Allow enabling job control without a tty in
 non-interactive mode..
Message-ID: <dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu>
User-Agent: s-nail v14.9.24-403-gdc9ff6b368
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Date:   Mon, 30 Jan 2023 22:15:40 +0100
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is a take-over of the FreeBSD bin/sh

  commit cd60e2c67d52e1f957841af19128c7227880743a
  Author:     Jilles Tjoelker <jilles@FreeBSD.org>
  AuthorDate: 2014-09-04 21:48:33 +0000
  Commit:     Jilles Tjoelker <jilles@FreeBSD.org>
  CommitDate: 2014-09-04 21:48:33 +0000

      sh: Allow enabling job control without a tty in non-interactive mode.

      If no tty is available, 'set -m' is still useful to put jobs in their own
      process groups.
---

Dear Ganael, it seems it requires an inline patch?
Let me try this -- thanks!!
Ciao.

 src/jobs.c | 114 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 47 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index f3b9ffc285..db1f204045 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -125,7 +125,7 @@ STATIC int getstatus(struct job *);
 
 #if JOBS
 static int restartjob(struct job *, int);
-static void xtcsetpgrp(int, pid_t);
+static void xtcsetpgrp(pid_t);
 #endif
 
 STATIC void
@@ -174,70 +174,84 @@ set_curjob(struct job *jp, unsigned mode)
 	}
 }
 
-#if JOBS
 /*
  * Turn job control on and off.
- *
- * Note:  This code assumes that the third arg to ioctl is a character
- * pointer, which is true on Berkeley systems but not System V.  Since
- * System V doesn't have job control yet, this isn't a problem now.
- *
- * Called with interrupts off.
  */
 
 int jobctl;
 
+#if JOBS
+static void
+jobctl_notty(void)
+{
+	if (ttyfd >= 0) {
+		close(ttyfd);
+		ttyfd = -1;
+	}
+	if (!iflag) {
+		setsignal(SIGTSTP);
+		setsignal(SIGTTOU);
+		setsignal(SIGTTIN);
+		jobctl = 1;
+		return;
+	}
+	sh_warnx("can't access tty; job control turned off");
+	mflag = 0;
+}
+
 void
 setjobctl(int on)
 {
-	int fd;
-	int pgrp;
+	int i;
 
 	if (on == jobctl || rootshell == 0)
 		return;
 	if (on) {
-		int ofd;
-		ofd = fd = sh_open(_PATH_TTY, O_RDWR, 1);
-		if (fd < 0) {
-			fd += 3;
-			while (!isatty(fd))
-				if (--fd < 0)
-					goto out;
+		if (ttyfd != -1)
+			close(ttyfd);
+		if ((ttyfd = sh_open(_PATH_TTY, O_RDWR, 1)) < 0) {
+			i = 0;
+			while (i <= 2 && !isatty(i))
+				i++;
+			if (i > 2 ||
+			    (ttyfd = fcntl(i, F_DUPFD_CLOEXEC, 10)) < 0) {
+				jobctl_notty();
+				return;
+			}
 		}
-		fd = savefd(fd, ofd);
+		ttyfd = savefd(ttyfd, ttyfd);
 		do { /* while we are in the background */
-			if ((pgrp = tcgetpgrp(fd)) < 0) {
-out:
-				sh_warnx("can't access tty; job control turned off");
-				mflag = on = 0;
-				goto close;
+			initialpgrp = tcgetpgrp(ttyfd);
+			if (initialpgrp < 0) {
+				jobctl_notty();
+				return;
 			}
-			if (pgrp == getpgrp())
-				break;
-			killpg(0, SIGTTIN);
-		} while (1);
-		initialpgrp = pgrp;
-
+			if (initialpgrp != getpgrp()) {
+				if (!iflag) {
+					initialpgrp = -1;
+					jobctl_notty();
+					return;
+				}
+				kill(0, SIGTTIN);
+				continue;
+			}
+		} while (0);
 		setsignal(SIGTSTP);
 		setsignal(SIGTTOU);
 		setsignal(SIGTTIN);
-		pgrp = rootpid;
-		setpgid(0, pgrp);
-		xtcsetpgrp(fd, pgrp);
-	} else {
-		/* turning job control off */
-		fd = ttyfd;
-		pgrp = initialpgrp;
-		xtcsetpgrp(fd, pgrp);
-		setpgid(0, pgrp);
+		setpgid(0, rootpid);
+		tcsetpgrp(ttyfd, rootpid);
+	} else { /* turning job control off */
+		setpgid(0, initialpgrp);
+		if (ttyfd >= 0) {
+			tcsetpgrp(ttyfd, initialpgrp);
+			close(ttyfd);
+			ttyfd = -1;
+		}
 		setsignal(SIGTSTP);
 		setsignal(SIGTTOU);
 		setsignal(SIGTTIN);
-close:
-		close(fd);
-		fd = -1;
 	}
-	ttyfd = fd;
 	jobctl = on;
 }
 #endif
@@ -394,7 +408,7 @@ restartjob(struct job *jp, int mode)
 	jp->state = JOBRUNNING;
 	pgid = jp->ps->pid;
 	if (mode == FORK_FG)
-		xtcsetpgrp(ttyfd, pgid);
+		xtcsetpgrp(pgid);
 	killpg(pgid, SIGCONT);
 	ps = jp->ps;
 	i = jp->nprocs;
@@ -457,6 +471,9 @@ showjob(struct output *out, struct job *jp, int mode)
 	int indent;
 	char s[80];
 
+	if (!iflag)
+		return;
+
 	ps = jp->ps;
 
 	if (mode & SHOW_PGID) {
@@ -878,7 +895,7 @@ static void forkchild(struct job *jp, union node *n, int mode)
 		/* This can fail because we are doing it in the parent also */
 		(void)setpgid(0, pgrp);
 		if (mode == FORK_FG)
-			xtcsetpgrp(ttyfd, pgrp);
+			xtcsetpgrp(pgrp);
 		setsignal(SIGTSTP);
 		setsignal(SIGTTOU);
 	} else
@@ -1018,7 +1035,7 @@ waitforjob(struct job *jp)
 	st = getstatus(jp);
 #if JOBS
 	if (jp->jobctl) {
-		xtcsetpgrp(ttyfd, rootpid);
+		xtcsetpgrp(rootpid);
 		/*
 		 * This is truly gross.
 		 * If we're doing job control, then we did a TIOCSPGRP which
@@ -1508,12 +1525,15 @@ showpipe(struct job *jp, struct output *out)
 
 #if JOBS
 STATIC void
-xtcsetpgrp(int fd, pid_t pgrp)
+xtcsetpgrp(pid_t pgrp)
 {
 	int err;
 
+	if (ttyfd < 0)
+		return;
+
 	sigblockall(NULL);
-	err = tcsetpgrp(fd, pgrp);
+	err = tcsetpgrp(ttyfd, pgrp);
 	sigclearmask();
 
 	if (err)
-- 
2.39.1


--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
