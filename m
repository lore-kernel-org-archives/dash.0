Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1262AC4708E
	for <linux-dash@archiver.kernel.org>; Tue,  3 Jan 2023 09:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbjACJvX (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Jan 2023 04:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbjACJvV (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Jan 2023 04:51:21 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B0FB5A
        for <dash@vger.kernel.org>; Tue,  3 Jan 2023 01:51:21 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pCdx0-00DP9q-93; Tue, 03 Jan 2023 17:51:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Jan 2023 17:51:18 +0800
Date:   Tue, 3 Jan 2023 17:51:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: [v2 PATCH] var: Do not add 1 to return value of strchrnul
Message-ID: <Y7P6ljzo6smYXmov@gondor.apana.org.au>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

When a variable like OPTIND is unset dash may call the action
function with a bogus pointer because it tries to add one to
the return value of strchrnul unconditionally.

Use strchr and nullstr instead.

Link: https://bugs.debian.org/985478
Reported-by: наб <nabijaczleweli@nabijaczleweli.xyz>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/var.c b/src/var.c
index ef9c2bd..b70d72c 100644
--- a/src/var.c
+++ b/src/var.c
@@ -154,6 +154,10 @@ RESET {
 }
 #endif
 
+static char *varnull(const char *s)
+{
+	return (strchr(s, '=') ?: nullstr - 1) + 1;
+}
 
 /*
  * This routine initializes the builtin variables.  It is called when the
@@ -266,7 +270,7 @@ struct var *setvareq(char *s, int flags)
 			goto out;
 
 		if (vp->func && (flags & VNOFUNC) == 0)
-			(*vp->func)(strchrnul(s, '=') + 1);
+			(*vp->func)(varnull(s));
 
 		if ((vp->flags & (VTEXTFIXED|VSTACK)) == 0)
 			ckfree(vp->text);
@@ -531,7 +535,7 @@ poplocalvars(void)
 			unsetvar(vp->text);
 		} else {
 			if (vp->func)
-				(*vp->func)(strchrnul(lvp->text, '=') + 1);
+				(*vp->func)(varnull(lvp->text));
 			if ((vp->flags & (VTEXTFIXED|VSTACK)) == 0)
 				ckfree(vp->text);
 			vp->flags = lvp->flags;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
