Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4CAC3DA7A
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 07:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjAEH0S (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 02:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjAEH0R (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 02:26:17 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9964BD59
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 23:26:16 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDKde-00E7D6-Lq; Thu, 05 Jan 2023 15:26:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Jan 2023 15:26:10 +0800
Date:   Thu, 5 Jan 2023 15:26:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: [PATCH] input: Only skip blank lines on PS1
Message-ID: <Y7Z7kiVnwF+sltL+@gondor.apana.org.au>
References: <Y7PIHqN4ic4UBOBb@gondor.apana.org.au>
 <9a6c2bc5-11aa-db99-8db5-541060624b01@gigawatt.nl>
 <Y7U/2PnYCDA5stZ8@gondor.apana.org.au>
 <83fb967d-19e3-d7de-becc-179af3045e59@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83fb967d-19e3-d7de-becc-179af3045e59@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Jan 04, 2023 at 11:18:49AM +0000, Harald van Dijk wrote:
> 
> One is that because of what you say, the history recording for commands
> greater than BUFSIZ is already buggy, but unlikely to pose a problem in
> practice currently because normally, people don't write such long commands.

It's not just that people don't write long lines, it's the fact
that most people use the shell with a terminal device in canonical
mode and the line length is capped in canonical mode to some value
less than 8K.

> Another is that the stripping of blank lines from history breaks when blank
> lines are significant, as in
> 
>   $ cat <<EOF
>   > hello
>   >
>   > world
>   > EOF
>   hello
> 
>   world
>   $ fc 1
>   26
>   q
>   hello
>   world
> 
> Note how the blank line was lost.
> 
> If there was already "something" (as the code puts it), then when more data
> is appended, blanks must be preserved.

Good point.  This patch should fix it.

---8<---
Blank line should not be skipped if they're found on PS2.

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 7b37ae2..5dcc8a2 100644
--- a/src/input.c
+++ b/src/input.c
@@ -254,6 +254,7 @@ retry:
 
 static int preadbuffer(void)
 {
+	int first = whichprompt == 1;
 	int something;
 	char savec;
 	int more;
@@ -279,7 +280,7 @@ again:
 	q = parsefile->nextc;
 
 	/* delete nul characters */
-	something = 0;
+	something = !first;
 	for (;;) {
 		int c;
 
@@ -327,7 +328,7 @@ check:
 	if (parsefile->fd == 0 && hist && something) {
 		HistEvent he;
 		INTOFF;
-		history(hist, &he, whichprompt == 1? H_ENTER : H_APPEND,
+		history(hist, &he, first ? H_ENTER : H_APPEND,
 			parsefile->nextc);
 		INTON;
 	}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
