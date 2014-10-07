From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [VAR] Use setvareq to set OPTIND initially
Date: Tue, 7 Oct 2014 22:27:37 +0800
Message-ID: <20141007142737.GA31218@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:38240 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbaJGO1l (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 7 Oct 2014 10:27:41 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

commit f20dcdd0948d7ebb7d462a0288ea218468ad4f6c
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue Oct 7 22:24:42 2014 +0800

    [VAR] Use setvareq to set OPTIND initially
    
    There is no need to setvarint to set the initial value of OPTIND
    of one.  This patch switchs to setvareq which also lets us avoid
    an unnecessary memory allocation.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index aa230ab..b990628 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-10-07  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Use setvareq to set OPTIND initially.
+
 2014-10-06  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Exit without arguments in a trap should use status outside traps.
diff --git a/src/var.c b/src/var.c
index fa24854..cc6f7f2 100644
--- a/src/var.c
+++ b/src/var.c
@@ -80,6 +80,7 @@ const char defifsvar[] = "IFS= \t\n";
 #else
 const char defifs[] = " \t\n";
 #endif
+MKINIT char defoptindvar[] = "OPTIND=1";
 
 int lineno;
 char linenovar[sizeof("LINENO=")+sizeof(int)*CHAR_BIT/3+1] = "LINENO=";
@@ -100,7 +101,7 @@ struct var varinit[] = {
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS1=$ ",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS2=> ",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS4=+ ",	0 },
-	{ 0,	VSTRFIXED|VTEXTFIXED,		"OPTIND=1",	getoptsreset },
+	{ 0,	VSTRFIXED|VTEXTFIXED,		defoptindvar,	getoptsreset },
 #ifdef WITH_LINENO
 	{ 0,	VSTRFIXED|VTEXTFIXED,		linenovar,	0 },
 #endif
@@ -142,7 +143,7 @@ INIT {
 		}
 	}
 
-	setvarint("OPTIND", 1, 0);
+	setvareq(defoptindvar, VTEXTFIXED);
 
 	fmtstr(ppid + 5, sizeof(ppid) - 5, "%ld", (long) getppid());
 	setvareq(ppid, VTEXTFIXED);

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
