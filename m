Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AC33D5
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096188; cv=none; b=n/qpTAB7VwR66BNHvbWJY+HRDa5Xw3Qjm98ISihuPJqdUBOOSLf+mE9GeF5/vl3X52jIlZ0ia8YZpJGGLcW65bUmgb84bS+cGY9qQNYsV7X2lOU0DdnkqBz6K+XIxNWin5h0/VbZXzyWMB6snu+wmaelqNYK21csmw2CGTRiPTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096188; c=relaxed/simple;
	bh=cOQ8E/oYZy5srCHFqeKWvMl6V87mEp35F1Lulbu6JiA=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=HJvlQngArg7AdK5wpW+ZHjjbYKAQedemIuXhdYQuyYms+3Daafnyzkx7o+TYsy56oMuab9qJKiJgsGSt2MoSgNROiYotV4x1DoeBNqoY+QIxWL5zgCNLLksAODe+Z+9H7a2SdB7DLit1UTBnbkfQDg8kwDHc1r7Aeaz4gwuhW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Z0g-00HGIJ-2t;
	Sun, 19 May 2024 13:23:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:23:04 +0800
Date: Sun, 19 May 2024 13:23:04 +0800
Message-Id: <bb213eedca334e291258563da614fedfd21b3287.1716096097.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1716096097.git.herbert@gondor.apana.org.au>
References: <cover.1716096097.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 3/3] input: Use tee(2) for stdin pipe
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

use tee(2) to peek at pipes in order to avoid reading one byte at
a time.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 configure.ac |  2 +-
 src/input.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++++------
 src/system.h |  7 ++++++
 3 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index cb55c3f..50effc0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -89,7 +89,7 @@ dnl Checks for library functions.
 AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit isalpha killpg \
 	       memfd_create mempcpy \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
-	       strtoumax sysconf)
+	       strtoumax sysconf tee)
 
 dnl Check whether it's worth working around FreeBSD PR kern/125009.
 dnl The traditional behavior of access/faccessat is crazy, but
diff --git a/src/input.c b/src/input.c
index b84ecec..8f8c173 100644
--- a/src/input.c
+++ b/src/input.c
@@ -57,14 +57,18 @@
 #include "redir.h"
 #include "shell.h"
 #include "syntax.h"
+#include "system.h"
 #include "trap.h"
 
 #define IBUFSIZ (BUFSIZ + PUNGETC_MAX + 1)
 
+MKINIT
 struct stdin_state {
 	tcflag_t canon;
 	off_t seekable;
 	struct termios tios;
+	int pip[2];
+	int pending;
 };
 
 MKINIT struct parsefile basepf;	/* top level input file */
@@ -85,6 +89,7 @@ static int preadbuffer(void);
 
 #ifdef mkinit
 INCLUDE <stdio.h>
+INCLUDE <string.h>
 INCLUDE <termios.h>
 INCLUDE <unistd.h>
 INCLUDE "input.h"
@@ -117,6 +122,11 @@ FORKRESET {
 		close(parsefile->fd);
 		parsefile->fd = 0;
 	}
+	if (stdin_state.pip[0]) {
+		close(stdin_state.pip[0]);
+		close(stdin_state.pip[1]);
+		memset(stdin_state.pip, 0, sizeof(stdin_state.pip));
+	}
 }
 
 POSTEXITRESET {
@@ -145,6 +155,43 @@ static bool stdin_bufferable(void)
 	return st->canon || st->seekable;
 }
 
+static void flush_tee(void *buf, int nr, int pending)
+{
+	while (pending > 0) {
+		int err;
+
+		err = read(0, buf, nr > pending ? pending : nr);
+		if (err > 0)
+			pending -= err;
+	}
+}
+
+static int stdin_tee(void *buf, int nr)
+{
+	int err;
+
+	if (stdin_istty)
+		return 0;
+
+	if (!stdin_state.pip[0]) {
+		err = pipe(stdin_state.pip);
+		if (err < 0)
+			return err;
+		if (stdin_state.pip[0] < 10)
+			stdin_state.pip[0] = savefd(stdin_state.pip[0],
+						    stdin_state.pip[0]);
+		if (stdin_state.pip[1] < 10)
+			stdin_state.pip[1] = savefd(stdin_state.pip[1],
+						    stdin_state.pip[1]);
+	}
+
+	flush_tee(buf, nr, stdin_state.pending);
+
+	err = tee(0, stdin_state.pip[1], nr, 0);
+	stdin_state.pending = err;
+	return err;
+}
+
 static void freestrings(struct strpush *sp)
 {
 	INTOFF;
@@ -280,10 +327,17 @@ retry:
 	}
 #endif
 
-	if (!fd && !stdin_bufferable())
-		nr = 1;
+	if (!fd && !stdin_bufferable()) {
+		nr = stdin_tee(buf, nr);
+		fd = stdin_state.pip[0];
+		if (nr <= 0) {
+			fd = 0;
+			nr = 1;
+		}
+	}
 
-	nr = read(fd, buf, nr);
+	if (nr >= 0)
+		nr = read(fd, buf, nr);
 
 	if (nr < 0) {
 		if (errno == EINTR && !(basepf.prev && pending_sig))
@@ -621,12 +675,15 @@ void __attribute__((noinline)) flush_input(void)
 {
 	int left = basepf.nleft + input_get_lleft(&basepf);
 
-	if (stdin_state.seekable && left) {
-		INTOFF;
+	INTOFF;
+	if (stdin_state.seekable && left)
 		lseek(0, -left, SEEK_CUR);
-		input_set_lleft(&basepf, basepf.nleft = 0);
-		INTON;
+	else if (stdin_state.pending > left) {
+		flush_tee(basebuf, BUFSIZ, stdin_state.pending - left);
+		stdin_state.pending = 0;
 	}
+	input_set_lleft(&basepf, basepf.nleft = 0);
+	INTON;
 }
 
 void reset_input(void)
diff --git a/src/system.h b/src/system.h
index 6b31d52..e7f968b 100644
--- a/src/system.h
+++ b/src/system.h
@@ -118,6 +118,13 @@ long sysconf(int) __attribute__((__noreturn__));
 int isblank(int c);
 #endif
 
+#ifndef HAVE_TEE
+static inline ssize_t tee(int fd_in, int fd_out, size_t len, unsigned int flags)
+{
+	return -1;
+}
+#endif
+
 #ifndef HAVE_FNMATCH
 static inline int fnmatch(const char *pattern, const char *string, int flags)
 {
-- 
2.39.2

