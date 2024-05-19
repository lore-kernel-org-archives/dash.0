Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A3033D5
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096186; cv=none; b=VNc8EkvjpCothBZPdPYDbCDXmE2ra+hqG4vLfjDrIlmOBMgI7q6LJ+IeAJ/b27hv3SzuI6oNXr15uHz2bS8KUqpwJM16hG7KY+Fw3WlI2yCYjop0sE7NSeDugoMFH5F2cC18/IGVN7IZrAdpA2yitkxqTcpipTjAnpVzB43bO6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096186; c=relaxed/simple;
	bh=j0Dh5oy5qEJ8WMp8fmPU7Wx4Ir/tZA7VxvqCuU2lf6Q=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=M+mA1xsNxgigGlVwHLVE+uB9ipYgF1o1XaNfJB9PvrlEfwsqbgFhGUjVKX0ar+Fl7cZqlgPx4zK2gA4MhBdlztxOc3Q0GqweyqTvH7xOtR3J6Jy8uq+G0+dtLQd68n3qWH+e4KRtAJLnCjzJuQgf4CIiMI+VOjkgSO8fhCeYrls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Z0e-00HGI8-1s;
	Sun, 19 May 2024 13:23:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:23:01 +0800
Date: Sun, 19 May 2024 13:23:01 +0800
Message-Id: <fd52d05affd400c2c2f2ba238ff83555d11ca648.1716096097.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1716096097.git.herbert@gondor.apana.org.au>
References: <cover.1716096097.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 2/3] input: Use lseek on stdin when possible
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

For files that can be sought, use lseek instead of reading one
byte at a time.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/eval.c    |   3 ++
 src/init.h    |   1 +
 src/input.c   | 108 +++++++++++++++++++++++++++++++++++---------------
 src/input.h   |   4 ++
 src/jobs.c    |   3 ++
 src/mkinit.c  |   6 +++
 src/options.c |   2 +-
 src/redir.c   |  26 +++++++-----
 src/trap.c    |   1 +
 9 files changed, 111 insertions(+), 43 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 32f1e64..c785edb 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -896,6 +896,8 @@ bail:
 		goto bail;
 
 	default:
+		flush_input();
+
 		/* Fork off a child process if necessary. */
 		if (!(flags & EV_EXIT) || have_traps()) {
 			INTOFF;
@@ -1131,6 +1133,7 @@ execcmd(int argc, char **argv)
 		iflag = 0;		/* exit on error */
 		mflag = 0;
 		optschanged();
+		flush_input();
 		shellexec(argv + 1, pathval(), 0);
 	}
 	return 0;
diff --git a/src/init.h b/src/init.h
index 4f98b5d..e117895 100644
--- a/src/init.h
+++ b/src/init.h
@@ -39,4 +39,5 @@ union node;
 void init(void);
 void exitreset(void);
 void forkreset(union node *);
+void postexitreset(void);
 void reset(void);
diff --git a/src/input.c b/src/input.c
index 193235d..b84ecec 100644
--- a/src/input.c
+++ b/src/input.c
@@ -32,11 +32,13 @@
  * SUCH DAMAGE.
  */
 
-#include <stdio.h>	/* defines BUFSIZ */
 #include <fcntl.h>
-#include <unistd.h>
+#include <stdbool.h>
+#include <stdio.h>	/* defines BUFSIZ */
 #include <stdlib.h>
 #include <string.h>
+#include <termios.h>
+#include <unistd.h>
 
 /*
  * This file implements the input routines used by the parser.
@@ -59,12 +61,21 @@
 
 #define IBUFSIZ (BUFSIZ + PUNGETC_MAX + 1)
 
+struct stdin_state {
+	tcflag_t canon;
+	off_t seekable;
+	struct termios tios;
+};
 
 MKINIT struct parsefile basepf;	/* top level input file */
 MKINIT char basebuf[IBUFSIZ];	/* buffer for top level input file */
 MKINIT struct parsefile *toppf = &basepf;
+MKINIT struct stdin_state stdin_state;
 struct parsefile *parsefile = &basepf;	/* current input file */
 int whichprompt;		/* 1 == PS1, 2 == PS2 */
+int stdin_istty;
+
+MKINIT void input_init(void);
 
 STATIC void pushfile(void);
 static void popstring(void);
@@ -74,6 +85,7 @@ static int preadbuffer(void);
 
 #ifdef mkinit
 INCLUDE <stdio.h>
+INCLUDE <termios.h>
 INCLUDE <unistd.h>
 INCLUDE "input.h"
 INCLUDE "error.h"
@@ -82,6 +94,8 @@ INCLUDE "syntax.h"
 INIT {
 	basepf.nextc = basepf.buf = basebuf;
 	basepf.linno = 1;
+
+	input_init();
 }
 
 RESET {
@@ -104,8 +118,32 @@ FORKRESET {
 		parsefile->fd = 0;
 	}
 }
+
+POSTEXITRESET {
+	flush_input();
+}
 #endif
 
+void input_init(void)
+{
+	struct stdin_state *st = &stdin_state;
+	int istty;
+
+	istty = tcgetattr(0, &st->tios) + 1;
+	st->seekable = istty ? 0 : lseek(0, 0, SEEK_CUR) + 1;
+	st->canon = istty ? st->tios.c_lflag & ICANON : 0;
+	stdin_istty = istty;
+}
+
+static bool stdin_bufferable(void)
+{
+	struct stdin_state *st = &stdin_state;
+
+	if (stdin_istty < 0)
+		input_init();
+
+	return st->canon || st->seekable;
+}
 
 static void freestrings(struct strpush *sp)
 {
@@ -191,6 +229,7 @@ static int
 preadfd(void)
 {
 	char *buf = parsefile->buf;
+	int fd = parsefile->fd;
 	int unget;
 	int pnr;
 	int nr;
@@ -214,7 +253,7 @@ preadfd(void)
 retry:
 	nr = pnr;
 #ifndef SMALL
-	if (parsefile->fd == 0 && el) {
+	if (fd == 0 && el) {
 		static const char *rl_cp;
 		static int el_len;
 
@@ -237,38 +276,23 @@ retry:
 				rl_cp = 0;
 		}
 
-	} else
-#endif
-	if (parsefile->fd)
-		nr = read(parsefile->fd, buf, nr);
-	else {
-		nr = 0;
-
-		do {
-			int err;
-
-			err = read(0, buf, 1);
-			if (err <= 0) {
-				if (nr)
-					break;
-
-				nr = err;
-				if (errno != EWOULDBLOCK)
-					break;
-				if (stdin_clear_nonblock() < 0)
-					break;
-
-				out2str("sh: turning off NDELAY mode\n");
-				goto retry;
-			}
-
-			nr++;
-		} while (0);
+		return nr;
 	}
+#endif
+
+	if (!fd && !stdin_bufferable())
+		nr = 1;
+
+	nr = read(fd, buf, nr);
 
 	if (nr < 0) {
 		if (errno == EINTR && !(basepf.prev && pending_sig))
 			goto retry;
+		if (fd == 0 && errno == EWOULDBLOCK &&
+		    stdin_clear_nonblock() >= 0) {
+			out2str("sh: turning off NDELAY mode\n");
+			goto retry;
+		}
 	}
 	return nr;
 }
@@ -302,6 +326,8 @@ static int preadbuffer(void)
 	something = !first;
 
 	more = input_get_lleft(parsefile);
+
+	INTOFF;
 	if (more <= 0) {
 		int nr;
 
@@ -313,6 +339,7 @@ again:
 			input_set_lleft(parsefile, parsefile->nleft = 0);
 			if (!IS_DEFINED_SMALL && nr > 0)
 				goto save;
+			INTON;
 			return PEOF;
 		}
 	}
@@ -365,11 +392,10 @@ save:
 
 	if (parsefile->fd == 0 && hist && something) {
 		HistEvent he;
-		INTOFF;
 		history(hist, &he, first ? H_ENTER : H_APPEND,
 			parsefile->nextc);
-		INTON;
 	}
+	INTON;
 
 	if (vflag) {
 		out2str(parsefile->nextc);
@@ -590,3 +616,21 @@ popallfiles(void)
 {
 	unwindfiles(toppf);
 }
+
+void __attribute__((noinline)) flush_input(void)
+{
+	int left = basepf.nleft + input_get_lleft(&basepf);
+
+	if (stdin_state.seekable && left) {
+		INTOFF;
+		lseek(0, -left, SEEK_CUR);
+		input_set_lleft(&basepf, basepf.nleft = 0);
+		INTON;
+	}
+}
+
+void reset_input(void)
+{
+	flush_input();
+	stdin_istty = -1;
+}
diff --git a/src/input.h b/src/input.h
index c59d784..af1c1be 100644
--- a/src/input.h
+++ b/src/input.h
@@ -35,6 +35,7 @@
  */
 
 #include <limits.h>
+#include <stdbool.h>
 
 #ifdef SMALL
 #define IS_DEFINED_SMALL 1
@@ -94,6 +95,7 @@ struct parsefile {
 };
 
 extern struct parsefile *parsefile;
+extern int stdin_istty;
 
 /*
  * The input line number.  Input.c just defines this variable, and saves
@@ -113,6 +115,8 @@ void pushstdin(void);
 void popfile(void);
 void unwindfiles(struct parsefile *);
 void popallfiles(void);
+void flush_input(void);
+void reset_input(void);
 
 static inline int input_get_lleft(struct parsefile *pf)
 {
diff --git a/src/jobs.c b/src/jobs.c
index 4cf6b8c..5765e6d 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -968,6 +968,9 @@ forkshell(struct job *jp, union node *n, int mode)
 	int pid;
 
 	TRACE(("forkshell(%%%d, %p, %d) called\n", jobno(jp), n, mode));
+
+	flush_input();
+
 	pid = fork();
 	if (pid == 0)
 		forkchild(jp, n, mode);
diff --git a/src/mkinit.c b/src/mkinit.c
index 870b64d..2514ebf 100644
--- a/src/mkinit.c
+++ b/src/mkinit.c
@@ -119,6 +119,11 @@ char forkreset[] = "\
  * This routine is called when we enter a subshell.\n\
  */\n";
 
+char postexitreset[] = "\
+/*\n\
+ * This routine is called in exitshell.\n\
+ */\n";
+
 char reset[] = "\
 /*\n\
  * This routine is called when an error or an interrupt occurs in an\n\
@@ -130,6 +135,7 @@ struct event event[] = {
 	{"INIT", "init", init},
 	{"EXITRESET", "exitreset", exitreset},
 	{"FORKRESET", "forkreset", forkreset, "union node *n"},
+	{"POSTEXITRESET", "postexitreset", postexitreset},
 	{"RESET", "reset", reset},
 	{NULL, NULL}
 };
diff --git a/src/options.c b/src/options.c
index f157321..4d0a53a 100644
--- a/src/options.c
+++ b/src/options.c
@@ -142,7 +142,7 @@ procargs(int argc, char **argv)
 			sh_error("-c requires an argument");
 		sflag = 1;
 	}
-	if (iflag == 2 && sflag == 1 && isatty(0) && isatty(1))
+	if (iflag == 2 && sflag == 1 && stdin_istty && isatty(1))
 		iflag = 1;
 	if (mflag == 2)
 		mflag = iflag;
diff --git a/src/redir.c b/src/redir.c
index c57d745..8d1c8f6 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -46,16 +46,17 @@
  * Code for dealing with input/output redirection.
  */
 
-#include "main.h"
-#include "shell.h"
-#include "nodes.h"
-#include "jobs.h"
-#include "options.h"
-#include "expand.h"
-#include "redir.h"
-#include "output.h"
-#include "memalloc.h"
 #include "error.h"
+#include "expand.h"
+#include "input.h"
+#include "jobs.h"
+#include "main.h"
+#include "memalloc.h"
+#include "nodes.h"
+#include "options.h"
+#include "output.h"
+#include "redir.h"
+#include "shell.h"
 #include "system.h"
 #include "trap.h"
 
@@ -142,6 +143,8 @@ redirect(union node *redir, int flags)
 			continue;
 
 		fd = n->nfile.fd;
+		if (fd == 0)
+			reset_input();
 
 		if (sv) {
 			int closed;
@@ -415,8 +418,11 @@ popredir(int drop)
 				close(i);
 			break;
 		default:
-			if (!drop)
+			if (!drop) {
+				if (i == 0)
+					reset_input();
 				dup2(rp->renamed[i], i);
+			}
 			close(rp->renamed[i]);
 			break;
 		}
diff --git a/src/trap.c b/src/trap.c
index f871656..2351b61 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -426,6 +426,7 @@ exitshell(void)
 	}
 out:
 	exitreset();
+	postexitreset();
 	/*
 	 * Disable job control so that whoever had the foreground before we
 	 * started can get it back.
-- 
2.39.2

