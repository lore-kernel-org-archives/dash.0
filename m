From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [EVAL] Move common skipcount logic into skiploop
Date: Mon, 6 Oct 2014 21:23:56 +0800
Message-ID: <20141006132355.GA22730@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:40711 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbaJFNYA (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Oct 2014 09:24:00 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

commit 598d300ffa0b9542a88feae900ccdd29e35374cf
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Oct 6 20:45:04 2014 +0800

    [EVAL] Move common skipcount logic into skiploop
    
    The functions evalloop and evalfor share the logic on checking
    and updating skipcount.  This patch moves that into the helper
    function skiploop.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index b70fa88..1d88e13 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -2,6 +2,7 @@
 
 	* Exit without arguments in a trap should use status outside traps.
 	* Do not allow break to break across function calls.
+	* Move common skipcount logic into skiploop.
 
 2014-10-03  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/eval.c b/src/eval.c
index eb5b120..daccf3d 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -339,27 +339,45 @@ void evaltreenr(union node *n, int flags)
 #endif
 
 
+static int skiploop(void)
+{
+	int skip = evalskip;
+
+	switch (skip) {
+	case 0:
+		break;
+
+	case SKIPBREAK:
+	case SKIPCONT:
+		if (likely(--skipcount <= 0)) {
+			evalskip = 0;
+			break;
+		}
+
+		skip = SKIPBREAK;
+		break;
+	}
+
+	return skip;
+}
+
+
 STATIC void
 evalloop(union node *n, int flags)
 {
+	int skip;
 	int status;
 
 	loopnest++;
 	status = 0;
 	flags &= EV_TESTED;
-	for (;;) {
+	do {
 		int i;
 
 		evaltree(n->nbinary.ch1, EV_TESTED);
-		if (evalskip) {
-skipping:	  if (evalskip == SKIPCONT && --skipcount <= 0) {
-				evalskip = 0;
-				continue;
-			}
-			if (evalskip == SKIPBREAK && --skipcount <= 0)
-				evalskip = 0;
-			break;
-		}
+		skip = skiploop();
+		if (skip)
+			continue;
 		i = exitstatus;
 		if (n->type != NWHILE)
 			i = !i;
@@ -367,9 +385,8 @@ skipping:	  if (evalskip == SKIPCONT && --skipcount <= 0) {
 			break;
 		evaltree(n->nbinary.ch2, flags);
 		status = exitstatus;
-		if (evalskip)
-			goto skipping;
-	}
+		skip = skiploop();
+	} while (!(skip & ~SKIPCONT));
 	loopnest--;
 	exitstatus = status;
 }
@@ -392,9 +409,6 @@ evalfor(union node *n, int flags)
 	arglist.lastp = &arglist.list;
 	for (argp = n->nfor.args ; argp ; argp = argp->narg.next) {
 		expandarg(argp, &arglist, EXP_FULL | EXP_TILDE);
-		/* XXX */
-		if (evalskip)
-			goto out;
 	}
 	*arglist.lastp = NULL;
 
@@ -404,18 +418,10 @@ evalfor(union node *n, int flags)
 	for (sp = arglist.list ; sp ; sp = sp->next) {
 		setvar(n->nfor.var, sp->text, 0);
 		evaltree(n->nfor.body, flags);
-		if (evalskip) {
-			if (evalskip == SKIPCONT && --skipcount <= 0) {
-				evalskip = 0;
-				continue;
-			}
-			if (evalskip == SKIPBREAK && --skipcount <= 0)
-				evalskip = 0;
+		if (skiploop() & ~SKIPCONT)
 			break;
-		}
 	}
 	loopnest--;
-out:
 	popstackmark(&smark);
 }

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
