From: maximilian attems <max@stro.at>
Subject: [PATCH] [SHELL] Fix klibc DEBUG compilation v2
Date: Sat,  4 Jun 2011 09:15:49 +0200
Message-ID: <1307171749-16260-1-git-send-email-max@stro.at>
Return-path: <dash-owner@vger.kernel.org>
Received: from vostochny.stro.at ([78.47.22.85]:43998 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185Ab1FDHQB (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 4 Jun 2011 03:16:01 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.hengli.com.au>
Cc: klibc@zytor.com, dash@vger.kernel.org, maximilian attems <max@stro.at>

dash didn't compile in DEBUG mode against klibc for all long time.
Now it only fails at link stage for not having setlinebuf(3) and
freopen(3).

Fixes:

usr/dash/show.o: In function `opentrace':
show.c:(.text+0x36): undefined reference to `freopen'
show.c:(.text+0x86): undefined reference to `setlinebuf'

Skip setlinebuf and use fclose/fopen inside SMALL.

Signed-off-by: maximilian attems <max@stro.at>
---
 src/show.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/show.c b/src/show.c
index 14dbef3..81e54ac 100644
--- a/src/show.c
+++ b/src/show.c
@@ -378,7 +378,11 @@ opentrace(void)
 	scopy("./trace", s);
 #endif /* not_this_way */
 	if (tracefile) {
+#ifndef SMALL
 		if (!freopen(s, "a", tracefile)) {
+#else
+		if (!(!fclose(tracefile) && (tracefile = fopen(s, "a")))) {
+#endif /* SMALL */
 			fprintf(stderr, "Can't re-open %s\n", s);
 			debug = 0;
 			return;
@@ -394,7 +398,9 @@ opentrace(void)
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

