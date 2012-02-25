From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] var.c: check for valid variable name before printing
	in "export -p"
Date: Sat, 25 Feb 2012 18:36:36 +1100
Message-ID: <20120225073636.GA19041@gondor.apana.org.au>
References: <1329216528-8462-1-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from sting.hengli.com.au ([178.18.18.71]:43030 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754383Ab2BYIJL (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 25 Feb 2012 03:09:11 -0500
Content-Disposition: inline
In-Reply-To: <1329216528-8462-1-git-send-email-harald@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: harald@redhat.com
Cc: dash@vger.kernel.org

On Tue, Feb 14, 2012 at 10:48:48AM +0000, harald@redhat.com wrote:
> From: Harald Hoyer <harald@redhat.com>
> 
> "export -p" prints all environment variables, without checking if the
> environment variable is a valid dash variable name.
> 
> IMHO, the only valid usecase for "export -p" is to eval the output.

Thanks a lot for the report and patch.

I'd prefer to fix this up at entry into the shell rather than
when we print out the variables.  So how about this patch?

commit 46d3c1a614f11f0d40a7e73376359618ff07abcd
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sat Feb 25 15:35:18 2012 +0800

    [VAR] Sanitise environment variable names on entry
    
    On Tue, Feb 14, 2012 at 10:48:48AM +0000, harald@redhat.com wrote:
    >
    > "export -p" prints all environment variables, without checking if the
    > environment variable is a valid dash variable name.
    >
    > IMHO, the only valid usecase for "export -p" is to eval the output.
    >
    > $ eval $(export -p); echo OK
    > OK
    >
    > Without this patch the following test does error out with:
    >
    > test.py:
    > import os
    > os.environ["test-test"]="test"
    > os.environ["test_test"]="test"
    > os.execv("./dash", [ './dash', '-c', 'eval $(export -p); echo OK' ])
    >
    > $ python test.py
    > ./dash: 1: export: test-test: bad variable name
    >
    > Of course the results can be more evil, if the environment variable
    > name is crafted, that it injects valid shell code.
    
    This patch fixes the issue by sanitising all environment variable names
    upon entry into the shell.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index d1e84c9..8686332 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2012-02-25  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Sanitise environment variable names on entry.
+
 2011-08-17  David S. Miller <davem@davemloft.net>
 
 	* Allow building without LINEO support.
diff --git a/src/var.c b/src/var.c
index 027beff..dc90249 100644
--- a/src/var.c
+++ b/src/var.c
@@ -136,7 +136,8 @@ INIT {
 
 	initvar();
 	for (envp = environ ; *envp ; envp++) {
-		if (strchr(*envp, '=')) {
+		p = endofname(*envp);
+		if (p != *envp && *p == '=') {
 			setvareq(*envp, VEXPORT|VTEXTFIXED);
 		}
 	}

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
