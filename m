From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] [DEBUG] Add newline when tracing in poplocalvars
Date: Tue, 12 Mar 2013 14:22:11 +0100
Message-ID: <1363094531-48060-1-git-send-email-peda@lysator.liu.se>
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:48583 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab3CLNWT (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 12 Mar 2013 09:22:19 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 61B5640007
	for <dash@vger.kernel.org>; Tue, 12 Mar 2013 14:22:16 +0100 (CET)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Peter Rosin <peda@lysator.liu.se>

Signed-off-by: Peter Rosin <peda@lysator.liu.se>
---
 ChangeLog |    4 ++++
 src/var.c |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index d84d3b7..959dd07 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2013-03-12  Peter Rosin  <peda@lysator.liu.se>
+
+	* Add newline when tracing in poplocalvars.
+
 2012-06-09  Christoph Mathys <eraserix@gmail.com>
 
 	* Add support for ulimit -r.
diff --git a/src/var.c b/src/var.c
index dc90249..c35e925 100644
--- a/src/var.c
+++ b/src/var.c
@@ -547,7 +547,7 @@ poplocalvars(int keep)
 	while ((lvp = next) != NULL) {
 		next = lvp->next;
 		vp = lvp->vp;
-		TRACE(("poplocalvar %s", vp ? vp->text : "-"));
+		TRACE(("poplocalvar %s\n", vp ? vp->text : "-"));
 		if (keep) {
 			int bits = VSTRFIXED;
 
-- 
1.7.9

