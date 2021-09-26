Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBBAC433EF
	for <linux-dash@archiver.kernel.org>; Sun, 26 Sep 2021 07:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAD560F0F
	for <linux-dash@archiver.kernel.org>; Sun, 26 Sep 2021 07:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhIZH3r (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 26 Sep 2021 03:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhIZH3q (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 26 Sep 2021 03:29:46 -0400
X-Greylist: delayed 958 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Sep 2021 00:28:11 PDT
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BA1C061570
        for <dash@vger.kernel.org>; Sun, 26 Sep 2021 00:28:10 -0700 (PDT)
Received: from [80.229.142.159] (port=43200 helo=argus.frippery.org)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <rmy@frippery.org>)
        id 1mUOKc-0008F1-0E
        for dash@vger.kernel.org; Sun, 26 Sep 2021 08:12:18 +0100
Received: by argus.frippery.org (Postfix, from userid 1000)
        id D8DFD5F6F; Sun, 26 Sep 2021 08:12:10 +0100 (BST)
Date:   Sun, 26 Sep 2021 08:12:10 +0100
From:   Ron Yorston <rmy@frippery.org>
To:     dash@vger.kernel.org
Subject: [PATCH] jobs: Report creation of background jobs
Message-ID: <61501d4a.OSIdlouybdqIzH3I%rmy@frippery.org>
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 9
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Although it doesn't seem to be in POSIX it's relatively common
for interactive shells to report details of jobs run in the
background.  bash, ksh and tcsh report job id and pid while
the Bourne shell from Unix V7 reports only the pid.

This from bash:

   $ sleep 100 & sleep 200 &
   [1] 4626
   [2] 4627
   $ sleep 300 | sleep 400 &
   [3] 4636
   $ jobs -l
   [1]   4626 Running                 sleep 100 &
   [2]-  4627 Running                 sleep 200 &
   [3]+  4635 Running                 sleep 300
         4636                       | sleep 400 &

Unlike reporting of job completions such messages are not controlled
by 'set -m'.

ash has never supported reporting of the creation of background
jobs.  Add this feature to dash.

Signed-off-by: Ron Yorston <rmy@frippery.org>
---
 src/jobs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/jobs.c b/src/jobs.c
index f3b9ffc..4e0cdcc 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -932,6 +932,8 @@ static void forkparent(struct job *jp, union node *n, int mode, pid_t pid)
 	if (mode == FORK_BG) {
 		backgndpid = pid;		/* set $! */
 		set_curjob(jp, CUR_RUNNING);
+		if (iflag && jp && jp->nprocs == 0)
+			outfmt(out2, "[%d] %d\n", jobno(jp), pid);
 	}
 	if (jp) {
 		struct procstat *ps = &jp->ps[jp->nprocs++];
-- 
2.31.1

