From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] [EXCEPTIONS] Eliminate global exerrno
Date: Wed, 6 Oct 2010 20:08:07 -0500
Message-ID: <20101007010807.GE1276@burratino>
References: <20100605160651.GA60028@stack.nl>
 <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org>
 <20100628065326.GA25667@gondor.apana.org.au>
 <20101006100420.GA361@burratino>
 <20101006100804.GB361@burratino>
 <20101006102930.GA6573@gondor.apana.org.au>
 <20101006105531.GB475@burratino>
 <4CAC68FD.4040602@redhat.com>
 <20101007010241.GB1276@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51024 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578Ab0JGBLO (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 21:11:14 -0400
Received: by ywh1 with SMTP id 1so77835ywh.19
        for <dash@vger.kernel.org>; Wed, 06 Oct 2010 18:11:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101007010241.GB1276@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

Pass the exit status from the exec builtin through the exitstatus
global.  This just eliminates a global variable; no noticeable
change is intended.

Based on v0.5.3~57 (Eliminated global exerrno, 2005-02-25).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thanks for reading.

 src/error.h |    1 -
 src/eval.c  |    8 ++++----
 src/exec.c  |    3 ++-
 src/main.c  |    2 --
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/src/error.h b/src/error.h
index 1bb6a82..15ccbe3 100644
--- a/src/error.h
+++ b/src/error.h
@@ -62,7 +62,6 @@ struct jmploc {
 
 extern struct jmploc *handler;
 extern int exception;
-extern int exerrno;	/* error for EXEXEC */
 
 /* exceptions */
 #define EXINT 0		/* SIGINT received */
diff --git a/src/eval.c b/src/eval.c
index 5b8d36b..0406571 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -850,15 +850,15 @@ bail:
 				listsetvar(varlist.list, VEXPORT);
 		}
 		if (evalbltin(cmdentry.u.cmd, argc, argv, flags)) {
-			int status;
 			int i;
 
 			i = exception;
 			if (i == EXEXIT)
 				goto raise;
-
-			status = (i == EXINT) ? SIGINT + 128 : 2;
-			exitstatus = status;
+			if (i == EXINT)
+				exitstatus = SIGINT + 128;
+			if (i == EXERROR)
+				exitstatus = 2;
 
 			if (i == EXINT || spclbltin > 0) {
 raise:
diff --git a/src/exec.c b/src/exec.c
index 9525a16..42299ea 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -86,7 +86,6 @@ struct tblentry {
 
 STATIC struct tblentry *cmdtable[CMDTABLESIZE];
 STATIC int builtinloc = -1;		/* index in path of %builtin, or -1 */
-int exerrno;				/* Last exec error */
 
 
 STATIC void tryexec(char *, char **, char **);
@@ -109,6 +108,7 @@ shellexec(char **argv, const char *path, int idx)
 	char *cmdname;
 	int e;
 	char **envp;
+	int exerrno;
 
 	envp = environment();
 	if (strchr(argv[0], '/') != NULL) {
@@ -138,6 +138,7 @@ shellexec(char **argv, const char *path, int idx)
 		exerrno = 2;
 		break;
 	}
+	exitstatus = exerrno;
 	TRACE(("shellexec failed for %s, errno %d, suppressint %d\n",
 		argv[0], e, suppressint ));
 	exerror(EXEXEC, "%s: %s", argv[0], errmsg(e, E_EXEC));
diff --git a/src/main.c b/src/main.c
index 5bc1a99..2bff956 100644
--- a/src/main.c
+++ b/src/main.c
@@ -115,8 +115,6 @@ main(int argc, char **argv)
 		e = exception;
 		if (e == EXERROR)
 			exitstatus = 2;
-		else if (e == EXEXEC)
-			exitstatus = exerrno;
 
 		s = state;
 		if (e == EXEXIT || s == 0 || iflag == 0 || shlvl)
-- 
1.7.2.3

