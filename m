From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 3/3] [PARSER] Catch variable length expansions on non-existant specials
Date: Wed, 05 Nov 2014 16:48:26 +0800
Message-ID: <E1XlwGQ-0005Xu-Ks@gondolin.me.apana.org.au>
References: <20141105084749.GA21242@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:55412 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaKEIs3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 5 Nov 2014 03:48:29 -0500
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1XlwGR-0005S5-HM
	for <dash@vger.kernel.org>; Wed, 05 Nov 2014 19:48:27 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Currently we only check special variable names that follow directly
after $ or ${.  So errors such as ${#&} are not caught.  This patch
fixes that by moving the is_special check to just before we print out
the special variable name.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog    |    4 ++++
 src/parser.c |   11 +++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 8e0d276..6a64f74 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-10-30  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Catch variable length expansions on non-existant specials.
+
 2014-10-28  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Removed unnecessary pungetc on EOF from parser.
diff --git a/src/parser.c b/src/parser.c
index 382ddf2..382658e 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1229,8 +1229,7 @@ varname:
 				STPUTC(c, out);
 				c = pgetc_eatbnl();
 			} while (is_digit(c));
-		}
-		else if (is_special(c)) {
+		} else {
 			int cc = c;
 
 			c = pgetc_eatbnl();
@@ -1251,10 +1250,14 @@ varname:
 				}
 			}
 
+			if (!is_special(cc)) {
+				if (subtype == VSLENGTH)
+					subtype = 0;
+				goto badsub;
+			}
+
 			USTPUTC(cc, out);
 		}
-		else
-			goto badsub;
 
 		if (subtype == 0) {
 			switch (c) {
