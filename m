Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF0C004D4
	for <linux-dash@archiver.kernel.org>; Thu, 19 Jan 2023 18:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjASSmU (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjASSmT (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 19 Jan 2023 13:42:19 -0500
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426A08C923
        for <dash@vger.kernel.org>; Thu, 19 Jan 2023 10:42:17 -0800 (PST)
Date:   Thu, 19 Jan 2023 19:33:30 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <20230119183330.geEMf%steffen@sdaoden.eu>
In-Reply-To: <2024648.dncibcYME7@dmc12.centralesupelec.fr>
References: <7091680.J8PY2HnTC3@home.martymac.org>
 <2175334.ZhQv657J3T@dmc12.centralesupelec.fr>
 <20230118231534.w90EG%steffen@sdaoden.eu>
 <2024648.dncibcYME7@dmc12.centralesupelec.fr>
User-Agent: s-nail v14.9.24-398-g20005f74ec
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=-=uvO_jlUDkAzQ7F5H_d_7Sqq3ikJzfni-13sV=-="
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is a multi-part message in MIME format.

--=-=uvO_jlUDkAzQ7F5H_d_7Sqq3ikJzfni-13sV=-=
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-ID: <20230119183330.N3oEK%steffen@sdaoden.eu>

Hello Ganael.

Ganael Laplanche wrote in
 <2024648.dncibcYME7@dmc12.centralesupelec.fr>:
 |On Thursday, January 19, 2023 12:15:34 AM CET Steffen Nurpmeso wrote:
 |> Not a "backport", but from shallow testing (i have no idea what
 |> i am doing), the attached patch works.
 |
 |Yes, it works ! With that patch, fpsync runs smoothly in the background \
 |(with 
 |specific PGIDs for sub-jobs) !
 |
 |Could a Dash developer review (and, if possible, commit) it ?

Yes, replace the open() with a sh_open(_PATH_TTY, O_RDWR, 1), and
use savefd() not dupfd without cloexec awareness.  Was a five
minute thing actually, the busybox patch was right i think.

Hm, i will attach a better one..  Shall anyone consider this,
please use that not the older one!  Thanks.

 |Again, Steffen, thank you very much for your help :)

Thanks to Jilles.  But walked.
(In fact .. i had the impression that someone should review
compilation without !JOBS.  Or, maybe, drop the option.)

Ciao.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)

--=-=uvO_jlUDkAzQ7F5H_d_7Sqq3ikJzfni-13sV=-=
Content-Type: text/x-diff; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dash.patch"
Content-ID: <20230119183330.w-heQ%steffen@sdaoden.eu>

=46rom dedaa3fa370ea9c4aeb1771b5568a7bef4065b04 Mon Sep 17 00:00:00 2001
Message-Id: <dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1674153195.git.steffe=
n@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
Date: Thu, 19 Jan 2023 19:32:55 +0100
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
 src/jobs.c | 114 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 47 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index f3b9ffc285..db1f204045 100644
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
@@ -174,70 +174,84 @@ set_curjob(struct job *jp, unsigned mode)
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
+		if ((ttyfd =3D sh_open(_PATH_TTY, O_RDWR, 1)) < 0) {
+			i =3D 0;
+			while (i <=3D 2 && !isatty(i))
+				i++;
+			if (i > 2 ||
+			    (ttyfd =3D fcntl(i, F_DUPFD_CLOEXEC, 10)) < 0) {
+				jobctl_notty();
+				return;
+			}
 		}
-		fd =3D savefd(fd, ofd);
+		ttyfd =3D savefd(ttyfd, ttyfd);
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
@@ -394,7 +408,7 @@ restartjob(struct job *jp, int mode)
 	jp->state =3D JOBRUNNING;
 	pgid =3D jp->ps->pid;
 	if (mode =3D=3D FORK_FG)
-		xtcsetpgrp(ttyfd, pgid);
+		xtcsetpgrp(pgid);
 	killpg(pgid, SIGCONT);
 	ps =3D jp->ps;
 	i =3D jp->nprocs;
@@ -457,6 +471,9 @@ showjob(struct output *out, struct job *jp, int mode)
 	int indent;
 	char s[80];
=20
+	if (!iflag)
+		return;
+
 	ps =3D jp->ps;
=20
 	if (mode & SHOW_PGID) {
@@ -878,7 +895,7 @@ static void forkchild(struct job *jp, union node *n, in=
t mode)
 		/* This can fail because we are doing it in the parent also */
 		(void)setpgid(0, pgrp);
 		if (mode =3D=3D FORK_FG)
-			xtcsetpgrp(ttyfd, pgrp);
+			xtcsetpgrp(pgrp);
 		setsignal(SIGTSTP);
 		setsignal(SIGTTOU);
 	} else
@@ -1018,7 +1035,7 @@ waitforjob(struct job *jp)
 	st =3D getstatus(jp);
 #if JOBS
 	if (jp->jobctl) {
-		xtcsetpgrp(ttyfd, rootpid);
+		xtcsetpgrp(rootpid);
 		/*
 		 * This is truly gross.
 		 * If we're doing job control, then we did a TIOCSPGRP which
@@ -1508,12 +1525,15 @@ showpipe(struct job *jp, struct output *out)
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


--=-=uvO_jlUDkAzQ7F5H_d_7Sqq3ikJzfni-13sV=-=--
