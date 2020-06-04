From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] eval: Check nflag in evaltree instead of cmdloop
Date: Thu, 4 Jun 2020 21:53:55 +1000
Message-ID: <20200604115355.GA13954@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:37086 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgFDLyD (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 4 Jun 2020 07:54:03 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, Joey Hess <id@joeyh.name>, 858288@bugs.debian.org

This patch moves the nflag check from cmdloop into evaltree.  This
is so that nflag will be in force even if we enter the shell via a
path other than cmdloop, e.g., through sh -c.

Reported-by: Joey Hess <id@joeyh.name>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/eval.c b/src/eval.c
index d10be38..9476fbb 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -213,6 +213,9 @@ evaltree(union node *n, int flags)
 
 	setstackmark(&smark);
 
+	if (nflag)
+		goto out;
+
 	if (n == NULL) {
 		TRACE(("evaltree(NULL) called\n"));
 		goto out;
diff --git a/src/main.c b/src/main.c
index 7a28534..5c49fdc 100644
--- a/src/main.c
+++ b/src/main.c
@@ -233,7 +233,7 @@ cmdloop(int top)
 				out2str("\nUse \"exit\" to leave shell.\n");
 			}
 			numeof++;
-		} else if (nflag == 0) {
+		} else {
 			int i;
 
 			job_warning = (job_warning == 2) ? 1 : 0;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
