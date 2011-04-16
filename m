From: Brian Koropoff <bkoropoff@gmail.com>
Subject: [PATCH 2/2] Port to HP-UX
Date: Fri, 15 Apr 2011 19:34:42 -0700
Message-ID: <1302921282.2620.7.camel@gemini>
References: <1302921010.2620.3.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56259 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab1DPCeo (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 15 Apr 2011 22:34:44 -0400
Received: by pzk9 with SMTP id 9so1232430pzk.19
        for <dash@vger.kernel.org>; Fri, 15 Apr 2011 19:34:43 -0700 (PDT)
In-Reply-To: <1302921010.2620.3.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

- strtoimax and strtoumax are macros and not functions,
   so switch to using AC_CHECK_DECLS in configure.ac
   to find them.

 - HP-UX lacks strsignal() and sys_siglist.  Check for
   sys_siglist in configure.ac and #ifdef around it.

 - HP-UX's vsnprintf() completely violates the standard
   by returning -1 (and neglecting to set errno) if the
   buffer is not large enough rather than returning the
   size necessary.  Work around it by (yuck) reallocating
   a dynamic buffer until it succeeds so we can return
   the expected result.

 - HP-UX needs _LARGEFILE64_SOURCE to be defined for open64()
   and friends to be available.  This seems to be safe to
   define everywhere, so do so.

 - The nl program doesn't like spaces between flags and their
   arguments, so remove them in mkbuiltins.

Signed-off-by: Brian Koropoff <bkoropoff@gmail.com>
---
 configure.ac   |   18 +++++++++++++++---
 src/mkbuiltins |    2 +-
 src/output.c   |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/system.c   |    2 ++
 src/system.h   |    4 ++--
 5 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index effdffc..ad09947 100644
--- a/configure.ac
+++ b/configure.ac
@@ -9,6 +9,8 @@ AC_PROG_CC
 AC_GNU_SOURCE
 AC_PROG_YACC
 
+AC_DEFINE([_LARGEFILE64_SOURCE],[1],[Always define])
+
 AC_MSG_CHECKING([for build system compiler])
 if test "$cross_compiling" = yes; then
 	CC_FOR_BUILD=${CC_FOR_BUILD-cc}
@@ -43,7 +45,7 @@ AC_ARG_ENABLE(glob, AS_HELP_STRING(--enable-glob, [Use glob(3) from libc]))
 dnl Checks for libraries.
 
 dnl Checks for header files.
-AC_CHECK_HEADERS(alloca.h paths.h)
+AC_CHECK_HEADERS(alloca.h paths.h unistd.h signal.h)
 
 dnl Check for declarations
 AC_CHECK_DECL([_PATH_BSHELL],,AC_DEFINE_UNQUOTED([_PATH_BSHELL], "/bin/sh", [Define to system shell path]),[
@@ -84,11 +86,21 @@ AC_CHECK_DECL([PRIdMAX],,
 #include <inttypes.h>
 ])
 
+dnl strtoimax is a macro on some systems
+AC_CHECK_DECLS([strtoimax, strtoumax],,,[#include <inttypes.h>])
+
+dnl Check for sys_siglist
+AC_CHECK_DECLS([sys_siglist], [], [],
+          [#include <signal.h>
+          #ifdef HAVE_UNISTD_H
+          # include <unistd.h>
+          #endif
+          ])
+
 dnl Checks for library functions.
 AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit imaxdiv isalpha killpg \
 	       mempcpy \
-	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
-	       strtoumax sysconf)
+	       sigsetmask stpcpy strchrnul strsignal strtod sysconf)
 
 if test "$enable_fnmatch" = yes; then
 	use_fnmatch=
diff --git a/src/mkbuiltins b/src/mkbuiltins
index f562ae2..a0dd66d 100644
--- a/src/mkbuiltins
+++ b/src/mkbuiltins
@@ -97,7 +97,7 @@ cat <<\!
  */
 
 !
-sed 's/	-[a-z]*//' $temp2 | nl -b a -v 0 | LC_COLLATE=C sort -u -k 3,3 |
+sed 's/	-[a-z]*//' $temp2 | nl -ba -v0 | LC_COLLATE=C sort -u -k 3,3 |
 tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ |
 	awk '{	printf "#define %s (builtincmd + %d)\n", $3, $1}'
 printf '\n#define NUMBUILTINS %d\n' $(wc -l < $temp2)
diff --git a/src/output.c b/src/output.c
index f62e7ea..4134a85 100644
--- a/src/output.c
+++ b/src/output.c
@@ -372,6 +372,56 @@ __closememout(void) {
 #endif
 #endif
 
+#ifdef __hpux
+static int
+xvsnprintf(char *outbuf, size_t length, const char *fmt, va_list ap)
+{
+	int ret;
+	char* dummy = NULL;
+	char* dummy_new = NULL;
+	size_t dummy_len = 8;
+	va_list ap_mine;
+
+	if (length > 0) {
+		INTOFF;
+		va_copy(ap_mine, ap);
+                errno = 0;
+		ret = vsnprintf(outbuf, length, fmt, ap_mine);
+		va_end(ap_mine);
+		INTON;
+	} else {
+		ret = -1;
+		errno = 0;
+	}
+
+	if (ret < 0 && errno == 0) {
+		do {
+			dummy_len *= 2;
+			dummy_new = realloc(dummy, dummy_len);
+			if (!dummy_new) {
+				ret = -1;
+				errno = ENOMEM;
+				break;
+			}
+			dummy = dummy_new;
+			INTOFF;
+			va_copy(ap_mine, ap);
+                        errno = 0;
+			ret = vsnprintf(dummy, dummy_len, fmt, ap_mine);
+			va_end(ap_mine);
+			INTON;
+		} while (ret < 0 && errno == 0);
+
+		if (ret >= 0 && length) {
+			memcpy(outbuf, dummy, length);
+		}
+		if (dummy) free(dummy);
+	}
+
+	return ret;
+}
+
+#else
 
 static int
 xvsnprintf(char *outbuf, size_t length, const char *fmt, va_list ap)
@@ -397,3 +447,5 @@ xvsnprintf(char *outbuf, size_t length, const char *fmt, va_list ap)
 	INTON;
 	return ret;
 }
+
+#endif
diff --git a/src/system.c b/src/system.c
index 844a641..dbf4601 100644
--- a/src/system.c
+++ b/src/system.c
@@ -92,8 +92,10 @@ char *strsignal(int sig)
 {
 	static char buf[19];
 
+#if HAVE_DECL_SYS_SIGLIST
 	if ((unsigned)sig < NSIG && sys_siglist[sig])
 		return (char *)sys_siglist[sig];
+#endif
 	fmtstr(buf, sizeof(buf), "Signal %d", sig); 
 	return buf;
 }
diff --git a/src/system.h b/src/system.h
index a8d09b3..00fc757 100644
--- a/src/system.h
+++ b/src/system.h
@@ -69,11 +69,11 @@ static inline double strtod(const char *nptr, char **endptr)
 }
 #endif
 
-#ifndef HAVE_STRTOIMAX
+#if !HAVE_DECL_STRTOIMAX
 #define strtoimax strtoll
 #endif
 
-#ifndef HAVE_STRTOUMAX
+#if !HAVE_DECL_STRTOUMAX
 #define strtoumax strtoull
 #endif
 
-- 
1.7.1


