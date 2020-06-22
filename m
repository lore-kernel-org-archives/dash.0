From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] Don't include config.h when building helpers using the native compiler
Date: Mon, 22 Jun 2020 07:25:13 +0200
Message-ID: <20200622052513.1850288-1-fontaine.fabrice@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgFVFZT (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 22 Jun 2020 01:25:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC67DC061794
        for <dash@vger.kernel.org>; Sun, 21 Jun 2020 22:25:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so48145wmi.3
        for <dash@vger.kernel.org>; Sun, 21 Jun 2020 22:25:18 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>, Peter Korsgaard <jacmet@sunsite.dk>

config.h contains settings for the cross compiler (most importantly
32/64bit versions of functions), so don't include it when calling the
native compiler to build the helpers.

Otherwise we get build errors like:

/usr/bin/gcc -include ../config.h -DBSD=1 -DSHELL -DIFS_BROKEN  -g -O2 -Wall    -o mkinit mkinit.c
In file included from /usr/include/sys/stat.h:107,
                 from /usr/include/fcntl.h:38,
                 from mkinit.c:50:
/usr/include/bits/stat.h:117: error: redefinition of ‘struct stat’
In file included from /usr/include/fcntl.h:38,
                 from mkinit.c:50:
/usr/include/sys/stat.h:504: error: redefinition of ‘stat’
/usr/include/sys/stat.h:455: note: previous definition of ‘stat’ was here

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
[Retrieved from:
https://git.buildroot.net/buildroot/tree/package/dash/0001-no-config.h-for-helpers.patch]
Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 src/Makefile.am | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index 1732465..3b1b54e 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -7,7 +7,6 @@ COMMON_CPPFLAGS = \
 AM_CFLAGS = $(COMMON_CFLAGS)
 AM_CPPFLAGS = -include $(top_builddir)/config.h $(COMMON_CPPFLAGS)
 AM_CFLAGS_FOR_BUILD = -g -O2 $(COMMON_CFLAGS) 
-AM_CPPFLAGS_FOR_BUILD = $(COMMON_CPPFLAGS)
 
 COMPILE_FOR_BUILD = \
 	$(CC_FOR_BUILD) $(DEFAULT_INCLUDES) $(AM_CPPFLAGS_FOR_BUILD) \
-- 
2.26.2
