Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69960C3A5A7
	for <linux-dash@archiver.kernel.org>; Tue,  6 Dec 2022 08:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiLFItT (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 6 Dec 2022 03:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiLFItS (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 6 Dec 2022 03:49:18 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDBBAE60
        for <dash@vger.kernel.org>; Tue,  6 Dec 2022 00:49:17 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2Tda-004Oh3-Kl; Tue, 06 Dec 2022 16:49:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 06 Dec 2022 16:49:14 +0800
Date:   Tue, 6 Dec 2022 16:49:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     dash@vger.kernel.org
Subject: [PATCH] eval: Always set exitstatus in evaltree
Message-ID: <Y48CCiIAagbl5q0L@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

There is no harm in setting exitstatus unconditionally in evaltree.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/eval.c b/src/eval.c
index 3337f71..eda251e 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -239,7 +239,7 @@ evaltree(union node *n, int flags)
 #endif
 	case NNOT:
 		status = !evaltree(n->nnot.com, EV_TESTED);
-		goto setstatus;
+		break;
 	case NREDIR:
 		errlinno = lineno = n->nredir.linno;
 		if (funcline)
@@ -250,7 +250,7 @@ evaltree(union node *n, int flags)
 			 evaltree(n->nredir.n, flags & EV_TESTED);
 		if (n->nredir.redirect)
 			popredir(0);
-		goto setstatus;
+		break;
 	case NCMD:
 		evalfn = evalcommand;
 checkexit:
@@ -292,7 +292,7 @@ evaln:
 		evalfn = evaltree;
 calleval:
 		status = evalfn(n, flags);
-		goto setstatus;
+		break;
 	case NIF:
 		status = evaltree(n->nif.test, EV_TESTED);
 		if (evalskip)
@@ -305,13 +305,14 @@ calleval:
 			goto evaln;
 		}
 		status = 0;
-		goto setstatus;
+		break;
 	case NDEFUN:
 		defun(n);
-setstatus:
-		exitstatus = status;
 		break;
 	}
+
+	exitstatus = status;
+
 out:
 	dotrap();
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
