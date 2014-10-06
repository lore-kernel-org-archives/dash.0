From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [BUILTIN] Allow return in loop conditional to set exit status
Date: Mon, 6 Oct 2014 21:25:48 +0800
Message-ID: <20141006132547.GB22730@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:48326 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbaJFNZv (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Oct 2014 09:25:51 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Stephane Chazelas <stephane_chazelas@yahoo.fr>, 332954@bugs.debian.org

commit f14b4626eb5c1c2fda137e7d1520c5f1cb7e85c4
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Oct 6 21:22:43 2014 +0800

    [BUILTIN] Allow return in loop conditional to set exit status
    
    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=332954
    
    When return is used in a loop conditional the exit status will
    be lost because we always set the exit status at the end of the
    loop to that of the last command executed in the body.
    
    This is counterintuitive and contrary to what most other shells do.
    
    This patch fixes this by always preserving the exit status of
    return when it is used in a loop conditional.
    
    The patch was originally written by Gerrit Pape <pape@smarden.org>.
    
    Reported-by: Stephane Chazelas <stephane_chazelas@yahoo.fr>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 1d88e13..297b81a 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -3,6 +3,7 @@
 	* Exit without arguments in a trap should use status outside traps.
 	* Do not allow break to break across function calls.
 	* Move common skipcount logic into skiploop.
+	* Allow return in loop conditional to set exit status.
 
 2014-10-03  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/eval.c b/src/eval.c
index daccf3d..7b341f3 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -387,8 +387,9 @@ evalloop(union node *n, int flags)
 		status = exitstatus;
 		skip = skiploop();
 	} while (!(skip & ~SKIPCONT));
+	if (skip != SKIPFUNC)
+		exitstatus = status;
 	loopnest--;
-	exitstatus = status;
 }
 

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
