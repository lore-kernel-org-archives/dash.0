Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A477C32793
	for <linux-dash@archiver.kernel.org>; Wed, 18 Jan 2023 23:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjARXVT (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 18 Jan 2023 18:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjARXVS (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 18 Jan 2023 18:21:18 -0500
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6845BD1
        for <dash@vger.kernel.org>; Wed, 18 Jan 2023 15:21:16 -0800 (PST)
Date:   Thu, 19 Jan 2023 00:15:34 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <20230118231534.w90EG%steffen@sdaoden.eu>
In-Reply-To: <2175334.ZhQv657J3T@dmc12.centralesupelec.fr>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <2021198.x0N0T6uNKo@home.martymac.org>
 <20230117210401.wrEtj%steffen@sdaoden.eu>
 <2175334.ZhQv657J3T@dmc12.centralesupelec.fr>
User-Agent: s-nail v14.9.24-398-g20005f74ec
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=-=0oTF0FyoNqzNKukDf6rsDS6SeMjZeWFcjnb7=-="
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is a multi-part message in MIME format.

--=-=0oTF0FyoNqzNKukDf6rsDS6SeMjZeWFcjnb7=-=
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-ID: <20230118231534.BJz3G%steffen@sdaoden.eu>

Hello Ganael.

Ganael Laplanche wrote in
 <2175334.ZhQv657J3T@dmc12.centralesupelec.fr>:
 |On Tuesday, January 17, 2023 10:04:01 PM CET Steffen Nurpmeso wrote:
 |> In the meantime i have taken over Jilles' commit to busybox ash,
 |> hopefully correct, let's see whether it is taken.
 |
 |Fantastic, thanks!
 |
 |Any chance to get it backported to Dash too ?

Not a "backport", but from shallow testing (i have no idea what
i am doing), the attached patch works.

Ciao,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)

--=-=0oTF0FyoNqzNKukDf6rsDS6SeMjZeWFcjnb7=-=
Content-Type: text/x-diff; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dash.patch"
Content-ID: <20230118231534.qF0ak%steffen@sdaoden.eu>

=46rom 39aa73889163629aa477adf536b557b80faa2bfc Mon Sep 17 00:00:00 2001
Message-Id: <39aa73889163629aa477adf536b557b80faa2bfc.1674083695.git.steffe=
n@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
Date: Thu, 19 Jan 2023 00:14:22 +0100
Subject: [PATCH] Allow enabling job control without a tty in non-interactive
 mode..

This is a take-over of the FreeBSD bin/sh

  commit cd60e2c67d52e1f957841af19128c7227880743a
  Author:     Jilles Tjoelker <jilles@FreeBSD.org>
  AuthorDate: 2014-09-04 21:48:33 +0000
  Commit:     Jilles Tjoelker <jilles@FreeBSD.org>
  CommitDate: 2014-09-04 21:48:33 +0000

      sh: Allow enabling job control without a tty in non-interactive mode.

      If no tty is available, 'set -m' is still useful to put jobs in their=
 own
      process groups.
---
 src/jobs.c | 125 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 47 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index f3b9ffc285..878cc4f7c0 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -125,7 +125,7 @@ STATIC int getstatus(struct job *);
=20
 #if JOBS
 static int restartjob(struct job *, int);
-static void xtcsetpgrp(int, pid_t);
+static void xtcsetpgrp(pid_t);
 #endif
=20
 STATIC void
@@ -174,70 +174,95 @@ set_curjob(struct job *jp, unsigned mode)
 	}
 }
=20
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
=20
 int jobctl;
=20
+#if JOBS
+static void
+jobctl_notty(void)
+{
+	if (ttyfd >=3D 0) {
+		close(ttyfd);
+		ttyfd =3D -1;
+	}
+	if (!iflag) {
+		setsignal(SIGTSTP);
+		setsignal(SIGTTOU);
+		setsignal(SIGTTIN);
+		jobctl =3D 1;
+		return;
+	}
+	sh_warnx("can't access tty; job control turned off");
+	mflag =3D 0;
+}
+
 void
 setjobctl(int on)
 {
-	int fd;
-	int pgrp;
+	int i;
=20
 	if (on =3D=3D jobctl || rootshell =3D=3D 0)
 		return;
 	if (on) {
-		int ofd;
-		ofd =3D fd =3D sh_open(_PATH_TTY, O_RDWR, 1);
-		if (fd < 0) {
-			fd +=3D 3;
-			while (!isatty(fd))
-				if (--fd < 0)
-					goto out;
+		if (ttyfd !=3D -1)
+			close(ttyfd);
+		if ((ttyfd =3D open(_PATH_TTY, O_RDWR | O_CLOEXEC)) < 0) {
+			i =3D 0;
+			while (i <=3D 2 && !isatty(i))
+				i++;
+			if (i > 2 ||
+			    (ttyfd =3D fcntl(i, F_DUPFD_CLOEXEC, 10)) < 0) {
+				jobctl_notty();
+				return;
+			}
+		}
+		if (ttyfd < 10) {
+			/*
+			 * Keep our TTY file descriptor out of the way of
+			 * the user's redirections.
+			 */
+			if ((i =3D fcntl(ttyfd, F_DUPFD_CLOEXEC, 10)) < 0) {
+				jobctl_notty();
+				return;
+			}
+			close(ttyfd);
+			ttyfd =3D i;
 		}
-		fd =3D savefd(fd, ofd);
 		do { /* while we are in the background */
-			if ((pgrp =3D tcgetpgrp(fd)) < 0) {
-out:
-				sh_warnx("can't access tty; job control turned off");
-				mflag =3D on =3D 0;
-				goto close;
+			initialpgrp =3D tcgetpgrp(ttyfd);
+			if (initialpgrp < 0) {
+				jobctl_notty();
+				return;
 			}
-			if (pgrp =3D=3D getpgrp())
-				break;
-			killpg(0, SIGTTIN);
-		} while (1);
-		initialpgrp =3D pgrp;
-
+			if (initialpgrp !=3D getpgrp()) {
+				if (!iflag) {
+					initialpgrp =3D -1;
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
-		pgrp =3D rootpid;
-		setpgid(0, pgrp);
-		xtcsetpgrp(fd, pgrp);
-	} else {
-		/* turning job control off */
-		fd =3D ttyfd;
-		pgrp =3D initialpgrp;
-		xtcsetpgrp(fd, pgrp);
-		setpgid(0, pgrp);
+		setpgid(0, rootpid);
+		tcsetpgrp(ttyfd, rootpid);
+	} else { /* turning job control off */
+		setpgid(0, initialpgrp);
+		if (ttyfd >=3D 0) {
+			tcsetpgrp(ttyfd, initialpgrp);
+			close(ttyfd);
+			ttyfd =3D -1;
+		}
 		setsignal(SIGTSTP);
 		setsignal(SIGTTOU);
 		setsignal(SIGTTIN);
-close:
-		close(fd);
-		fd =3D -1;
 	}
-	ttyfd =3D fd;
 	jobctl =3D on;
 }
 #endif
@@ -394,7 +419,7 @@ restartjob(struct job *jp, int mode)
 	jp->state =3D JOBRUNNING;
 	pgid =3D jp->ps->pid;
 	if (mode =3D=3D FORK_FG)
-		xtcsetpgrp(ttyfd, pgid);
+		xtcsetpgrp(pgid);
 	killpg(pgid, SIGCONT);
 	ps =3D jp->ps;
 	i =3D jp->nprocs;
@@ -457,6 +482,9 @@ showjob(struct output *out, struct job *jp, int mode)
 	int indent;
 	char s[80];
=20
+	if (!iflag)
+		return;
+
 	ps =3D jp->ps;
=20
 	if (mode & SHOW_PGID) {
@@ -878,7 +906,7 @@ static void forkchild(struct job *jp, union node *n, in=
t mode)
 		/* This can fail because we are doing it in the parent also */
 		(void)setpgid(0, pgrp);
 		if (mode =3D=3D FORK_FG)
-			xtcsetpgrp(ttyfd, pgrp);
+			xtcsetpgrp(pgrp);
 		setsignal(SIGTSTP);
 		setsignal(SIGTTOU);
 	} else
@@ -1018,7 +1046,7 @@ waitforjob(struct job *jp)
 	st =3D getstatus(jp);
 #if JOBS
 	if (jp->jobctl) {
-		xtcsetpgrp(ttyfd, rootpid);
+		xtcsetpgrp(rootpid);
 		/*
 		 * This is truly gross.
 		 * If we're doing job control, then we did a TIOCSPGRP which
@@ -1508,12 +1536,15 @@ showpipe(struct job *jp, struct output *out)
=20
 #if JOBS
 STATIC void
-xtcsetpgrp(int fd, pid_t pgrp)
+xtcsetpgrp(pid_t pgrp)
 {
 	int err;
=20
+	if (ttyfd < 0)
+		return;
+
 	sigblockall(NULL);
-	err =3D tcsetpgrp(fd, pgrp);
+	err =3D tcsetpgrp(ttyfd, pgrp);
 	sigclearmask();
=20
 	if (err)
--=20
2.39.0


--=-=0oTF0FyoNqzNKukDf6rsDS6SeMjZeWFcjnb7=-=--
