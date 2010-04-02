From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: test -x should use faccessat, not stat
Date: Fri, 2 Apr 2010 22:03:53 +0800
Message-ID: <20100402140353.GA31098@gondor.apana.org.au>
References: <20100214061137.GA9882@gondor.apana.org.au> <4B794CA2.1080707@byu.net> <20100216120413.GA32318@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:49657 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752918Ab0DBOD6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 Apr 2010 10:03:58 -0400
Content-Disposition: inline
In-Reply-To: <20100216120413.GA32318@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
Cc: dash@vger.kernel.org

On Tue, Feb 16, 2010 at 08:04:13PM +0800, Herbert Xu wrote:
> 
> First of all I completely agree with you that the current dash
> behaviour is busted.  As to how we should fix it, let me think
> about this a little more before making a decision.

After much deliberation (alright, I've simply been busy elsewhere :)
I've committed this patch.

commit 1d68712ba2e439f36874c4ed1e3d9ffec177a06c
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Apr 2 22:02:22 2010 +0800

    [BUILTIN] Use faccessat if available
    
    Eric Blake suggested that we should use faccessat so that ACLs
    and other corner cases are handled correctly.  This patch does
    exactly that.
    
    Note that faccessat doesn't handle ACLs when euid != uid, as
    this case is currently implemented by glibc instead of the kernel,
    using code similar to the existing dash test.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 7af5070..9f63819 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,5 +1,9 @@
 2010-04-02  Herbert Xu <herbert@gondor.apana.org.au>
 
+	* Use faccessat if available.
+
+2010-04-02  Herbert Xu <herbert@gondor.apana.org.au>
+
 	* Make trap signal name/number errors non-fatal.
 	* Release 0.5.6.
 
diff --git a/configure.ac b/configure.ac
index df6e099..c943725 100644
--- a/configure.ac
+++ b/configure.ac
@@ -46,7 +46,8 @@ dnl Checks for header files.
 AC_CHECK_HEADERS(alloca.h)
 
 dnl Checks for library functions.
-AC_CHECK_FUNCS(bsearch getpwnam getrlimit imaxdiv isalpha killpg mempcpy \
+AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit imaxdiv isalpha killpg \
+	       mempcpy \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
 	       strtoumax sysconf)
 
diff --git a/src/bltin/test.c b/src/bltin/test.c
index 8e7077a..7888f38 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -11,6 +11,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
+#include <fcntl.h>
 #include <stdint.h>
 #include <stdlib.h>
 #include <string.h>
@@ -147,8 +148,12 @@ static int isoperand(char **);
 static int newerf(const char *, const char *);
 static int olderf(const char *, const char *);
 static int equalf(const char *, const char *);
+#ifdef HAVE_FACCESSAT
+static int test_file_access(const char *, int);
+#else
 static int test_st_mode(const struct stat64 *, int);
 static int bash_group_member(gid_t);
+#endif
 
 static inline intmax_t getn(const char *s)
 {
@@ -295,6 +300,14 @@ primary(enum token n)
 			return strlen(*t_wp) != 0;
 		case FILTT:
 			return isatty(getn(*t_wp));
+#ifdef HAVE_FACCESSAT
+		case FILRD:
+			return test_file_access(*t_wp, R_OK);
+		case FILWR:
+			return test_file_access(*t_wp, W_OK);
+		case FILEX:
+			return test_file_access(*t_wp, X_OK);
+#endif
 		default:
 			return filstat(*t_wp, n);
 		}
@@ -364,12 +377,14 @@ filstat(char *nm, enum token mode)
 		return 0;
 
 	switch (mode) {
+#ifndef HAVE_FACCESSAT
 	case FILRD:
 		return test_st_mode(&s, R_OK);
 	case FILWR:
 		return test_st_mode(&s, W_OK);
 	case FILEX:
 		return test_st_mode(&s, X_OK);
+#endif
 	case FILEXIST:
 		return 1;
 	case FILREG:
@@ -469,6 +484,12 @@ equalf (const char *f1, const char *f2)
 		b1.st_ino == b2.st_ino);
 }
 
+#ifdef HAVE_FACCESSAT
+static int test_file_access(const char *path, int mode)
+{
+	return !faccessat(AT_FDCWD, path, mode, AT_EACCESS);
+}
+#else	/* HAVE_FACCESSAT */
 /*
  * Similar to what access(2) does, but uses the effective uid and gid.
  * Doesn't make the mistake of telling root that any file is executable.
@@ -519,3 +540,4 @@ bash_group_member(gid_t gid)
 
 	return (0);
 }
+#endif	/* HAVE_FACCESSAT */

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
