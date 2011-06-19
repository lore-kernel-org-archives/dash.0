From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] setvareq: do not return a freed pointer
Date: Sun, 19 Jun 2011 21:30:41 +0200
Message-ID: <8739j5aaam.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:35271 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754196Ab1FSTa4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 19 Jun 2011 15:30:56 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id D139194013C
	for <dash@vger.kernel.org>; Sun, 19 Jun 2011 21:30:42 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This change may be technically unnecessary, but it's worth
the minuscule cost of the initialization.

2011-06-19  Jim Meyering  <meyering@redhat.com>

	setvareq: do not return a freed pointer
	* src/var.c (setvareq): Don't return a freed pointer.
	In at least one case (when called from unsetvar), the return
	value is not used, but better not to risk it, and to placate
	static analyzers.  Spotted by coverity.
	Exercise via dash -c 'j=; unset j'

From e91caa66e9f1e449e5ea129d2c1e304e66784e2f Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Sun, 19 Jun 2011 21:28:02 +0200
Subject: [PATCH] setvareq: do not return a freed pointer

* src/var.c (setvareq): Don't return a freed pointer.
In at least one case (when called from unsetvar), the return
value is not used, but better not to risk it, and to placate
static analyzers.  Spotted by coverity.
Exercise via dash -c 'j=; unset j'

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 ChangeLog |    9 +++++++++
 src/var.c |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/var.c b/src/var.c
index ecc8c90..34c5d32 100644
--- a/src/var.c
+++ b/src/var.c
@@ -276,6 +276,7 @@ struct var *setvareq(char *s, int flags)
 		     (vp->flags & VSTRFIXED)) == VUNSET) {
 			*vpp = vp->next;
 			ckfree(vp);
+			vp = NULL;
 out_free:
 			if ((flags & (VTEXTFIXED|VSTACK|VNOSAVE)) == VNOSAVE)
 				ckfree(s);
--
1.7.6.rc2.4.g36bfb.dirty
