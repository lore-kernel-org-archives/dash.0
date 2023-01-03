Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BF0C46467
	for <linux-dash@archiver.kernel.org>; Tue,  3 Jan 2023 09:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjACJjr (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Jan 2023 04:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjACJjq (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Jan 2023 04:39:46 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72997F29
        for <dash@vger.kernel.org>; Tue,  3 Jan 2023 01:39:44 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pCdll-00DP0l-Lo; Tue, 03 Jan 2023 17:39:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Jan 2023 17:39:41 +0800
Date:   Tue, 3 Jan 2023 17:39:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: [PATCH] var: Do not add 1 to return value of strchrnul
Message-ID: <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> --- a/src/var.c
> +++ b/src/var.c
> @@ -266,7 +266,7 @@ struct var *setvareq(char *s, int flags)
>                        goto out;
> 
>                if (vp->func && (flags & VNOFUNC) == 0)
> -                       (*vp->func)(strchrnul(s, '=') + 1);
> +                       (*vp->func)(strchrnul(s, '=') + 1, flags);

Yes this was definitely broken.  strchrnul returns a pointer to the
final NUL character so adding one to it is just wrong.

However, I don't think we need to pass the flags to the action
function since none of them care about whether it's unset.  We
just need to pass a pointer to an empty string rather than some
bogus pointer.

---8<---
When a variable like OPTIND is unset dash may call the action
function with a bogus pointer because it tries to add one to
the return value of strchrnul unconditionally.

Use strchr and nullstr instead.

Link: https://bugs.debian.org/985478
Reported-by: наб <nabijaczleweli@nabijaczleweli.xyz>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/var.c b/src/var.c
index ef9c2bd..f42bfd7 100644
--- a/src/var.c
+++ b/src/var.c
@@ -266,7 +266,7 @@ struct var *setvareq(char *s, int flags)
 			goto out;
 
 		if (vp->func && (flags & VNOFUNC) == 0)
-			(*vp->func)(strchrnul(s, '=') + 1);
+			(*vp->func)((strchr(s, '=') ?: nullstr - 1) + 1);
 
 		if ((vp->flags & (VTEXTFIXED|VSTACK)) == 0)
 			ckfree(vp->text);
@@ -531,7 +531,8 @@ poplocalvars(void)
 			unsetvar(vp->text);
 		} else {
 			if (vp->func)
-				(*vp->func)(strchrnul(lvp->text, '=') + 1);
+				(*vp->func)((strchr(lvp->text, '=') ?:
+					     nullstr - 1) + 1);
 			if ((vp->flags & (VTEXTFIXED|VSTACK)) == 0)
 				ckfree(vp->text);
 			vp->flags = lvp->flags;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
