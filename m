From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Kill pgetc_macro
Date: Mon, 29 Sep 2014 17:08:50 +0800
Message-ID: <20140929090850.GA1343@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:49732 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaI2JIy (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 29 Sep 2014 05:08:54 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

While looking at the backslash newline bug it occured to me that
pgetc_macro is vestigial and should be removed.  I've run some
speed tests on the result and the difference appears to be in the
noise.  But if anyone sees a big regression please let me know.

commit 339b9c0781cca7afb0964c6a655cda8ad9cf9fc2
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Sep 29 17:05:53 2014 +0800

    [INPUT] Kill pgetc_macro
    
    pgetc_macro is identical to pgetc except that it's a macro and
    pgetc isn't.  Since there is very little performance difference
    on modern systems it's time to kill pgetc_macro.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 7345144..0fbc514 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-09-29  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Kill pgetc_macro.
+
 2014-09-28  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Correctly handle test ! ! = !.
diff --git a/src/input.c b/src/input.c
index d31c45b..9e533a4 100644
--- a/src/input.c
+++ b/src/input.c
@@ -134,7 +134,10 @@ RESET {
 int
 pgetc(void)
 {
-	return pgetc_macro();
+	if (--parsenleft >= 0)
+		return (signed char)*parsenextc++;
+	else
+		return preadbuffer();
 }
 
 
@@ -147,7 +150,7 @@ pgetc2()
 {
 	int c;
 	do {
-		c = pgetc_macro();
+		c = pgetc();
 	} while (c == PEOA);
 	return c;
 }
diff --git a/src/input.h b/src/input.h
index 50a7797..775291b 100644
--- a/src/input.h
+++ b/src/input.h
@@ -61,6 +61,3 @@ void setinputstring(char *);
 void popfile(void);
 void popallfiles(void);
 void closescript(void);
-
-#define pgetc_macro() \
-	(--parsenleft >= 0 ? (signed char)*parsenextc++ : preadbuffer())
diff --git a/src/parser.c b/src/parser.c
index 572cbcd..c4eaae2 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -775,7 +775,7 @@ xxreadtoken(void)
 		setprompt(2);
 	}
 	for (;;) {	/* until token or start of word found */
-		c = pgetc_macro();
+		c = pgetc();
 		switch (c) {
 		case ' ': case '\t':
 		case PEOA:
@@ -1009,7 +1009,7 @@ quotemark:
 					USTPUTC(c, out);
 				}
 			}
-			c = pgetc_macro();
+			c = pgetc();
 		}
 	}
 endword:

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
