From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 3/4] [VAR] Move unsetvar functionality into setvareq
Date: Wed, 26 May 2010 21:00:33 +1000
Message-ID: <E1OHELh-0006sn-L0@gondolin.me.apana.org.au>
References: <20100526105948.GA26352@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:34515 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750727Ab0EZLAj (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 26 May 2010 07:00:39 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Geoff Clare <gwc@opengroup.org>, dash@vger.kernel.org, pape@smarden.org

[VAR] Move unsetvar functionality into setvareq

This patch moves the unsetvar code into setvareq so that we can
no have a pathological case of an unset variable hanging around
unless it has a bit pinning it like VEXPORT.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog |    1 +
 src/var.c |   54 +++++++++++++++++-------------------------------------
 src/var.h |    2 +-
 3 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index f3c7701..1f7120f 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2010-05-25  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix poplocalvar leak.
+	* Move unsetvar functionality into setvareq.
 
 2010-05-24  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/var.c b/src/var.c
index fc6d367..12f2f6c 100644
--- a/src/var.c
+++ b/src/var.c
@@ -266,10 +266,22 @@ setvareq(char *s, int flags)
 		if ((vp->flags & (VTEXTFIXED|VSTACK)) == 0)
 			ckfree(vp->text);
 
+		if (((flags & (VEXPORT|VREADONLY|VSTRFIXED|VUNSET)) |
+		     (vp->flags & VSTRFIXED)) == VUNSET) {
+			*vpp = vp->next;
+			ckfree(vp);
+out_free:
+			if ((flags & (VTEXTFIXED|VSTACK|VNOSAVE)) == VNOSAVE)
+				ckfree(s);
+			return;
+		}
+
 		flags |= vp->flags & ~(VTEXTFIXED|VSTACK|VNOSAVE|VUNSET);
 	} else {
 		if (flags & VNOSET)
 			return;
+		if ((flags & (VEXPORT|VREADONLY|VSTRFIXED|VUNSET)) == VUNSET)
+			goto out_free;
 		/* not found */
 		vp = ckmalloc(sizeof (*vp));
 		vp->next = *vpp;
@@ -588,7 +600,6 @@ unsetcmd(int argc, char **argv)
 	char **ap;
 	int i;
 	int flag = 0;
-	int ret = 0;
 
 	while ((i = nextopt("vf")) != '\0') {
 		flag = i;
@@ -596,15 +607,13 @@ unsetcmd(int argc, char **argv)
 
 	for (ap = argptr; *ap ; ap++) {
 		if (flag != 'f') {
-			i = unsetvar(*ap);
-			ret |= i;
-			if (!(i & 2))
-				continue;
+			unsetvar(*ap);
+			continue;
 		}
 		if (flag != 'v')
 			unsetfunc(*ap);
 	}
-	return ret & 1;
+	return 0;
 }
 
 
@@ -612,38 +621,9 @@ unsetcmd(int argc, char **argv)
  * Unset the specified variable.
  */
 
-int
-unsetvar(const char *s)
+void unsetvar(const char *s)
 {
-	struct var **vpp;
-	struct var *vp;
-	int retval;
-
-	vpp = findvar(hashvar(s), s);
-	vp = *vpp;
-	retval = 2;
-	if (vp) {
-		int flags = vp->flags;
-
-		retval = 1;
-		if (flags & VREADONLY)
-			goto out;
-		if ((flags & VSTRFIXED) == 0) {
-			INTOFF;
-			if ((flags & (VTEXTFIXED|VSTACK)) == 0)
-				ckfree(vp->text);
-			*vpp = vp->next;
-			ckfree(vp);
-			INTON;
-		} else if (!(flags & VUNSET)) {
-			setvar(s, 0, 0);
-			vp->flags &= ~VEXPORT;
-		}
-		retval = 0;
-	}
