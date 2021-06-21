Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E0AC48BE5
	for <linux-dash@archiver.kernel.org>; Mon, 21 Jun 2021 09:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1CF160FD8
	for <linux-dash@archiver.kernel.org>; Mon, 21 Jun 2021 09:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFUJ7g (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Jun 2021 05:59:36 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50788 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhFUJ7f (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Jun 2021 05:59:35 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lvGgC-0008G0-VI; Mon, 21 Jun 2021 17:57:21 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lvGgB-0002QZ-LO; Mon, 21 Jun 2021 17:57:19 +0800
Date:   Mon, 21 Jun 2021 17:57:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Denys Vlasenko <vda.linux@googlemail.com>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
Subject: [PATCH] parser: Fix VSLENGTH parsing with trailing garbage
Message-ID: <20210621095719.GA9287@gondor.apana.org.au>
References: <CAK1hOcNX1K_o0E7eFDAD2FYE8WCTpj1hUfzyvQstEQ5S=6onHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1hOcNX1K_o0E7eFDAD2FYE8WCTpj1hUfzyvQstEQ5S=6onHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Sat, Jun 19, 2021 at 02:44:46PM +0200, Denys Vlasenko wrote:
> 
> CTLVAR and CTLBACKQ are not properly handled if encountered
> inside {$#...}. Testcase:
> 
> dash -c "`printf 'echo ${#1\x82}'`" 00 111 222
> 
> It should execute "echo ${#1 <byte 0x82> }" and thus print "3"
> (the length of $1, which is "111").
> 
> Instead, it segfaults.
> 
> (Ideally, it should fail since "1 <byte 0x82>" is not a valid
> variable name, but currently dash accepts e.g. "${#1abc}"
> as if it is "${#1}bc". A separate, less serious bug...).

In fact these two bugs are one and the same.  This patch fixes
both by detecting the invalid substitution and not emitting it
into the node tree.

Incidentally this reveals a bug in how we parse ${#10} that got
introduced recently, which is also fixed here.

Reported-by: Denys Vlasenko <vda.linux@googlemail.com>
Fixes: 7710a926b321 ("parser: Only accept single-digit parameter...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index 3c80d17..13c2df5 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1252,7 +1252,8 @@ varname:
 			do {
 				STPUTC(c, out);
 				c = pgetc_eatbnl();
-			} while (!subtype && is_digit(c));
+			} while ((subtype <= 0 || subtype >= VSLENGTH) &&
+				 is_digit(c));
 		} else if (c != '}') {
 			int cc = c;
 
@@ -1312,6 +1313,8 @@ varname:
 				break;
 			}
 		} else {
+			if (subtype == VSLENGTH && c != '}')
+				subtype = 0;
 badsub:
 			pungetc();
 		}
diff --git a/src/parser.h b/src/parser.h
index 524ac1c..7d2749b 100644
--- a/src/parser.h
+++ b/src/parser.h
@@ -62,6 +62,7 @@
 #define VSTRIMLEFT	0x8		/* ${var#pattern} */
 #define VSTRIMLEFTMAX	0x9		/* ${var##pattern} */
 #define VSLENGTH	0xa		/* ${#var} */
+/* VSLENGTH must come last. */
 
 /* values of checkkwd variable */
 #define CHKALIAS	0x1
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
