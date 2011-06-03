From: maximilian attems <max@stro.at>
Subject: [PATCH] JOBS: fix klibc DEBUG compilation
Date: Fri,  3 Jun 2011 19:38:27 +0200
Message-ID: <1307122707-30526-1-git-send-email-max@stro.at>
Return-path: <dash-owner@vger.kernel.org>
Received: from vostochny.stro.at ([78.47.22.85]:59010 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab1FCRjs (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 3 Jun 2011 13:39:48 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.hengli.com.au>
Cc: klibc@zytor.com, dash@vger.kernel.org, maximilian attems <max@stro.at>

dash didn't compile in DEBUG mode against klibc for all long time.
Now it fails at link stage for not having setlinebuf(3).

Fixes:

usr/dash/show.o: In function `opentrace':
show.c:(.text+0x86): undefined reference to `setlinebuf'                        
Signed-off-by: maximilian attems <max@stro.at>
---

the last open error, looks more like a klibc bug to me,
will fix it there:
show.c:(.text+0x36): undefined reference to `freopen'                           

 src/show.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/show.c b/src/show.c
index 14dbef3..b4160e1 100644
--- a/src/show.c
+++ b/src/show.c
@@ -394,7 +394,9 @@ opentrace(void)
 	if ((flags = fcntl(fileno(tracefile), F_GETFL, 0)) >= 0)
 		fcntl(fileno(tracefile), F_SETFL, flags | O_APPEND);
 #endif
+#ifndef SMALL
 	setlinebuf(tracefile);
+#endif /* SMALL */
 	fputs("\nTracing started.\n", tracefile);
 }
 #endif /* DEBUG */
-- 
1.7.4.4

