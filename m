Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F29B208CB
	for <dash@vger.kernel.org>; Sun, 14 Apr 2024 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713081087; cv=none; b=TNpxkV8V0N/xKz4UUmCUYgo/SJoH1WE5nmaRLVRjFgpmhmkCKutGpJ86WNolj5iGwfve+obAQf6YG91GHjoksg25pLP85mhvqbiIEN0rna8m71xOWiUQzF+Tcna1+ndCKjzTt+eLNIShcwSOsoF4bmsMBsgcFyOWSvXxc9GBnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713081087; c=relaxed/simple;
	bh=htBX7Wsoe3v1ZOcQVdC+YEi+3/zkwgQbhtTo/3HlDKs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ns+7hWq66TlqTfuIwOr7d1/1MVtr1xdg+tAnDPQw73aDnQKijcoNOtH5/64CntwogRjWYWphP98ILSRlQLj0sVwZ+4lKUttCNKfkxzjrKwZHjpPVBcTSFnbtutODbehMmn4ys1OcC4uobsgpAx84iWSa2pA5XO8QYDV8LK0OWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvudz-001Qxm-Hm; Sun, 14 Apr 2024 15:51:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 14 Apr 2024 15:51:37 +0800
Date: Sun, 14 Apr 2024 15:51:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dash@vger.kernel.org
Subject: [PATCH] redir: Use memfd_create instead of pipe
Message-ID: <ZhuLCZfwRfflgv0v@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use memfd_create(2) instead of pipe(2).  With pipe(2), a fork
is required if the amount of data to be written exceeds the pipe
size.  This is not the case with memfd_create.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 configure.ac |  2 +-
 src/eval.c   |  3 +--
 src/redir.c  | 57 ++++++++++++++++++++++++++++++++++------------------
 src/redir.h  |  1 +
 src/system.h |  7 +++++++
 5 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6993364..cb55c3f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -87,7 +87,7 @@ AC_CHECK_DECL([PRIdMAX],,
 
 dnl Checks for library functions.
 AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit isalpha killpg \
-	       mempcpy \
+	       memfd_create mempcpy \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
 	       strtoumax sysconf)
 
diff --git a/src/eval.c b/src/eval.c
index 978a174..fce5314 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -635,8 +635,7 @@ evalbackcmd(union node *n, struct backcmd *result)
 		goto out;
 	}
 
-	if (pipe(pip) < 0)
-		sh_error("Pipe call failed");
+	sh_pipe(pip, 0);
 	jp = makejob(1);
 	if (forkshell(jp, n, FORK_NOJOB) == 0) {
 		FORCEINTON;
diff --git a/src/redir.c b/src/redir.c
index bcc81b4..12233be 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -32,6 +32,7 @@
  * SUCH DAMAGE.
  */
 
+#include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/param.h>	/* PIPE_BUF */
@@ -280,6 +281,17 @@ ecreate:
 	sh_open_fail(fname, O_CREAT, EEXIST);
 }
 
+static int sh_dup2(int ofd, int nfd)
+{
+	if (nfd < 0)
+		nfd = dup(ofd);
+	else
+		nfd = dup2(ofd, nfd);
+	if (nfd < 0)
+		sh_error("%d: %s", ofd, strerror(errno));
+
+	return nfd;
+}
 
 #ifdef notyet
 static void dupredirect(union node *redir, int f, char memory[10])
@@ -288,7 +300,6 @@ static void dupredirect(union node *redir, int f)
 #endif
 {
 	int fd = redir->nfile.fd;
-	int err = 0;
 
 #ifdef notyet
 	memory[fd] = 0;
@@ -301,26 +312,31 @@ static void dupredirect(union node *redir, int f)
 				memory[fd] = 1;
 			else
 #endif
-				if (dup2(f, fd) < 0) {
-					err = errno;
-					goto err;
-				}
+				sh_dup2(f, fd);
 			return;
 		}
 		f = fd;
-	} else if (dup2(f, fd) < 0)
-		err = errno;
+	} else
+		sh_dup2(f, fd);
 
 	close(f);
-	if (err < 0)
-		goto err;
-
-	return;
-
-err:
-	sh_error("%d: %s", f, strerror(err));
 }
 
+int sh_pipe(int pip[2], int memfd)
+{
+	if (memfd) {
+		pip[0] = memfd_create("dash", 0);
+		if (pip[0] >= 0) {
+			pip[1] = sh_dup2(pip[0], -1);
+			return 1;
+		}
+	}
+
+	if (pipe(pip) < 0)
+		sh_error("Pipe call failed");
+
+	return 0;
+}
 
 /*
  * Handle here documents.  Normally we fork off a process to write the
@@ -331,9 +347,10 @@ err:
 STATIC int
 openhere(union node *redir)
 {
-	char *p;
-	int pip[2];
 	size_t len = 0;
+	int pip[2];
+	int memfd;
+	char *p;
 
 	p = redir->nhere.doc->narg.text;
 	if (redir->type == NXHERE) {
@@ -341,12 +358,12 @@ openhere(union node *redir)
 		p = stackblock();
 	}
 
-	if (pipe(pip) < 0)
-		sh_error("Pipe call failed");
-
 	len = strlen(p);
-	if (len <= PIPESIZE) {
+	memfd = sh_pipe(pip, len > PIPESIZE);
+
+	if (memfd || len <= PIPESIZE) {
 		xwrite(pip[1], p, len);
+		lseek(pip[1], 0, SEEK_SET);
 		goto out;
 	}
 
diff --git a/src/redir.h b/src/redir.h
index 16f5c20..0be5f1a 100644
--- a/src/redir.h
+++ b/src/redir.h
@@ -50,4 +50,5 @@ int redirectsafe(union node *, int);
 void unwindredir(struct redirtab *stop);
 struct redirtab *pushredir(union node *redir);
 int sh_open(const char *pathname, int flags, int mayfail);
+int sh_pipe(int pip[2], int memfd);
 
diff --git a/src/system.h b/src/system.h
index 007952c..371c64b 100644
--- a/src/system.h
+++ b/src/system.h
@@ -54,6 +54,13 @@ static inline void sigclearmask(void)
 #endif
 }
 
+#ifndef HAVE_MEMFD_CREATE
+static inline int memfd_create(const char *name, unsigned int flags)
+{
+	return -1;
+}
+#endif
+
 #ifndef HAVE_MEMPCPY
 void *mempcpy(void *, const void *, size_t);
 #endif
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
