From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Port to Solaris
Date: Tue, 15 Mar 2011 15:36:37 +0800
Message-ID: <20110315073637.GA8898@gondor.apana.org.au>
References: <1299979112.3797.9.camel@gemini> <1299979521.3797.12.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:57318 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab1COHgm (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 15 Mar 2011 03:36:42 -0400
Content-Disposition: inline
In-Reply-To: <1299979521.3797.12.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Brian Koropoff <bkoropoff@gmail.com>
Cc: dash@vger.kernel.org

On Sun, Mar 13, 2011 at 01:25:21AM +0000, Brian Koropoff wrote:
> Signed-off-by: Brian Koropoff <bkoropoff@gmail.com>

Thanks for the patch.  I've made some minor updates before applying:

* Remove unnecessary config.h inclusions (already included on command
  line)
* Only check mktemp when tempfile is unavailable

Please take a look at the end result to see if I've messed anything
up.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
commit bfcdc4969510997fe81debf52982641febfa1bdf
Author: Brian Koropoff <bkoropoff@gmail.com>
Date:   Tue Mar 15 15:35:14 2011 +0800

    [SHELL] Port to Solaris
    
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
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index e96bdc4..08c3792 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2011-03-15  Brian Koropoff <bkoropoff@gmail.com>
+
+	* Port to Solaris.
+
 2011-03-11  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix backslash handling in read(1).
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
index 9a69b69..2d9d4b5 100644
--- a/src/cd.c
+++ b/src/cd.c
@@ -37,6 +37,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
 
 /*
  * The cd and pwd commands.
diff --git a/src/exec.c b/src/exec.c
index b273420..194088b 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -37,7 +37,9 @@
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
index 9a1e533..b27d629 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -33,7 +33,9 @@
  */
 
 #include <sys/param.h>
+#ifdef HAVE_PATHS_H
 #include <paths.h>
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/src/jobs.c b/src/jobs.c
index f67116e..4b1b938 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -36,7 +36,9 @@
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
index 99107c2..f562ae2 100644
--- a/src/mkbuiltins
+++ b/src/mkbuiltins
@@ -36,7 +36,20 @@
 #	@(#)mkbuiltins	8.2 (Berkeley) 5/4/95
 
 tempfile=tempfile
-if ! type tempfile > /dev/null 2>&1; then
+if ! type tempfile > /dev/null 2>&1 && ! type mktemp > /dev/null 2>&1; then
+	_my_tempfile()
+	{
+		local index=0
+		while test -f "${TMPDIR:-/tmp}/builtin.$$.$index"; do
+			index=`expr $index + 1`
+		done
+
+		touch "${TMPDIR:-/tmp}/builtin.$$.$index"
+		echo "${TMPDIR:-/tmp}/builtin.$$.$index"
+	}
+
+	tempfile="_my_tempfile"
+elif ! type tempfile > /dev/null 2>&1; then
 	tempfile="mktemp ${TMPDIR:-/tmp}/builtin.XXXXXX"
 fi
 
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
index 2f9b5c4..f62e7ea 100644
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
index 17a9533..a8d09b3 100644
--- a/src/system.h
+++ b/src/system.h
@@ -98,6 +98,10 @@ static inline int killpg(pid_t pid, int signal)
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
index 25c2216..aec1076 100644
--- a/src/var.c
+++ b/src/var.c
@@ -34,7 +34,9 @@
 
 #include <unistd.h>
 #include <stdlib.h>
+#ifdef HAVE_PATHS_H
 #include <paths.h>
+#endif
 
 /*
  * Shell variables.
@@ -223,7 +225,7 @@ intmax_t setvarint(const char *name, intmax_t val, int flags)
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
