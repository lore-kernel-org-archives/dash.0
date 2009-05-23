From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [JOBS] Do not close stderr when /dev/tty fails to open
Date: Sat, 23 May 2009 12:23:08 +1000
Message-ID: <20090523022308.GA9308@gondor.apana.org.au>
References: <20090222113304.GA3015@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:37169 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755096AbZEWCXJ (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 May 2009 22:23:09 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1M7gtB-00013S-CI
	for <dash@vger.kernel.org>; Sat, 23 May 2009 12:23:09 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1M7gtA-0002QV-Eb
	for dash@vger.kernel.org; Sat, 23 May 2009 12:23:08 +1000
Content-Disposition: inline
In-Reply-To: <20090222113304.GA3015@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Sun, Feb 22, 2009 at 07:33:04PM +0800, Herbert Xu wrote:
> [JOBS] Do not close stderr when /dev/tty fails to open

Turns out that there was more to this than jobs.c  The use of
savefd in redir ended up closing the wrong file descriptor too,
albeit in a harmless manner.  I'm going to throw this fix in.

commit 3db215abfe4c0079cc932d7070ad675e5f6273ea
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sat May 23 12:21:26 2009 +1000

    [REDIR] Fix incorrect savefd conversions
    
    When I added savefd we ended up closing the wrong fd in two of
    the three places where it was used.  This is because we often
    want to close an fd other than the one that was dupped.  This
    patch fixes this by adding a second argument to savefd denoting
    the fd to be closed.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 27c4fd1..1e198e9 100644
--- a/src/input.c
+++ b/src/input.c
@@ -410,7 +410,7 @@ setinputfile(const char *fname, int flags)
 		sh_error("Can't open %s", fname);
 	}
 	if (fd < 10)
-		fd = savefd(fd);
+		fd = savefd(fd, fd);
 	setinputfd(fd, flags & INPUT_PUSH_FILE);
 out:
 	INTON;
diff --git a/src/jobs.c b/src/jobs.c
index b1ab7ab..a4fada0 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -189,17 +189,15 @@ setjobctl(int on)
 	if (on == jobctl || rootshell == 0)
 		return;
 	if (on) {
-		fd = open(_PATH_TTY, O_RDWR);
+		int ofd;
+		ofd = fd = open(_PATH_TTY, O_RDWR);
 		if (fd < 0) {
 			fd += 3;
 			while (!isatty(fd))
 				if (--fd < 0)
 					goto out;
-			fd = dup(fd);
-			if (fd < 0)
-				goto out;
 		}
-		fd = savefd(fd);
+		fd = savefd(fd, ofd);
 		do { /* while we are in the background */
 			if ((pgrp = tcgetpgrp(fd)) < 0) {
 out:
diff --git a/src/redir.c b/src/redir.c
index ce34db0..27450fb 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -145,7 +145,7 @@ redirect(union node *redir, int flags)
 			if (likely(i == EMPTY)) {
 				i = CLOSED;
 				if (fd != newfd) {
-					i = savefd(fd);
+					i = savefd(fd, newfd);
 					fd = -1;
 				}
 			}
@@ -399,7 +399,7 @@ RESET {
  */
 
 int
-savefd(int from)
+savefd(int from, int ofd)
 {
 	int newfd;
 	int err;
@@ -407,7 +407,7 @@ savefd(int from)
 	newfd = fcntl(from, F_DUPFD, 10);
 	err = newfd < 0 ? errno : 0;
 	if (err != EBADF) {
-		close(from);
+		close(ofd);
 		if (err)
 			sh_error("%d: %s", from, strerror(err));
 		else
diff --git a/src/redir.h b/src/redir.h
index a8e6630..d1d160e 100644
--- a/src/redir.h
+++ b/src/redir.h
@@ -45,6 +45,6 @@ union node;
 void redirect(union node *, int);
 void popredir(int);
 void clearredir(void);
-int savefd(int);
+int savefd(int, int);
 int redirectsafe(union node *, int);
 
Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
