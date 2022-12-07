Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D9FC352A1
	for <linux-dash@archiver.kernel.org>; Wed,  7 Dec 2022 08:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLGI47 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 7 Dec 2022 03:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiLGI41 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 7 Dec 2022 03:56:27 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7498D29834
        for <dash@vger.kernel.org>; Wed,  7 Dec 2022 00:55:10 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2qCp-004qba-PG; Wed, 07 Dec 2022 16:55:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 07 Dec 2022 16:55:07 +0800
Date:   Wed, 7 Dec 2022 16:55:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org
Subject: [PATCH] eval: Test evalskip before flipping status for NNOT
Message-ID: <Y5BU6+7igxd21p8o@gondor.apana.org.au>
References: <Y48CCiIAagbl5q0L@gondor.apana.org.au>
 <ce0c3ef7-66a9-08de-546f-d8ef8263b6da@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0c3ef7-66a9-08de-546f-d8ef8263b6da@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Dec 06, 2022 at 10:15:03AM +0000, Harald van Dijk wrote:
> 
> There is a long-standing bug that may or may not be harder to fix if this
> patch goes in, depending on how you want to fix it. Here's a script that
> already fails on current dash.
> 
>   f() {
>     if ! return 0
>     then :
>     fi
>   }
>   f
> 
> This should return 0, and does return 0 in bash and ksh (and almost all
> shells), but returns 1 in dash.
> 
> There are a few possible ways of fixing it. Some of them rely on continuing
> to conditionally set exitstatus.

This can be fixed simply by testing evalskip prior to flipping the
status.

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/eval.c b/src/eval.c
index 7aa5cc2..fa43b68 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -238,7 +238,9 @@ evaltree(union node *n, int flags)
 		break;
 #endif
 	case NNOT:
-		status = !evaltree(n->nnot.com, EV_TESTED);
+		status = evaltree(n->nnot.com, EV_TESTED);
+		if (!evalskip)
+			status = !status;
 		break;
 	case NREDIR:
 		errlinno = lineno = n->nredir.linno;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
