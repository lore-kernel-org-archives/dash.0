From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: "command -p" does not correctly limit search to a safe PATH
Date: Fri, 26 Sep 2014 16:44:43 +0800
Message-ID: <20140926084443.GA14940@gondor.apana.org.au>
References: <CAL=-wemDL=2-7Rco761LTgGrFeAA_-zvz0ECpk4xZE7QJsGUEg@mail.gmail.com>
 <51E30212.3030901@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:47300 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbaIZIot (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 26 Sep 2014 04:44:49 -0400
Content-Disposition: inline
In-Reply-To: <51E30212.3030901@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Craig Loomis <cploomis@gmail.com>, dash@vger.kernel.org

On Sun, Jul 14, 2013 at 07:54:58PM +0000, Harald van Dijk wrote:
>
> commit 475e328589fd2e843c138d49fb96699a2a66151d
> Author: Harald van Dijk <harald@gigawatt.nl>
> Date:   Sun Jul 14 21:23:01 2013 +0200
> 
>     command: allow combining -p with -v

Patch applied.  Thanks a lot!

I've also added a little optimisation patch on top to minimise
the size impact.

commit d813a572d94455f1d0d43ccad49edfacd13ee2e3
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Sep 26 16:42:18 2014 +0800

    [BUILTIN] Small optimisation of command -pv change
    
    This patch moves the pathval call into the describe_command
    function and also eliminates an unnecessary branch when DEBUG
    is off.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 2fbc628..a8d5fa2 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-09-26  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Small optimisation to command -pv change.
+
 2014-09-26  Harald van Dijk <harald@gigawatt.nl>
 
 	* command: allow combining -p with -v.
diff --git a/src/exec.c b/src/exec.c
index e56e3f6..ec0eadd 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -727,7 +727,7 @@ typecmd(int argc, char **argv)
 	int err = 0;
 
 	for (i = 1; i < argc; i++) {
-		err |= describe_command(out1, argv[i], pathval(), 1);
+		err |= describe_command(out1, argv[i], NULL, 1);
 	}
 	return err;
 }
@@ -743,6 +743,8 @@ describe_command(out, command, path, verbose)
 	struct tblentry *cmdp;
 	const struct alias *ap;
 
+	path = path ?: pathval();
+
 	if (verbose) {
 		outstr(command, out);
 	}
@@ -840,19 +842,19 @@ commandcmd(argc, argv)
 		VERIFY_BRIEF = 1,
 		VERIFY_VERBOSE = 2,
 	} verify = 0;
-	const char *path = pathval();
+	const char *path = NULL;
 
 	while ((c = nextopt("pvV")) != '\0')
 		if (c == 'V')
 			verify |= VERIFY_VERBOSE;
 		else if (c == 'v')
 			verify |= VERIFY_BRIEF;
-		else if (c == 'p')
-			path = defpath;
 #ifdef DEBUG
-		else
+		else if (c != 'p')
 			abort();
 #endif
+		else
+			path = defpath;
 
 	cmd = *argptr;
 	if (verify && cmd)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
