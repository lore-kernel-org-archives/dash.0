From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] [BUILTIN] Fix "test -x" as root on FreeBSD 8
Date: Tue, 27 Sep 2011 18:19:06 -0500
Message-ID: <20110927231906.GC19549@elie>
References: <20110926211636.GA6645@elie>
 <20110926221648.GF5629@elie>
 <20110927134517.GA30958@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62573 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab1I0XTP convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 27 Sep 2011 19:19:15 -0400
Received: by yib18 with SMTP id 18so5786366yib.19
        for <dash@vger.kernel.org>; Tue, 27 Sep 2011 16:19:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110927134517.GA30958@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, Christoph Egger <christoph@debian.org>, Petr Salinger <Petr.Salinger@seznam.cz>

POSIX.1-2008 =C2=A74.4 "File Access Permission" sayeth:

	If execute permission is requested, access shall be granted
	if execute permission is granted to at least one user by the
	file permission bits or by an alternate access control
	mechanism; otherwise, access shall be denied.

=46or historical reasons, POSIX unfortunately also allows access() and
faccessat() to return success for X_OK if the current process is
privileged, even when the above condition is not fulfilled and actual
execution would fail.  On the affected platforms, "test -x <path>" as
root started returning true on nonexecutable files when dash switched
from its own emulation to the true faccessat in v0.5.7~54
(2010-04-02).

Work around this by checking the permissions bits when mode =3D=3D X_OK
and geteuid() =3D=3D 0 on such platforms.

Unfortunately the behavior seems to vary from one kernel version to
another, so we cannot just check the behavior at compile time and rely
on that.  A survey of some affected kernels:

 - NetBSD's kernel moved to the sane semantics in 1997
 - OpenBSD's kernel made the same change in version 4.4, three years
   ago
 - FreeBSD 9's kernel fixes this but hasn't been released yet

It seems safe to only apply the workaround on systems using the
=46reeBSD kernel for now, and to push for standardization on the
expected access()/faccessat() semantics so we can drop the workaround
altogether in a few years.

To try it on other platforms, use "./configure --enable-test-workaround=
".

Reported-by: Christoph Egger <christoph@debian.org>
Analysis-by: Petr Salinger <Petr.Salinger@seznam.cz>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Herbert Xu wrote:

> So pleas exclude the changes on Linux.

Good idea.

Even if the person checking can get root permissions to try it, a
check at compile time is not enough to predict behavior at run time.
=46or example:

 - glibc-bsd changed to the modern behavior on 2011-09-04 without a
   corresponding ABI bump

 - the kernel of FreeBSD changed to the modern behavior in 2010-08-30,
   r212002, and the change will be included in version 9 (but there is
   no plan to backport to version 8):

   http://www.freebsd.org/cgi/query-pr.cgi?pr=3Dkern/125009

 - according to that FreeBSD problem report, Mac OS 10.4 uses the
   pre-modern behavior only for device files (!), OpenBSD 4.3 always
   uses the pre-modern behavior, and NetBSD uses the modern behavior

 - of course they all inherited that behavior from BSD as far as I
   can tell, which is why bash 1.11 and hence dash's !HAVE_FACCESSAT
   codepath defend against it.

I don't know what AT&T unix did, but it probably doesn't matter.
Probably best to use an explicit list of platforms and let the
person building override it.  How about this?

 configure.ac     |   31 +++++++++++++++++++++++++++++++
 src/bltin/test.c |   20 ++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index c6fb401a..980f553b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -90,6 +90,37 @@ AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit =
isalpha killpg \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
 	       strtoumax sysconf)
=20
+dnl Check whether it's worth working around FreeBSD PR kern/125009.
+dnl The traditional behavior of access/faccessat is crazy, but
+dnl POSIX.1-2008 explicitly allows those functions to misbehave.
+dnl
+dnl Unaffected kernels:
+dnl
+dnl - all versions of Linux
+dnl - NetBSD sys/kern/vfs_subr.c 1.64, 1997-04-23
+dnl - FreeBSD 9 (r212002), 2010-09-10
+dnl - OpenBSD sys/kern/vfs_subr.c 1.166, 2008-06-09
+dnl
+dnl Also worked around in Debian's libc0.1 2.13-19 when using
+dnl kFreeBSD 8.
+
+AC_ARG_ENABLE(test-workaround, AS_HELP_STRING(--enable-test-workaround=
, \
+	[Guard against faccessat(2) that tells root all files are executable]=
),,
+	[enable_test_workaround=3Dauto])
+
+if test "enable_test_workaround" =3D "auto" &&
+   test "$ac_cv_func_faccessat" =3D yes; then
+	case `uname -s 2>/dev/null` in
+	GNU/kFreeBSD | \
+	FreeBSD)
+		enable_test_workaround=3Dyes
+	esac
+fi
+if test "$enable_test_workaround" =3D "yes"; then
+	AC_DEFINE([HAVE_TRADITIONAL_FACCESSAT], [1],
+		[Define if your faccessat tells root all files are executable])
+fi
+
 if test "$enable_fnmatch" =3D yes; then
 	use_fnmatch=3D
 	AC_CHECK_FUNCS(fnmatch, use_fnmatch=3Dyes)
diff --git a/src/bltin/test.c b/src/bltin/test.c
index 90135e14..a73d3a27 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -155,6 +155,14 @@ static int test_st_mode(const struct stat64 *, int=
);
 static int bash_group_member(gid_t);
 #endif
=20
+#ifdef HAVE_FACCESSAT
+# ifdef HAVE_TRADITIONAL_FACCESSAT
+static inline int faccessat_confused_about_superuser(void) { return 1;=
 }
+# else
+static inline int faccessat_confused_about_superuser(void) { return 0;=
 }
+# endif
+#endif
+
 static inline intmax_t getn(const char *s)
 {
 	return atomax10(s);
@@ -485,8 +493,20 @@ equalf (const char *f1, const char *f2)
 }
=20
 #ifdef HAVE_FACCESSAT
+static int has_exec_bit_set(const char *path)
+{
+	struct stat64 st;
+
+	if (stat64(path, &st))
+		return 0;
+	return st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH);
+}
+
 static int test_file_access(const char *path, int mode)
 {
+	if (faccessat_confused_about_superuser() &&
+	    mode =3D=3D X_OK && geteuid() =3D=3D 0 && !has_exec_bit_set(path)=
)
+		return 0;
 	return !faccessat(AT_FDCWD, path, mode, AT_EACCESS);
 }
 #else	/* HAVE_FACCESSAT */
--=20
1.7.7.rc1

