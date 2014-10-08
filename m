From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [EXPAND] Split unquoted $@/$* correctly when IFS is set but empty
Date: Wed, 8 Oct 2014 15:26:36 +0800
Message-ID: <20141008072636.GA7524@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:43862 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbaJHH0k (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Oct 2014 03:26:40 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

commit 3c06acdac0b1ba0e0acdda513a57ee6e31385dce
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed Oct 8 15:24:23 2014 +0800

    [EXPAND] Split unquoted $@/$* correctly when IFS is set but empty
    
    Currently we do not field-split $@/$* when it isn't quoted and IFS
    is set but empty.  This is obviously wrong.  This patch fixes this.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index b990628..dd2ee9d 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-10-08  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Split unquoted $@/$* correctly when IFS is set but empty.
+
 2014-10-07  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Use setvareq to set OPTIND initially.
diff --git a/src/expand.c b/src/expand.c
index 11fd7b7..51ba8a1 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -116,7 +116,7 @@ STATIC const char *subevalvar(char *, char *, int, int, int, int, int);
 STATIC char *evalvar(char *, int);
 STATIC size_t strtodest(const char *, const char *, int);
 STATIC void memtodest(const char *, size_t, const char *, int);
-STATIC ssize_t varvalue(char *, int, int);
+STATIC ssize_t varvalue(char *, int, int, int *);
 STATIC void expandmeta(struct strlist *, int);
 #ifdef HAVE_GLOB
 STATIC void addglob(const glob_t *);
@@ -722,6 +722,7 @@ evalvar(char *p, int flag)
 	ssize_t varlen;
 	int easy;
 	int quoted;
+	int nulonly;
 
 	varflags = *p++;
 	subtype = varflags & VSTYPE;
@@ -732,11 +733,12 @@ evalvar(char *p, int flag)
 	quoted = flag & EXP_QUOTED;
 	var = p;
 	easy = (!quoted || (*var == '@' && shellparam.nparam));
+	nulonly = easy;
 	startloc = expdest - (char *)stackblock();
 	p = strchr(p, '=') + 1;
 
 again:
-	varlen = varvalue(var, varflags, flag);
+	varlen = varvalue(var, varflags, flag, &nulonly);
 	if (varflags & VSNUL)
 		varlen--;
 
@@ -787,7 +789,7 @@ vsplus:
 		if (!easy)
 			goto end;
 record:
-		recordregion(startloc, expdest - (char *)stackblock(), quoted);
+		recordregion(startloc, expdest - (char *)stackblock(), nulonly);
 		goto end;
 	}
 
@@ -892,7 +894,7 @@ strtodest(p, syntax, quotes)
  */
 
 STATIC ssize_t
-varvalue(char *name, int varflags, int flags)
+varvalue(char *name, int varflags, int flags, int *nulonly)
 {
 	int num;
 	char *p;
@@ -907,7 +909,8 @@ varvalue(char *name, int varflags, int flags)
 	int quotes = (discard ? 0 : (flags & QUOTES_ESC)) | QUOTES_KEEPNUL;
 	ssize_t len = 0;
 
-	sep = quoted ? ((flags & EXP_FULL) << CHAR_BIT) : 0;
+	sep = *nulonly ? (flags & EXP_FULL) << CHAR_BIT : 0;
+	*nulonly = 0;
 	syntax = quoted ? DQSYNTAX : BASESYNTAX;
 
 	switch (*name) {
@@ -938,15 +941,16 @@ numvar:
 		expdest = p;
 		break;
 	case '@':
-		if (sep)
+		if (quoted)
 			goto param;
 		/* fall through */
 	case '*':
-		sep = ifsset() ? ifsval()[0] : ' ';
+		sep |= ifsset() ? ifsval()[0] : ' ';
 param:
 		if (!(ap = shellparam.p))
 			return -1;
 		sepc = sep;
+		*nulonly = !sepc;
 		while ((p = *ap++)) {
 			len += strtodest(p, syntax, quotes);


Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
