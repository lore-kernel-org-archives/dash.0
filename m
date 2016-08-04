From: Kylie McClain <somasissounds@gmail.com>
Subject: [PATCH 2/2] histedit: Remove non-glibc fallback code
Date: Thu,  4 Aug 2016 01:54:11 -0400
Message-ID: <20160804055411.23558-2-somasissounds@gmail.com>
References: <20160804055411.23558-1-somasissounds@gmail.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34565 "EHLO
	mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcHDGLj (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 4 Aug 2016 02:11:39 -0400
Received: by mail-qt0-f194.google.com with SMTP id c52so12322633qte.1
        for <dash@vger.kernel.org>; Wed, 03 Aug 2016 23:11:16 -0700 (PDT)
In-Reply-To: <20160804055411.23558-1-somasissounds@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Kylie McClain <somasis@exherbo.org>

From: Kylie McClain <somasis@exherbo.org>

This fallback code seems to go back the import of the repository back in 2005,
it fails on musl libc, and there aren't any comments explaining why this
difference is needed. Regardless, any compatibility ifdefs should probably be
checking macros defined on systems that need a different code path, rather than
just having fallback code for non-glibc.
---
 src/histedit.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/histedit.c b/src/histedit.c
index 94465d7..4498cf4 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -214,11 +214,7 @@ histcmd(int argc, char **argv)
 	if (argc == 1)
 		sh_error("missing history argument");
 
-#ifdef __GLIBC__
 	optind = 0;
-#else
-	optreset = 1; optind = 1; /* initialize getopt */
-#endif
 	while (not_fcnumber(argv[optind]) &&
 	      (ch = getopt(argc, argv, ":e:lnrs")) != -1)
 		switch ((char)ch) {
-- 
2.9.0

