From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [OPTIONS] Use exit status 127 when the script to run
	does not exist
Date: Sun, 28 Nov 2010 20:33:13 +0800
Message-ID: <20101128123313.GA11079@gondor.apana.org.au>
References: <20100605160651.GA60028@stack.nl> <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org> <20100628065326.GA25667@gondor.apana.org.au> <20101006100420.GA361@burratino> <20101128120627.GA10839@gondor.apana.org.au> <20101128122437.GA10877@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:45152 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab0K1MdQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 07:33:16 -0500
Content-Disposition: inline
In-Reply-To: <20101128122437.GA10877@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>

On Sun, Nov 28, 2010 at 08:24:37PM +0800, Herbert Xu wrote:
> On Sun, Nov 28, 2010 at 08:06:27PM +0800, Herbert Xu wrote:
> >
> > However, instead of adding an ad-hoc exception for EXFILE, I'm
> > simply going to move the exit status setting for EXERROR out of
> > main.c and into error.c which should let you get what you want.
> 
> Something like this:

And here is the final patch that I applied for this:

commit 34f60a3781ea8f17f3d2a1a743a9aab9b31a296f
Author: Gerrit Pape <pape@smarden.org>
Date:   Sun Nov 28 20:32:00 2010 +0800

    [INPUT] Use exit status 127 when the script to run does not exist
    
    This commit makes dash exit with return code 127 instead of 2 if
    started as non-interactive shell with a non-existent command_file
    specified as argument (or a directory), as documented in
     http://www.opengroup.org/onlinepubs/009695399/utilities/sh.html#tag_04_128_14
    
    The wrong exit code was reported by Clint Adams and Jari Aalto through
     http://bugs.debian.org/548743
     http://bugs.debian.org/548687
    
    Signed-off-by: Gerrit Pape <pape@smarden.org>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index e5479a8..a18838c 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-11-28  Gerrit Pape <pape@smarden.org>
+
+	* Use exit status 127 when the script to run does not exist.
+
 2010-11-28  Philipp Weis <pweis@pweis.com>
 
 	* Document optional open parenthesis for case patterns.
diff --git a/src/input.c b/src/input.c
index e57ad76..bd3a9a2 100644
--- a/src/input.c
+++ b/src/input.c
@@ -42,6 +42,7 @@
  * This file implements the input routines used by the parser.
  */
 
+#include "eval.h"
 #include "shell.h"
 #include "redir.h"
 #include "syntax.h"
@@ -408,7 +409,8 @@ setinputfile(const char *fname, int flags)
 	if ((fd = open(fname, O_RDONLY)) < 0) {
 		if (flags & INPUT_NOFILE_OK)
 			goto out;
-		sh_error("Can't open %s", fname);
+		exitstatus = 127;
+		exerror(EXERROR, "Can't open %s", fname);
 	}
 	if (fd < 10)
 		fd = savefd(fd, fd);

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
