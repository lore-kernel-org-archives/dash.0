From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] parser: Fix alias expansion after heredoc or newlines
Date: Wed, 29 Apr 2020 00:19:59 +1000
Message-ID: <20200428141958.GA18579@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:47784 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgD1OUE (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 28 Apr 2020 10:20:04 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, Harald van Dijk <harald@gigawatt.nl>, Martijn Dekker <martijn@inlv.org>

The following patch is meant to be applied on top of:

https://patchwork.kernel.org/patch/11512439/

---8<---
This script should print OK:

	alias a="case x in " b=x
	a
	b) echo BAD;; esac

	alias BEGIN={ END=}
	BEGIN
		cat <<- EOF > /dev/null
			$(:)
		EOF
	END

	: <<- EOF &&
		$(:)
	EOF
	BEGIN
		echo OK
	END

However, because the value of checkkwd is either zeroed when it
shouldn't, or isn't zeroed when it should, dash currently gets
it wrong in every case.

This patch fixes it by saving checkkwd and zeroing it where needed.

Suggested-by: Harald van Dijk <harald@gigawatt.nl>
Reported-by: Harald van Dijk <harald@gigawatt.nl>
Reported-by: Martijn Dekker <martijn@inlv.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index 5c9e9a0..be84f8b 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -704,10 +704,14 @@ top:
 	if (kwd & CHKNL) {
 		while (t == TNL) {
 			parseheredoc();
+			checkkwd = 0;
 			t = xxreadtoken();
 		}
 	}
 
+	kwd |= checkkwd;
+	checkkwd = 0;
+
 	if (t != TWORD || quoteflag) {
 		goto out;
 	}
@@ -725,7 +729,7 @@ top:
 		}
 	}
 
-	if (checkkwd & CHKALIAS) {
+	if (kwd & CHKALIAS) {
 		struct alias *ap;
 		if ((ap = lookupalias(wordtext, 1)) != NULL) {
 			if (*ap->val) {
@@ -735,7 +739,6 @@ top:
 		}
 	}
 out:
-	checkkwd = 0;
 #ifdef DEBUG
 	if (!alreadyseen)
 	    TRACE(("token %s %s\n", tokname[t], t == TWORD ? wordtext : ""));
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
