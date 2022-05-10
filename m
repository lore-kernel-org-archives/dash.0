Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DFEC433F5
	for <linux-dash@archiver.kernel.org>; Tue, 10 May 2022 08:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiEJIki (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 10 May 2022 04:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiEJIke (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 10 May 2022 04:40:34 -0400
X-Greylist: delayed 1178 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 May 2022 01:36:37 PDT
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E8E1FB2D6
        for <dash@vger.kernel.org>; Tue, 10 May 2022 01:36:36 -0700 (PDT)
Received: from [2001:470:6ccc:1::4] (port=57892 helo=argus.frippery.org)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <rmy@frippery.org>)
        id 1noL3D-00050y-Sz
        for dash@vger.kernel.org; Tue, 10 May 2022 09:17:04 +0100
Received: by argus.frippery.org (Postfix, from userid 1000)
        id C91DC6012; Tue, 10 May 2022 09:16:55 +0100 (BST)
Date:   Tue, 10 May 2022 09:16:55 +0100
From:   Ron Yorston <rmy@frippery.org>
To:     dash@vger.kernel.org
Subject: [PATCH] var: move hashvar() calls into findvar()
Message-ID: <627a1f77.3CLq0J9mI6V6UePB%rmy@frippery.org>
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 9
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

The first argument to findvar() is always obtained by a call to
hashvar(), the return value of which is otherwise unused.

Signed-off-by: Ron Yorston <rmy@frippery.org>
---
 src/var.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/src/var.c b/src/var.c
index ef9c2bd..e301fe5 100644
--- a/src/var.c
+++ b/src/var.c
@@ -107,7 +107,7 @@ STATIC struct var *vartab[VTABSIZE];
 
 STATIC struct var **hashvar(const char *);
 STATIC int vpcmp(const void *, const void *);
-STATIC struct var **findvar(struct var **, const char *);
+STATIC struct var **findvar(const char *);
 
 /*
  * Initialize the varable symbol tables and import the environment
@@ -247,9 +247,8 @@ struct var *setvareq(char *s, int flags)
 {
 	struct var *vp, **vpp;
 
-	vpp = hashvar(s);
 	flags |= (VEXPORT & (((unsigned) (1 - aflag)) - 1));
-	vpp = findvar(vpp, s);
+	vpp = findvar(s);
 	vp = *vpp;
 	if (vp) {
 		if (vp->flags & VREADONLY) {
@@ -311,7 +310,7 @@ lookupvar(const char *name)
 {
 	struct var *v;
 
-	if ((v = *findvar(hashvar(name), name)) && !(v->flags & VUNSET)) {
+	if ((v = *findvar(name)) && !(v->flags & VUNSET)) {
 #ifdef WITH_LINENO
 		if (v == &vlineno && v->text == linenovar) {
 			fmtstr(linenovar+7, sizeof(linenovar)-7, "%d", lineno);
@@ -418,7 +417,7 @@ exportcmd(int argc, char **argv)
 			if ((p = strchr(name, '=')) != NULL) {
 				p++;
 			} else {
-				if ((vp = *findvar(hashvar(name), name))) {
+				if ((vp = *findvar(name))) {
 					vp->flags |= flag;
 					continue;
 				}
@@ -462,7 +461,6 @@ localcmd(int argc, char **argv)
 void mklocal(char *name, int flags)
 {
 	struct localvar *lvp;
-	struct var **vpp;
 	struct var *vp;
 
 	INTOFF;
@@ -475,8 +473,7 @@ void mklocal(char *name, int flags)
 	} else {
 		char *eq;
 
-		vpp = hashvar(name);
-		vp = *findvar(vpp, name);
+		vp = *findvar(name);
 		eq = strchr(name, '=');
 		if (vp == NULL) {
 			if (eq)
@@ -663,9 +660,11 @@ vpcmp(const void *a, const void *b)
 }
 
 STATIC struct var **
-findvar(struct var **vpp, const char *name)
+findvar(const char *name)
 {
-	for (; *vpp; vpp = &(*vpp)->next) {
+	struct var **vpp;
+
+	for (vpp = hashvar(name); *vpp; vpp = &(*vpp)->next) {
 		if (varequal((*vpp)->text, name)) {
 			break;
 		}
-- 
2.35.3

