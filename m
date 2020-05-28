From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] shell: Enable fnmatch/glob by default
Date: Thu, 28 May 2020 22:57:52 +1000
Message-ID: <20200528125751.GA18863@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:36532 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389884AbgE1M5z (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 28 May 2020 08:57:55 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

As fnmatch(3) and glob(3) from glibc are now working consistently,
this patch enables them by default.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/configure.ac b/configure.ac
index dbd97d8..d73b2bf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,9 +37,10 @@ if test "$enable_static" = "yes"; then
 	export LDFLAGS="-static -Wl,--fatal-warnings"
 fi
 
-AC_ARG_ENABLE(fnmatch, AS_HELP_STRING(--enable-fnmatch, \
-				      [Use fnmatch(3) from libc]))
-AC_ARG_ENABLE(glob, AS_HELP_STRING(--enable-glob, [Use glob(3) from libc]))
+AC_ARG_ENABLE(fnmatch, AS_HELP_STRING(--disable-fnmatch, \
+				      [Do not use fnmatch(3) from libc]))
+AC_ARG_ENABLE(glob, AS_HELP_STRING(--disable-glob, \
+				   [Do not use glob(3) from libc]))
 
 dnl Checks for libraries.
 
@@ -122,12 +123,12 @@ if test "$enable_test_workaround" = "yes"; then
 		[Define if your faccessat tells root all files are executable])
 fi
 
-if test "$enable_fnmatch" = yes; then
+if test "$enable_fnmatch" != no; then
 	use_fnmatch=
 	AC_CHECK_FUNCS(fnmatch, use_fnmatch=yes)
 fi
 
-if test "$use_fnmatch" = yes && test "$enable_glob" = yes; then
+if test "$use_fnmatch" = yes && test "$enable_glob" != no; then
 	AC_CHECK_FUNCS(glob)
 fi
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
