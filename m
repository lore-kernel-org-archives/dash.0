From: Stephen Kitt <steve@sk2.org>
Subject: [PATCH] Handle string-based job descriptors
Date: Fri,  3 Jun 2016 09:54:31 +0200
Message-ID: <1464940471-9819-1-git-send-email-steve@sk2.org>
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:31144 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbcFCHyj (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 3 Jun 2016 03:54:39 -0400
Received: from heffalump.sk2.org (unknown [88.186.243.14])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 307BD5FFB9
	for <dash@vger.kernel.org>; Fri,  3 Jun 2016 09:57:13 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Stephen Kitt <steve@sk2.org>

When looking for a job using a string descriptor, e.g.

	fg %man

the relevant loop in src/jobs.c only ever exits to the err label. With
this patch, when the end condition is reached, we check whether a job
was found, and if so, set things up to exit correctly via gotit.
Multiple matches are already caught using the test in the match block.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 src/jobs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index c2c2332..37f3b41 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -715,8 +715,14 @@ check:
 
 	found = 0;
 	while (1) {
-		if (!jp)
-			goto err;
+		if (!jp) {
+			if (found) {
+				jp = found;
+				goto gotit;
+			} else {
+				goto err;
+			}
+		}
 		if (match(jp->ps[0].cmd, p)) {
 			if (found)
 				goto err;
-- 
2.8.1

