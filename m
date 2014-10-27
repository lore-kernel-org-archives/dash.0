From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4/9] [OUTPUT] Add ifdefs around MEM_OUT handling in outmem
Date: Mon, 27 Oct 2014 16:26:57 +0800
Message-ID: <E1Xifdh-0001hc-HM@gondolin.me.apana.org.au>
References: <20141027082546.GA6447@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:45137 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbaJ0I1A (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Oct 2014 04:27:00 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1Xifdi-0006Iz-1w
	for <dash@vger.kernel.org>; Mon, 27 Oct 2014 19:26:58 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

MEM_OUT is only used by forkless backtick processing which we do
not currently support.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog    |    1 +
 src/output.c |    6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/ChangeLog b/ChangeLog
index 9d2dc7c..47ba519 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -4,6 +4,7 @@
 	* Handle embedded NULs correctly in printf.
 	* Replace open-coded flushall in preadbuffer.
 	* Add likely tag in outmem.
+	* Add ifdefs around MEM_OUT handling in outmem.
 
 2014-10-13  Eric Blake <eblake@redhat.com>
 
diff --git a/src/output.c b/src/output.c
index 3e1ae25..4d3b4c2 100644
--- a/src/output.c
+++ b/src/output.c
@@ -154,10 +154,13 @@ buffered:
 	if (!bufsize) {
 		;
 	} else if (dest->buf == NULL) {
+#ifdef notyet
 		if (dest->fd == MEM_OUT && len > bufsize) {
 			bufsize = len;
 		}
+#endif
 		offset = 0;
+#ifdef notyet
 		goto alloc;
 	} else if (dest->fd == MEM_OUT) {
 		offset = bufsize;
@@ -169,6 +172,7 @@ buffered:
 		if (bufsize < offset)
 			goto err;
 alloc:
+#endif
 		INTOFF;
 		dest->buf = ckrealloc(dest->buf, bufsize);
 		dest->bufsize = bufsize;
@@ -184,7 +188,9 @@ alloc:
 		goto buffered;
 
 	if ((xwrite(dest->fd, p, len))) {
+#ifdef notyet
 err:
+#endif
 		dest->flags |= OUTPUT_ERR;
 	}
 #endif
