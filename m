From: David Miller <davem@davemloft.net>
Subject: [PATCH 1/2] [SHELL] Allow building without LINEO support.
Date: Tue, 16 Aug 2011 17:45:02 -0700 (PDT)
Message-ID: <20110816.174502.2209127983953431973.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:53253 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab1HQApX (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 16 Aug 2011 20:45:23 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: herbert@gondor.hengli.com.au


Simply specify --disable-lineno to configure.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 configure.ac |    5 +++++
 src/var.c    |    4 ++++
 src/var.h    |    6 ++++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7eae954..96b6310 100644
--- a/configure.ac
+++ b/configure.ac
@@ -131,5 +131,10 @@ if test "$use_libedit" != "yes"; then
 else
 	export LIBS="$LIBS -ledit"
 fi
+AC_ARG_ENABLE(lineno, AS_HELP_STRING(--disable-lineno, \
+				     [Disable LINENO support]))
+if test "$enable_lineno" != "no"; then
+	AC_DEFINE([WITH_LINENO], 1, [Define if you build with -DWITH_LINENO])
+fi
 AC_CONFIG_FILES([Makefile src/Makefile])
 AC_OUTPUT
diff --git a/src/var.c b/src/var.c
index ecc8c90..027beff 100644
--- a/src/var.c
+++ b/src/var.c
@@ -101,7 +101,9 @@ struct var varinit[] = {
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS2=> ",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"PS4=+ ",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED,		"OPTIND=1",	getoptsreset },
+#ifdef WITH_LINENO
 	{ 0,	VSTRFIXED|VTEXTFIXED,		linenovar,	0 },
+#endif
 #ifndef SMALL
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"TERM\0",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"HISTSIZE\0",	sethistsize },
@@ -335,9 +337,11 @@ lookupvar(const char *name)
 	struct var *v;
 
 	if ((v = *findvar(hashvar(name), name)) && !(v->flags & VUNSET)) {
+#ifdef WITH_LINENO
 		if (v == &vlineno && v->text == linenovar) {
 			fmtstr(linenovar+7, sizeof(linenovar)-7, "%d", lineno);
 		}
+#endif
 		return strchrnul(v->text, '=') + 1;
 	}
 	return NULL;
diff --git a/src/var.h b/src/var.h
index 54f7b2d..79ee71a 100644
--- a/src/var.h
+++ b/src/var.h
@@ -88,9 +88,15 @@ extern struct var varinit[];
 #define vps2 (&vps1)[1]
 #define vps4 (&vps2)[1]
 #define voptind (&vps4)[1]
+#ifdef WITH_LINENO
 #define vlineno (&voptind)[1]
+#endif
 #ifndef SMALL
+#ifdef WITH_LINENO
 #define vterm (&vlineno)[1]
+#else
+#define vterm (&voptind)[1]
+#endif
 #define vhistsize (&vterm)[1]
 #endif
 
-- 
1.7.6.401.g6a319

