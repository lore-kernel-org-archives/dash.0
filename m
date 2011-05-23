From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] avoid clang warning about dead store to "size"
Date: Mon, 23 May 2011 10:31:43 +0200
Message-ID: <878vtxrf68.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:40346 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973Ab1EWIbu (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 May 2011 04:31:50 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7D2B9940262
	for <dash@vger.kernel.org>; Mon, 23 May 2011 10:31:44 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I ran clang's scan-build on dash and it reported one nit:

ANALYZE: memalloc.c makestrspace
memalloc.c:276:9: warning: Value stored to 'size' during its initialization is never read
        size_t size = stackblocksize();
               ^      ~~~~~~~~~~~~~~~~


From f6fb674bab5afa22de4fcfb4a2debfa4d139c73c Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Mon, 23 May 2011 10:27:57 +0200
Subject: [PATCH] avoid clang warning about dead store to "size"

* src/memalloc.c (makestrspace): Remove dead store.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 ChangeLog      |    3 +++
 src/memalloc.c |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 56c5c3f..8725b08 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,8 +1,11 @@
 2011-05-23  Jim Meyering  <meyering@redhat.com>

+	avoid clang warning about dead store to "size"
+	* src/memalloc.c (makestrspace): Remove dead store.
+
 	avoid gcc warning: variable 'oldstackp' set but not used
 	* src/memalloc.c (growstackblock): Remove declaration and set of
 	set-but-not-used variable.  Also remove a stray space-before-TAB.

 2011-03-15  Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/memalloc.c b/src/memalloc.c
index 9fea067..d8e4413 100644
--- a/src/memalloc.c
+++ b/src/memalloc.c
@@ -270,13 +270,13 @@ growstackstr(void)
  */

 char *
 makestrspace(size_t newlen, char *p)
 {
 	size_t len = p - stacknxt;
-	size_t size = stackblocksize();
+	size_t size;

 	for (;;) {
 		size_t nleft;

 		size = stackblocksize();
 		nleft = size - len;
--
1.7.5.2.1.g56b30
