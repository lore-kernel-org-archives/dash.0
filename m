From: Brian Koropoff <bkoropoff@gmail.com>
Subject: [PATCH 3/3] Port to HP-UX
Date: Tue, 18 Jan 2011 21:16:02 -0800
Message-ID: <1295414162.6486.5.camel@gemini>
References: <1295413636.4278.28.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41589 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab1ASFQH (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 19 Jan 2011 00:16:07 -0500
Received: by pwj3 with SMTP id 3so84766pwj.19
        for <dash@vger.kernel.org>; Tue, 18 Jan 2011 21:16:07 -0800 (PST)
In-Reply-To: <1295413636.4278.28.camel@gemini>
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
 configure.ac    |   16 +++++++++++++---
 src/Makefile.am |    3 ++-
 src/mkbuiltins  |    2 +-
 src/output.c    |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/system.c    |    2 ++
 src/system.h    |    4 ++--
 6 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0a60055..07c2726 100644
--- a/configure.ac
+++ b/configure.ac
@@ -43,7 +43,7 @@ AC_ARG_ENABLE(glob, AS_HELP_STRING(--enable-glob, [Use glob(3) from libc]))
 dnl Checks for libraries.
 
 dnl Checks for header files.
-AC_CHECK_HEADERS(alloca.h paths.h)
+AC_CHECK_HEADERS(alloca.h paths.h unistd.h signal.h)
 
 dnl Check for declarations
 AC_CHECK_DECL([_PATH_BSHELL],,AC_DEFINE_UNQUOTED([_PATH_BSHELL], "/bin/sh", [Define to system shell path]),[
@@ -65,6 +65,17 @@ AC_CHECK_DECL([_PATH_TTY],,AC_DEFINE_UNQUOTED([_PATH_TTY], "/dev/tty", [Define t
 dnl Some systems lack isblank
 AC_CHECK_DECLS([isblank],,,[#include <ctype.h>])
 
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
 dnl Check for types and sizes
 AC_CHECK_SIZEOF([intmax_t])
 AC_CHECK_SIZEOF([long long int])
@@ -82,8 +93,7 @@ AC_DEFINE_UNQUOTED([INTMAX_FSTR], "$intmax_fstr", [Define to printf format strin
 dnl Checks for library functions.
 AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit imaxdiv isalpha killpg \
 	       mempcpy \
-	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
-	       strtoumax sysconf)
+	       sigsetmask stpcpy strchrnul strsignal strtod sysconf)
 
 if test "$enable_fnmatch" = yes; then
 	use_fnmatch=
diff --git a/src/Makefile.am b/src/Makefile.am
index ba68d55..b99daf1 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -4,7 +4,8 @@ COMMON_CFLAGS = -Wall
 COMMON_CPPFLAGS = \
 	-include $(top_builddir)/config.h \
 	-DBSD=1 -DSHELL \
-	-DIFS_BROKEN
+	-DIFS_BROKEN \
+	-D_LARGEFILE64_SOURCE
 
 AM_CFLAGS = $(COMMON_CFLAGS)
 AM_CPPFLAGS = $(COMMON_CPPFLAGS)
diff --git a/src/mkbuiltins b/src/mkbuiltins
index 495274e..f6260b2 100644
--- a/src/mkbuiltins
+++ b/src/mkbuiltins
@@ -99,7 +99,7 @@ cat <<\!
  */
 
 !
-sed 's/	-[a-z]*//' $temp2 | nl -b a -v 0 | LC_COLLATE=C sort -u -k 3,3 |
+sed 's/	-[a-z]*//' $temp2 | nl -ba -v0 | LC_COLLATE=C sort -u -k 3,3 |
 tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ |
 	awk '{	printf "#define %s (builtincmd + %d)\n", $3, $1}'
 printf '\n#define NUMBUILTINS %d\n' $(wc -l < $temp2)
diff --git a/src/output.c b/src/output.c
index 3425603..db4a8a7 100644
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
index e712605..b1e9b63 100644
--- a/src/system.h
+++ b/src/system.h
@@ -70,11 +70,11 @@ static inline double strtod(const char *nptr, char **endptr)
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


