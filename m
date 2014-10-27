From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 2/9] [INPUT] Replace open-coded flushall in preadbuffer
Date: Mon, 27 Oct 2014 16:26:56 +0800
Message-ID: <E1Xifdg-0001h3-EK@gondolin.me.apana.org.au>
References: <20141027082546.GA6447@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:35497 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbaJ0I07 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Oct 2014 04:26:59 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1Xifdh-0006Ij-4e
	for <dash@vger.kernel.org>; Mon, 27 Oct 2014 19:26:57 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog   |    1 +
 src/input.c |    5 +----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 379672f..e6d6cbf 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -2,6 +2,7 @@
 
 	* Add printf support for format string a, A, and F.
 	* Handle embedded NULs correctly in printf.
+	* Replace open-coded flushall in preadbuffer.
 
 2014-10-13  Eric Blake <eblake@redhat.com>
 
diff --git a/src/input.c b/src/input.c
index 9e533a4..f11ac84 100644
--- a/src/input.c
+++ b/src/input.c
@@ -245,10 +245,7 @@ preadbuffer(void)
 	}
 	if (unlikely(parsenleft == EOF_NLEFT || parsefile->buf == NULL))
 		return PEOF;
-	flushout(&output);
-#ifdef FLUSHERR
-	flushout(&errout);
-#endif
+	flushall();
 
 	more = parselleft;
 	if (more <= 0) {
