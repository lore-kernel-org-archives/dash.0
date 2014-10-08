From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [EXPAND] Do not split quoted VSLENGTH and VSTRIM
Date: Wed, 8 Oct 2014 15:42:50 +0800
Message-ID: <20141008074249.GA7629@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:59891 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbaJHHm4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Oct 2014 03:42:56 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

commit 8ecad23eae02bbdf36fe5dc8e53deb67fb894357
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed Oct 8 15:42:08 2014 +0800

    [EXPAND] Do not split quoted VSLENGTH and VSTRIM
    
    Currently VSLENGTH and VSTRIM* are field-split even within quotes.
    This is obviously wrong.  This patch fixes that.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index dd2ee9d..e981a43 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2014-10-08  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Split unquoted $@/$* correctly when IFS is set but empty.
+	* Do not split quoted VSLENGTH and VSTRIM.
 
 2014-10-07  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/expand.c b/src/expand.c
index 51ba8a1..dc8ae47 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -753,28 +753,22 @@ vsplus:
 			argstr(p, flag | EXP_TILDE | EXP_WORD);
 			goto end;
 		}
-		if (easy)
-			goto record;
-		goto end;
+		goto record;
 	}
 
 	if (subtype == VSASSIGN || subtype == VSQUESTION) {
-		if (varlen < 0) {
-			if (subevalvar(p, var, 0, subtype, startloc,
-				       varflags, flag & ~QUOTES_ESC)) {
-				varflags &= ~VSNUL;
-				/* 
-				 * Remove any recorded regions beyond 
-				 * start of variable 
-				 */
-				removerecordregions(startloc);
-				goto again;
-			}
-			goto end;
-		}
-		if (easy)
+		if (varlen >= 0)
 			goto record;
-		goto end;
+
+		subevalvar(p, var, 0, subtype, startloc, varflags,
+			   flag & ~QUOTES_ESC);
+		varflags &= ~VSNUL;
+		/* 
+		 * Remove any recorded regions beyond 
+		 * start of variable 
+		 */
+		removerecordregions(startloc);
+		goto again;
 	}
 
 	if (varlen < 0 && uflag)
@@ -786,9 +780,9 @@ vsplus:
 	}
 
 	if (subtype == VSNORMAL) {
+record:
 		if (!easy)
 			goto end;
-record:
 		recordregion(startloc, expdest - (char *)stackblock(), nulonly);
 		goto end;
 	}

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
