From: Mike Gilbert <floppym@gentoo.org>
Subject: [PATCH] input: Fix compiling against libedit with -fno-common
Date: Sat,  2 May 2020 14:37:06 -0400
Message-ID: <20200502183706.2719782-1-floppym@gentoo.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:39488 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbgEBShi (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 2 May 2020 14:37:38 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jeroen Roovers <jer@gentoo.org>, Mike Gilbert <floppym@gentoo.org>

From: Jeroen Roovers <jer@gentoo.org>

With -fno-common, which will be enabled by default in GCC 10, we see
this error:

ld: input.o:(.bss+0x0): multiple definition of `el';
histedit.o:(.bss+0x8): first defined here

To fix this, simply remove the definition as it is not needed.

Signed-off-by: Jeroen Roovers <jer@gentoo.org>
Signed-off-by: Mike Gilbert <floppym@gentoo.org>
---
 src/input.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/input.c b/src/input.c
index ae0c4c8..e84eca8 100644
--- a/src/input.c
+++ b/src/input.c
@@ -67,10 +67,6 @@ MKINIT char basebuf[IBUFSIZ];	/* buffer for top level input file */
 struct parsefile *parsefile = &basepf;	/* current input file */
 int whichprompt;		/* 1 == PS1, 2 == PS2 */
 
-#ifndef SMALL
-EditLine *el;			/* cookie for editline package */
-#endif
-
 STATIC void pushfile(void);
 static int preadfd(void);
 static void setinputfd(int fd, int push);
-- 
2.25.1
