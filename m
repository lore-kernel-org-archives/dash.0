Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F588C3DA7A
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 07:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjAEHNB (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 02:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAEHNA (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 02:13:00 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944BD5276E
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 23:12:58 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDKQm-00E72v-1W; Thu, 05 Jan 2023 15:12:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Jan 2023 15:12:52 +0800
Date:   Thu, 5 Jan 2023 15:12:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: [PATCH] input: Check for int_pending while clearing input
Message-ID: <Y7Z4dM091n25aUQa@gondor.apana.org.au>
References: <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
 <bb422d70-0ba5-e29b-3ec8-8fc1c4630233@gigawatt.nl>
 <Y7VMJGPXXziUrBio@gondor.apana.org.au>
 <8ddcc8a3-9588-435a-9d5f-1edbcd121012@gigawatt.nl>
 <Y7WIuSnsIbkHrEvH@gondor.apana.org.au>
 <6883838e-4340-c80a-cca4-83d2d57078ba@gigawatt.nl>
 <Y7WQCoSQmTniSXUx@gondor.apana.org.au>
 <5eca3f9d-ed49-2ef2-0004-4495a676400e@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eca3f9d-ed49-2ef2-0004-4495a676400e@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Jan 04, 2023 at 02:59:23PM +0000, Harald van Dijk wrote:
>
> As long as we're talking about things like that, regardless of how it's
> implemented, we could also get another SIGINT during the skipping of the
> rest of the input line.

Actually, that's a good point and we should stop clearing the line
if we detect SIGINT.

---8<---
If we receive SIGINT while clearing a partially read line from
stdin we should bail out instead of continuing.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 8691617..1c83287 100644
--- a/src/input.c
+++ b/src/input.c
@@ -89,7 +89,8 @@ RESET {
 	popallfiles();
 	basepf.unget = 0;
 	while (basepf.lastc[0] != '\n' &&
-	       basepf.lastc[0] != PEOF)
+	       basepf.lastc[0] != PEOF &&
+	       !int_pending())
 		pgetc();
 }
 
Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
