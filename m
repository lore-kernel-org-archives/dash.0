From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] redir: Retry open64 on EINTR
Date: Thu, 28 May 2020 21:31:45 +1000
Message-ID: <20200528113145.GA934@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:35952 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388412AbgE1Lbx (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 28 May 2020 07:31:53 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, 755446@bugs.debian.org, Samuel Thibault <sthibault@debian.org>, Jilles Tjoelker <jilles@stack.nl>

It is possible for open64 to block on named pipes, and therefore
it can be interrupted by signals and return EINTR.  We should only
let it fail with EINTR if real signals are pending (i.e., it should
not fail on SIGCHLD if SIGCHLD has not been trapped).

This patch adds a new helper sh_open to retry the open64 call if
necessary.  It also calls sh_error when appropriate.

Fixes: 3800d4934391 ("[JOBS] Fix dowait signal race")
Reported-by: Samuel Thibault <sthibault@debian.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 17544e7..6103312 100644
--- a/src/input.c
+++ b/src/input.c
@@ -393,12 +393,9 @@ setinputfile(const char *fname, int flags)
 	int fd;
 
 	INTOFF;
-	if ((fd = open64(fname, O_RDONLY)) < 0) {
-		if (flags & INPUT_NOFILE_OK)
-			goto out;
-		exitstatus = 127;
-		exerror(EXERROR, "Can't open %s", fname);
-	}
+	fd = sh_open(fname, O_RDONLY, flags & INPUT_NOFILE_OK);
+	if (fd < 0)
+		goto out;
 	if (fd < 10)
 		fd = savefd(fd, fd);
 	setinputfd(fd, flags & INPUT_PUSH_FILE);
diff --git a/src/jobs.c b/src/jobs.c
index f65435d..95e7ec4 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -196,7 +196,7 @@ setjobctl(int on)
 		return;
 	if (on) {
 		int ofd;
-		ofd = fd = open64(_PATH_TTY, O_RDWR);
+		ofd = fd = sh_open(_PATH_TTY, O_RDWR, 1);
 		if (fd < 0) {
 			fd += 3;
 			while (!isatty(fd))
@@ -887,8 +887,7 @@ static void forkchild(struct job *jp, union node *n, int mode)
 		ignoresig(SIGQUIT);
 		if (jp->nprocs == 0) {
 			close(0);
-			if (open64(_PATH_DEVNULL, O_RDONLY) != 0)
-				sh_error("Can't open %s", _PATH_DEVNULL);
+			sh_open(_PATH_DEVNULL, O_RDONLY, 0);
 		}
 	}
 	if (!oldlvl && iflag) {
diff --git a/src/redir.c b/src/redir.c
index 895140c..93abba3 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -55,6 +55,7 @@
 #include "output.h"
 #include "memalloc.h"
 #include "error.h"
+#include "trap.h"
 
 
 #define EMPTY -2		/* marks an unused slot in redirtab */
@@ -180,56 +181,83 @@ redirect(union node *redir, int flags)
 }
 
 
+static int sh_open_fail(const char *, int, int) __attribute__((__noreturn__));
+static int sh_open_fail(const char *pathname, int flags, int e)
+{
+	const char *word;
+	int action;
+
+	word = "open";
+	action = E_OPEN;
+	if (flags & O_CREAT) {
+		word = "create";
+		action = E_CREAT;
+	}
+
+	sh_error("cannot %s %s: %s", word, pathname, errmsg(e, action));
+}
+
+
+int sh_open(const char *pathname, int flags, int mayfail)
+{
+	int fd;
+	int e;
+
+	do {
+		fd = open64(pathname, flags, 0666);
+		e = errno;
+	} while (fd < 0 && e == EINTR && !pending_sig);
+
+	if (mayfail || fd >= 0)
+		return fd;
+
+	sh_open_fail(pathname, flags, e);
+}
+
+
 STATIC int
 openredirect(union node *redir)
 {
 	struct stat64 sb;
 	char *fname;
+	int flags;
 	int f;
 
 	switch (redir->nfile.type) {
 	case NFROM:
-		fname = redir->nfile.expfname;
-		if ((f = open64(fname, O_RDONLY)) < 0)
-			goto eopen;
+		flags = O_RDONLY;
+do_open:
+		f = sh_open(redir->nfile.expfname, flags, 0);
 		break;
 	case NFROMTO:
-		fname = redir->nfile.expfname;
-		if ((f = open64(fname, O_RDWR|O_CREAT, 0666)) < 0)
-			goto ecreate;
-		break;
+		flags = O_RDWR|O_CREAT;
+		goto do_open;
 	case NTO:
 		/* Take care of noclobber mode. */
 		if (Cflag) {
 			fname = redir->nfile.expfname;
 			if (stat64(fname, &sb) < 0) {
-				if ((f = open64(fname, O_WRONLY|O_CREAT|O_EXCL, 0666)) < 0)
-					goto ecreate;
-			} else if (!S_ISREG(sb.st_mode)) {
-				if ((f = open64(fname, O_WRONLY, 0666)) < 0)
-					goto ecreate;
-				if (!fstat64(f, &sb) && S_ISREG(sb.st_mode)) {
-					close(f);
-					errno = EEXIST;
-					goto ecreate;
-				}
-			} else {
-				errno = EEXIST;
+				flags = O_WRONLY|O_CREAT|O_EXCL;
+				goto do_open;
+			}
+
+			if (S_ISREG(sb.st_mode))
+				goto ecreate;
+
+			f = sh_open(fname, O_WRONLY, 0);
+			if (!fstat64(f, &sb) && S_ISREG(sb.st_mode)) {
+				close(f);
 				goto ecreate;
 			}
 			break;
 		}
 		/* FALLTHROUGH */
 	case NCLOBBER:
-		fname = redir->nfile.expfname;
-		if ((f = open64(fname, O_WRONLY|O_CREAT|O_TRUNC, 0666)) < 0)
-			goto ecreate;
-		break;
+		flags = O_WRONLY|O_CREAT|O_TRUNC;
+		goto do_open;
 	case NAPPEND:
-		fname = redir->nfile.expfname;
-		if ((f = open64(fname, O_WRONLY|O_CREAT|O_APPEND, 0666)) < 0)
-			goto ecreate;
-		break;
+		flags = O_WRONLY|O_CREAT|O_APPEND;
+		goto do_open;
 	case NTOFD:
 	case NFROMFD:
 		f = redir->ndup.dupfd;
@@ -249,9 +277,7 @@ openredirect(union node *redir)
 
 	return f;
 ecreate:
-	sh_error("cannot create %s: %s", fname, errmsg(errno, E_CREAT));
-eopen:
-	sh_error("cannot open %s: %s", fname, errmsg(errno, E_OPEN));
+	sh_open_fail(fname, O_CREAT, EEXIST);
 }
 
 
diff --git a/src/redir.h b/src/redir.h
index 1cf2761..16f5c20 100644
--- a/src/redir.h
+++ b/src/redir.h
@@ -49,4 +49,5 @@ int savefd(int, int);
 int redirectsafe(union node *, int);
 void unwindredir(struct redirtab *stop);
 struct redirtab *pushredir(union node *redir);
+int sh_open(const char *pathname, int flags, int mayfail);
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
