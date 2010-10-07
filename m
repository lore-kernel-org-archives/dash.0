From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Revert "Eliminated global exerrno."
Date: Wed, 6 Oct 2010 22:35:18 -0500
Message-ID: <20101007033518.GB2285@burratino>
References: <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org>
 <20100628065326.GA25667@gondor.apana.org.au>
 <20101006100420.GA361@burratino>
 <20101006100804.GB361@burratino>
 <20101006102930.GA6573@gondor.apana.org.au>
 <20101006105531.GB475@burratino>
 <4CAC68FD.4040602@redhat.com>
 <20101007010241.GB1276@burratino>
 <20101007010458.GD1276@burratino>
 <20101007025649.GA14649@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43103 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab0JGDi0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 23:38:26 -0400
Received: by yxp4 with SMTP id 4so116930yxp.19
        for <dash@vger.kernel.org>; Wed, 06 Oct 2010 20:38:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101007025649.GA14649@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <eblake@redhat.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

Herbert Xu wrote:

> Actually the bug is elsewhere.

It does bisect to there. :)  But you're right, it would have been
simpler to send one patch.

> --- a/src/eval.c
> +++ b/src/eval.c
> @@ -854,7 +854,7 @@ bail:
>  			int i;
>  
>  			i = exception;
> -			if (i == EXEXIT)
> +			if (i == EXEXIT || i == EXEXEC)
>  				goto raise;

Good call.  This is better than my patch because it exits like it
ought to for

	command exec nonexistent

(as POSIX says:

	If command is specified, exec shall not return to the shell

).

Maybe the following would make sense on top?

-- 8< --
Subject: [EXCEPTIONS] Use EXEXIT in place of EXEXEC

The intended semantics of EXEXEC are identical to EXEXIT, so
simplify by using EXEXIT directly.

Functional change: in edge cases (exec within a trap handler),
this causes the exit status from exec not to be clobbered.
For example, without this patch:

 $ sh -c 'trap "exec nonexistent" EXIT'; echo $?
 exec: 1: nonexistent: not found
 0

And with it:

 $ sh -c 'trap "exec nonexistent" EXIT'; echo $?
 exec: 1: nonexistent: not found
 127

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 src/error.h |    1 -
 src/eval.c  |    2 +-
 src/exec.c  |    2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/error.h b/src/error.h
index be0eec9..f236d9f 100644
--- a/src/error.h
+++ b/src/error.h
@@ -66,7 +66,6 @@ extern int exception;
 /* exceptions */
 #define EXINT 0		/* SIGINT received */
 #define EXERROR 1	/* a generic error */
-#define EXEXEC 3	/* command execution failed */
 #define EXEXIT 4	/* exit the shell */
 
 
diff --git a/src/eval.c b/src/eval.c
index b966749..5b8d36b 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -854,7 +854,7 @@ bail:
 			int i;
 
 			i = exception;
-			if (i == EXEXIT || i == EXEXEC)
+			if (i == EXEXIT)
 				goto raise;
 
 			status = (i == EXINT) ? SIGINT + 128 : 2;
diff --git a/src/exec.c b/src/exec.c
index 42299ea..b273420 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -141,7 +141,7 @@ shellexec(char **argv, const char *path, int idx)
 	exitstatus = exerrno;
 	TRACE(("shellexec failed for %s, errno %d, suppressint %d\n",
 		argv[0], e, suppressint ));
-	exerror(EXEXEC, "%s: %s", argv[0], errmsg(e, E_EXEC));
+	exerror(EXEXIT, "%s: %s", argv[0], errmsg(e, E_EXEC));
 	/* NOTREACHED */
 }
 
-- 
1.7.2.3

