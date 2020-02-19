From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH] Remove poplocalvars() always-zero argument, make it static
Date: Wed, 19 Feb 2020 17:39:13 +0100
Message-ID: <20200219163913.11951-1-dvlasenk@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43499 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726700AbgBSQjW (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 19 Feb 2020 11:39:22 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 src/var.c | 24 ++++--------------------
 src/var.h |  1 -
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/src/var.c b/src/var.c
index 0d7e1db..b146018 100644
--- a/src/var.c
+++ b/src/var.c
@@ -504,8 +504,8 @@ void mklocal(char *name, int flags)
  * Interrupts must be off.
  */
=20
-void
-poplocalvars(int keep)
+static void
+poplocalvars(void)
 {
 	struct localvar_list *ll;
 	struct localvar *lvp, *next;
@@ -522,23 +522,7 @@ poplocalvars(int keep)
 		next =3D lvp->next;
 		vp =3D lvp->vp;
 		TRACE(("poplocalvar %s\n", vp ? vp->text : "-"));
-		if (keep) {
-			int bits =3D VSTRFIXED;
-
-			if (lvp->flags !=3D VUNSET) {
-				if (vp->text =3D=3D lvp->text)
-					bits |=3D VTEXTFIXED;
-				else if (!(lvp->flags & (VTEXTFIXED|VSTACK)))
-					ckfree(lvp->text);
-			}
-
-			vp->flags &=3D ~bits;
-			vp->flags |=3D (lvp->flags & bits);
-
-			if ((vp->flags &
-			     (VEXPORT|VREADONLY|VSTRFIXED|VUNSET)) =3D=3D VUNSET)
-				unsetvar(vp->text);
-		} else if (vp =3D=3D NULL) {	/* $- saved */
+		if (vp =3D=3D NULL) {	/* $- saved */
 			memcpy(optlist, lvp->text, sizeof(optlist));
 			ckfree(lvp->text);
 			optschanged();
@@ -586,7 +570,7 @@ out:
 void unwindlocalvars(struct localvar_list *stop)
 {
 	while (localvar_stack !=3D stop)
-		poplocalvars(0);
+		poplocalvars();
 }
=20
=20
diff --git a/src/var.h b/src/var.h
index cd0477f..aa7575a 100644
--- a/src/var.h
+++ b/src/var.h
@@ -148,7 +148,6 @@ int exportcmd(int, char **);
 int localcmd(int, char **);
 void mklocal(char *name, int flags);
 struct localvar_list *pushlocalvars(int push);
-void poplocalvars(int);
 void unwindlocalvars(struct localvar_list *stop);
 int unsetcmd(int, char **);
 void unsetvar(const char *);
--=20
2.25.0
