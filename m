From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH] Remove unused expandmeta() flag parameter
Date: Wed, 29 Apr 2020 08:29:53 +0200
Message-ID: <20200429062953.19042-1-dvlasenk@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41633 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726158AbgD2GaI (ORCPT
        <rfc822;dash@vger.kernel.org>); Wed, 29 Apr 2020 02:30:08 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 src/expand.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/expand.c b/src/expand.c
index 4a5d75a..985cd70 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -118,7 +118,7 @@ STATIC char *evalvar(char *, int);
 static size_t strtodest(const char *p, int flags);
 static size_t memtodest(const char *p, size_t len, int flags);
 STATIC ssize_t varvalue(char *, int, int, int);
-STATIC void expandmeta(struct strlist *, int);
+STATIC void expandmeta(struct strlist *);
 #ifdef HAVE_GLOB
 STATIC void addglob(const glob_t *);
 #else
@@ -205,7 +205,7 @@ expandarg(union node *arg, struct arglist *arglist, i=
nt flag)
 		ifsbreakup(p, -1, &exparg);
 		*exparg.lastp =3D NULL;
 		exparg.lastp =3D &exparg.list;
-		expandmeta(exparg.list, flag);
+		expandmeta(exparg.list);
 	} else {
 		sp =3D (struct strlist *)stalloc(sizeof (struct strlist));
 		sp->text =3D p;
@@ -1155,9 +1155,7 @@ out:
=20
 #ifdef HAVE_GLOB
 STATIC void
-expandmeta(str, flag)
-	struct strlist *str;
-	int flag;
+expandmeta(struct strlist *str)
 {
 	/* TODO - EXP_REDIR */
=20
@@ -1221,7 +1219,7 @@ STATIC unsigned expdir_max;
=20
=20
 STATIC void
-expandmeta(struct strlist *str, int flag)
+expandmeta(struct strlist *str)
 {
 	static const char metachars[] =3D {
 		'*', '?', '[', 0
--=20
2.25.0
