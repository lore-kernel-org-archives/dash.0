From: Martin Michlmayr <tbm@cyrius.com>
Subject: [PATCH] Fix typos
Date: Wed, 20 May 2020 16:08:36 +0800
Message-ID: <20200520080836.GA19305@jirafa.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay12.mail.gandi.net ([217.70.178.232]:40709 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETIIu (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 20 May 2020 04:08:50 -0400
Received: from jirafa.cyrius.com (unknown [110.54.246.209])
        (Authenticated sender: tbm@cyrius.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E851E20000B
        for <dash@vger.kernel.org>; Wed, 20 May 2020 08:08:47 +0000 (UTC)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

diff --git a/src/TOUR b/src/TOUR
index 056e79b..e30836e 100644
--- a/src/TOUR
+++ b/src/TOUR
@@ -100,7 +100,7 @@ string was going to be:
         p = stackptr;
         *p++ = c;       /* repeated as many times as needed */
         stackptr = p;
-The folloing three macros (defined in memalloc.h) perform these
+The following three macros (defined in memalloc.h) perform these
 operations, but grow the stack if you run off the end:
         STARTSTACKSTR(p);
         STPUTC(c, p);   /* repeated as many times as needed */
@@ -198,7 +198,7 @@ EXECUTION:  Command execution is handled by the following files:
         eval.c     The top level routines.
         redir.c    Code to handle redirection of input and output.
         jobs.c     Code to handle forking, waiting, and job control.
-        exec.c     Code to to path searches and the actual exec sys call.
+        exec.c     Code to path searches and the actual exec sys call.
         expand.c   Code to evaluate arguments.
         var.c      Maintains the variable symbol table.  Called from expand.c.
 
diff --git a/src/jobs.c b/src/jobs.c
index f65435d..0926360 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -557,7 +557,7 @@ showjobs(struct output *out, int mode)
 
 	TRACE(("showjobs(%x) called\n", mode));
 
-	/* If not even one one job changed, there is nothing to do */
+	/* If not even one job changed, there is nothing to do */
 	dowait(DOWAIT_NONBLOCK, NULL);
 
 	for (jp = curjob; jp; jp = jp->prev_job) {

-- 
Martin Michlmayr
https://www.cyrius.com/
