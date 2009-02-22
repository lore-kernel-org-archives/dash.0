From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PARSER] Use CHKNL to parse case statements
Date: Sun, 22 Feb 2009 19:51:49 +0800
Message-ID: <20090222115149.GB3038@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:33101 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751487AbZBVLvx (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 22 Feb 2009 06:51:53 -0500
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1LbCs9-00080k-UK
	for <dash@vger.kernel.org>; Sun, 22 Feb 2009 22:51:50 +1100
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1LbCs9-0000pt-53
	for dash@vger.kernel.org; Sun, 22 Feb 2009 19:51:49 +0800
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

commit 49b82fcfda542b8db21073e6fceb4ac79984600d
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Feb 22 19:51:13 2009 +0800

    [PARSER] Use CHKNL to parse case statements
    
    Instead of open-coding the newline loop, use the CHKNL flag to
    get readtoken to eat the newlines before the in keyword for the
    case statement.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index d7e0f79..2c955e5 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -4,6 +4,7 @@
 	* Remove EXSIG.
 	* Do not close stderr when /dev/tty fails to open.
 	* Allow newlines after var name in for statements.
+	* Use CHKNL to parse case statements.
 
 2009-01-14  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/parser.c b/src/parser.c
index 425c457..dad1037 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -402,10 +402,8 @@ TRACE(("expecting DO got %s %s\n", tokname[got], got == TWORD ? wordtext : ""));
 		n2->narg.text = wordtext;
 		n2->narg.backquote = backquotelist;
 		n2->narg.next = NULL;
-		do {
-			checkkwd = CHKKWD | CHKALIAS;
-		} while (readtoken() == TNL);
-		if (lasttoken != TIN)
+		checkkwd = CHKNL | CHKKWD | CHKALIAS;
+		if (readtoken() != TIN)
 			synexpect(TIN);
 		cpp = &n1->ncase.cases;
 next_case:
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
