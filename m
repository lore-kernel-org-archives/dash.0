Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F160DC64E8A
	for <linux-dash@archiver.kernel.org>; Wed,  2 Dec 2020 05:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C23221FE
	for <linux-dash@archiver.kernel.org>; Wed,  2 Dec 2020 05:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgLBFci (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 2 Dec 2020 00:32:38 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53006 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgLBFch (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 2 Dec 2020 00:32:37 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kkKjx-0007zd-TO; Wed, 02 Dec 2020 16:31:47 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 02 Dec 2020 16:31:45 +1100
Date:   Wed, 2 Dec 2020 16:31:45 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Michael Biebl <biebl@debian.org>
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash@vger.kernel.org, 974705@bugs.debian.org
Subject: [PATCH] jobs: Only block in waitcmd on first run
Message-ID: <20201202053145.GA8074@gondor.apana.org.au>
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <20201201065623.GA27646@gondor.apana.org.au>
 <86689c77-34c6-2dbe-32d2-95f826bfa634@debian.org>
 <20201201232606.GA32382@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201232606.GA32382@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This patch ensures that waitcmd never blocks unless there are
outstanding jobs.  This could otherwise trigger a hang if children
were created prior to the shell coming into existence, or if
there are backgrounded children of other kinds (e.g., a here-
document).

Fixes: 6c691b3e5099 ("jobs: Only clear gotsigchld when waiting...")
Reported-by: Michael Biebl <biebl@debian.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 3417633..516786f 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -81,6 +81,7 @@
 #define DOWAIT_NONBLOCK 0
 #define DOWAIT_BLOCK 1
 #define DOWAIT_WAITCMD 2
+#define DOWAIT_WAITCMD_ALL 4
 
 /* array of jobs */
 static struct job *jobtab;
@@ -615,7 +616,7 @@ waitcmd(int argc, char **argv)
 				jp->waited = 1;
 				jp = jp->prev_job;
 			}
-			if (!dowait(DOWAIT_WAITCMD, 0))
+			if (!dowait(DOWAIT_WAITCMD_ALL, 0))
 				goto sigout;
 		}
 	}
@@ -1138,6 +1139,7 @@ static int dowait(int block, struct job *jp)
 		pid = waitone(block, jp);
 		rpid &= !!pid;
 
+		block &= ~DOWAIT_WAITCMD_ALL;
 		if (!pid || (jp && jp->state != JOBRUNNING))
 			block = DOWAIT_NONBLOCK;
 	} while (pid >= 0);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
