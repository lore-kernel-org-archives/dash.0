From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 3/9] [OUTPUT] Add likely tag in outmem
Date: Mon, 27 Oct 2014 16:26:57 +0800
Message-ID: <E1Xifdh-0001hJ-18@gondolin.me.apana.org.au>
References: <20141027082546.GA6447@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:59354 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbaJ0I1A (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Oct 2014 04:27:00 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1Xifdh-0006Ir-Jw
	for <dash@vger.kernel.org>; Mon, 27 Oct 2014 19:26:57 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

The branch in outmem where the string fits in the buffer is the
common case and is now marked as likely.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog    |    1 +
 src/output.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/ChangeLog b/ChangeLog
index e6d6cbf..9d2dc7c 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -3,6 +3,7 @@
 	* Add printf support for format string a, A, and F.
 	* Handle embedded NULs correctly in printf.
 	* Replace open-coded flushall in preadbuffer.
+	* Add likely tag in outmem.
 
 2014-10-13  Eric Blake <eblake@redhat.com>
 
diff --git a/src/output.c b/src/output.c
index 1b20850..3e1ae25 100644
--- a/src/output.c
+++ b/src/output.c
@@ -144,7 +144,7 @@ outmem(const char *p, size_t len, struct output *dest)
 	size_t nleft;
 
 	nleft = dest->end - dest->nextc;
-	if (nleft >= len) {
+	if (likely(nleft >= len)) {
 buffered:
 		dest->nextc = mempcpy(dest->nextc, p, len);
 		return;
