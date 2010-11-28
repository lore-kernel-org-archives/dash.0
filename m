From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [OPTIONS] Use exit status 127 when the script to run
	does not exist
Date: Sun, 28 Nov 2010 20:24:37 +0800
Message-ID: <20101128122437.GA10877@gondor.apana.org.au>
References: <20100605160651.GA60028@stack.nl> <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org> <20100628065326.GA25667@gondor.apana.org.au> <20101006100420.GA361@burratino> <20101128120627.GA10839@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:34094 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762Ab0K1MYj (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 07:24:39 -0500
Content-Disposition: inline
In-Reply-To: <20101128120627.GA10839@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>

On Sun, Nov 28, 2010 at 08:06:27PM +0800, Herbert Xu wrote:
>
> However, instead of adding an ad-hoc exception for EXFILE, I'm
> simply going to move the exit status setting for EXERROR out of
> main.c and into error.c which should let you get what you want.

Something like this:

commit a42317f10233cf2fcff033cc705fd14315188374
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Nov 28 20:22:00 2010 +0800

    [ERROR] Allow the originator of EXERROR to set the exit status
    
    Some errors have exit status values specified by POSIX and it is
    therefore desirable to be able to set the exit status at the EXERROR
    source rather than in main.c.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 76cbeb4..e5479a8 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -5,6 +5,7 @@
 2010-11-28  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fixed trap/return regression due to SKIPEVAL removal.
+	* Allow the originator of EXERROR to set the exit status.
 
 2010-10-18  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/error.c b/src/error.c
index e304d3d..f1a358d 100644
--- a/src/error.c
+++ b/src/error.c
@@ -163,6 +163,8 @@ sh_error(const char *msg, ...)
 {
 	va_list ap;
 
+	exitstatus = 2;
+
 	va_start(ap, msg);
 	exverror(EXERROR, msg, ap);
 	/* NOTREACHED */
diff --git a/src/eval.c b/src/eval.c
index ea4afc6..013a8dd 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -823,11 +823,13 @@ evalcommand(union node *cmd, int flags)
 	}
 
 	if (status) {
+bail:
+		exitstatus = status;
+
 		/* We have a redirection error. */
 		if (spclbltin > 0)
 			exraise(EXERROR);
-bail:
-		exitstatus = status;
+
 		goto out;
 	}
 
diff --git a/src/main.c b/src/main.c
index 2bff956..1735c67 100644
--- a/src/main.c
+++ b/src/main.c
@@ -113,8 +113,6 @@ main(int argc, char **argv)
 		reset();
 
 		e = exception;
-		if (e == EXERROR)
-			exitstatus = 2;
 
 		s = state;
 		if (e == EXEXIT || s == 0 || iflag == 0 || shlvl)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
