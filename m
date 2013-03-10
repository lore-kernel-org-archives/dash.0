From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] [DEBUG] Do not attempt to output a NULL message
Date: Sun, 10 Mar 2013 22:58:38 +0100
Message-ID: <513D020E.8050704@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:41976 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab3CJWHE (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 10 Mar 2013 18:07:04 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 1576140004
	for <dash@vger.kernel.org>; Sun, 10 Mar 2013 22:58:39 +0100 (CET)
Received: from [192.168.0.64] (90-227-119-137-no95.business.telia.com [90.227.119.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id E98AD40003
	for <dash@vger.kernel.org>; Sun, 10 Mar 2013 22:58:38 +0100 (CET)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Prevent future problems, as noone calls exverror with a NULL msg
at this time.

Signed-off-by: Peter Rosin <peda@lysator.liu.se>
---
 src/error.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

I stumbled on this when reading the code... Or is msg only ever
NULL when DEBUG is #defined?

Cheers,
Peter

diff --git a/src/error.c b/src/error.c
index 9d31989..5ab69c0 100644
--- a/src/error.c
+++ b/src/error.c
@@ -151,8 +151,8 @@ exverror(int cond, const char *msg, va_list ap)
 		TRACE(("\") pid=%d\n", getpid()));
 	} else
 		TRACE(("exverror(%d, NULL) pid=%d\n", cond, getpid()));
-	if (msg)
 #endif
+	if (msg)
 		exvwarning(-1, msg, ap);
 
 	flushall();
-- 
1.7.9

