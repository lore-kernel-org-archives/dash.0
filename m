From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [EXPAND] Optimise nulonly away and just use quoted as before
Date: Wed, 8 Oct 2014 20:11:44 +0800
Message-ID: <20141008121144.GA9340@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:59224 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbaJHMLr (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Oct 2014 08:11:47 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

commit ab657e36b68f4a7e9ddb0f36c455c98d1c069a2c
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed Oct 8 20:09:56 2014 +0800

    [EXPAND] Optimise nulonly away and just use quoted as before
    
    This patch makes a small optimisation by using the same value for
    quoted between evalvar and varvalue by eliminating nulonly and
    passing along quoted instead.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index e981a43..5f033df 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -2,6 +2,7 @@
 
 	* Split unquoted $@/$* correctly when IFS is set but empty.
 	* Do not split quoted VSLENGTH and VSTRIM.
+	* Optimise nulonly away and just use quoted as before.
 
 2014-10-07  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/expand.c b/src/expand.c
index dc8ae47..dfb3f0e 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -722,7 +722,6 @@ evalvar(char *p, int flag)
 	ssize_t varlen;
 	int easy;
 	int quoted;
-	int nulonly;
 
 	varflags = *p++;
 	subtype = varflags & VSTYPE;
@@ -733,12 +732,11 @@ evalvar(char *p, int flag)
 	quoted = flag & EXP_QUOTED;
 	var = p;
 	easy = (!quoted || (*var == '@' && shellparam.nparam));
-	nulonly = easy;
 	startloc = expdest - (char *)stackblock();
 	p = strchr(p, '=') + 1;
 
 again:
-	varlen = varvalue(var, varflags, flag, &nulonly);
+	varlen = varvalue(var, varflags, flag, &quoted);
 	if (varflags & VSNUL)
 		varlen--;
 
@@ -783,7 +781,7 @@ vsplus:
 record:
 		if (!easy)
 			goto end;
-		recordregion(startloc, expdest - (char *)stackblock(), nulonly);
+		recordregion(startloc, expdest - (char *)stackblock(), quoted);
 		goto end;
 	}
 
@@ -888,7 +886,7 @@ strtodest(p, syntax, quotes)
  */
 
 STATIC ssize_t
-varvalue(char *name, int varflags, int flags, int *nulonly)
+varvalue(char *name, int varflags, int flags, int *quotedp)
 {
 	int num;
 	char *p;
@@ -897,14 +895,12 @@ varvalue(char *name, int varflags, int flags, int *nulonly)
 	char sepc;
 	char **ap;
 	char const *syntax;
-	int quoted = flags & EXP_QUOTED;
+	int quoted = *quotedp;
 	int subtype = varflags & VSTYPE;
 	int discard = subtype == VSPLUS || subtype == VSLENGTH;
 	int quotes = (discard ? 0 : (flags & QUOTES_ESC)) | QUOTES_KEEPNUL;
 	ssize_t len = 0;
 
-	sep = *nulonly ? (flags & EXP_FULL) << CHAR_BIT : 0;
-	*nulonly = 0;
 	syntax = quoted ? DQSYNTAX : BASESYNTAX;
 
 	switch (*name) {
@@ -935,16 +931,20 @@ numvar:
 		expdest = p;
 		break;
 	case '@':
+		sep = 0;
 		if (quoted)
 			goto param;
 		/* fall through */
 	case '*':
-		sep |= ifsset() ? ifsval()[0] : ' ';
+		sep = ifsset() ? ifsval()[0] : ' ';
+		if (!quoted) {
 param:
+			sep |= (flags & EXP_FULL) << CHAR_BIT;
+		}
+		sepc = sep;
+		*quotedp = !sepc;
 		if (!(ap = shellparam.p))
 			return -1;
-		sepc = sep;
-		*nulonly = !sepc;
 		while ((p = *ap++)) {
 			len += strtodest(p, syntax, quotes);

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
