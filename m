From: maximilian attems <max@stro.at>
Subject: [PATCH] [klibc] dash: cd fix getpwd
Date: Fri,  2 Apr 2010 07:30:09 +0200
Message-ID: <1270186209-14582-1-git-send-email-max@stro.at>
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:48024 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab0DBFaT (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 Apr 2010 01:30:19 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>, dash@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, maximilian attems <max@stro.at>

On review of klibc dash changes:
"Hmm, this breaks the non-glibc case. You're now returning a pointer to a
string on the stack which is illegal." Herbert Xu

Use upstream dash way.

Signed-off-by: maximilian attems <max@stro.at>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
sorry for resend, mesed up previous sent.

 usr/dash/cd.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/usr/dash/cd.c b/usr/dash/cd.c
index 8a23110..ba9a1bc 100644
--- a/usr/dash/cd.c
+++ b/usr/dash/cd.c
@@ -253,12 +253,13 @@ getpwd()
 {
 #ifdef __GLIBC__
 	char *dir = getcwd(0, 0);
+	if (dir)
+		return dir;
 #else
 	char buf[PATH_MAX];
-	char *dir = getcwd(buf, sizeof(buf));
+	if(getcwd(buf, sizeof(buf)))
+		return savestr(buf);
 #endif
-	if (dir)
-		return dir;
 	sh_warnx("getcwd() failed: %s", strerror(errno));
 	return nullstr;
 }
-- 
1.7.0.3

