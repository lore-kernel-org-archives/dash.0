From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] [EXCEPTIONS] Stop documenting EXSHELLPROC
Date: Wed, 6 Oct 2010 22:39:23 -0500
Message-ID: <20101007033923.GC2285@burratino>
References: <20101006100420.GA361@burratino>
 <20101006100804.GB361@burratino>
 <20101006102930.GA6573@gondor.apana.org.au>
 <20101006105531.GB475@burratino>
 <4CAC68FD.4040602@redhat.com>
 <20101007010241.GB1276@burratino>
 <20101007010347.GC1276@burratino>
 <20101007030153.GA15132@gondor.apana.org.au>
 <20101007030414.GA2285@burratino>
 <20101007032903.GA15283@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49312 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760058Ab0JGDma (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 23:42:30 -0400
Received: by yxp4 with SMTP id 4so117827yxp.19
        for <dash@vger.kernel.org>; Wed, 06 Oct 2010 20:42:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101007032903.GA15283@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <eblake@redhat.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

At some point between ash 0.3.5-11.0.1 and ash 0.3.8-37, Debian
ash stopped using the EXSHELLPROC exception to handle shell
scripts without a magic number.

Remove all remaining references to it to avoid confusion.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Herbert Xu wrote:

> Yeah please resend the patch with the fix-up.

Done.  (Patch is against master, as before.)

 src/TOUR    |   11 +----------
 src/error.h |    1 -
 2 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/src/TOUR b/src/TOUR
index 4baac62..056e79b 100644
--- a/src/TOUR
+++ b/src/TOUR
@@ -43,10 +43,6 @@ C source files for entries looking like:
                            back to the main command loop */
         }
 
-        SHELLPROC {
-              x = 3;    /* executed when the shell runs a shell procedure */
-        }
-
 It pulls this code out into routines which are when particular
 events occur.  The intent is to improve modularity by isolating
 the information about which modules need to be explicitly
@@ -79,12 +75,7 @@ EXCEPTIONS:  Code for dealing with exceptions appears in
 exceptions.c.  The C language doesn't include exception handling,
 so I implement it using setjmp and longjmp.  The global variable
 exception contains the type of exception.  EXERROR is raised by
-calling error.  EXINT is an interrupt.  EXSHELLPROC is an excep-
-tion which is raised when a shell procedure is invoked.  The pur-
-pose of EXSHELLPROC is to perform the cleanup actions associated
-with other exceptions.  After these cleanup actions, the shell
-can interpret a shell procedure itself without exec'ing a new
-copy of the shell.
+calling error.  EXINT is an interrupt.
 
 INTERRUPTS:  In an interactive shell, an interrupt will cause an
 EXINT exception to return to the main command loop.  (Exception:
diff --git a/src/error.h b/src/error.h
index 3162e15..be0eec9 100644
--- a/src/error.h
+++ b/src/error.h
@@ -66,7 +66,6 @@ extern int exception;
 /* exceptions */
 #define EXINT 0		/* SIGINT received */
 #define EXERROR 1	/* a generic error */
-#define EXSHELLPROC 2	/* execute a shell procedure */
 #define EXEXEC 3	/* command execution failed */
 #define EXEXIT 4	/* exit the shell */
 
-- 
1.7.2.3

