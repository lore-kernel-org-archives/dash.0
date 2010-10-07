From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] Revert "Eliminated global exerrno."
Date: Wed, 6 Oct 2010 20:04:58 -0500
Message-ID: <20101007010458.GD1276@burratino>
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
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61035 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299Ab0JGBIF (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 21:08:05 -0400
Received: by ywh1 with SMTP id 1so77030ywh.19
        for <dash@vger.kernel.org>; Wed, 06 Oct 2010 18:08:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101007010241.GB1276@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

This reverts commit c0e07c010e5abdea1a7d1357edb1d08adac529cb.

Yes, it is nicer to pass the exit status through the exitstatus
global, but look at the consequences:

 $ sh -c 'exec nonexistent'; echo $?
 exec: 1: nonexistent: not found
 2
 $ sh -c 'exec .'; echo $?
 exec: 1: .: Permission denied
 2

According to POSIX:
"If command is not found, the exit status shall be 127. If command is
found, but it is not an executable utility, the exit status shall
be 126."

Make it so again.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 src/error.h |    1 +
 src/exec.c  |    3 +--
 src/main.c  |    2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/error.h b/src/error.h
index 15ccbe3..1bb6a82 100644
--- a/src/error.h
+++ b/src/error.h
@@ -62,6 +62,7 @@ struct jmploc {
 
 extern struct jmploc *handler;
 extern int exception;
+extern int exerrno;	/* error for EXEXEC */
 
 /* exceptions */
 #define EXINT 0		/* SIGINT received */
diff --git a/src/exec.c b/src/exec.c
index 42299ea..9525a16 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -86,6 +86,7 @@ struct tblentry {
 
 STATIC struct tblentry *cmdtable[CMDTABLESIZE];
 STATIC int builtinloc = -1;		/* index in path of %builtin, or -1 */
+int exerrno;				/* Last exec error */
 
 
 STATIC void tryexec(char *, char **, char **);
@@ -108,7 +109,6 @@ shellexec(char **argv, const char *path, int idx)
 	char *cmdname;
 	int e;
 	char **envp;
-	int exerrno;
 
 	envp = environment();
 	if (strchr(argv[0], '/') != NULL) {
@@ -138,7 +138,6 @@ shellexec(char **argv, const char *path, int idx)
 		exerrno = 2;
 		break;
 	}
-	exitstatus = exerrno;
 	TRACE(("shellexec failed for %s, errno %d, suppressint %d\n",
 		argv[0], e, suppressint ));
 	exerror(EXEXEC, "%s: %s", argv[0], errmsg(e, E_EXEC));
diff --git a/src/main.c b/src/main.c
index 2bff956..5bc1a99 100644
--- a/src/main.c
+++ b/src/main.c
@@ -115,6 +115,8 @@ main(int argc, char **argv)
 		e = exception;
 		if (e == EXERROR)
 			exitstatus = 2;
+		else if (e == EXEXEC)
+			exitstatus = exerrno;
 
 		s = state;
 		if (e == EXEXIT || s == 0 || iflag == 0 || shlvl)
-- 
1.7.2.3

