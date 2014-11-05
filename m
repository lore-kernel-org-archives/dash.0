From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 1/3] [PARSER] Removed unnecessary pungetc on EOF from parser
Date: Wed, 05 Nov 2014 16:48:23 +0800
Message-ID: <E1XlwGN-0005XK-TN@gondolin.me.apana.org.au>
References: <20141105084749.GA21242@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:37020 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaKEIs0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 5 Nov 2014 03:48:26 -0500
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1XlwGO-0005Rp-Ap
	for <dash@vger.kernel.org>; Wed, 05 Nov 2014 19:48:24 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Doing a pungetc on an EOF is a noop and is only useful when we
don't know what character we're putting back.  This patch removes
an unnecessary pungetc when we know it's EOF.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog    |    4 ++++
 src/parser.c |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 5212a9a..70ccfed 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-10-28  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Removed unnecessary pungetc on EOF from parser.
+
 2014-10-27  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Add printf support for format string a, A, and F.
diff --git a/src/parser.c b/src/parser.c
index f6c43be..f0c919d 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -208,8 +208,6 @@ list(int nlflag)
 		case TEOF:
 			if (heredoclist)
 				parseheredoc();
-			else
-				pungetc();		/* push back EOF on input */
 			tokpushback++;
 			return n1;
 		default:
