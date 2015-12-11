From: Jonathan Perkin <jperkin@joyent.com>
Subject: [PATCH] [SHELL] Fix 64-bit Solaris build
Date: Fri, 11 Dec 2015 13:07:14 +0000
Message-ID: <20151211130714.GD54973@joyent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34069 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbbLKNHW (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 11 Dec 2015 08:07:22 -0500
Received: by mail-wm0-f50.google.com with SMTP id c17so10955389wmd.1
        for <dash@vger.kernel.org>; Fri, 11 Dec 2015 05:07:22 -0800 (PST)
Received: from joyent.com (host86-144-234-20.range86-144.btcentralplus.com. [86.144.234.20])
        by smtp.gmail.com with ESMTPSA id t64sm3306298wmf.23.2015.12.11.05.07.18
        for <dash@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Dec 2015 05:07:20 -0800 (PST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

In a 64-bit Solaris environment there is no stat64() function, only
stat().  This conflicts with the stat64 #define used to support
dietlibc/klibc when stat64() is not found and results in:

  ./../config.h:194:16: error: redefinition of 'struct stat'
   #define stat64 stat
                ^
  In file included from cd.c:36:0:
  /usr/include/sys/stat.h:217:8: note: originally defined here
   struct stat {
          ^

Instead, add a AC_CHECK_DECL test for stat64, and only perform the
AC_CHECK_FUNC test if it isn't already defined.
---
 configure.ac | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8ae0dc6..f4c9b87 100644
--- a/configure.ac
+++ b/configure.ac
@@ -139,10 +139,12 @@ if test "$ac_cv_func_signal" != yes; then
 fi
 
 dnl Check for stat64 (dietlibc/klibc).
-AC_CHECK_FUNC(stat64,, [
-	AC_DEFINE(fstat64, fstat, [64-bit operations are the same as 32-bit])
-	AC_DEFINE(lstat64, lstat, [64-bit operations are the same as 32-bit])
-	AC_DEFINE(stat64, stat, [64-bit operations are the same as 32-bit])
+AC_CHECK_DECL(stat64,,[
+	AC_CHECK_FUNC(stat64,, [
+		AC_DEFINE(fstat64, fstat, [64-bit operations are the same as 32-bit])
+		AC_DEFINE(lstat64, lstat, [64-bit operations are the same as 32-bit])
+		AC_DEFINE(stat64, stat, [64-bit operations are the same as 32-bit])
+	])
 ])
 
 AC_CHECK_FUNC(open64,, [
-- 
2.4.9 (Apple Git-60)

-- 
Jonathan Perkin  -  Joyent, Inc.  -  www.joyent.com
