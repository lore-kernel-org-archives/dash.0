From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [BUILTIN] Do not allow break to break across function calls
Date: Mon, 6 Oct 2014 19:50:48 +0800
Message-ID: <20141006115048.GA22025@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:49716 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbaJFLuv (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Oct 2014 07:50:51 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

commit ebfdd97a10e34a5e70eadfc21ebfc033ef93a563
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Oct 6 19:45:58 2014 +0800

    [BUILTIN] Do not allow break to break across function calls
    
    As it is if you do a multi-level break inside a function it'll
    actually include loops outside of the function call.  This is
    counterintuitive.
    
    This patch changes this by saving and resetting loopnest when
    entering a function.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index d0ec202..b70fa88 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2014-10-06  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Exit without arguments in a trap should use status outside traps.
+	* Do not allow break to break across function calls.
 
 2014-10-03  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/eval.c b/src/eval.c
index 51a900d..eb5b120 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -928,9 +928,11 @@ evalfun(struct funcnode *func, int argc, char **argv, int flags)
 	struct jmploc jmploc;
 	int e;
 	int savefuncline;
+	int saveloopnest;
 
 	saveparam = shellparam;
 	savefuncline = funcline;
+	saveloopnest = loopnest;
 	savehandler = handler;
 	if ((e = setjmp(jmploc.loc))) {
 		goto funcdone;
@@ -940,6 +942,7 @@ evalfun(struct funcnode *func, int argc, char **argv, int flags)
 	shellparam.malloc = 0;
 	func->count++;
 	funcline = func->n.ndefun.linno;
+	loopnest = 0;
 	INTON;
 	shellparam.nparam = argc - 1;
 	shellparam.p = argv + 1;
@@ -950,6 +953,7 @@ evalfun(struct funcnode *func, int argc, char **argv, int flags)
 	poplocalvars(0);
 funcdone:
 	INTOFF;
+	loopnest = saveloopnest;
 	funcline = savefuncline;
 	freefunc(func);
 	freeparam(&shellparam);

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
