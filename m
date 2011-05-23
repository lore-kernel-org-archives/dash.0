From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] avoid gcc warning: variable 'oldstackp' set but not used
Date: Mon, 23 May 2011 10:20:12 +0200
Message-ID: <87ei3prfpf.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:59404 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677Ab1EWIUY (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 May 2011 04:20:24 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 794F6940268
	for <dash@vger.kernel.org>; Mon, 23 May 2011 10:20:14 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Compiling with gcc-4.6.0, I noticed a new warning.
This fixes it:


From 6c4c5e33e9143946335e2adc952ea250e474926b Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Mon, 23 May 2011 10:18:27 +0200
Subject: [PATCH] avoid gcc warning: variable 'oldstackp' set but not used

* src/memalloc.c (growstackblock): Remove declaration and set of
set-but-not-used variable.  Also remove a stray space-before-TAB.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 ChangeLog      |    6 ++++++
 src/memalloc.c |    4 +---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 50a8044..56c5c3f 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,9 @@
+2011-05-23  Jim Meyering  <meyering@redhat.com>
+
+	avoid gcc warning: variable 'oldstackp' set but not used
+	* src/memalloc.c (growstackblock): Remove declaration and set of
+	set-but-not-used variable.  Also remove a stray space-before-TAB.
+
 2011-03-15  Herbert Xu <herbert@gondor.apana.org.au>

 	* Fix clobbering of checkkwd.
diff --git a/src/memalloc.c b/src/memalloc.c
index e75e609..9fea067 100644
--- a/src/memalloc.c
+++ b/src/memalloc.c
@@ -206,20 +206,18 @@ growstackblock(void)
 {
 	size_t newlen;

- 	newlen = stacknleft * 2;
+	newlen = stacknleft * 2;
 	if (newlen < stacknleft)
 		sh_error("Out of space");
 	if (newlen < 128)
 		newlen += 128;

 	if (stacknxt == stackp->space && stackp != &stackbase) {
-		struct stack_block *oldstackp;
 		struct stack_block *sp;
 		struct stack_block *prevstackp;
 		size_t grosslen;

 		INTOFF;
-		oldstackp = stackp;
 		sp = stackp;
 		prevstackp = sp->prev;
 		grosslen = newlen + sizeof(struct stack_block) - MINSIZE;
--
1.7.5.2.1.g56b30
