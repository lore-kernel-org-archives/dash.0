From: Brian Koropoff <bkoropoff@gmail.com>
Subject: [PATCH] Port to Solaris
Date: Sat, 12 Mar 2011 17:25:21 -0800
Message-ID: <1299979521.3797.12.camel@gemini>
References: <1299979112.3797.9.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:36242 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab1CMBZO (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 12 Mar 2011 20:25:14 -0500
Received: by pxi2 with SMTP id 2so1032128pxi.10
        for <dash@vger.kernel.org>; Sat, 12 Mar 2011 17:25:13 -0800 (PST)
In-Reply-To: <1299979112.3797.9.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

- Solaris lacks paths.h and the various _PATH_* #defines.
  Check for them in configure.ac and fall back on the
  usual suspects when they are missing.

- Older Solaris lacks isblank(), and versions that have it
  use a macro.  Check for the declaration in configure.ac
  and fall back on a naive version when missing.

- Older Solaris does not support %jd (intmax_t) in format
  strings, but it does support the PRIdMAX macro from inttypes.h.
  Do a configure check for PRIdMAX and use it in the code.
  If it doesn't exist, define it to "lld" when sizeof(long long)
  equals sizeof(intmax_t) as this is more likely to work on
  older systems.  Otherwise, use "jd" and hope for the best.

- Older Solaris lacks stdint.h, but inttypes.h provides the
  same types and works on all platforms I've tried dash on,
  so just use it instead.

- Older Solaris doesn't like it when vsnprintf() is passed
  a NULL buffer (in violation of the POSIX spec, of course).
  Pass a 1-byte dummy buffer instead.

- Solaris lacks tempfile and mktemp programs.  Fall back on a
  "good-enough" custom function in mkbuiltins.

Signed-off-by: Brian Koropoff <bkoropoff@gmail.com>
---
 configure.ac     |   41 ++++++++++++++++++++++++++++++++++++++++-
 src/arith_yacc.c |    1 -
 src/bltin/test.c |    2 +-
 src/cd.c         |    4 ++++
 src/exec.c       |    5 +++++
 src/expand.c     |    4 ++--
 src/expand.h     |    2 +-
 src/histedit.c   |    5 +++++
 src/jobs.c       |    5 +++++
 src/jobs.h       |    2 +-
 src/miscbltin.c  |    4 ++--
 src/mkbuiltins   |   15 +++++++++++++++
 src/mystring.c   |    2 +-
 src/mystring.h   |    2 +-
 src/output.c     |   14 ++++++++++++++
 src/system.c     |    8 ++++++++
 src/system.h     |    5 +++++
 src/var.c        |    7 ++++++-
 src/var.h        |    2 +-
 19 files changed, 117 insertions(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index c943725..effdffc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -43,7 +43,46 @@ AC_ARG_ENABLE(glob, AS_HELP_STRING(--enable-glob, [Use glob(3) from libc]))
 dnl Checks for libraries.
 
 dnl Checks for header files.
-AC_CHECK_HEADERS(alloca.h)
+AC_CHECK_HEADERS(alloca.h paths.h)
+
+dnl Check for declarations
+AC_CHECK_DECL([_PATH_BSHELL],,AC_DEFINE_UNQUOTED([_PATH_BSHELL], "/bin/sh", [Define to system shell path]),[
+#ifdef HAVE_PATHS_H
+#include <paths.h>
+#endif
+])
+AC_CHECK_DECL([_PATH_DEVNULL],,AC_DEFINE_UNQUOTED([_PATH_DEVNULL], "/dev/null", [Define to devnull device node path]),[
+#ifdef HAVE_PATHS_H
+#include <paths.h>
+#endif
+])
+AC_CHECK_DECL([_PATH_TTY],,AC_DEFINE_UNQUOTED([_PATH_TTY], "/dev/tty", [Define to tty device node path]),[
+#ifdef HAVE_PATHS_H
+#include <paths.h>
+#endif
+])
+
+dnl Some systems lack isblank
+AC_CHECK_DECLS([isblank],,,[#include <ctype.h>])
+
+dnl Check for sizes of types
+AC_CHECK_SIZEOF([intmax_t])
+AC_CHECK_SIZEOF([long long int])
+
+dnl Select a fallback format string for intmax_t in case we don't find PRIdMAX
+if test "x$ac_cv_sizeof_intmax_t" = "x$ac_cv_sizeof_long_long_int"; then
+  intmax_fstr="lld"
+else
+  intmax_fstr="jd"
+fi
+
+dnl Check for PRIdMAX and define it to a fallback if not found
+AC_CHECK_DECL([PRIdMAX],,
+	[AC_DEFINE_UNQUOTED([PRIdMAX], "$intmax_fstr",
+				       [Define to printf format string for intmax_t])],
+        [
+#include <inttypes.h>
+])
 
 dnl Checks for library functions.
 AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit imaxdiv isalpha killpg \
diff --git a/src/arith_yacc.c b/src/arith_yacc.c
index 6c5a720..bf21830 100644
--- a/src/arith_yacc.c
+++ b/src/arith_yacc.c
@@ -33,7 +33,6 @@
  */
 
 #include <inttypes.h>
-#include <stdint.h>
 #include <stdlib.h>
 #include "arith_yacc.h"
 #include "expand.h"
diff --git a/src/bltin/test.c b/src/bltin/test.c
index 7888f38..90135e1 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -12,7 +12,7 @@
 #include <sys/types.h>
 
 #include <fcntl.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
diff --git a/src/cd.c b/src/cd.c
index 9a69b69..cf80df8 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -32,11 +32,15 @@
  * SUCH DAMAGE.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
 
 /*
  * The cd and pwd commands.
diff --git a/src/exec.c b/src/exec.c
index b273420..d8e6a40 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -32,12 +32,17 @@
  * SUCH DAMAGE.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#ifdef HAVE_PATHS_H
 #include <paths.h>
+#endif
 
 /*
  * When commands are first encountered, they are entered in a hash table.
diff --git a/src/expand.c b/src/expand.c
index 7a9b157..f155ea0 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -42,7 +42,7 @@
 #endif
 #include <stdlib.h>
 #include <stdio.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <limits.h>
 #include <string.h>
 #include <fnmatch.h>
@@ -1691,7 +1691,7 @@ cvtnum(intmax_t num)
 	int len = max_int_length(sizeof(num));
 
 	expdest = makestrspace(len, expdest);
-	len = fmtstr(expdest, len, "%jd", num);
+	len = fmtstr(expdest, len, "%" PRIdMAX, num);
 	STADJUST(len, expdest);
 	return len;
 }
diff --git a/src/expand.h b/src/expand.h
index 4251a4a..6a90f67 100644
--- a/src/expand.h
+++ b/src/expand.h
@@ -34,7 +34,7 @@
  *	@(#)expand.h	8.2 (Berkeley) 5/4/95
  */
 
-#include <stdint.h>
+#include <inttypes.h>
 
 struct strlist {
 	struct strlist *next;
diff --git a/src/histedit.c b/src/histedit.c
index 9a1e533..84f9a48 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -32,8 +32,13 @@
  * SUCH DAMAGE.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
 #include <sys/param.h>
+#ifdef HAVE_PATHS_H
 #include <paths.h>
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/src/jobs.c b/src/jobs.c
index f67116e..88b5792 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -32,11 +32,16 @@
  * SUCH DAMAGE.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
 #include <fcntl.h>
 #include <signal.h>
 #include <unistd.h>
 #include <stdlib.h>
+#ifdef HAVE_PATHS_H
 #include <paths.h>
+#endif
 #include <sys/types.h>
 #include <sys/param.h>
 #ifdef BSD
diff --git a/src/jobs.h b/src/jobs.h
index 9c095ea..953ee87 100644
--- a/src/jobs.h
+++ b/src/jobs.h
@@ -34,7 +34,7 @@
  *	@(#)jobs.h	8.2 (Berkeley) 5/4/95
  */
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <sys/types.h>
 
 /* Mode argument to forkshell.  Don't change FORK_FG or FORK_BG. */
diff --git a/src/miscbltin.c b/src/miscbltin.c
index f507381..e354df4 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -44,7 +44,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <ctype.h>
-#include <stdint.h>
+#include <inttypes.h>
 
 #include "shell.h"
 #include "options.h"
@@ -410,7 +410,7 @@ static void printlim(enum limtype how, const struct rlimit *limit,
 		out1fmt("unlimited\n");
 	else {
 		val /= l->factor;
-		out1fmt("%jd\n", (intmax_t) val);
+		out1fmt("%" PRIdMAX "\n", (intmax_t) val);
 	}
 }
 
diff --git a/src/mkbuiltins b/src/mkbuiltins
index 99107c2..495274e 100644
--- a/src/mkbuiltins
+++ b/src/mkbuiltins
@@ -40,6 +40,21 @@ if ! type tempfile > /dev/null 2>&1; then
 	tempfile="mktemp ${TMPDIR:-/tmp}/builtin.XXXXXX"
 fi
 
+if ! type mktemp > /dev/null 2>&1; then
+	_my_tempfile()
+	{
+	    index=0
+	    while test -f "${TMPDIR:-/tmp}/builtin.$$.$index"; do
+		index=`expr $index + 1`
+	    done
+
+	    touch "${TMPDIR:-/tmp}/builtin.$$.$index"
+	    echo "${TMPDIR:-/tmp}/builtin.$$.$index"
+	}
+
+	tempfile="_my_tempfile"
+fi
+
 trap 'rm -f $temp $temp2' EXIT
 temp=$($tempfile)
 temp2=$($tempfile)
diff --git a/src/mystring.c b/src/mystring.c
index bbb6b77..0106bd2 100644
--- a/src/mystring.c
+++ b/src/mystring.c
@@ -46,7 +46,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <stdlib.h>
 #include "shell.h"
 #include "syntax.h"
diff --git a/src/mystring.h b/src/mystring.h
index 3522523..083ea98 100644
--- a/src/mystring.h
+++ b/src/mystring.h
@@ -34,7 +34,7 @@
  *	@(#)mystring.h	8.2 (Berkeley) 5/4/95
  */
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <string.h>
 
 extern const char snlfmt[];
diff --git a/src/output.c b/src/output.c
index 2f9b5c4..3425603 100644
--- a/src/output.c
+++ b/src/output.c
@@ -378,6 +378,20 @@ xvsnprintf(char *outbuf, size_t length, const char *fmt, va_list ap)
 {
 	int ret;
 
+#ifdef __sun
+	/* 
+	 * vsnprintf() on older versions of Solaris returns -1 when
+	 * passed a length of 0.  To avoid this, use a dummy
+	 * 1-character buffer instead.
+	 */
+	char dummy[1];
+
+	if (length == 0) {
+		outbuf = dummy;
+		length = sizeof(dummy);
+	}
+#endif
+
 	INTOFF;
 	ret = vsnprintf(outbuf, length, fmt, ap);
 	INTON;
diff --git a/src/system.c b/src/system.c
index 5fd6062..844a641 100644
--- a/src/system.c
+++ b/src/system.c
@@ -170,9 +170,11 @@ int isupper(int c) {
 }
 

+#if HAVE_DECL_ISBLANK
 int isblank(int c) {
 	return _isblank(c);
 }
+#endif
 

 int isgraph(int c) {
@@ -189,3 +191,9 @@ int isxdigit(int c) {
 	return _isxdigit(c);
 }
 #endif
+
+#if !HAVE_DECL_ISBLANK
+int isblank(int c) {
+	return c == ' ' || c == '\t';
+}
+#endif
diff --git a/src/system.h b/src/system.h
index 17a9533..e712605 100644
--- a/src/system.h
+++ b/src/system.h
@@ -26,6 +26,7 @@
  * SUCH DAMAGE.
  */
 
+#include "config.h"
 #include <limits.h>
 #include <signal.h>
 #include <sys/types.h>
@@ -98,6 +99,10 @@ static inline int killpg(pid_t pid, int signal)
 long sysconf(int) __attribute__((__noreturn__));
 #endif
 
+#if !HAVE_DECL_ISBLANK
+int isblank(int c);
+#endif
+
 /*
  * A trick to suppress uninitialized variable warning without generating any
  * code
diff --git a/src/var.c b/src/var.c
index 25c2216..ddb28f4 100644
--- a/src/var.c
+++ b/src/var.c
@@ -32,9 +32,14 @@
  * SUCH DAMAGE.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
 #include <unistd.h>
 #include <stdlib.h>
+#ifdef HAVE_PATHS_H
 #include <paths.h>
+#endif
 
 /*
  * Shell variables.
@@ -223,7 +228,7 @@ intmax_t setvarint(const char *name, intmax_t val, int flags)
 	int len = max_int_length(sizeof(val));
 	char buf[len];
 
-	fmtstr(buf, len, "%jd", val);
+	fmtstr(buf, len, "%" PRIdMAX, val);
 	setvar(name, buf, flags);
 	return val;
 }
diff --git a/src/var.h b/src/var.h
index 7aa051f..35dd099 100644
--- a/src/var.h
+++ b/src/var.h
@@ -34,7 +34,7 @@
  *	@(#)var.h	8.2 (Berkeley) 5/4/95
  */
 
-#include <stdint.h>
+#include <inttypes.h>
 
 /*
  * Shell variables.
-- 
1.7.1


