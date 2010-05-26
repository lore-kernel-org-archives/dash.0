From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 2/4] [VAR] Fix poplocalvar leak
Date: Wed, 26 May 2010 21:00:32 +1000
Message-ID: <E1OHELg-0006sc-H8@gondolin.me.apana.org.au>
References: <20100526105948.GA26352@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:34513 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750727Ab0EZLAi (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 26 May 2010 07:00:38 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Geoff Clare <gwc@opengroup.org>, dash@vger.kernel.org, pape@smarden.org

[VAR] Fix poplocalvar leak

When a variable is marked as local, we set VSTRFIXED on its vp
recored.  However, poplocalvar never clears this flag for variables
that were unset to begin with.  Thus if you ever made an unset
variable local, it would get the VSTRFIXED bit and stick around
forever.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog |    4 ++++
 src/var.c |    8 +++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 7285a23..f3c7701 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-05-25  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix poplocalvar leak.
+
 2010-05-24  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Add localvars nesting.
diff --git a/src/var.c b/src/var.c
index de1a5f5..fc6d367 100644
--- a/src/var.c
+++ b/src/var.c
@@ -543,7 +543,8 @@ poplocalvars(void)
 			memcpy(optlist, lvp->text, sizeof(optlist));
 			ckfree(lvp->text);
 			optschanged();
-		} else if ((lvp->flags & (VUNSET|VSTRFIXED)) == VUNSET) {
+		} else if (lvp->flags == VUNSET) {
+			vp->flags &= ~(VSTRFIXED|VREADONLY);
 			unsetvar(vp->text);
 		} else {
 			if (vp->func)
@@ -627,8 +628,6 @@ unsetvar(const char *s)
 		retval = 1;
 		if (flags & VREADONLY)
 			goto out;
-		if (flags & VUNSET)
-			goto ok;
 		if ((flags & VSTRFIXED) == 0) {
 			INTOFF;
 			if ((flags & (VTEXTFIXED|VSTACK)) == 0)
@@ -636,11 +635,10 @@ unsetvar(const char *s)
 			*vpp = vp->next;
 			ckfree(vp);
 			INTON;
-		} else {
+		} else if (!(flags & VUNSET)) {
 			setvar(s, 0, 0);
 			vp->flags &= ~VEXPORT;
 		}
-ok:
 		retval = 0;
 	}
 
