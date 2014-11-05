From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 2/3] [PARSER] Simplify EOF/newline handling in list parser
Date: Wed, 05 Nov 2014 16:48:25 +0800
Message-ID: <E1XlwGP-0005Xd-4f@gondolin.me.apana.org.au>
References: <20141105084749.GA21242@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:60805 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaKEIs2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 5 Nov 2014 03:48:28 -0500
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1XlwGP-0005Rx-RP
	for <dash@vger.kernel.org>; Wed, 05 Nov 2014 19:48:25 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This patch simplifies the EOF and new handling in the list parser.
In particular, it eliminates a case where we may leave here-documents
unfinished upon EOF.

It also removes special EOF/newline handling from parsecmd.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog    |    1 
 src/parser.c |   60 +++++++++++++++++++++++++----------------------------------
 2 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 70ccfed..8e0d276 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2014-10-28  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Removed unnecessary pungetc on EOF from parser.
+	* Simplify EOF/newline handling in list parser.
 
 2014-10-27  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/parser.c b/src/parser.c
index f0c919d..382ddf2 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -135,19 +135,13 @@ static inline int realeofmark(const char *eofmark)
 union node *
 parsecmd(int interact)
 {
-	int t;
-
 	tokpushback = 0;
+	checkkwd = 0;
+	heredoclist = 0;
 	doprompt = interact;
 	if (doprompt)
 		setprompt(doprompt);
 	needprompt = 0;
-	t = readtoken();
-	if (t == TEOF)
-		return NEOF;
-	if (t == TNL)
-		return NULL;
-	tokpushback++;
 	return list(1);
 }
 
@@ -158,11 +152,27 @@ list(int nlflag)
 	union node *n1, *n2, *n3;
 	int tok;
 
-	checkkwd = CHKNL | CHKKWD | CHKALIAS;
-	if (nlflag == 2 && tokendlist[peektoken()])
-		return NULL;
 	n1 = NULL;
 	for (;;) {
+		switch (peektoken()) {
+		case TNL:
+			if (!(nlflag & 1))
+				break;
+			parseheredoc();
+			return n1;
+
+		case TEOF:
+			if (!n1 && (nlflag & 1))
+				n1 = NEOF;
+			parseheredoc();
+			return n1;
+		}
+
+		checkkwd = CHKNL | CHKKWD | CHKALIAS;
+		if (nlflag == 2 && tokendlist[peektoken()])
+			return n1;
+		nlflag |= 2;
+
 		n2 = andor();
 		tok = readtoken();
 		if (tok == TBACKGND) {
@@ -189,29 +199,15 @@ list(int nlflag)
 			n1 = n3;
 		}
 		switch (tok) {
-		case TBACKGND:
-		case TSEMI:
-			tok = readtoken();
-			/* fall through */
 		case TNL:
-			if (tok == TNL) {
-				parseheredoc();
-				if (nlflag == 1)
-					return n1;
-			} else {
-				tokpushback++;
-			}
-			checkkwd = CHKNL | CHKKWD | CHKALIAS;
-			if (tokendlist[peektoken()])
-				return n1;
-			break;
 		case TEOF:
-			if (heredoclist)
-				parseheredoc();
 			tokpushback++;
-			return n1;
+			/* fall through */
+		case TBACKGND:
+		case TSEMI:
+			break;
 		default:
-			if (nlflag == 1)
+			if ((nlflag & 1))
 				synexpect(-1);
 			tokpushback++;
 			return n1;
@@ -1443,10 +1439,6 @@ parsearith: {
 
 #ifdef mkinit
 INCLUDE "parser.h"
-RESET {
-	tokpushback = 0;
-	checkkwd = 0;
-}
 #endif
 
 
