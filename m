From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [EVAL] Do not clobber exitstatus in evalcommand
Date: Fri, 3 Oct 2014 14:35:25 +0800
Message-ID: <20141003063525.GA1228@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:57680 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbaJCGgE (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 3 Oct 2014 02:36:04 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

commit 0d1fb088a4a16569260de4266d4bd359491c6bcd
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Oct 3 14:07:07 2014 +0800

    [EVAL] Do not clobber exitstatus in evalcommand
    
    All originators of EXERROR have been setting the exitstatus for
    a while now.  So it is no longer appropriate to set it explicitly
    in evalcommand.
    
    In fact doing so may cause the original exitstatus to be lost.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 9a601df..4dc8fa3 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-10-03  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Do not clobber exitstatus in evalcommand.
+
 2014-10-02  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix use-after-free in dotrap/evalstring.
diff --git a/src/eval.c b/src/eval.c
index 0708bf5..3f4d957 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -853,12 +853,9 @@ bail:
 				listsetvar(varlist.list, VEXPORT);
 		}
 		if (evalbltin(cmdentry.u.cmd, argc, argv, flags)) {
-			if (exception == EXERROR) {
-				exitstatus = 2;
-				if (spclbltin <= 0) {
-					FORCEINTON;
-					break;
-				}
+			if (exception == EXERROR && spclbltin <= 0) {
+				FORCEINTON;
+				break;
 			}
 raise:
 			longjmp(handler->loc, 1);

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
