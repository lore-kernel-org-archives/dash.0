Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B10C54EAA
	for <linux-dash@archiver.kernel.org>; Mon, 30 Jan 2023 11:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjA3Lhl (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 30 Jan 2023 06:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbjA3Lhi (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 30 Jan 2023 06:37:38 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8E71D90C
        for <dash@vger.kernel.org>; Mon, 30 Jan 2023 03:37:35 -0800 (PST)
Received: (Authenticated sender: ganael.laplanche@martymac.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 3F401100006;
        Mon, 30 Jan 2023 11:37:31 +0000 (UTC)
From:   Ganael Laplanche <ganael.laplanche@martymac.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Date:   Mon, 30 Jan 2023 12:37:28 +0100
Message-ID: <5757811.Zv9zXsTiuT@home.martymac.org>
In-Reply-To: <Y9dwEOSA7SR9+ovZ@gondor.apana.org.au>
References: <Y9Olps/fwxaItE4j@gondor.apana.org.au>
 <2744018.j5hJsU0yqa@dmc12.centralesupelec.fr>
 <Y9dwEOSA7SR9+ovZ@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2618837.TYJnH3iKXO"
Content-Transfer-Encoding: 7Bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2618837.TYJnH3iKXO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, January 30, 2023 8:21:52 AM CET Herbert Xu wrote:

Hello Herbert,

> Sorry but that didn't work either, please have a look at the
> list of patches on the queue:
> 
> https://patchwork.kernel.org/project/dash/list/

Well, it seems the previous patch had space problems.

Find a fixed version attached.

Best regards,

-- 
Ganael LAPLANCHE <ganael.laplanche@martymac.org>
http://www.martymac.org | http://contribs.martymac.org
FreeBSD: martymac <martymac@FreeBSD.org>, http://www.FreeBSD.org
--nextPart2618837.TYJnH3iKXO
Content-Disposition: attachment; filename="dash.patch"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset="unicode-2-0-utf-8"; name="dash.patch"

=46rom dedaa3fa370ea9c4aeb1771b5568a7bef4065b04 Mon Sep 17 00:00:00 2001
Message-Id: <dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1674153195.git.steffe=
n@sdaoden.eu>
=46rom: Steffen Nurpmeso <steffen@sdaoden.eu>
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
=2D--
 src/jobs.c | 114 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 47 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index f3b9ffc285..db1f204045 100644
=2D-- a/src/jobs.c
+++ b/src/jobs.c
@@ -125,7 +125,7 @@
=20
 #if JOBS
 static int restartjob(struct job *, int);
=2Dstatic void xtcsetpgrp(int, pid_t);
+static void xtcsetpgrp(pid_t);
 #endif
=20
 STATIC void
@@ -174,70 +174,84 @@
 	}
 }
=20
=2D#if JOBS
 /*
  * Turn job control on and off.
=2D *
=2D * Note:  This code assumes that the third arg to ioctl is a character
=2D * pointer, which is true on Berkeley systems but not System V.  Since
=2D * System V doesn't have job control yet, this isn't a problem now.
=2D *
=2D * Called with interrupts off.
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
=2D	int fd;
=2D	int pgrp;
+	int i;
=20
 	if (on =3D=3D jobctl || rootshell =3D=3D 0)
 		return;
 	if (on) {
=2D		int ofd;
=2D		ofd =3D fd =3D sh_open(_PATH_TTY, O_RDWR, 1);
=2D		if (fd < 0) {
=2D			fd +=3D 3;
=2D			while (!isatty(fd))
=2D				if (--fd < 0)
=2D					goto out;
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
=2D		fd =3D savefd(fd, ofd);
+		ttyfd =3D savefd(ttyfd, ttyfd);
 		do { /* while we are in the background */
=2D			if ((pgrp =3D tcgetpgrp(fd)) < 0) {
=2Dout:
=2D				sh_warnx("can't access tty; job control turned off");
=2D				mflag =3D on =3D 0;
=2D				goto close;
+			initialpgrp =3D tcgetpgrp(ttyfd);
+			if (initialpgrp < 0) {
+				jobctl_notty();
+				return;
 			}
=2D			if (pgrp =3D=3D getpgrp())
=2D				break;
=2D			killpg(0, SIGTTIN);
=2D		} while (1);
=2D		initialpgrp =3D pgrp;
=2D
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
=2D		pgrp =3D rootpid;
=2D		setpgid(0, pgrp);
=2D		xtcsetpgrp(fd, pgrp);
=2D	} else {
=2D		/* turning job control off */
=2D		fd =3D ttyfd;
=2D		pgrp =3D initialpgrp;
=2D		xtcsetpgrp(fd, pgrp);
=2D		setpgid(0, pgrp);
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
=2Dclose:
=2D		close(fd);
=2D		fd =3D -1;
 	}
=2D	ttyfd =3D fd;
 	jobctl =3D on;
 }
 #endif
@@ -394,7 +408,7 @@
 	jp->state =3D JOBRUNNING;
 	pgid =3D jp->ps->pid;
 	if (mode =3D=3D FORK_FG)
=2D		xtcsetpgrp(ttyfd, pgid);
+		xtcsetpgrp(pgid);
 	killpg(pgid, SIGCONT);
 	ps =3D jp->ps;
 	i =3D jp->nprocs;
@@ -457,6 +471,9 @@
 	int indent;
 	char s[80];
=20
+	if (!iflag)
+		return;
+
 	ps =3D jp->ps;
=20
 	if (mode & SHOW_PGID) {
@@ -878,7 +895,7 @@
 		/* This can fail because we are doing it in the parent also */
 		(void)setpgid(0, pgrp);
 		if (mode =3D=3D FORK_FG)
=2D			xtcsetpgrp(ttyfd, pgrp);
+			xtcsetpgrp(pgrp);
 		setsignal(SIGTSTP);
 		setsignal(SIGTTOU);
 	} else
@@ -1018,7 +1035,7 @@
 	st =3D getstatus(jp);
 #if JOBS
 	if (jp->jobctl) {
=2D		xtcsetpgrp(ttyfd, rootpid);
+		xtcsetpgrp(rootpid);
 		/*
 		 * This is truly gross.
 		 * If we're doing job control, then we did a TIOCSPGRP which
@@ -1508,12 +1525,15 @@
=20
 #if JOBS
 STATIC void
=2Dxtcsetpgrp(int fd, pid_t pgrp)
+xtcsetpgrp(pid_t pgrp)
 {
 	int err;
=20
+	if (ttyfd < 0)
+		return;
+
 	sigblockall(NULL);
=2D	err =3D tcsetpgrp(fd, pgrp);
+	err =3D tcsetpgrp(ttyfd, pgrp);
 	sigclearmask();
=20
 	if (err)

--nextPart2618837.TYJnH3iKXO--



