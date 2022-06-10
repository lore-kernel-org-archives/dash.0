Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954D5C433EF
	for <linux-dash@archiver.kernel.org>; Fri, 10 Jun 2022 22:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbiFJWXv (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 10 Jun 2022 18:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbiFJWXv (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 10 Jun 2022 18:23:51 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 15:23:42 PDT
Received: from lucifer.abilit.eu (lucifer.abilit.eu [85.93.218.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3965E1F2CC
        for <dash@vger.kernel.org>; Fri, 10 Jun 2022 15:23:41 -0700 (PDT)
Received: from mailout.lll.lu (unknown [10.10.13.1])
        by lucifer.abilit.eu (Postfix) with ESMTPS id 3EEECE91CD
        for <dash@vger.kernel.org>; Sat, 11 Jun 2022 00:16:02 +0200 (CEST)
Received: from [192.168.178.21] (vodsl-10467.vo.lu [85.93.207.227])
        (authenticated bits=0)
        by lll.lu (8.15.2/8.15.2/Debian-22) with ESMTPSA id 25AMG1Kg2474121
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
        for <dash@vger.kernel.org>; Sat, 11 Jun 2022 00:16:01 +0200
From:   Alain Knaff <alain@knaff.lu>
Subject: [PATCH] Portability of dash to legacy systems, such as AT&T Unix PC
To:     dash@vger.kernel.org
Message-ID: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
Date:   Sat, 11 Jun 2022 00:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

While attempting to run an GNU autoconf script on the AT&T Unix PC, I
came across the need to get a POSIX compliant shell.

Indeed, the system shell was not up to the task, as it lacked important
features, such as local positional parameters (the $1, $2, etc would get 
clobbered by calls to sub functions)

Bash worked, but was too big for this memory-starved machine (ran out of
memory during long pipes, as each stage duplicates process' memory
image).

So my choice fell on dash. However, a number of adaptations were
necessary to get it to compile; appended to the end of this mail is a
patch.

Here a summary of the needed changes:

- test for presence of header files which are missing on the UnixPC
getopt.h sys/resource.h termios.h (and others, which might be missing
elsewhere)

- local implementation, replacement or skipping of functions missing on
the UnixPC: tcgetpgrp tcsetpgrp setpgid vfork wait3 sigaction
sigprocmask sigsuspend raise lstat dup2 getgroups strstr stpncpy
strcasecmp strerror strndup strtoul vsnprintf

- lack of POSIX signal handling (sigsuspend, sigaction ...) => use
signal() if sigaction() is absent, and for the other calls, simply skip

- SIGCHLD is called SIGCLD on SystemV systems such as the UnixPC

- realloc() doesn't work on NULL pointers (whereas on more modern
platforms it just behaves as malloc() if passed a NULL pointer

- Fixed USE_GLIBC_STDIO (actually a misnomer, as non GNU C libraries 
supply stdio as well => USE_LIBC_STDIO):moving around of #ifdef's mostly
"notyet" and USE_GLIBC_STDIO itself, missing semicolons, use stdio
streams rather than fd filedescriptors

- As vsnprintf is unavailable on Unix (and possibly other legacy
platforms as well), partly replaced the out1fmt in showvars with outstr,
or else it would fail on variables with *huge* contents as they happen
in GNU autoconf scripts

- choice of an "appropriate" imtmax_t type if none is suggested by the
system libraries: n.B. the type has to be supported by printf, not just
the compiler

- Reworked the handling of isalnum, iscntrl, etc. functions/macros.
On the UnixPC these are actually preprocessor macros doing an array
lookup, whereas dash's system.c so far relied on them just being calls
to other functions (_isalnum instead of isalnum). If these are actually
defined to something else entirely (array lookup),the approach doesn't
work. Just replaced it with wrapper functions. Or maybe we should do
away with that lookup table containing function pointers, and instead
use a huge series of if(...) else if() statements, that don't care about
whether they call a macro or something else

- the signal_names list compilation got the wrong signal names when cross
compiling (from the build platform, rather than from the intended host
platform) => switched to getting them from host platform by calling the
cross compiler with -E, and then compiling the result with the build
platform's own compiler.
Avoid to write real-time signal names beyond end of array (are these
signal names used anyways?).
I also made strsignal use this list if both strsignl and sys_siglist are
unavailable on target platform.

- Redid calculation of SSIZE_MAX so that it works even if size_t is a
*signed* type, as on UnixPC.

- if sys/wait.h lacks some of the needed macros, just define *all* of
them (because the sys/wait.h supplied for UnixPC is for the wrong
endianness... d'oh)


Regards,

Alain

diff -urN -x .svn ref/dash-0.5.11.5/config.h.in dash/config.h.in
--- ref/dash-0.5.11.5/config.h.in	2021-09-03 09:03:47.000000000 +0200
+++ dash/config.h.in	2022-06-05 17:06:57.911384209 +0200
@@ -13,12 +13,28 @@
    don't. */
 #undef HAVE_DECL_ISBLANK
 
+/* Define to 1 if you have the declaration of `sys_siglist', and to 0 if you
+   don't. */
+#undef HAVE_DECL_SYS_SIGLIST
+
+/* Define to 1 if you have the `dup2' function. */
+#undef HAVE_DUP2
+
 /* Define to 1 if you have the `faccessat' function. */
 #undef HAVE_FACCESSAT
 
+/* Define to 1 if you have the <fcntl.h> header file. */
+#undef HAVE_FCNTL_H
+
 /* Define to 1 if you have the `fnmatch' function. */
 #undef HAVE_FNMATCH
 
+/* Define to 1 if you have the `getgroups' function. */
+#undef HAVE_GETGROUPS
+
+/* Define to 1 if you have the <getopt.h> header file. */
+#undef HAVE_GETOPT_H
+
 /* Define to 1 if you have the `getpwnam' function. */
 #undef HAVE_GETPWNAM
 
@@ -37,6 +53,9 @@
 /* Define to 1 if you have the `killpg' function. */
 #undef HAVE_KILLPG
 
+/* Define to 1 if you have the `lstat' function. */
+#undef HAVE_LSTAT
+
 /* Define to 1 if you have the <memory.h> header file. */
 #undef HAVE_MEMORY_H
 
@@ -46,9 +65,27 @@
 /* Define to 1 if you have the <paths.h> header file. */
 #undef HAVE_PATHS_H
 
+/* Define to 1 if you have the `raise' function. */
+#undef HAVE_RAISE
+
+/* Define to 1 if you have the `setpgid' function. */
+#undef HAVE_SETPGID
+
+/* Define to 1 if you have the `sigaction' function. */
+#undef HAVE_SIGACTION
+
+/* Define to 1 if you have the <signal.h> header file. */
+#undef HAVE_SIGNAL_H
+
+/* Define to 1 if you have the `sigprocmask' function. */
+#undef HAVE_SIGPROCMASK
+
 /* Define to 1 if you have the `sigsetmask' function. */
 #undef HAVE_SIGSETMASK
 
+/* Define to 1 if you have the `sigsuspend' function. */
+#undef HAVE_SIGSUSPEND
+
 /* Define to 1 if you have the <stdint.h> header file. */
 #undef HAVE_STDINT_H
 
@@ -58,24 +95,42 @@
 /* Define to 1 if you have the `stpcpy' function. */
 #undef HAVE_STPCPY
 
+/* Define to 1 if you have the `stpncpy' function. */
+#undef HAVE_STPNCPY
+
+/* Define to 1 if you have the `strcasecmp' function. */
+#undef HAVE_STRCASECMP
+
 /* Define to 1 if you have the `strchrnul' function. */
 #undef HAVE_STRCHRNUL
 
+/* Define to 1 if you have the `strerror' function. */
+#undef HAVE_STRERROR
+
 /* Define to 1 if you have the <strings.h> header file. */
 #undef HAVE_STRINGS_H
 
 /* Define to 1 if you have the <string.h> header file. */
 #undef HAVE_STRING_H
 
+/* Define to 1 if you have the `strndup' function. */
+#undef HAVE_STRNDUP
+
 /* Define to 1 if you have the `strsignal' function. */
 #undef HAVE_STRSIGNAL
 
+/* Define to 1 if you have the `strstr' function. */
+#undef HAVE_STRSTR
+
 /* Define to 1 if you have the `strtod' function. */
 #undef HAVE_STRTOD
 
 /* Define to 1 if you have the `strtoimax' function. */
 #undef HAVE_STRTOIMAX
 
+/* Define to 1 if you have the `strtoul' function. */
+#undef HAVE_STRTOUL
+
 /* Define to 1 if you have the `strtoumax' function. */
 #undef HAVE_STRTOUMAX
 
@@ -85,18 +140,42 @@
 /* Define to 1 if you have the `sysconf' function. */
 #undef HAVE_SYSCONF
 
+/* Define to 1 if you have the <sys/resource.h> header file. */
+#undef HAVE_SYS_RESOURCE_H
+
 /* Define to 1 if you have the <sys/stat.h> header file. */
 #undef HAVE_SYS_STAT_H
 
+/* Define to 1 if you have the <sys/time.h> header file. */
+#undef HAVE_SYS_TIME_H
+
 /* Define to 1 if you have the <sys/types.h> header file. */
 #undef HAVE_SYS_TYPES_H
 
+/* Define to 1 if you have the `tcgetpgrp' function. */
+#undef HAVE_TCGETPGRP
+
+/* Define to 1 if you have the `tcsetpgrp' function. */
+#undef HAVE_TCSETPGRP
+
+/* Define to 1 if you have the <termios.h> header file. */
+#undef HAVE_TERMIOS_H
+
 /* Define if your faccessat tells root all files are executable */
 #undef HAVE_TRADITIONAL_FACCESSAT
 
 /* Define to 1 if you have the <unistd.h> header file. */
 #undef HAVE_UNISTD_H
 
+/* Define to 1 if you have the `vfork' function. */
+#undef HAVE_VFORK
+
+/* Define to 1 if you have the `vsnprintf' function. */
+#undef HAVE_VSNPRINTF
+
+/* Define to 1 if you have the `wait3' function. */
+#undef HAVE_WAIT3
+
 /* Name of package */
 #undef PACKAGE
 
@@ -124,6 +203,9 @@
 /* The size of `intmax_t', as computed by sizeof. */
 #undef SIZEOF_INTMAX_T
 
+/* The size of `long int', as computed by sizeof. */
+#undef SIZEOF_LONG_INT
+
 /* The size of `long long int', as computed by sizeof. */
 #undef SIZEOF_LONG_LONG_INT
 
@@ -180,23 +262,57 @@
 /* Define to 1 if you need to in order for `stat' and other things to work. */
 #undef _POSIX_SOURCE
 
+/* Define for Solaris 2.5.1 so the uint32_t typedef from <sys/synch.h>,
+   <pthread.h>, or <semaphore.h> is not used. If the typedef were allowed, the
+   #define below would cause a syntax error. */
+#undef _UINT32_T
+
 /* 64-bit operations are the same as 32-bit */
 #undef dirent64
 
 /* 64-bit operations are the same as 32-bit */
 #undef fstat64
 
+/* Define to `int' if <sys/types.h> doesn't define. */
+#undef gid_t
+
+/* Define intmax_t type, must also be supported by printf */
+#undef intmax_t
+
 /* 64-bit operations are the same as 32-bit */
 #undef lstat64
 
 /* 64-bit operations are the same as 32-bit */
 #undef open64
 
+/* Define to `int' if <sys/types.h> does not define. */
+#undef pid_t
+
 /* 64-bit operations are the same as 32-bit */
 #undef readdir64
 
+/* Define atomic signal type */
+#undef sig_atomic_t
+
 /* klibc has bsd_signal instead of signal */
 #undef signal
 
+/* Define type for signal mask, may be int where signal blocking is not
+   supported at all */
+#undef sigset_t
+
+/* Define to `int' if <sys/types.h> does not define. */
+#undef ssize_t
+
 /* 64-bit operations are the same as 32-bit */
 #undef stat64
+
+/* Define to `int' if <sys/types.h> doesn't define. */
+#undef uid_t
+
+/* Define to the type of an unsigned integer type of width exactly 32 bits if
+   such a type exists and the standard includes do not define it. */
+#undef uint32_t
+
+/* Define uintmax_t type, must also be supported by printf */
+#undef uintmax_t
diff -urN -x .svn ref/dash-0.5.11.5/configure dash/configure
--- ref/dash-0.5.11.5/configure	2021-09-03 09:03:45.000000000 +0200
+++ dash/configure	2022-06-10 21:56:21.548705295 +0200
@@ -1792,6 +1792,114 @@
 
 } # ac_fn_c_check_decl
 
+# ac_fn_c_check_type LINENO TYPE VAR INCLUDES
+# -------------------------------------------
+# Tests whether TYPE exists after having included INCLUDES, setting cache
+# variable VAR accordingly.
+ac_fn_c_check_type ()
+{
+  as_lineno=${as_lineno-"$1"} as_lineno_stack=as_lineno_stack=$as_lineno_stack
+  { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $2" >&5
+$as_echo_n "checking for $2... " >&6; }
+if eval \${$3+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+  eval "$3=no"
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+$4
+int
+main ()
+{
+if (sizeof ($2))
+	 return 0;
+  ;
+  return 0;
+}
+_ACEOF
+if ac_fn_c_try_compile "$LINENO"; then :
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+$4
+int
+main ()
+{
+if (sizeof (($2)))
+	    return 0;
+  ;
+  return 0;
+}
+_ACEOF
+if ac_fn_c_try_compile "$LINENO"; then :
+
+else
+  eval "$3=yes"
+fi
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+fi
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+fi
+eval ac_res=\$$3
+	       { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_res" >&5
+$as_echo "$ac_res" >&6; }
+  eval $as_lineno_stack; ${as_lineno_stack:+:} unset as_lineno
+
+} # ac_fn_c_check_type
+
+# ac_fn_c_find_uintX_t LINENO BITS VAR
+# ------------------------------------
+# Finds an unsigned integer type with width BITS, setting cache variable VAR
+# accordingly.
+ac_fn_c_find_uintX_t ()
+{
+  as_lineno=${as_lineno-"$1"} as_lineno_stack=as_lineno_stack=$as_lineno_stack
+  { $as_echo "$as_me:${as_lineno-$LINENO}: checking for uint$2_t" >&5
+$as_echo_n "checking for uint$2_t... " >&6; }
+if eval \${$3+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+  eval "$3=no"
+     # Order is important - never check a type that is potentially smaller
+     # than half of the expected target width.
+     for ac_type in uint$2_t 'unsigned int' 'unsigned long int' \
+	 'unsigned long long int' 'unsigned short int' 'unsigned char'; do
+       cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+$ac_includes_default
+int
+main ()
+{
+static int test_array [1 - 2 * !((($ac_type) -1 >> ($2 / 2 - 1)) >> ($2 / 2 - 1) == 3)];
+test_array [0] = 0;
+return test_array [0];
+
+  ;
+  return 0;
+}
+_ACEOF
+if ac_fn_c_try_compile "$LINENO"; then :
+  case $ac_type in #(
+  uint$2_t) :
+    eval "$3=yes" ;; #(
+  *) :
+    eval "$3=\$ac_type" ;;
+esac
+fi
+rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+       if eval test \"x\$"$3"\" = x"no"; then :
+
+else
+  break
+fi
+     done
+fi
+eval ac_res=\$$3
+	       { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_res" >&5
+$as_echo "$ac_res" >&6; }
+  eval $as_lineno_stack; ${as_lineno_stack:+:} unset as_lineno
+
+} # ac_fn_c_find_uintX_t
+
 # ac_fn_c_compute_int LINENO EXPR VAR INCLUDES
 # --------------------------------------------
 # Tries to find the compile-time value of EXPR in a program that includes
@@ -4605,7 +4713,8 @@
 
 
 
-for ac_header in alloca.h paths.h
+for ac_header in alloca.h paths.h \
+		getopt.h sys/resource.h termios.h signal.h sys/time.h fcntl.h
 do :
   as_ac_Header=`$as_echo "ac_cv_header_$ac_header" | $as_tr_sh`
 ac_fn_c_check_header_mongrel "$LINENO" "$ac_header" "$as_ac_Header" "$ac_includes_default"
@@ -4681,6 +4790,152 @@
 _ACEOF
 
 
+ac_fn_c_check_decl "$LINENO" "sys_siglist" "ac_cv_have_decl_sys_siglist" "#include <signal.h>
+/* NetBSD declares sys_siglist in unistd.h.  */
+#ifdef HAVE_UNISTD_H
+# include <unistd.h>
+#endif
+
+"
+if test "x$ac_cv_have_decl_sys_siglist" = xyes; then :
+  ac_have_decl=1
+else
+  ac_have_decl=0
+fi
+
+cat >>confdefs.h <<_ACEOF
+#define HAVE_DECL_SYS_SIGLIST $ac_have_decl
+_ACEOF
+
+
+ac_fn_c_check_type "$LINENO" "pid_t" "ac_cv_type_pid_t" "$ac_includes_default"
+if test "x$ac_cv_type_pid_t" = xyes; then :
+
+else
+
+cat >>confdefs.h <<_ACEOF
+#define pid_t int
+_ACEOF
+
+fi
+
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for uid_t in sys/types.h" >&5
+$as_echo_n "checking for uid_t in sys/types.h... " >&6; }
+if ${ac_cv_type_uid_t+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#include <sys/types.h>
+
+_ACEOF
+if (eval "$ac_cpp conftest.$ac_ext") 2>&5 |
+  $EGREP "uid_t" >/dev/null 2>&1; then :
+  ac_cv_type_uid_t=yes
+else
+  ac_cv_type_uid_t=no
+fi
+rm -f conftest*
+
+fi
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_cv_type_uid_t" >&5
+$as_echo "$ac_cv_type_uid_t" >&6; }
+if test $ac_cv_type_uid_t = no; then
+
+$as_echo "#define uid_t int" >>confdefs.h
+
+
+$as_echo "#define gid_t int" >>confdefs.h
+
+fi
+
+ac_fn_c_check_type "$LINENO" "ssize_t" "ac_cv_type_ssize_t" "$ac_includes_default"
+if test "x$ac_cv_type_ssize_t" = xyes; then :
+
+else
+
+cat >>confdefs.h <<_ACEOF
+#define ssize_t int
+_ACEOF
+
+fi
+
+ac_fn_c_find_uintX_t "$LINENO" "32" "ac_cv_c_uint32_t"
+case $ac_cv_c_uint32_t in #(
+  no|yes) ;; #(
+  *)
+
+$as_echo "#define _UINT32_T 1" >>confdefs.h
+
+
+cat >>confdefs.h <<_ACEOF
+#define uint32_t $ac_cv_c_uint32_t
+_ACEOF
+;;
+  esac
+
+
+ac_fn_c_check_type "$LINENO" "sig_atomic_t" "ac_cv_type_sig_atomic_t" "
+$ac_includes_default
+#ifdef HAVE_SIGNAL_H
+#include <signal.h>
+#endif
+
+"
+if test "x$ac_cv_type_sig_atomic_t" = xyes; then :
+
+else
+
+cat >>confdefs.h <<_ACEOF
+#define sig_atomic_t int
+_ACEOF
+
+fi
+
+
+ac_fn_c_check_type "$LINENO" "sigset_t" "ac_cv_type_sigset_t" "
+$ac_includes_default
+#ifdef HAVE_SIGNAL_H
+#include <signal.h>
+#endif
+
+"
+if test "x$ac_cv_type_sigset_t" = xyes; then :
+
+else
+
+cat >>confdefs.h <<_ACEOF
+#define sigset_t int
+_ACEOF
+
+fi
+
+
+
+ac_fn_c_check_type "$LINENO" "intmax_t" "ac_cv_type_intmax_t" "$ac_includes_default"
+if test "x$ac_cv_type_intmax_t" = xyes; then :
+
+else
+
+cat >>confdefs.h <<_ACEOF
+#define intmax_t long
+_ACEOF
+
+fi
+
+
+ac_fn_c_check_type "$LINENO" "uintmax_t" "ac_cv_type_uintmax_t" "$ac_includes_default"
+if test "x$ac_cv_type_uintmax_t" = xyes; then :
+
+else
+
+cat >>confdefs.h <<_ACEOF
+#define uintmax_t unsigned long
+_ACEOF
+
+fi
+
+
 # The cast to long int works around a bug in the HP C Compiler
 # version HP92453-01 B.11.11.23709.GP, which incorrectly rejects
 # declarations like `int a3[[(sizeof (unsigned char)) >= 0]];'.
@@ -4747,12 +5002,48 @@
 _ACEOF
 
 
+# The cast to long int works around a bug in the HP C Compiler
+# version HP92453-01 B.11.11.23709.GP, which incorrectly rejects
+# declarations like `int a3[[(sizeof (unsigned char)) >= 0]];'.
+# This bug is HP SR number 8606223364.
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking size of long int" >&5
+$as_echo_n "checking size of long int... " >&6; }
+if ${ac_cv_sizeof_long_int+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+  if ac_fn_c_compute_int "$LINENO" "(long int) (sizeof (long int))" "ac_cv_sizeof_long_int"        "$ac_includes_default"; then :
+
+else
+  if test "$ac_cv_type_long_int" = yes; then
+     { { $as_echo "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
+$as_echo "$as_me: error: in \`$ac_pwd':" >&2;}
+as_fn_error 77 "cannot compute sizeof (long int)
+See \`config.log' for more details" "$LINENO" 5; }
+   else
+     ac_cv_sizeof_long_int=0
+   fi
+fi
+
+fi
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_cv_sizeof_long_int" >&5
+$as_echo "$ac_cv_sizeof_long_int" >&6; }
+
+
+
+cat >>confdefs.h <<_ACEOF
+#define SIZEOF_LONG_INT $ac_cv_sizeof_long_int
+_ACEOF
+
+
 
 if test "x$ac_cv_sizeof_intmax_t" = "x$ac_cv_sizeof_long_long_int"; then
   intmax_fstr="lld"
+else if test "x$ac_cv_sizeof_intmax_t" = "x$ac_cv_sizeof_long_int"; then
+  intmax_fstr="ld"
 else
   intmax_fstr="jd"
 fi
+fi
 
 ac_fn_c_check_decl "$LINENO" "PRIdMAX" "ac_cv_have_decl_PRIdMAX" "
 #include <inttypes.h>
@@ -4772,7 +5063,11 @@
 for ac_func in bsearch faccessat getpwnam getrlimit isalpha killpg \
 	       mempcpy \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
-	       strtoumax sysconf
+	       strtoumax sysconf \
+	       tcgetpgrp tcsetpgrp setpgid vfork wait3 \
+	       sigaction sigprocmask sigsuspend raise \
+	       lstat dup2 getgroups \
+	       strstr stpncpy strcasecmp strerror strndup strtoul vsnprintf
 do :
   as_ac_var=`$as_echo "ac_cv_func_$ac_func" | $as_tr_sh`
 ac_fn_c_check_func "$LINENO" "$ac_func" "$as_ac_var"
diff -urN -x .svn ref/dash-0.5.11.5/configure.ac dash/configure.ac
--- ref/dash-0.5.11.5/configure.ac	2021-09-03 09:03:16.000000000 +0200
+++ dash/configure.ac	2022-06-05 17:06:33.490735411 +0200
@@ -44,7 +44,8 @@
 dnl Checks for libraries.
 
 dnl Checks for header files.
-AC_CHECK_HEADERS(alloca.h paths.h)
+AC_CHECK_HEADERS(alloca.h paths.h \
+		getopt.h sys/resource.h termios.h signal.h sys/time.h fcntl.h)
 
 dnl Check for declarations
 AC_CHECK_DECL([_PATH_BSHELL],,AC_DEFINE_UNQUOTED([_PATH_BSHELL], "/bin/sh", [Define to system shell path]),[
@@ -66,16 +67,45 @@
 dnl Some systems lack isblank
 AC_CHECK_DECLS([isblank],,,[#include <ctype.h>])
 
+AC_DECL_SYS_SIGLIST
+AC_TYPE_PID_T
+AC_TYPE_UID_T
+AC_TYPE_SSIZE_T
+AC_TYPE_UINT32_T
+
+AC_CHECK_TYPE([sig_atomic_t],,AC_DEFINE_UNQUOTED([sig_atomic_t],int,[Define atomic signal type]),[
+AC_INCLUDES_DEFAULT
+#ifdef HAVE_SIGNAL_H
+#include <signal.h>
+#endif
+])
+
+AC_CHECK_TYPE([sigset_t],,AC_DEFINE_UNQUOTED([sigset_t],int,[Define type for signal mask, may be int where signal blocking is not supported at all]),[
+AC_INCLUDES_DEFAULT
+#ifdef HAVE_SIGNAL_H
+#include <signal.h>
+#endif
+])
+
+
+AC_CHECK_TYPE([intmax_t],,AC_DEFINE_UNQUOTED([intmax_t],long,[Define intmax_t type, must also be supported by printf]))
+
+AC_CHECK_TYPE([uintmax_t],,AC_DEFINE_UNQUOTED([uintmax_t],unsigned long,[Define uintmax_t type, must also be supported by printf]))
+
 dnl Check for sizes of types
 AC_CHECK_SIZEOF([intmax_t])
 AC_CHECK_SIZEOF([long long int])
+AC_CHECK_SIZEOF([long int])
 
 dnl Select a fallback format string for intmax_t in case we don't find PRIdMAX
 if test "x$ac_cv_sizeof_intmax_t" = "x$ac_cv_sizeof_long_long_int"; then
   intmax_fstr="lld"
+else if test "x$ac_cv_sizeof_intmax_t" = "x$ac_cv_sizeof_long_int"; then
+  intmax_fstr="ld"
 else
   intmax_fstr="jd"
 fi
+fi
 
 dnl Check for PRIdMAX and define it to a fallback if not found
 AC_CHECK_DECL([PRIdMAX],,
@@ -89,7 +119,11 @@
 AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit isalpha killpg \
 	       mempcpy \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
-	       strtoumax sysconf)
+	       strtoumax sysconf \
+	       tcgetpgrp tcsetpgrp setpgid vfork wait3 \
+	       sigaction sigprocmask sigsuspend raise \
+	       lstat dup2 getgroups \
+	       strstr stpncpy strcasecmp strerror strndup strtoul vsnprintf )
 
 dnl Check whether it's worth working around FreeBSD PR kern/125009.
 dnl The traditional behavior of access/faccessat is crazy, but
diff -urN -x .svn ref/dash-0.5.11.5/src/Makefile.in dash/src/Makefile.in
--- ref/dash-0.5.11.5/src/Makefile.in	2021-09-03 09:03:44.000000000 +0200
+++ dash/src/Makefile.in	2022-06-05 15:19:50.200425210 +0200
@@ -824,6 +824,11 @@
 signames.c: mksignames
 	$(AM_V_GEN)./$^
 
+mksignames: mksignames.c mksignames.h
+
+mksignames.h: mksignames.tmpl.h
+	$(AM_V_CC)$(COMPILE) -E $< | sed '1,/START/d' >$@
+
 mksyntax: token.h
 
 $(HELPERS): %: %.c
diff -urN -x .svn ref/dash-0.5.11.5/src/bltin/test.c dash/src/bltin/test.c
--- ref/dash-0.5.11.5/src/bltin/test.c	2021-05-17 08:40:16.000000000 +0200
+++ dash/src/bltin/test.c	2022-06-05 17:38:51.506021997 +0200
@@ -659,10 +659,12 @@
  */
 static int test_access(const struct stat64 *sp, int stmode)
 {
+#ifdef HAVE_GETGROUPS
 	gid_t *groups;
 	register int n;
-	uid_t euid;
 	int maxgroups;
+#endif
+	uid_t euid;
 
 	/*
 	 * I suppose we could use access() if not running as root and if we are
@@ -681,6 +683,7 @@
 		stmode <<= 6;
 	else if (sp->st_gid == getegid())
 		stmode <<= 3;
+#ifdef HAVE_GETGROUPS
 	else {
 		/* XXX stolen almost verbatim from ksh93.... */
 		/* on some systems you can be in several groups */
@@ -694,6 +697,7 @@
 			}
 		}
 	}
+#endif
 
 	return sp->st_mode & stmode;
 }
diff -urN -x .svn ref/dash-0.5.11.5/src/eval.c dash/src/eval.c
--- ref/dash-0.5.11.5/src/eval.c	2021-09-03 09:01:44.000000000 +0200
+++ dash/src/eval.c	2022-06-07 13:49:10.233883520 +0200
@@ -818,7 +818,11 @@
 	if (iflag && funcline == 0 && argc > 0)
 		lastarg = nargv[-1];
 
+#ifdef USE_GLIBC_STDIO
+	preverrout.stream = stderr;
+#else
 	preverrout.fd = 2;
+#endif
 	expredir(cmd->ncmd.redirect);
 	redir_stop = pushredir(cmd->ncmd.redirect);
 	status = redirectsafe(cmd->ncmd.redirect, REDIR_PUSH|REDIR_SAVEFD2);
diff -urN -x .svn ref/dash-0.5.11.5/src/exec.c dash/src/exec.c
--- ref/dash-0.5.11.5/src/exec.c	2019-02-25 05:52:05.000000000 +0100
+++ dash/src/exec.c	2022-06-05 11:05:38.474721992 +0200
@@ -133,8 +133,12 @@
 	default:
 		exerrno = 126;
 		break;
+#ifdef ELOOP
 	case ELOOP:
+#endif
+#ifdef ENAMETOOLONG
 	case ENAMETOOLONG:
+#endif
 	case ENOENT:
 	case ENOTDIR:
 		exerrno = 127;
diff -urN -x .svn ref/dash-0.5.11.5/src/expand.c dash/src/expand.c
--- ref/dash-0.5.11.5/src/expand.c	2021-09-03 09:01:44.000000000 +0200
+++ dash/src/expand.c	2022-06-10 21:36:06.896402689 +0200
@@ -33,7 +33,9 @@
  */
 
 #include <sys/types.h>
+#ifdef HAVE_SYS_TIME_H
 #include <sys/time.h>
+#endif
 #include <sys/stat.h>
 #include <dirent.h>
 #include <unistd.h>
@@ -1485,6 +1487,84 @@
 
 
 #ifndef HAVE_FNMATCH
+
+static int fn_isalnum(int c) {
+	return isalnum(c);
+}
+#undef isalnum
+#define isalnum fn_isalnum
+
+static int fn_iscntrl(int c) {
+	return iscntrl(c);
+}
+#undef iscntrl
+#define iscntrl fn_iscntrl
+
+static int fn_islower(int c) {
+	return islower(c);
+}
+#undef islower
+#define islower fn_islower
+
+static int fn_isspace(int c) {
+	return isspace(c);
+}
+#undef isspace
+#define isspace fn_isspace
+
+static int fn_isalpha(int c) {
+	return isalpha(c);
+}
+#undef isalpha
+#define isalpha fn_isalpha
+
+static int fn_isdigit(int c) {
+	return isdigit(c);
+}
+#undef isdigit
+#define isdigit fn_isdigit
+
+static int fn_isprint(int c) {
+	return isprint(c);
+}
+#undef isprint
+#define isprint fn_isprint
+
+static int fn_isblank(int c) {
+#if HAVE_DECL_ISBLANK
+	return isblank(c);
+#else
+	return c == ' ' || c == '\t';
+#endif
+}
+#undef isblank
+#define isblank fn_isblank
+
+static int fn_isupper(int c) {
+	return isupper(c);
+}
+#undef isupper
+#define isupper fn_isupper
+
+static int fn_isgraph(int c) {
+	return isgraph(c);
+}
+#undef isgraph
+#define isgraph fn_isgraph
+
+static int fn_ispunct(int c) {
+	return ispunct(c);
+}
+#undef ispunct
+#define ispunct fn_ispunct
+
+static int fn_isxdigit(int c) {
+	return isxdigit(c);
+}
+#undef isxdigit
+#define isxdigit fn_isxdigit
+
+
 STATIC int ccmatch(const char *p, int chr, const char **r)
 {
 	static const struct class {
diff -urN -x .svn ref/dash-0.5.11.5/src/histedit.c dash/src/histedit.c
--- ref/dash-0.5.11.5/src/histedit.c	2018-03-10 09:01:43.000000000 +0100
+++ dash/src/histedit.c	2022-06-05 13:35:57.503014770 +0200
@@ -39,7 +39,12 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#ifdef HAVE_GETOPT_H
 #include <getopt.h>
+#else
+extern char * optarg;
+extern int optind;
+#endif
 /*
  * Editline and history functions (and glue).
  */
diff -urN -x .svn ref/dash-0.5.11.5/src/input.c dash/src/input.c
--- ref/dash-0.5.11.5/src/input.c	2021-09-03 09:01:44.000000000 +0200
+++ dash/src/input.c	2022-05-31 12:27:19.037861895 +0200
@@ -54,6 +54,7 @@
 #include "alias.h"
 #include "parser.h"
 #include "main.h"
+#include "system.h"
 #ifndef SMALL
 #include "myhistedit.h"
 #endif
@@ -177,17 +178,21 @@
 		nr = read(parsefile->fd, buf, IBUFSIZ - 1);
 
 
-	if (nr < 0) {
-		if (errno == EINTR)
-			goto retry;
-		if (parsefile->fd == 0 && errno == EWOULDBLOCK) {
-			int flags = fcntl(0, F_GETFL, 0);
-			if (flags >= 0 && flags & O_NONBLOCK) {
-				flags &=~ O_NONBLOCK;
-				if (fcntl(0, F_SETFL, flags) >= 0) {
-					out2str("sh: turning off NDELAY mode\n");
-					goto retry;
-				}
+	if (nr < 0 && errno == EINTR)
+		goto retry;
+	if (parsefile->fd == 0 &&
+#ifdef EWOULDBLOCK
+	    (nr < 0 && errno == EWOULDBLOCK)
+#else
+	    nr == 0
+#endif
+	    ) {
+		int flags = fcntl(0, F_GETFL, 0);
+		if (flags >= 0 && flags & O_NONBLOCK) {
+			flags &=~ O_NONBLOCK;
+			if (fcntl(0, F_SETFL, flags) >= 0) {
+				out2str("sh: turning off NDELAY mode\n");
+				goto retry;
 			}
 		}
 	}
diff -urN -x .svn ref/dash-0.5.11.5/src/jobs.c dash/src/jobs.c
--- ref/dash-0.5.11.5/src/jobs.c	2021-09-03 09:01:44.000000000 +0200
+++ dash/src/jobs.c	2022-06-10 21:36:45.377427343 +0200
@@ -43,14 +43,20 @@
 #include <sys/param.h>
 #ifdef BSD
 #include <sys/wait.h>
+#ifdef HAVE_SYS_TIME_H
 #include <sys/time.h>
+#endif
+#ifdef HAVE_SYS_RESOURCE_H
 #include <sys/resource.h>
 #endif
+#endif
 #include <sys/ioctl.h>
 
 #include "shell.h"
 #if JOBS
+#ifdef HAVE_TERMIOS_H
 #include <termios.h>
+#endif
 #undef CEOF			/* syntax.h redefines this */
 #endif
 #include "exec.h"
@@ -205,6 +211,7 @@
 					goto out;
 		}
 		fd = savefd(fd, ofd);
+#ifdef HAVE_TCGETPGRP
 		do { /* while we are in the background */
 			if ((pgrp = tcgetpgrp(fd)) < 0) {
 out:
@@ -214,25 +221,46 @@
 			}
 			if (pgrp == getpgrp())
 				break;
+#ifdef SIGTTIN
 			killpg(0, SIGTTIN);
+#endif
 		} while (1);
+#else
+	out:
+#endif
 		initialpgrp = pgrp;
 
+#ifdef SIGTSTP
 		setsignal(SIGTSTP);
+#endif
+#ifdef SIGTTOU
 		setsignal(SIGTTOU);
+#endif
+#ifdef SIGTTIN
 		setsignal(SIGTTIN);
+#endif
 		pgrp = rootpid;
+#ifdef HAVE_SETPGID
 		setpgid(0, pgrp);
+#endif
 		xtcsetpgrp(fd, pgrp);
 	} else {
 		/* turning job control off */
 		fd = ttyfd;
 		pgrp = initialpgrp;
 		xtcsetpgrp(fd, pgrp);
+#ifdef HAVE_SETPGID
 		setpgid(0, pgrp);
+#endif
+#ifdef SIGTSTP
 		setsignal(SIGTSTP);
+#endif
+#ifdef SIGTTOU
 		setsignal(SIGTTOU);
+#endif
+#ifdef SIGTTIN
 		setsignal(SIGTTIN);
+#endif
 close:
 		close(fd);
 		fd = -1;
@@ -325,7 +353,10 @@
 	do {
 		if (**argv == '%') {
 			jp = getjob(*argv, 0);
-			pid = -jp->ps[0].pid;
+			pid = jp->ps[0].pid;
+#ifdef HAVE_SETPGID
+			pid = -pid;
+#endif
 		} else
 			pid = **argv == '-' ?
 				-number(*argv + 1) : number(*argv);
@@ -393,9 +424,11 @@
 		goto out;
 	jp->state = JOBRUNNING;
 	pgid = jp->ps->pid;
-	if (mode == FORK_FG)
+	if (mode == FORK_FG)		
 		xtcsetpgrp(ttyfd, pgid);
+#ifdef SIGCONT
 	killpg(pgid, SIGCONT);
+#endif
 	ps = jp->ps;
 	i = jp->nprocs;
 	do {
@@ -876,11 +909,17 @@
 		else
 			pgrp = jp->ps[0].pid;
 		/* This can fail because we are doing it in the parent also */
+#ifdef HAVE_SETPGID
 		(void)setpgid(0, pgrp);
+#endif
 		if (mode == FORK_FG)
 			xtcsetpgrp(ttyfd, pgrp);
+#ifdef SIGTSTP
 		setsignal(SIGTSTP);
+#endif
+#ifdef SIGTTOU
 		setsignal(SIGTTOU);
+#endif
 	} else
 #endif
 	if (mode == FORK_BG) {
@@ -929,7 +968,9 @@
 		else
 			pgrp = jp->ps[0].pid;
 		/* This can fail because we are doing it in the child also */
+#ifdef HAVE_SETPGID
 		(void)setpgid(pid, pgrp);
+#endif
 	}
 #endif
 	if (mode == FORK_BG) {
@@ -971,7 +1012,11 @@
 	sigblockall(NULL);
 	vforked++;
 
+#ifdef HAVE_VFORK
 	pid = vfork();
+#else
+	pid = fork();
+#endif
 
 	if (!pid) {
 		forkchild(jp, n, FORK_FG);
@@ -1168,7 +1213,13 @@
 waitproc(int block, int *status)
 {
 	sigset_t oldmask;
-	int flags = block == DOWAIT_BLOCK ? 0 : WNOHANG;
+	int flags = block == DOWAIT_BLOCK ? 0 :
+#ifdef HAVE_WAIT3
+		WNOHANG
+#else
+		0
+#endif
+		;
 	int err;
 
 #if JOBS
@@ -1177,18 +1228,43 @@
 #endif
 
 	do {
-		gotsigchld = 0;
+#ifndef HAVE_WAIT3
+		if(!block && !gotsigchld) {
+			errno=10;
+			return -1;
+		}
+#endif
 		do
+#ifdef HAVE_WAIT3
 			err = wait3(status, flags, NULL);
+#else
+			err = wait(status);
+#endif
 		while (err < 0 && errno == EINTR);
 
+		if(gotsigchld) {
+			gotsigchld = 0;
+#ifndef HAVE_SIGACTION
+			/* Re-establish SIGCHLD signal handler. This
+			 * has to be done after wait, or it would
+			 * immediately raise another signal, as the
+			 * "child died" situation has not yet been
+			 * cleared */
+			signal(SIGCHLD, onsig);
+#endif
+		}
+
 		if (err || (err = -!block))
 			break;
 
 		sigblockall(&oldmask);
 
 		while (!gotsigchld && !pending_sig)
+#ifdef HAVE_SIGSUSPEND
 			sigsuspend(&oldmask);
+#else
+			pause();
+#endif
 
 		sigclearmask();
 	} while (gotsigchld);
@@ -1513,8 +1589,10 @@
 STATIC void
 xtcsetpgrp(int fd, pid_t pgrp)
 {
+#if HAVE_TCSETPGRP
 	if (tcsetpgrp(fd, pgrp))
 		sh_error("Cannot set tty process group (%s)", strerror(errno));
+#endif
 }
 #endif
 
diff -urN -x .svn ref/dash-0.5.11.5/src/memalloc.c dash/src/memalloc.c
--- ref/dash-0.5.11.5/src/memalloc.c	2018-08-29 05:16:09.000000000 +0200
+++ dash/src/memalloc.c	2022-05-30 08:18:15.122212642 +0200
@@ -66,7 +66,10 @@
 pointer
 ckrealloc(pointer p, size_t nbytes)
 {
-	p = realloc(p, nbytes);
+	if(p == NULL)
+		p = malloc(nbytes);
+	else
+		p = realloc(p, nbytes);
 	if (p == NULL)
 		sh_error("Out of space");
 	return p;
diff -urN -x .svn ref/dash-0.5.11.5/src/miscbltin.c dash/src/miscbltin.c
--- ref/dash-0.5.11.5/src/miscbltin.c	2018-03-10 08:59:26.000000000 +0100
+++ dash/src/miscbltin.c	2022-06-05 14:17:33.465316124 +0200
@@ -39,8 +39,12 @@
 #include <sys/types.h>		/* quad_t */
 #include <sys/param.h>		/* BSD4_4 */
 #include <sys/stat.h>
+#ifdef HAVE_SYS_TIME_H
 #include <sys/time.h>
+#endif
+#ifdef HAVE_SYS_RESOURCE_H
 #include <sys/resource.h>
+#endif
 #include <unistd.h>
 #include <stdlib.h>
 #include <ctype.h>
diff -urN -x .svn ref/dash-0.5.11.5/src/mksignames.c dash/src/mksignames.c
--- ref/dash-0.5.11.5/src/mksignames.c	2014-09-28 10:19:32.000000000 +0200
+++ dash/src/mksignames.c	2022-06-10 23:50:22.759137600 +0200
@@ -21,344 +21,8 @@
 
 #include <stdio.h>
 #include <sys/types.h>
-#include <signal.h>
 #include <stdlib.h>
-
-#if !defined (NSIG)
-#  define NSIG 64
-#endif
-
-/*
- * Special traps:
- *	EXIT == 0
- */
-#define LASTSIG NSIG-1
-
-char *signal_names[2 * NSIG + 3];
-
-#define signal_names_size (sizeof(signal_names)/sizeof(signal_names[0]))
-
-char *progname;
-
-/* AIX 4.3 defines SIGRTMIN and SIGRTMAX as 888 and 999 respectively.
-   I don't want to allocate so much unused space for the intervening signal
-   numbers, so we just punt if SIGRTMAX is past the bounds of the
-   signal_names array (handled in configure). */
-#if defined (SIGRTMAX) && defined (UNUSABLE_RT_SIGNALS)
-#  undef SIGRTMAX
-#  undef SIGRTMIN
-#endif
-
-#if defined (SIGRTMAX) || defined (SIGRTMIN)
-#  define RTLEN 14
-#  define RTLIM 256
-#endif
-
-void
-initialize_signames ()
-{
-  register int i;
-#if defined (SIGRTMAX) || defined (SIGRTMIN)
-  int rtmin, rtmax, rtcnt;
-#endif
-
-  for (i = 1; i < signal_names_size; i++)
-    signal_names[i] = (char *)NULL;
-
-  /* `signal' 0 is what we do on exit. */
-  signal_names[0] = "EXIT";
-
-  /* Place signal names which can be aliases for more common signal
-     names first.  This allows (for example) SIGABRT to overwrite SIGLOST. */
-
-  /* POSIX 1003.1b-1993 real time signals, but take care of incomplete
-     implementations. Acoording to the standard, both, SIGRTMIN and
-     SIGRTMAX must be defined, SIGRTMIN must be stricly less than
-     SIGRTMAX, and the difference must be at least 7, that is, there
-     must be at least eight distinct real time signals. */
-
-  /* The generated signal names are SIGRTMIN, SIGRTMIN+1, ...,
-     SIGRTMIN+x, SIGRTMAX-x, ..., SIGRTMAX-1, SIGRTMAX. If the number
-     of RT signals is odd, there is an extra SIGRTMIN+(x+1).
-     These names are the ones used by ksh and /usr/xpg4/bin/sh on SunOS5. */
-
-#if defined (SIGRTMIN)
-  rtmin = SIGRTMIN;
-  signal_names[rtmin] = "RTMIN";
-#endif
-
-#if defined (SIGRTMAX)
-  rtmax = SIGRTMAX;
-  signal_names[rtmax] = "RTMAX";
-#endif
-
-#if defined (SIGRTMAX) && defined (SIGRTMIN)
-  if (rtmax > rtmin)
-    {
-      rtcnt = (rtmax - rtmin - 1) / 2;
-      /* croak if there are too many RT signals */
-      if (rtcnt >= RTLIM/2)
-	{
-	  rtcnt = RTLIM/2-1;
-	  fprintf(stderr, "%s: error: more than %i real time signals, fix `%s'\n",
-		  progname, RTLIM, progname);
-	}
-
-      for (i = 1; i <= rtcnt; i++)
-	{
-	  signal_names[rtmin+i] = (char *)malloc(RTLEN);
-	  if (signal_names[rtmin+i])
-	    sprintf (signal_names[rtmin+i], "RTMIN+%d", i);
-	  signal_names[rtmax-i] = (char *)malloc(RTLEN);
-	  if (signal_names[rtmax-i])
-	    sprintf (signal_names[rtmax-i], "RTMAX-%d", i);
-	}
-
-      if (rtcnt < RTLIM/2-1 && rtcnt != (rtmax-rtmin)/2)
-	{
-	  /* Need an extra RTMIN signal */
-	  signal_names[rtmin+rtcnt+1] = (char *)malloc(RTLEN);
-	  if (signal_names[rtmin+rtcnt+1])
-	    sprintf (signal_names[rtmin+rtcnt+1], "RTMIN+%d", rtcnt+1);
-	}
-    }
-#endif /* SIGRTMIN && SIGRTMAX */
-
-/* AIX */
-#if defined (SIGLOST)	/* resource lost (eg, record-lock lost) */
-  signal_names[SIGLOST] = "LOST";
-#endif
-
-#if defined (SIGMSG)	/* HFT input data pending */
-  signal_names[SIGMSG] = "MSG";
-#endif
-
-#if defined (SIGDANGER)	/* system crash imminent */
-  signal_names[SIGDANGER] = "DANGER";
-#endif
-
-#if defined (SIGMIGRATE) /* migrate process to another CPU */
-  signal_names[SIGMIGRATE] = "MIGRATE";
-#endif
-
-#if defined (SIGPRE)	/* programming error */
-  signal_names[SIGPRE] = "PRE";
-#endif
-
-#if defined (SIGVIRT)	/* AIX virtual time alarm */
-  signal_names[SIGVIRT] = "VIRT";
-#endif
-
-#if defined (SIGALRM1)	/* m:n condition variables */
-  signal_names[SIGALRM1] = "ALRM1";
-#endif
-
-#if defined (SIGWAITING)	/* m:n scheduling */
-  signal_names[SIGWAITING] = "WAITING";
-#endif
-
-#if defined (SIGGRANT)	/* HFT monitor mode granted */
-  signal_names[SIGGRANT] = "GRANT";
-#endif
-
-#if defined (SIGKAP)	/* keep alive poll from native keyboard */
-  signal_names[SIGKAP] = "KAP";
-#endif
-
-#if defined (SIGRETRACT) /* HFT monitor mode retracted */
-  signal_names[SIGRETRACT] = "RETRACT";
-#endif
-
-#if defined (SIGSOUND)	/* HFT sound sequence has completed */
-  signal_names[SIGSOUND] = "SOUND";
-#endif
-
-#if defined (SIGSAK)	/* Secure Attention Key */
-  signal_names[SIGSAK] = "SAK";
-#endif
-
-/* SunOS5 */
-#if defined (SIGLWP)	/* special signal used by thread library */
-  signal_names[SIGLWP] = "LWP";
-#endif
-
-#if defined (SIGFREEZE)	/* special signal used by CPR */
-  signal_names[SIGFREEZE] = "FREEZE";
-#endif
-
-#if defined (SIGTHAW)	/* special signal used by CPR */
-  signal_names[SIGTHAW] = "THAW";
-#endif
-
-#if defined (SIGCANCEL)	/* thread cancellation signal used by libthread */
-  signal_names[SIGCANCEL] = "CANCEL";
-#endif
-
-/* HP-UX */
-#if defined (SIGDIL)	/* DIL signal (?) */
-  signal_names[SIGDIL] = "DIL";
-#endif
-
-/* System V */
-#if defined (SIGCLD)	/* Like SIGCHLD.  */
-  signal_names[SIGCLD] = "CLD";
-#endif
-
-#if defined (SIGPWR)	/* power state indication */
-  signal_names[SIGPWR] = "PWR";
-#endif
-
-#if defined (SIGPOLL)	/* Pollable event (for streams)  */
-  signal_names[SIGPOLL] = "POLL";
-#endif
-
-/* Unknown */
-#if defined (SIGWINDOW)
-  signal_names[SIGWINDOW] = "WINDOW";
-#endif
-
-/* Common */
-#if defined (SIGHUP)	/* hangup */
-  signal_names[SIGHUP] = "HUP";
-#endif
-
-#if defined (SIGINT)	/* interrupt */
-  signal_names[SIGINT] = "INT";
-#endif
-
-#if defined (SIGQUIT)	/* quit */
-  signal_names[SIGQUIT] = "QUIT";
-#endif
-
-#if defined (SIGILL)	/* illegal instruction (not reset when caught) */
-  signal_names[SIGILL] = "ILL";
-#endif
-
-#if defined (SIGTRAP)	/* trace trap (not reset when caught) */
-  signal_names[SIGTRAP] = "TRAP";
-#endif
-
-#if defined (SIGIOT)	/* IOT instruction */
-  signal_names[SIGIOT] = "IOT";
-#endif
-
-#if defined (SIGABRT)	/* Cause current process to dump core. */
-  signal_names[SIGABRT] = "ABRT";
-#endif
-
-#if defined (SIGEMT)	/* EMT instruction */
-  signal_names[SIGEMT] = "EMT";
-#endif
-
-#if defined (SIGFPE)	/* floating point exception */
-  signal_names[SIGFPE] = "FPE";
-#endif
-
-#if defined (SIGKILL)	/* kill (cannot be caught or ignored) */
-  signal_names[SIGKILL] = "KILL";
-#endif
-
-#if defined (SIGBUS)	/* bus error */
-  signal_names[SIGBUS] = "BUS";
-#endif
-
-#if defined (SIGSEGV)	/* segmentation violation */
-  signal_names[SIGSEGV] = "SEGV";
-#endif
-
-#if defined (SIGSYS)	/* bad argument to system call */
-  signal_names[SIGSYS] = "SYS";
-#endif
-
-#if defined (SIGPIPE)	/* write on a pipe with no one to read it */
-  signal_names[SIGPIPE] = "PIPE";
-#endif
-
-#if defined (SIGALRM)	/* alarm clock */
-  signal_names[SIGALRM] = "ALRM";
-#endif
-
-#if defined (SIGTERM)	/* software termination signal from kill */
-  signal_names[SIGTERM] = "TERM";
-#endif
-
-#if defined (SIGURG)	/* urgent condition on IO channel */
-  signal_names[SIGURG] = "URG";
-#endif
-
-#if defined (SIGSTOP)	/* sendable stop signal not from tty */
-  signal_names[SIGSTOP] = "STOP";
-#endif
-
-#if defined (SIGTSTP)	/* stop signal from tty */
-  signal_names[SIGTSTP] = "TSTP";
-#endif
-
-#if defined (SIGCONT)	/* continue a stopped process */
-  signal_names[SIGCONT] = "CONT";
-#endif
-
-#if defined (SIGCHLD)	/* to parent on child stop or exit */
-  signal_names[SIGCHLD] = "CHLD";
-#endif
-
-#if defined (SIGTTIN)	/* to readers pgrp upon background tty read */
-  signal_names[SIGTTIN] = "TTIN";
-#endif
-
-#if defined (SIGTTOU)	/* like TTIN for output if (tp->t_local&LTOSTOP) */
-  signal_names[SIGTTOU] = "TTOU";
-#endif
-
-#if defined (SIGIO)	/* input/output possible signal */
-  signal_names[SIGIO] = "IO";
-#endif
-
-#if defined (SIGXCPU)	/* exceeded CPU time limit */
-  signal_names[SIGXCPU] = "XCPU";
-#endif
-
-#if defined (SIGXFSZ)	/* exceeded file size limit */
-  signal_names[SIGXFSZ] = "XFSZ";
-#endif
-
-#if defined (SIGVTALRM)	/* virtual time alarm */
-  signal_names[SIGVTALRM] = "VTALRM";
-#endif
-
-#if defined (SIGPROF)	/* profiling time alarm */
-  signal_names[SIGPROF] = "PROF";
-#endif
-
-#if defined (SIGWINCH)	/* window changed */
-  signal_names[SIGWINCH] = "WINCH";
-#endif
-
-/* 4.4 BSD */
-#if defined (SIGINFO) && !defined (_SEQUENT_)	/* information request */
-  signal_names[SIGINFO] = "INFO";
-#endif
-
-#if defined (SIGUSR1)	/* user defined signal 1 */
-  signal_names[SIGUSR1] = "USR1";
-#endif
-
-#if defined (SIGUSR2)	/* user defined signal 2 */
-  signal_names[SIGUSR2] = "USR2";
-#endif
-
-#if defined (SIGKILLTHR)	/* BeOS: Kill Thread */
-  signal_names[SIGKILLTHR] = "KILLTHR";
-#endif
-
-  for (i = 0; i < NSIG; i++)
-    if (signal_names[i] == (char *)NULL)
-      {
-	signal_names[i] = (char *)malloc (18);
-	if (signal_names[i])
-	  sprintf (signal_names[i], "%d", i);
-      }
-}
+#include "mksignames.h"
 
 void
 write_signames (stream)
@@ -372,7 +36,7 @@
   fprintf (stream, "#include <signal.h>\n\n");
   fprintf (stream,
 	   "/* A translation list so we can be polite to our users. */\n");
-  fprintf (stream, "const char *const signal_names[NSIG + 1] = {\n");
+  fprintf (stream, "const char *const signal_names[%d] = {\n", LASTSIG + 2);
 
   for (i = 0; i <= LASTSIG; i++)
     fprintf (stream, "    \"%s\",\n", signal_names[i]);
diff -urN -x .svn ref/dash-0.5.11.5/src/mksignames.tmpl.h dash/src/mksignames.tmpl.h
--- ref/dash-0.5.11.5/src/mksignames.tmpl.h	1970-01-01 01:00:00.000000000 +0100
+++ dash/src/mksignames.tmpl.h	2022-06-10 23:45:10.494817070 +0200
@@ -0,0 +1,349 @@
+#include <sys/types.h>
+#include <signal.h>
+
+START
+
+#if !defined (NSIG)
+#  define NSIG 64
+#endif
+
+/*
+ * Special traps:
+ *	EXIT == 0
+ */
+static int LASTSIG = NSIG-1;
+
+char *signal_names[2 * NSIG + 3];
+#define ARRAY_SIZE (2 * NSIG + 3)
+
+#define signal_names_size (sizeof(signal_names)/sizeof(signal_names[0]))
+
+char *progname;
+
+/* AIX 4.3 defines SIGRTMIN and SIGRTMAX as 888 and 999 respectively.
+   I don't want to allocate so much unused space for the intervening signal
+   numbers, so we just punt if SIGRTMAX is past the bounds of the
+   signal_names array (handled in configure). */
+#if defined (SIGRTMAX) && defined (UNUSABLE_RT_SIGNALS)
+#  undef SIGRTMAX
+#  undef SIGRTMIN
+#endif
+
+#if defined (SIGRTMAX) || defined (SIGRTMIN)
+#  define RTLEN 14
+#  define RTLIM 256
+#endif
+
+void
+initialize_signames ()
+{
+  register int i;
+#if defined (SIGRTMAX) || defined (SIGRTMIN)
+  int rtmin, rtmax, rtcnt;
+#endif
+
+  for (i = 1; i < signal_names_size; i++)
+    signal_names[i] = (char *)NULL;
+
+  /* `signal' 0 is what we do on exit. */
+  signal_names[0] = "EXIT";
+
+  /* Place signal names which can be aliases for more common signal
+     names first.  This allows (for example) SIGABRT to overwrite SIGLOST. */
+
+  /* POSIX 1003.1b-1993 real time signals, but take care of incomplete
+     implementations. Acoording to the standard, both, SIGRTMIN and
+     SIGRTMAX must be defined, SIGRTMIN must be stricly less than
+     SIGRTMAX, and the difference must be at least 7, that is, there
+     must be at least eight distinct real time signals. */
+
+  /* The generated signal names are SIGRTMIN, SIGRTMIN+1, ...,
+     SIGRTMIN+x, SIGRTMAX-x, ..., SIGRTMAX-1, SIGRTMAX. If the number
+     of RT signals is odd, there is an extra SIGRTMIN+(x+1).
+     These names are the ones used by ksh and /usr/xpg4/bin/sh on SunOS5. */
+
+#if defined (SIGRTMIN)
+  rtmin = SIGRTMIN;
+  if(rtmin < ARRAY_SIZE)
+    signal_names[rtmin] = "RTMIN";
+#endif
+
+#if defined (SIGRTMAX)
+  rtmax = SIGRTMAX;
+  if(rtmax < ARRAY_SIZE)
+    signal_names[rtmax] = "RTMAX";
+#endif
+
+#if defined (SIGRTMAX) && defined (SIGRTMIN)
+  if (rtmax > rtmin)
+    {
+      rtcnt = (rtmax - rtmin - 1) / 2;
+      /* croak if there are too many RT signals */
+      if (rtcnt >= RTLIM/2)
+	{
+	  rtcnt = RTLIM/2-1;
+	  fprintf(stderr, "%s: error: more than %i real time signals, fix `%s'\n",
+		  progname, RTLIM, progname);
+	}
+
+      for (i = 1; i <= rtcnt; i++)
+	{
+	  if (rtmin+i < ARRAY_SIZE) {
+	    signal_names[rtmin+i] = (char *)malloc(RTLEN);
+	    if(signal_names[rtmin+i])
+	      sprintf (signal_names[rtmin+i], "RTMIN+%d", i);
+	  }
+	  if (rtmax-i < ARRAY_SIZE) {
+	    signal_names[rtmax-i] = (char *)malloc(RTLEN);
+	    if(signal_names[rtmax-i])
+	      sprintf (signal_names[rtmax-i], "RTMAX-%d", i);
+	  }
+	}
+
+      if (rtcnt < RTLIM/2-1 && rtcnt != (rtmax-rtmin)/2)
+	{
+	  if (rtmin+rtcnt+1 < ARRAY_SIZE) {
+	    /* Need an extra RTMIN signal */
+	    signal_names[rtmin+rtcnt+1] = (char *)malloc(RTLEN);
+	    if (signal_names[rtmin+rtcnt+1])
+	      sprintf (signal_names[rtmin+rtcnt+1], "RTMIN+%d", rtcnt+1);
+	  }
+	}
+    }
+#endif /* SIGRTMIN && SIGRTMAX */
+
+/* AIX */
+#if defined (SIGLOST)	/* resource lost (eg, record-lock lost) */
+  signal_names[SIGLOST] = "LOST";
+#endif
+
+#if defined (SIGMSG)	/* HFT input data pending */
+  signal_names[SIGMSG] = "MSG";
+#endif
+
+#if defined (SIGDANGER)	/* system crash imminent */
+  signal_names[SIGDANGER] = "DANGER";
+#endif
+
+#if defined (SIGMIGRATE) /* migrate process to another CPU */
+  signal_names[SIGMIGRATE] = "MIGRATE";
+#endif
+
+#if defined (SIGPRE)	/* programming error */
+  signal_names[SIGPRE] = "PRE";
+#endif
+
+#if defined (SIGVIRT)	/* AIX virtual time alarm */
+  signal_names[SIGVIRT] = "VIRT";
+#endif
+
+#if defined (SIGALRM1)	/* m:n condition variables */
+  signal_names[SIGALRM1] = "ALRM1";
+#endif
+
+#if defined (SIGWAITING)	/* m:n scheduling */
+  signal_names[SIGWAITING] = "WAITING";
+#endif
+
+#if defined (SIGGRANT)	/* HFT monitor mode granted */
+  signal_names[SIGGRANT] = "GRANT";
+#endif
+
+#if defined (SIGKAP)	/* keep alive poll from native keyboard */
+  signal_names[SIGKAP] = "KAP";
+#endif
+
+#if defined (SIGRETRACT) /* HFT monitor mode retracted */
+  signal_names[SIGRETRACT] = "RETRACT";
+#endif
+
+#if defined (SIGSOUND)	/* HFT sound sequence has completed */
+  signal_names[SIGSOUND] = "SOUND";
+#endif
+
+#if defined (SIGSAK)	/* Secure Attention Key */
+  signal_names[SIGSAK] = "SAK";
+#endif
+
+/* SunOS5 */
+#if defined (SIGLWP)	/* special signal used by thread library */
+  signal_names[SIGLWP] = "LWP";
+#endif
+
+#if defined (SIGFREEZE)	/* special signal used by CPR */
+  signal_names[SIGFREEZE] = "FREEZE";
+#endif
+
+#if defined (SIGTHAW)	/* special signal used by CPR */
+  signal_names[SIGTHAW] = "THAW";
+#endif
+
+#if defined (SIGCANCEL)	/* thread cancellation signal used by libthread */
+  signal_names[SIGCANCEL] = "CANCEL";
+#endif
+
+/* HP-UX */
+#if defined (SIGDIL)	/* DIL signal (?) */
+  signal_names[SIGDIL] = "DIL";
+#endif
+
+/* System V */
+#if defined (SIGCLD)	/* Like SIGCHLD.  */
+  signal_names[SIGCLD] = "CLD";
+#endif
+
+#if defined (SIGPWR)	/* power state indication */
+  signal_names[SIGPWR] = "PWR";
+#endif
+
+#if defined (SIGPOLL)	/* Pollable event (for streams)  */
+  signal_names[SIGPOLL] = "POLL";
+#endif
+
+/* Unknown */
+#if defined (SIGWINDOW)
+  signal_names[SIGWINDOW] = "WINDOW";
+#endif
+
+/* Common */
+#if defined (SIGHUP)	/* hangup */
+  signal_names[SIGHUP] = "HUP";
+#endif
+
+#if defined (SIGINT)	/* interrupt */
+  signal_names[SIGINT] = "INT";
+#endif
+
+#if defined (SIGQUIT)	/* quit */
+  signal_names[SIGQUIT] = "QUIT";
+#endif
+
+#if defined (SIGILL)	/* illegal instruction (not reset when caught) */
+  signal_names[SIGILL] = "ILL";
+#endif
+
+#if defined (SIGTRAP)	/* trace trap (not reset when caught) */
+  signal_names[SIGTRAP] = "TRAP";
+#endif
+
+#if defined (SIGIOT)	/* IOT instruction */
+  signal_names[SIGIOT] = "IOT";
+#endif
+
+#if defined (SIGABRT)	/* Cause current process to dump core. */
+  signal_names[SIGABRT] = "ABRT";
+#endif
+
+#if defined (SIGEMT)	/* EMT instruction */
+  signal_names[SIGEMT] = "EMT";
+#endif
+
+#if defined (SIGFPE)	/* floating point exception */
+  signal_names[SIGFPE] = "FPE";
+#endif
+
+#if defined (SIGKILL)	/* kill (cannot be caught or ignored) */
+  signal_names[SIGKILL] = "KILL";
+#endif
+
+#if defined (SIGBUS)	/* bus error */
+  signal_names[SIGBUS] = "BUS";
+#endif
+
+#if defined (SIGSEGV)	/* segmentation violation */
+  signal_names[SIGSEGV] = "SEGV";
+#endif
+
+#if defined (SIGSYS)	/* bad argument to system call */
+  signal_names[SIGSYS] = "SYS";
+#endif
+
+#if defined (SIGPIPE)	/* write on a pipe with no one to read it */
+  signal_names[SIGPIPE] = "PIPE";
+#endif
+
+#if defined (SIGALRM)	/* alarm clock */
+  signal_names[SIGALRM] = "ALRM";
+#endif
+
+#if defined (SIGTERM)	/* software termination signal from kill */
+  signal_names[SIGTERM] = "TERM";
+#endif
+
+#if defined (SIGURG)	/* urgent condition on IO channel */
+  signal_names[SIGURG] = "URG";
+#endif
+
+#if defined (SIGSTOP)	/* sendable stop signal not from tty */
+  signal_names[SIGSTOP] = "STOP";
+#endif
+
+#if defined (SIGTSTP)	/* stop signal from tty */
+  signal_names[SIGTSTP] = "TSTP";
+#endif
+
+#if defined (SIGCONT)	/* continue a stopped process */
+  signal_names[SIGCONT] = "CONT";
+#endif
+
+#if defined (SIGCHLD)	/* to parent on child stop or exit */
+  signal_names[SIGCHLD] = "CHLD";
+#endif
+
+#if defined (SIGTTIN)	/* to readers pgrp upon background tty read */
+  signal_names[SIGTTIN] = "TTIN";
+#endif
+
+#if defined (SIGTTOU)	/* like TTIN for output if (tp->t_local&LTOSTOP) */
+  signal_names[SIGTTOU] = "TTOU";
+#endif
+
+#if defined (SIGIO)	/* input/output possible signal */
+  signal_names[SIGIO] = "IO";
+#endif
+
+#if defined (SIGXCPU)	/* exceeded CPU time limit */
+  signal_names[SIGXCPU] = "XCPU";
+#endif
+
+#if defined (SIGXFSZ)	/* exceeded file size limit */
+  signal_names[SIGXFSZ] = "XFSZ";
+#endif
+
+#if defined (SIGVTALRM)	/* virtual time alarm */
+  signal_names[SIGVTALRM] = "VTALRM";
+#endif
+
+#if defined (SIGPROF)	/* profiling time alarm */
+  signal_names[SIGPROF] = "PROF";
+#endif
+
+#if defined (SIGWINCH)	/* window changed */
+  signal_names[SIGWINCH] = "WINCH";
+#endif
+
+/* 4.4 BSD */
+#if defined (SIGINFO) && !defined (_SEQUENT_)	/* information request */
+  signal_names[SIGINFO] = "INFO";
+#endif
+
+#if defined (SIGUSR1)	/* user defined signal 1 */
+  signal_names[SIGUSR1] = "USR1";
+#endif
+
+#if defined (SIGUSR2)	/* user defined signal 2 */
+  signal_names[SIGUSR2] = "USR2";
+#endif
+
+#if defined (SIGKILLTHR)	/* BeOS: Kill Thread */
+  signal_names[SIGKILLTHR] = "KILLTHR";
+#endif
+
+  for (i = 0; i < NSIG; i++)
+    if (signal_names[i] == (char *)NULL)
+      {
+	signal_names[i] = (char *)malloc (18);
+	if (signal_names[i])
+	  sprintf (signal_names[i], "%d", i);
+      }
+}
diff -urN -x .svn ref/dash-0.5.11.5/src/output.c dash/src/output.c
--- ref/dash-0.5.11.5/src/output.c	2019-02-25 05:52:11.000000000 +0100
+++ dash/src/output.c	2022-06-10 21:52:55.947242913 +0200
@@ -75,7 +75,7 @@
 };
 struct output errout = {
 	.stream = 0, .nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = 2, .flags = 0
-}
+};
 #ifdef notyet
 struct output memout = {
 	.stream = 0, .nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = MEM_OUT, .flags = 0
@@ -88,13 +88,13 @@
 struct output errout = {
 	.nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = 2, .flags = 0
 };
-struct output preverrout;
 #ifdef notyet
 struct output memout = {
 	.nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = MEM_OUT, .flags = 0
 };
 #endif
 #endif
+struct output preverrout;
 struct output *out1 = &output;
 struct output *out2 = &errout;
 
@@ -213,7 +213,6 @@
 }
 
 
-#ifndef USE_GLIBC_STDIO
 
 
 void
@@ -222,7 +221,6 @@
 	char buf = c;
 	outmem(&buf, 1, dest);
 }
-#endif
 
 
 void
@@ -376,7 +374,6 @@
 }
 
 
-#ifdef notyet
 #ifdef USE_GLIBC_STDIO
 void initstreams() {
 	output.stream = stdout;
@@ -384,6 +381,7 @@
 }
 
 
+#ifdef notyet
 void
 openmemout(void) {
 	INTOFF;
diff -urN -x .svn ref/dash-0.5.11.5/src/output.h dash/src/output.h
--- ref/dash-0.5.11.5/src/output.h	2014-10-27 05:18:12.000000000 +0100
+++ dash/src/output.h	2022-06-10 21:49:03.189056553 +0200
@@ -42,6 +42,8 @@
 #endif
 #include <sys/types.h>
 
+#include "system.h"
+
 struct output {
 #ifdef USE_GLIBC_STDIO
 	FILE *stream;
@@ -81,13 +83,11 @@
 void doformat(struct output *, const char *, va_list);
 #endif
 int xwrite(int, const void *, size_t);
-#ifdef notyet
 #ifdef USE_GLIBC_STDIO
 void initstreams(void);
 void openmemout(void);
 int __closememout(void);
 #endif
-#endif
 
 static inline void
 freestdout()
diff -urN -x .svn ref/dash-0.5.11.5/src/redir.c dash/src/redir.c
--- ref/dash-0.5.11.5/src/redir.c	2021-09-03 09:01:45.000000000 +0200
+++ dash/src/redir.c	2022-06-10 21:38:36.000372433 +0200
@@ -176,7 +176,11 @@
 		out2 = &memout;
 #endif
 	if (flags & REDIR_SAVEFD2 && sv->renamed[2] >= 0)
+#ifdef USE_GLIBC_STDIO
+		preverrout.stream = fdopen(sv->renamed[2],"a");
+#else
 		preverrout.fd = sv->renamed[2];
+#endif
 }
 
 
diff -urN -x .svn ref/dash-0.5.11.5/src/shell.h dash/src/shell.h
--- ref/dash-0.5.11.5/src/shell.h	2014-09-28 10:19:32.000000000 +0200
+++ dash/src/shell.h	2022-05-31 12:53:12.362105119 +0200
@@ -82,6 +82,10 @@
 #define TRACEV(param)
 #endif
 
+#if !defined SIGCHLD && defined SIGCLD
+# define SIGCHLD SIGCLD
+#endif
+
 #if defined(__GNUC__) && __GNUC__ < 3
 #define va_copy __va_copy
 #endif
diff -urN -x .svn ref/dash-0.5.11.5/src/system.c dash/src/system.c
--- ref/dash-0.5.11.5/src/system.c	2022-06-05 11:23:38.603392873 +0200
+++ dash/src/system.c	2022-06-10 23:49:45.974157507 +0200
@@ -26,8 +26,15 @@
  * SUCH DAMAGE.
  */
 
+#ifndef HAVE_ISALPHA
+#include <ctype.h>
+#endif
+
 #include <signal.h>
 #include <string.h>
+#ifdef HAVE_FCNTL_H
+#include <fcntl.h>
+#endif
 
 #include "error.h"
 #include "output.h"
@@ -64,6 +71,10 @@
 {
 	static char buf[19];
 
+#if !HAVE_DECL_SYS_SIGLIST
+	extern char *signal_names[];
+# define sys_siglist signal_names
+#endif
 	if ((unsigned)sig < NSIG && sys_siglist[sig])
 		return (char *)sys_siglist[sig];
 	fmtstr(buf, sizeof(buf), "Signal %d", sig); 
@@ -100,3 +111,198 @@
 	sh_error("no sysconf for: %d", name);
 }
 #endif
+
+
+#ifndef HAVE_DUP2
+int dup2(int a, int b)
+{
+	close(b);
+	return fcntl(a, F_DUPFD, b);
+}
+#endif
+
+#ifndef HAVE_STRSTR
+char * strstr (const char* haystack, const char *needle)
+{
+	const char *start;
+	int i;
+	if (!haystack) return 0;
+	for(start=haystack; *start;start++) {
+		for(i=0; start[i] && needle[i]; i++)
+			if(start[i] != needle[i])
+				break;
+		if(!needle[i])
+			return (char *)start;
+	}
+	return NULL;
+}
+#endif
+
+#ifndef HAVE_STRNDUP
+char *strdup(const char *str)
+{
+    char *nstr;
+
+    if (str == (char*)0)
+        return 0;
+
+    nstr = (char*)malloc((strlen(str) + 1));
+
+    if (nstr == (char*)0)
+    {
+        (void)fprintf(stderr, "strdup(): not enough memory to duplicate `%s'\n",
+		      str);
+	exit(1);
+    }
+
+    (void)strcpy(nstr, str);
+
+    return nstr;
+}
+#endif
+
+#ifndef HAVE_STRCASECMP
+int strcasecmp(const char *s1, const char *s2)
+{
+  register const unsigned char *p1 = (const unsigned char *) s1;
+  register const unsigned char *p2 = (const unsigned char *) s2;
+  unsigned char c1, c2;
+
+  if (p1 == p2)
+    return 0;
+
+  do
+    {
+      c1 = tolower (*p1++);
+      c2 = tolower (*p2++);
+      if (c1 == '\0')
+	break;
+    }
+  while (c1 == c2);
+
+  return c1 - c2;
+}
+#endif
+
+#if 0
+static int getdigit(char a, int max)
+{
+	int dig;
+
+	if(a < '0')
+		return -1;
+	if(a <= '9') {
+		dig = a - '0';
+	} else if(a >= 'a')
+		dig = a - 'a' + 10;
+	else if(a >= 'A')
+		dig = a - 'A' + 10;
+	else
+		return -1;
+	if(dig >= max)
+		return -1;
+	else
+		return dig;
+}
+
+extern int errno;
+unsigned long strtoull(const char *string, char **eptr, int base)
+{
+	unsigned long long accu, dig;
+	if(base < 1 || base > 36) {
+		if(string[0] == '0') {
+			switch(string[1]) {
+			       	case 'x':
+				case 'X':
+					return strtoull(string+2, eptr, 16);
+				case 'b':
+			       	case 'B':
+					return strtoull(string+2, eptr, 2);
+				default:
+					return strtoull(string, eptr, 8);
+			}
+		}
+	       	return strtoull(string, eptr, 10);
+	}
+	if(base == 16 && string[0] == '0' &&
+	   (string[1] == 'x' || string[1] == 'X'))
+		string += 2;
+
+	if(base == 2 && string[0] == '0' &&
+	   (string[1] == 'b' || string[1] == 'B'))
+		string += 2;
+	accu = 0;
+	while( (dig = getdigit(*string, base)) != -1 ) {
+		accu = accu * base + dig;
+		string++;
+	}
+	if(eptr)
+		*eptr = (char *) string;
+	return accu;
+}
+
+long strtoll(const char *string, char **eptr, int base)
+{
+	if(*string == '-') {
+		return - (long) strtoull(string+1, eptr, base);
+	} else
+		return (long) strtoull(string, eptr, base);
+}
+#endif
+
+#ifndef HAVE_STRTOUL
+unsigned long strtoul(const char *string, char **eptr, int base)
+{
+	return (unsigned long) strtol(string, eptr, base);
+}
+#endif
+
+#ifndef HAVE_RAISE
+int raise(int sig)
+{
+	return kill(getpid(),sig);
+}
+#endif
+
+#ifndef HAVE_STRERROR
+char *strerror(int x) {
+	extern char *sys_errlist[];
+	return sys_errlist[x];
+}
+#endif
+
+#ifndef HAVE_STPNCPY
+char *stpncpy(char *dst, const char *src, int len)
+{
+	int i,nullSeen=0;
+	char *ret=dst+len;
+	for(i=0; i<len; i++) {
+		if(nullSeen)
+			dst[i] = '\0';
+		else {
+			dst[i] = src[i];
+			if(dst[i] == '\0') {
+				nullSeen = 1;
+				ret = dst+i;
+			}
+		}
+	}
+	return ret;
+}
+#endif
+
+#ifndef HAVE_VSNPRINTF
+int vsnprintf(char *str, size_t size, const char *format, va_list ap)
+{
+	char buffer[4096];
+	int ret;
+	int n;
+	ret = vsprintf(buffer, format, ap);
+	if(ret < 0 || size == 0)
+		return ret;
+	n = (ret >= size) ? size - 1 : ret;
+	strncpy(str, buffer, n);
+	str[n]='\0';
+	return ret;
+}
+#endif
diff -urN -x .svn ref/dash-0.5.11.5/src/system.h dash/src/system.h
--- ref/dash-0.5.11.5/src/system.h	2018-12-14 06:48:03.000000000 +0100
+++ dash/src/system.h	2022-06-05 17:38:13.661022658 +0200
@@ -26,12 +26,14 @@
  * SUCH DAMAGE.
  */
 
+#ifndef SYSTEM_INCL
+
 #include <limits.h>
 #include <signal.h>
 #include <sys/types.h>
 
 #ifndef SSIZE_MAX
-#define SSIZE_MAX ((ssize_t)((size_t)-1 >> 1))
+#define SSIZE_MAX ((1 << (sizeof(ssize_t)*8-1))-1)
 #endif
 
 static inline void sigclearmask(void)
@@ -48,9 +50,11 @@
 #pragma GCC diagnostic pop
 #endif
 #else
+# ifdef HAVE_SIGPROCMASK
 	sigset_t set;
 	sigemptyset(&set);
 	sigprocmask(SIG_SETMASK, &set, 0);
+# endif
 #endif
 }
 
@@ -79,11 +83,19 @@
 #endif
 
 #ifndef HAVE_STRTOIMAX
+#if SIZEOF_INTMAX_T > SIZEOF_LONG_INT
 #define strtoimax strtoll
+#else
+#define strtoimax strtol
+#endif
 #endif
 
 #ifndef HAVE_STRTOUMAX
+#if SIZEOF_INTMAX_T > SIZEOF_LONG_INT
 #define strtoumax strtoull
+#else
+#define strtoumax strtoul
+#endif
 #endif
 
 #ifndef HAVE_BSEARCH
@@ -91,6 +103,8 @@
 	      int (*)(const void *, const void *));
 #endif
 
+#include <stdio.h>
+
 #ifndef HAVE_KILLPG
 static inline int killpg(pid_t pid, int signal)
 {
@@ -98,7 +112,13 @@
 	if (pid < 0)
 		abort();
 #endif
-	return kill(-pid, signal);
+	return kill(
+#ifdef HAVE_SETPGID
+		    -pid
+#else
+		    pid
+#endif
+		    , signal);
 }
 #endif
 
@@ -116,3 +136,105 @@
  * code
  */
 #define uninitialized_var(x) x = x
+
+#if (defined O_NDELAY && !defined O_NONBLOCK)
+# define O_NONBLOCK O_NDELAY
+#endif
+
+#if !defined SIGCHLD && defined SIGCLD
+# define SIGCHLD SIGCLD
+#endif
+
+#ifndef FD_CLOEXEC
+# define FD_CLOEXEC 1
+#endif
+
+#ifndef WEXITSTATUS
+
+/* If WIFEXITED(STATUS), the low-order 8 bits of the status.  */
+#undef WEXITSTATUS
+#define	WEXITSTATUS(status)	(((status) & 0xff00) >> 8)
+
+/* If WIFSIGNALED(STATUS), the terminating signal.  */
+#undef WTERMSIG
+#define	WTERMSIG(status)	((status) & 0x7f)
+
+/* If WIFSTOPPED(STATUS), the signal that stopped the child.  */
+#undef WSTOPSIG
+#define	WSTOPSIG(status)	WEXITSTATUS(status)
+
+/* Nonzero if STATUS indicates normal termination.  */
+#undef WIFEXITED
+#define	WIFEXITED(status)	(WTERMSIG(status) == 0)
+
+/* Nonzero if STATUS indicates termination by a signal.  */
+#undef WIFSIGNALED
+#define WIFSIGNALED(status) \
+  (((signed char) (((status) & 0x7f) + 1) >> 1) > 0)
+
+/* Nonzero if STATUS indicates the child is stopped.  */
+#undef WIFSTOPPED
+#define	WIFSTOPPED(status)	(((status) & 0xff) == 0x7f)
+
+/* Nonzero if STATUS indicates the child dumped core.  */
+#undef WCOREDUMP
+#ifndef WCOREFLAG
+# define	WCOREFLAG		0x80
+#endif
+#define	WCOREDUMP(status)	((status) & WCOREFLAG)
+
+#endif
+
+#ifndef HAVE_STRSTR
+extern char * strstr (const char* haystack, const char *needle);
+#endif
+
+#ifndef PATH_MAX
+#define PATH_MAX 1024
+#endif
+
+#ifndef NAME_MAX
+#define NAME_MAX 14
+#endif
+
+#ifndef S_ISREG
+#define S_ISREG(x) ((x) & S_IFREG)
+#endif
+#ifndef S_ISDIR
+#define S_ISDIR(x) ((x) & S_IFDIR)
+#endif
+#ifndef S_ISCHR
+#define S_ISCHR(x) ((x) & S_IFCHR)
+#endif
+#ifndef S_ISBLK
+#define S_ISBLK(x) ((x) & S_IFBLK)
+#endif
+
+#ifndef S_IFFIFO
+#define S_IFFIFO 0
+#endif
+#ifndef S_ISFIFO
+#define S_ISFIFO(x) ((x) & S_IFFIFO)
+#endif
+
+#ifndef S_IFSOCK
+#define S_IFSOCK 0
+#endif
+#ifndef S_ISSOCK
+#define S_ISSOCK(x) ((x) & S_IFSOCK)
+#endif
+
+#ifndef S_IFLNK
+#define S_IFLNK 0
+#endif
+#ifndef S_ISLNK
+#define S_ISLNK(x) ((x) & S_IFLNK)
+#endif
+
+#ifndef HAVE_LSTAT
+#define lstat stat
+#endif
+
+#define SYSTEM_INCL
+#endif
+
diff -urN -x .svn ref/dash-0.5.11.5/src/trap.c dash/src/trap.c
--- ref/dash-0.5.11.5/src/trap.c	2021-05-17 08:40:16.000000000 +0200
+++ dash/src/trap.c	2022-06-10 21:40:05.518755116 +0200
@@ -85,6 +85,7 @@
 #ifdef mkinit
 INCLUDE "memalloc.h"
 INCLUDE "trap.h"
+INCLUDE "system.h"
 
 INIT {
 	sigmode[SIGCHLD - 1] = S_DFL;
@@ -179,7 +180,16 @@
 	int action;
 	int lvforked;
 	char *t, tsig;
+#ifdef HAVE_SIGACTION
 	struct sigaction act;
+#define SIGNAL(signo) sigaction(signo, &act,0)
+#define HDLR act.sa_handler
+#else
+	typedef void (*sighandler_t)(int);
+	sighandler_t *hdlr;
+#define SIGNAL(signo) signal(signo, hdlr)	
+#define HDLR hdlr
+#endif
 
 	lvforked = vforked;
 
@@ -206,12 +216,18 @@
 				action = S_IGN;
 			break;
 #if JOBS
+#ifdef SIGTSTP
 		case SIGTSTP:
+#endif
+#ifdef SIGTTOU
 		case SIGTTOU:
+#endif
+#if defined SIGTSTP || defined SIGTTOU
 			if (mflag)
 				action = S_IGN;
 			break;
 #endif
+#endif
 		}
 	}
 
@@ -220,6 +236,7 @@
 
 	t = &sigmode[signo - 1];
 	tsig = *t;
+#ifdef HAVE_SIGACTION
 	if (tsig == 0) {
 		/*
 		 * current setting unknown
@@ -233,32 +250,37 @@
 			return;
 		}
 		if (act.sa_handler == SIG_IGN) {
+#ifdef SIGTSTP
 			if (mflag && (signo == SIGTSTP ||
-			     signo == SIGTTIN || signo == SIGTTOU)) {
-				tsig = S_IGN;	/* don't hard ignore these */
+                            signo == SIGTTIN || signo == SIGTTOU)) {
+				tsig = S_IGN;   /* don't hard ignore these */
 			} else
+#endif
 				tsig = S_HARD_IGN;
 		} else {
 			tsig = S_RESET;	/* force to be set */
 		}
 	}
+#endif
 	if (tsig == S_HARD_IGN || tsig == action)
 		return;
 	switch (action) {
 	case S_CATCH:
-		act.sa_handler = onsig;
+		HDLR = onsig;
 		break;
 	case S_IGN:
-		act.sa_handler = SIG_IGN;
+		HDLR = SIG_IGN;
 		break;
 	default:
-		act.sa_handler = SIG_DFL;
+		HDLR = SIG_DFL;
 	}
 	if (!lvforked)
 		*t = action;
+#ifdef HAVE_SIGACTION
 	act.sa_flags = 0;
 	sigfillset(&act.sa_mask);
-	sigaction(signo, &act, 0);
+#endif
+	SIGNAL(signo);
 }
 
 /*
@@ -284,6 +306,10 @@
 void
 onsig(int signo)
 {
+#ifndef HAVE_SIGACTION
+	if(signo != SIGCHLD)
+		signal(signo, onsig);
+#endif
 	if (vforked)
 		return;
 
@@ -439,8 +465,13 @@
 
 void sigblockall(sigset_t *oldmask)
 {
+#ifdef HAVE_SIGPROCMASK
 	sigset_t mask;
 
 	sigfillset(&mask);
 	sigprocmask(SIG_SETMASK, &mask, oldmask);
+#else
+	if(oldmask)
+		*oldmask = 0;
+#endif
 }
diff -urN -x .svn ref/dash-0.5.11.5/src/var.c dash/src/var.c
--- ref/dash-0.5.11.5/src/var.c	2021-05-17 08:40:16.000000000 +0200
+++ dash/src/var.c	2022-06-10 21:59:05.293054207 +0200
@@ -390,7 +390,13 @@
 		if (*p)
 			q = single_quote(++p);
 
+#ifdef HAVE_VSNPRINTF
 		out1fmt("%s%s%.*s%s\n", prefix, sep, (int)(p - *ep), *ep, q);
+#else
+		out1fmt("%s%s%.*s", prefix, sep, (int)(p - *ep), *ep);
+		outstr(q, out1);
+		outcslow('\n', out1);
+#endif
 	}
 
 	return 0;
