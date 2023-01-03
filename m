Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB39C53210
	for <linux-dash@archiver.kernel.org>; Tue,  3 Jan 2023 05:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjACFcr (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Jan 2023 00:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjACFcp (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Jan 2023 00:32:45 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4DA6412
        for <dash@vger.kernel.org>; Mon,  2 Jan 2023 21:32:43 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pCZuj-00DM41-1f; Tue, 03 Jan 2023 13:32:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Jan 2023 13:32:41 +0800
Date:   Tue, 3 Jan 2023 13:32:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org, harald@gigawatt.nl
Subject: [PATCH] input: Eat rest of line upon reset
Message-ID: <Y7O9+cQuuAwo4HtG@gondor.apana.org.au>
References: <b62afca3e10b03c802276ace6e514f7ccb7a5134.1670979949.git.nabijaczleweli@nabijaczleweli.xyz>
 <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Jan 03, 2023 at 09:53:23AM +0800, Herbert Xu wrote:
>
> This is broken.  What if we already read a newline just before
> the syntax error (e.g., synexpect(TDO))?
> 
> This needs to be dealt with in the input layer.

This works for me:

---8<---
Interactively, sh_error() doesn't terminate, so
  echo "|$(printf %10000s)echo bug" | sh -i
would read the first 8KiB, see that it's invalid, then jump back to the
parser, which would then read and execute the rest of the line as-if
it were the next line.

The fix for this is to explicitly consume the rest of the invalid line,
so that the next line observed is /actually/ the next line.

This is difficult to trigger accidentally right now, since we consume
the entire icanon line buffer at once (provided it's <8k, which it
~always is interactively), so we always observe one line at a time,
but the next patch would make even "| echo bug" blow up.

Reported-by: наб <nabijaczleweli@nabijaczleweli.xyz> 
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index dfe2fd6..e72eae7 100644
--- a/src/input.c
+++ b/src/input.c
@@ -77,6 +77,7 @@ INCLUDE <stdio.h>
 INCLUDE <unistd.h>
 INCLUDE "input.h"
 INCLUDE "error.h"
+INCLUDE "syntax.h"
 
 INIT {
 	basepf.nextc = basepf.buf = basebuf;
@@ -85,9 +86,11 @@ INIT {
 
 RESET {
 	/* clear input buffer */
-	basepf.lleft = basepf.nleft = 0;
-	basepf.unget = 0;
 	popallfiles();
+	basepf.unget = 0;
+	while (basepf.lastc[0] != '\n' &&
+	       basepf.lastc[0] != PEOF)
+		pgetc();
 }
 
 FORKRESET {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
