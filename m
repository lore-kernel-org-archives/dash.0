From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: shell: Always use explicit large file API
Date: Thu, 7 May 2020 23:42:12 +1000
Message-ID: <20200507134212.GA17032@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:38968 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEGNmP (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 7 May 2020 09:42:15 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, 759230@bugs.debian.org

There are some remaining stat/readdir calls in dash that may lead
to spurious EOVERFLOW errors on 32-bit platforms.  This patch changes
them (as well as open(2)) to use the explicit large file API.

Reported-by: Tatsuki Sugiura <sugi@nemui.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/configure.ac b/configure.ac
index 5dab5aa..dbd97d8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -144,8 +144,13 @@ AC_CHECK_FUNC(stat64,, [
 	AC_DEFINE(fstat64, fstat, [64-bit operations are the same as 32-bit])
 	AC_DEFINE(lstat64, lstat, [64-bit operations are the same as 32-bit])
 	AC_DEFINE(stat64, stat, [64-bit operations are the same as 32-bit])
+	AC_DEFINE(readdir64, readdir,
+		  [64-bit operations are the same as 32-bit])
+	AC_DEFINE(dirent64, dirent,
+		  [64-bit operations are the same as 32-bit])
 ])
 
+dnl OS X apparently has stat64 but not open64.
 AC_CHECK_FUNC(open64,, [
 	AC_DEFINE(open64, open, [64-bit operations are the same as 32-bit])
 ])
diff --git a/src/bltin/test.c b/src/bltin/test.c
index b7188df..c7fc479 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -473,17 +473,17 @@ static int isoperand(char **tp)
 static int
 newerf (const char *f1, const char *f2)
 {
-	struct stat b1, b2;
+	struct stat64 b1, b2;
 
 #ifdef HAVE_ST_MTIM
-	return (stat (f1, &b1) == 0 &&
-		stat (f2, &b2) == 0 &&
+	return (stat64(f1, &b1) == 0 &&
+		stat64(f2, &b2) == 0 &&
 		( b1.st_mtim.tv_sec > b2.st_mtim.tv_sec ||
 		 (b1.st_mtim.tv_sec == b2.st_mtim.tv_sec && (b1.st_mtim.tv_nsec > b2.st_mtim.tv_nsec )))
 	);
 #else
-	return (stat (f1, &b1) == 0 &&
-		stat (f2, &b2) == 0 &&
+	return (stat64(f1, &b1) == 0 &&
+		stat64(f2, &b2) == 0 &&
 		b1.st_mtime > b2.st_mtime);
 #endif
 }
@@ -491,17 +491,17 @@ newerf (const char *f1, const char *f2)
 static int
 olderf (const char *f1, const char *f2)
 {
-	struct stat b1, b2;
+	struct stat64 b1, b2;
 
 #ifdef HAVE_ST_MTIM
-	return (stat (f1, &b1) == 0 &&
-		stat (f2, &b2) == 0 &&
+	return (stat64(f1, &b1) == 0 &&
+		stat64(f2, &b2) == 0 &&
 		(b1.st_mtim.tv_sec < b2.st_mtim.tv_sec ||
 		 (b1.st_mtim.tv_sec == b2.st_mtim.tv_sec && (b1.st_mtim.tv_nsec < b2.st_mtim.tv_nsec )))
 	);
 #else
-	return (stat (f1, &b1) == 0 &&
-		stat (f2, &b2) == 0 &&
+	return (stat64(f1, &b1) == 0 &&
+		stat64(f2, &b2) == 0 &&
 		b1.st_mtime < b2.st_mtime);
 #endif
 }
@@ -509,10 +509,10 @@ olderf (const char *f1, const char *f2)
 static int
 equalf (const char *f1, const char *f2)
 {
-	struct stat b1, b2;
+	struct stat64 b1, b2;
 
-	return (stat (f1, &b1) == 0 &&
-		stat (f2, &b2) == 0 &&
+	return (stat64(f1, &b1) == 0 &&
+		stat64(f2, &b2) == 0 &&
 		b1.st_dev == b2.st_dev &&
 		b1.st_ino == b2.st_ino);
 }
diff --git a/src/cd.c b/src/cd.c
index b6742af..1ef1dc5 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -96,7 +96,7 @@ cdcmd(int argc, char **argv)
 	const char *path;
 	const char *p;
 	char c;
-	struct stat statb;
+	struct stat64 statb;
 	int flags;
 	int len;
 
@@ -132,7 +132,7 @@ dotdot:
 		c = *p;
 		p = stalloc(len);
 
-		if (stat(p, &statb) >= 0 && S_ISDIR(statb.st_mode)) {
+		if (stat64(p, &statb) >= 0 && S_ISDIR(statb.st_mode)) {
 			if (c && c != ':')
 				flags |= CD_PRINT;
 docd:
diff --git a/src/expand.c b/src/expand.c
index 4a5d75a..ecd7ee5 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1286,7 +1286,7 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 	int metaflag;
 	struct stat64 statb;
 	DIR *dirp;
-	struct dirent *dp;
+	struct dirent64 *dp;
 	int atend;
 	int matchdot;
 	int esc;
@@ -1363,7 +1363,7 @@ expmeta(char *name, unsigned name_len, unsigned expdir_len)
 		p++;
 	if (*p == '.')
 		matchdot++;
-	while (! int_pending() && (dp = readdir(dirp)) != NULL) {
+	while (! int_pending() && (dp = readdir64(dirp)) != NULL) {
 		if (dp->d_name[0] == '.' && ! matchdot)
 			continue;
 		if (pmatch(start, dp->d_name)) {
diff --git a/src/input.c b/src/input.c
index 177fd0a..7d6be63 100644
--- a/src/input.c
+++ b/src/input.c
@@ -397,7 +397,7 @@ setinputfile(const char *fname, int flags)
 	int fd;
 
 	INTOFF;
-	if ((fd = open(fname, O_RDONLY)) < 0) {
+	if ((fd = open64(fname, O_RDONLY)) < 0) {
 		if (flags & INPUT_NOFILE_OK)
 			goto out;
 		exitstatus = 127;
diff --git a/src/jobs.c b/src/jobs.c
index a9e6524..f65435d 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -196,7 +196,7 @@ setjobctl(int on)
 		return;
 	if (on) {
 		int ofd;
-		ofd = fd = open(_PATH_TTY, O_RDWR);
+		ofd = fd = open64(_PATH_TTY, O_RDWR);
 		if (fd < 0) {
 			fd += 3;
 			while (!isatty(fd))
@@ -887,7 +887,7 @@ static void forkchild(struct job *jp, union node *n, int mode)
 		ignoresig(SIGQUIT);
 		if (jp->nprocs == 0) {
 			close(0);
-			if (open(_PATH_DEVNULL, O_RDONLY) != 0)
+			if (open64(_PATH_DEVNULL, O_RDONLY) != 0)
 				sh_error("Can't open %s", _PATH_DEVNULL);
 		}
 	}
diff --git a/src/main.c b/src/main.c
index 36431fc..7a28534 100644
--- a/src/main.c
+++ b/src/main.c
@@ -298,7 +298,7 @@ find_dot_file(char *basename)
 {
 	char *fullname;
 	const char *path = pathval();
-	struct stat statb;
+	struct stat64 statb;
 	int len;
 
 	/* don't try this for absolute or relative paths */
@@ -308,7 +308,7 @@ find_dot_file(char *basename)
 	while ((len = padvance(&path, basename)) >= 0) {
 		fullname = stackblock();
 		if ((!pathopt || *pathopt == 'f') &&
-		    !stat(fullname, &statb) && S_ISREG(statb.st_mode)) {
+		    !stat64(fullname, &statb) && S_ISREG(statb.st_mode)) {
 			/* This will be freed by the caller. */
 			return stalloc(len);
 		}
diff --git a/src/var.c b/src/var.c
index b146018..ef9c2bd 100644
--- a/src/var.c
+++ b/src/var.c
@@ -125,7 +125,7 @@ INIT {
 	char **envp;
 	static char ppid[32] = "PPID=";
 	const char *p;
-	struct stat st1, st2;
+	struct stat64 st1, st2;
 
 	initvar();
 	for (envp = environ ; *envp ; envp++) {
@@ -143,7 +143,7 @@ INIT {
 
 	p = lookupvar("PWD");
 	if (p)
-		if (*p != '/' || stat(p, &st1) || stat(".", &st2) ||
+		if (*p != '/' || stat64(p, &st1) || stat64(".", &st2) ||
 		    st1.st_dev != st2.st_dev || st1.st_ino != st2.st_ino)
 			p = 0;
 	setpwd(p, 0);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
