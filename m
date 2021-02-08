Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B535C433E0
	for <linux-dash@archiver.kernel.org>; Mon,  8 Feb 2021 03:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C06764D9C
	for <linux-dash@archiver.kernel.org>; Mon,  8 Feb 2021 03:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBHDmM (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 7 Feb 2021 22:42:12 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:36958 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBHDmM (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 7 Feb 2021 22:42:12 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l8xQW-000660-7M; Mon, 08 Feb 2021 14:41:29 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 08 Feb 2021 14:41:28 +1100
Date:   Mon, 8 Feb 2021 14:41:28 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Vladimir N. Oleynik" <dzo@simtreas.ru>
Cc:     dash@vger.kernel.org
Subject: [PATCH] parser: Fix regression on ${#10} expansion
Message-ID: <20210208034127.GA31149@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b91eab68-0a8a-36f0-a947-344cf2c168f5@simtreas.ru>
X-Newsgroups: apana.lists.os.linux.dash
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Thanks for the patch!

---8<---
Vladimir N. Oleynik <dzo@simtreas.ru> wrote:
> 
> dash have bug for ${#10} and etc: ignores 0... in name (without errors :)
> 
> $ foo() { echo "length 10-th arg '${10}' is ${#10}"; }
> $ foo a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11
> length 10-th arg 'a10' is 2
> 
> But need:
> length 10-th arg 'a10' is 3
> 
> Micro patch attached
>
> --- parser.c~   2021-02-04 00:51:34.000000000 +0400
> +++ parser.c    2021-02-05 12:42:43.616635640 +0400
> @@ -1274,7 +1274,7 @@
>                        do {
>                                STPUTC(c, out);
>                                c = pgetc_eatbnl();
> -                       } while (!subtype && is_digit(c));
> +                       } while ((!subtype || subtype == VSLENGTH) && is_digit(c));
>                } else if (c != '}') {
>                        int cc = c;

I would rather test against VSNORMAL.

Fixes: 7710a926b321 ("parser: Only accept single-digit parameter...")
Reported-by: Vladimir N. Oleynik <dzo@simtreas.ru>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index 3c80d17..834d2e3 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1252,7 +1252,7 @@ varname:
 			do {
 				STPUTC(c, out);
 				c = pgetc_eatbnl();
-			} while (!subtype && is_digit(c));
+			} while (subtype != VSNORMAL && is_digit(c));
 		} else if (c != '}') {
 			int cc = c;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
