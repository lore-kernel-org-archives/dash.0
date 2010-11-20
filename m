From: Jilles Tjoelker <jilles@stack.nl>
Subject: [PATCH] [REDIR] Replace GPL noclobberopen code with the FreeBSD
 version.
Date: Sat, 20 Nov 2010 15:47:33 +0100
Message-ID: <20101120144733.GA17293@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:63580 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751445Ab0KTOrg (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 20 Nov 2010 09:47:36 -0500
Received: from turtle.stack.nl (turtle.stack.nl [IPv6:2001:610:1108:5010::132])
	by mx1.stack.nl (Postfix) with ESMTP id 15F151DD62C
	for <dash@vger.kernel.org>; Sat, 20 Nov 2010 15:47:34 +0100 (CET)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Replace noclobberopen() from bash with the FreeBSD code for noclobber
opens.

This also reduces code size by eliminating an unnecessary check.
---
 src/redir.c |   77 +++++++++++-----------------------------------------------
 1 files changed, 15 insertions(+), 62 deletions(-)

diff --git a/src/redir.c b/src/redir.c
index b4e49c0..f96a76b 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -84,7 +84,6 @@ STATIC void dupredirect(union node *, int, char[10]);
 STATIC void dupredirect(union node *, int);
 #endif
 STATIC int openhere(union node *);
-STATIC int noclobberopen(const char *);
 
 
 /*
@@ -168,6 +167,7 @@ redirect(union node *redir, int flags)
 STATIC int
 openredirect(union node *redir)
 {
+	struct stat64 sb;
 	char *fname;
 	int f;
 
@@ -186,8 +186,21 @@ openredirect(union node *redir)
 		/* Take care of noclobber mode. */
 		if (Cflag) {
 			fname = redir->nfile.expfname;
-			if ((f = noclobberopen(fname)) < 0)
+			if (stat64(fname, &sb) < 0) {
+				if ((f = open64(fname, O_WRONLY|O_CREAT|O_EXCL, 0666)) < 0)
+					goto ecreate;
+			} else if (!S_ISREG(sb.st_mode)) {
+				if ((f = open64(fname, O_WRONLY, 0666)) < 0)
+					goto ecreate;
+				if (fstat64(f, &sb) < 0 && S_ISREG(sb.st_mode)) {
+					close(f);
+					errno = EEXIST;
+					goto ecreate;
+				}
+			} else {
+				errno = EEXIST;
 				goto ecreate;
+			}
 			break;
 		}
 		/* FALLTHROUGH */
@@ -397,66 +410,6 @@ savefd(int from, int ofd)
 }
 
 
-/*
- * Open a file in noclobber mode.
- * The code was copied from bash.
- */
-int
-noclobberopen(fname)
-	const char *fname;
-{
-	int r, fd;
-	struct stat64 finfo, finfo2;
-
-	/*
-	 * If the file exists and is a regular file, return an error
-	 * immediately.
-	 */
-	r = stat64(fname, &finfo);
-	if (r == 0 && S_ISREG(finfo.st_mode)) {
-		errno = EEXIST;
-		return -1;
-	}
-
-	/*
-	 * If the file was not present (r != 0), make sure we open it
-	 * exclusively so that if it is created before we open it, our open
-	 * will fail.  Make sure that we do not truncate an existing file.
-	 * Note that we don't turn on O_EXCL unless the stat failed -- if the
-	 * file was not a regular file, we leave O_EXCL off.
-	 */
-	if (r != 0)
-		return open64(fname, O_WRONLY|O_CREAT|O_EXCL, 0666);
-	fd = open64(fname, O_WRONLY|O_CREAT, 0666);
-
-	/* If the open failed, return the file descriptor right away. */
-	if (fd < 0)
-		return fd;
-
-	/*
-	 * OK, the open succeeded, but the file may have been changed from a
-	 * non-regular file to a regular file between the stat and the open.
-	 * We are assuming that the O_EXCL open handles the case where FILENAME
-	 * did not exist and is symlinked to an existing file between the stat
-	 * and open.
-	 */
-
-	/*
-	 * If we can open it and fstat the file descriptor, and neither check
-	 * revealed that it was a regular file, and the file has not been
-	 * replaced, return the file descriptor.
-	 */
-	 if (fstat64(fd, &finfo2) == 0 && !S_ISREG(finfo2.st_mode) &&
-	     finfo.st_dev == finfo2.st_dev && finfo.st_ino == finfo2.st_ino)
-	 	return fd;
-
-	/* The file has been replaced.  badness. */
-	close(fd);
-	errno = EEXIST;
-	return -1;
-}
-
