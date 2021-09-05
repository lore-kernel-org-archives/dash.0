Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A0C433F5
	for <linux-dash@archiver.kernel.org>; Sun,  5 Sep 2021 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D57660F5E
	for <linux-dash@archiver.kernel.org>; Sun,  5 Sep 2021 08:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbhIEJA1 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 5 Sep 2021 05:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhIEJA1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 5 Sep 2021 05:00:27 -0400
X-Greylist: delayed 1388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Sep 2021 01:59:24 PDT
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3FCC061575
        for <dash@vger.kernel.org>; Sun,  5 Sep 2021 01:59:24 -0700 (PDT)
Received: from [80.229.142.159] (port=56502 helo=argus.frippery.org)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <rmy@frippery.org>)
        id 1mMndO-0007Ec-DT
        for dash@vger.kernel.org; Sun, 05 Sep 2021 09:36:14 +0100
Received: by argus.frippery.org (Postfix, from userid 1000)
        id 17B5A60B7; Sun,  5 Sep 2021 09:36:11 +0100 (BST)
Date:   Sun, 05 Sep 2021 09:36:11 +0100
From:   Ron Yorston <rmy@frippery.org>
To:     dash@vger.kernel.org
Subject: [PATCH] input: Remove special case for unget EOF
Message-ID: <6134817b.feb8Hlf2SOdlZPZw%rmy@frippery.org>
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 9
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Commit 17db43b5841504b694203952fb0e82246c06a97f (input: Allow two
consecutive calls to pungetc) ensures that EOF is handled like any
other character with respect to unget.  As a result it's possible
to remove the special case for unget of EOF in preadbuffer.

Signed-off-by: Ron Yorston <rmy@frippery.org>
---
 src/input.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/input.c b/src/input.c
index d7c101b..ec075f5 100644
--- a/src/input.c
+++ b/src/input.c
@@ -58,7 +58,6 @@
 #include "myhistedit.h"
 #endif
 
-#define EOF_NLEFT -99		/* value of parsenleft when EOF pushed back */
 #define IBUFSIZ (BUFSIZ + 1)
 
 
@@ -220,9 +219,8 @@ retry:
  * Refill the input buffer and return the next input character:
  *
  * 1) If a string was pushed back on the input, pop it;
- * 2) If an EOF was pushed back (parsenleft == EOF_NLEFT) or we are reading
- *    from a string so we can't refill the buffer, return EOF.
- * 3) If the is more stuff in this buffer, use it else call read to fill it.
+ * 2) If we are reading from a string we can't refill the buffer, return EOF.
+ * 3) If there is more stuff in this buffer, use it else call read to fill it.
  * 4) Process input up to the next newline, deleting nul characters.
  */
 
@@ -239,8 +237,7 @@ static int preadbuffer(void)
 		popstring();
 		return __pgetc();
 	}
-	if (unlikely(parsefile->nleft == EOF_NLEFT ||
-		     parsefile->buf == NULL))
+	if (parsefile->buf == NULL)
 		return PEOF;
 	flushall();
 
@@ -248,7 +245,7 @@ static int preadbuffer(void)
 	if (more <= 0) {
 again:
 		if ((more = preadfd()) <= 0) {
-			parsefile->lleft = parsefile->nleft = EOF_NLEFT;
+			parsefile->lleft = parsefile->nleft = 0;
 			return PEOF;
 		}
 	}
-- 
2.31.1

