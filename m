Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A9DC3DA7A
	for <linux-dash@archiver.kernel.org>; Fri,  6 Jan 2023 03:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjAFDQB (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 22:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAFDQA (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 22:16:00 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9276625C9
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 19:15:58 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDdD1-00ERhx-FG; Fri, 06 Jan 2023 11:15:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Jan 2023 11:15:55 +0800
Date:   Fri, 6 Jan 2023 11:15:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: [PATCH] parser: Print CTLBACKQ early in parsesub
Message-ID: <Y7eSaxWkgoiFl8Lx@gondor.apana.org.au>
References: <Y7aSMJlVi7fXD1DC@gondor.apana.org.au>
 <20230105134204.e7mczfzt2vbit3oc@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105134204.e7mczfzt2vbit3oc@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Jan 05, 2023 at 02:42:04PM +0100, наб wrote:
>
> I think this means we also need to turn the USTPUTC() into STPUTC(),
> since the previous code explicitly over-accounted for it in growstackto().

Good catch.  However, we can easily get rid of it by moving the
USTPUTC to the top:

---8<---
As we are allowed to perform 4 USTPUTC's we can save a growstackstr
call by adding the CTLBACKQ before we save the string.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index f5f76d5..299c260 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1360,6 +1360,7 @@ parsebackq: {
 	struct heredoc *saveheredoclist;
 	int uninitialized_var(saveprompt);
 
+	USTPUTC(CTLBACKQ, out);
 	str = stackblock();
 	savelen = out - (char *)stackblock();
 	grabstackblock(savelen);
@@ -1443,7 +1444,6 @@ done:
 	if (oldstyle)
 		tokpushback = 0;
 	out = stnputs(str, savelen, stackblock());
-	STPUTC(CTLBACKQ, out);
 	if (oldstyle)
 		goto parsebackq_oldreturn;
 	else
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
