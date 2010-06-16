From: Brian Koropoff <bkoropoff@gmail.com>
Subject: [PATCH] Fix regression when unsetting variables.
Date: Tue, 15 Jun 2010 19:29:58 -0700
Message-ID: <1276655398.16819.26.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59278 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068Ab0FPCbv (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 15 Jun 2010 22:31:51 -0400
Received: by pva4 with SMTP id 4so441779pva.19
        for <dash@vger.kernel.org>; Tue, 15 Jun 2010 19:31:51 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

When removing a variable from its hash chain, assign to the 'next' pointer
of the previous link rather than the hash bucket.
---
 src/var.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/var.c b/src/var.c
index f456fbd..c0e5706 100644
--- a/src/var.c
+++ b/src/var.c
@@ -238,11 +238,11 @@ intmax_t setvarint(const char *name, intmax_t val, int flags)
 void
 setvareq(char *s, int flags)
 {
-	struct var *vp, **vpp;
+	struct var *vp, **vpp, **fvpp;
 
 	vpp = hashvar(s);
 	flags |= (VEXPORT & (((unsigned) (1 - aflag)) - 1));
-	vp = *findvar(vpp, s);
+	vp = *(fvpp = findvar(vpp, s));
 	if (vp) {
 		if (vp->flags & VREADONLY) {
 			const char *n;
@@ -265,7 +265,7 @@ setvareq(char *s, int flags)
 
 		if (((flags & (VEXPORT|VREADONLY|VSTRFIXED|VUNSET)) |
 		     (vp->flags & VSTRFIXED)) == VUNSET) {
-			*vpp = vp->next;
+			*fvpp = vp->next;
 			ckfree(vp);
 out_free:
 			if ((flags & (VTEXTFIXED|VSTACK|VNOSAVE)) == VNOSAVE)
-- 
1.7.0.4


