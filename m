From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] jobs: Don't attempt to access job table for job %0
Date: Thu, 10 Dec 2015 08:59:34 +0100
Message-ID: <1449734374-23041-1-git-send-email-tklauser@distanz.ch>
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:56847 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279AbbLJH7s (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Dec 2015 02:59:48 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: herbert@gondor.apana.org.au
Cc: dash@vger.kernel.org

If job %0 is (mistakenly) specified, an out-of-bounds access to the
jobtab occurs in function getjob() if num = 0:

	jp = jobtab + 0 - 1

Fix this by checking that the job number is larger than 0 before
accessing the jobtab.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 src/jobs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/jobs.c b/src/jobs.c
index c2c2332a25fa..39978635d891 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -699,7 +699,7 @@ check:
 
 	if (is_number(p)) {
 		num = atoi(p);
-		if (num <= njobs) {
+		if (num > 0 && num <= njobs) {
 			jp = jobtab + num - 1;
 			if (jp->used)
 				goto gotit;
-- 
2.6.3.368.gf34be46.dirty


