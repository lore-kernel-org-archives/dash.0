From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2] jobs: Handle string-based job descriptors
Date: Mon, 6 Jun 2016 22:45:27 +0800
Message-ID: <20160606144527.GA23630@gondor.apana.org.au>
References: <1464940471-9819-1-git-send-email-steve@sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:56076 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbcFFOpd (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Jun 2016 10:45:33 -0400
Content-Disposition: inline
In-Reply-To: <1464940471-9819-1-git-send-email-steve@sk2.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stephen Kitt <steve@sk2.org>
Cc: dash@vger.kernel.org

On Fri, Jun 03, 2016 at 09:54:31AM +0200, Stephen Kitt wrote:
> When looking for a job using a string descriptor, e.g.
> 
> 	fg %man
> 
> the relevant loop in src/jobs.c only ever exits to the err label. With
> this patch, when the end condition is reached, we check whether a job
> was found, and if so, set things up to exit correctly via gotit.
> Multiple matches are already caught using the test in the match block.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Thanks for the patch.  I'd prefer to move that logic out of the
loop, like this:

---8<---
From: Stephen Kitt <steve@sk2.org>

When looking for a job using a string descriptor, e.g.

	fg %man

the relevant loop in src/jobs.c only ever exits to the err label. With
this patch, when the end condition is reached, we check whether a job
was found, and if so, set things up to exit correctly via gotit.
Multiple matches are already caught using the test in the match block.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 3997863..4f02e38 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -714,9 +714,7 @@ check:
 	}
 
 	found = 0;
-	while (1) {
-		if (!jp)
-			goto err;
+	while (jp) {
 		if (match(jp->ps[0].cmd, p)) {
 			if (found)
 				goto err;
@@ -726,6 +724,10 @@ check:
 		jp = jp->prev_job;
 	}
 
+	if (!found)
+		goto err;
+	jp = found;
+
 gotit:
 #if JOBS
 	err_msg = "job %s not created under job control";
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
