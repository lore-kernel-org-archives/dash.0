Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27975FEE4
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731836494; cv=none; b=qtpMr8aDOcPAMvoHyiVf5v8JY93UVqdC1OODPjbEAvl9Yly1uK5RBArkK3ZgICxUQj9SwdUXEBk9buJXHpx21QURp1rs4XbYaz8+h7Lj8qNSOyFBHLaiZUho9HQgQ8DnxB/aTOkrIfjXlziszV7mX+TfqJbqXjo0sVmhnxlh/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731836494; c=relaxed/simple;
	bh=cw9kq6Jr4d+5ga3JEVT4n+YsNXllvcVrrUQSr/itfGI=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=r8qPm/ikbu7uQc4eIczCOe7CyQ7IArN4/ged+cdW21UXfZ85lIBX7fi7z8/kcM240/xYEShTIw4v0r83CjmesmpelML3iqUtnURrte1X3wC72LGaEaS0cI/SDl1xg4WbsIXgfB5O73X28Hwjz4KHuiNBLfeX6SpdDnwL58TuYHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AH9fNZk207481
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 10:41:24 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AH9fL50414437
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 17 Nov 2024 10:41:23 +0100
Content-Type: multipart/mixed; boundary="------------0aKGvz1eCKydeEAsbVl70I0w"
Message-ID: <d59c5c6c-784a-41fa-b839-12c685d3c769@knaff.lu>
Date: Sun, 17 Nov 2024 10:41:21 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: P*rtability of dash to legacy systems, such as AT&T Unix PC :
 07-sys-functions
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
Content-Language: en-US
Autocrypt: addr=alain@knaff.lu; keydata=
 xsDiBEk9qFcRBADO4trPtib39qvAEBlkAIcBGnZ137EmmNLU1pFZC5acLyJ4wYhVdcol97lC
 4ZkD0DJek6DVidQfz4hA7JbZy2W8l6O/o2k/Ja2bWkb8qtrcUNVDJzdJjNqXmmxdsyLd5QVt
 uCHgi3Zz0kq9aJnRCVuAyfrjMdaUsOThi07u1EyEywCgjxVKODAifumqfdjVxS5NoV7x7TkD
 /0k2F3/5/NYchgLz6Qu3As5MVtPs7NkJ0Mpal4Gy8CaKefHcynY+zCziM/oBw0+PIFxyFud0
 uT9HRIdEp1DlaTTUYlt95HeDYmCUh0Wt1PwNNRWcm+vTUuK7tOxzYadUqbzO+F6C+WN8msxA
 hcxzUgsL/YyXVilvL8XqB+RlS5bBA/9OxXc2mJs01nWu5khvVFNwUCDS8FRYyoHeodVZFGLC
 UG1PrV9nHva5vYJk1QlZP3qEotnK+6l4708X9yhdw2+UCtxvseTQ6JWBtIdJyo+Qv7apSQA3
 kkau6Om7SOyW1i/2LcCZU84SC923uBH7VNeUzCnzelVFubk6eRwzjNvrj80cQUxBSU4gS05B
 RkYgPGFsYWluQGtuYWZmLmx1PsJgBBMRAgAgBQJJPahXAhsDBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQyAYxsm9DGWFEsgCeOSavzyOp8Bj3nOP8hC6XeCX/3k4Anj0KegsyeIVxuj5X
 TUnh535vXfZvzsFNBEk9qFoQCACt2vctXYAr+ndRbaeR4ygJ8rKH8ARu68nDuQuxOKCasaQr
 xm8+/RxvmTfriP00tYZAca2tmCjwntKVsK4eNSivvo6c7BwziCnQx/vW+kJK4ctckMHSZPqe
 4a1HWYURg5oxaqGo4f06YAn9O0yDo6xdGGNUMpYHv2O1/jsAEgAM/c/US+gNctzsNKQ4lVwp
 HH4NEabev+zlisnTO3V39iXijZbe9AYlD4qZH/0nFBDCCt9EDTe+/6IFfvIrnVx7o367U9XL
 SCLVQt4k7xqCIow7RP5BlOYLDV50yMva8c62yhWpDYKSyJsQGn/nGiiv6P4Ye/monfkQD+PC
 nKPXDYCjAAMFB/9D2FSYHyikvOoXXMTfjGHUyIQK6FCtKINTFfBPuwlWOWCukrQrzH0BmTVC
 /WuMOrrmxl0IFHGtOV2Zp+bdsjhlzgZ4kXAmqw1Qiphb/YLD6VY5TQ59Tkl7+nCQ0wjcRim1
 Sg6OzmoNttHpTt9eAvLZMz7yi9Nq40yKXh+zXZtzHIgdsXG+tO9+LEWojdbXgIdZin2yUKYt
 KxbpwyM0qCN9oGtKTAi0GX+tuHdAqWwYEgVnd27LcBGLTs6QJPsjQKHiAtYJwu6MWiF7bvCr
 iBNyVG3yU3inZcQvIdYxO0VUN3wVSEIbRHcNzG2u1UD6ZuF+3bv39dh54m1CQzbzzRepwkkE
 GBECAAkFAkk9qFoCGwwACgkQyAYxsm9DGWHNLwCfWr4DLrBZMktv9RTGbcIZ+/NgTswAn3aG
 LBuTFPDEO0bfA+7PlpCctCJT
In-Reply-To: <ZhDq9L88eTrLxlWW@gondor.apana.org.au>

This is a multi-part message in MIME format.
--------------0aKGvz1eCKydeEAsbVl70I0w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The 7th patch tests for system functions, declarations and macro
definitions which may be absent on some systems such as UnixPC.

Replacement functions and definitions are supplied.

After applying the 7 first patches, dash compiles on Solaris10

Regards,

Alain

diff -X ../exclude.txt -urN dash-0.5.12+06-stdbool/configure.ac dash-0.5.12+07-sys-functions/configure.ac
--- dash-0.5.12+06-stdbool/configure.ac	2024-11-10 17:06:18.440583714 +0000
+++ dash-0.5.12+07-sys-functions/configure.ac	2024-11-10 17:29:12.073235300 +0000
@@ -67,6 +67,8 @@
 dnl Some systems lack isblank
 AC_CHECK_DECLS([isblank],,,[#include <ctype.h>])
 
+AC_DECL_SYS_SIGLIST
+
 dnl Check for sizes of types
 AC_CHECK_SIZEOF([intmax_t])
 AC_CHECK_SIZEOF([long long int])
@@ -88,9 +90,22 @@
 
 dnl Checks for library functions.
 AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit isalpha killpg \
-	       mempcpy \
+	       mempcpy memmove \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
-	       strtoumax sysconf)
+	       strtoumax sysconf \
+	       vfork lstat dup2 getgroups \
+	       strstr stpncpy strcasecmp strerror strdup strtoul \
+	       readdir)
+
+dnl Checks for prototypes
+AC_CHECK_DECLS([malloc, realloc, calloc, free, strdup, strerror, bsearch])
+
+AC_CHECK_DECLS([getpwnam],,,[
+AC_INCLUDES_DEFAULT
+#ifdef HAVE_PWD_H
+#include <pwd.h>
+#endif
+])
 
 dnl Check whether it's worth working around FreeBSD PR kern/125009.
 dnl The traditional behavior of access/faccessat is crazy, but
diff -X ../exclude.txt -urN dash-0.5.12+06-stdbool/src/bltin/test.c dash-0.5.12+07-sys-functions/src/bltin/test.c
--- dash-0.5.12+06-stdbool/src/bltin/test.c	2024-10-20 08:37:55.798682937 +0000
+++ dash-0.5.12+07-sys-functions/src/bltin/test.c	2024-10-21 10:43:42.395812820 +0000
@@ -22,6 +22,7 @@
 #include <unistd.h>
 #include <stdarg.h>
 #include "bltin.h"
+#include "system.h"
 
 /* test(1) accepts the following grammar:
 	oexpr	::= aexpr | aexpr "-o" oexpr ;
@@ -663,10 +664,12 @@
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
@@ -685,6 +688,7 @@
 		stmode <<= 6;
 	else if (sp->st_gid == getegid())
 		stmode <<= 3;
+#ifdef HAVE_GETGROUPS
 	else {
 		/* XXX stolen almost verbatim from ksh93.... */
 		/* on some systems you can be in several groups */
@@ -698,6 +702,7 @@
 			}
 		}
 	}
+#endif
 
 	return sp->st_mode & stmode;
 }
diff -X ../exclude.txt -urN dash-0.5.12+06-stdbool/src/cd.c dash-0.5.12+07-sys-functions/src/cd.c
--- dash-0.5.12+06-stdbool/src/cd.c	2024-10-20 08:37:55.802683032 +0000
+++ dash-0.5.12+07-sys-functions/src/cd.c	2024-11-10 11:14:26.988743365 +0000
@@ -62,6 +62,7 @@
 #include "mystring.h"
 #include "show.h"
 #include "cd.h"
+#include "system.h"
 
 #define CD_PHYSICAL 1
 #define CD_PRINT 2
diff -X ../exclude.txt -urN dash-0.5.12+06-stdbool/src/exec.c dash-0.5.12+07-sys-functions/src/exec.c
--- dash-0.5.12+06-stdbool/src/exec.c	2024-10-20 08:37:55.802683032 +0000
+++ dash-0.5.12+07-sys-functions/src/exec.c	2024-10-20 21:19:22.613459913 +0000
@@ -135,8 +135,12 @@
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
diff -X ../exclude.txt -urN dash-0.5.12+06-stdbool/src/expand.c dash-0.5.12+07-sys-functions/src/expand.c
--- dash-0.5.12+06-stdbool/src/expand.c	2024-10-20 21:03:17.122588883 +0000
+++ dash-0.5.12+07-sys-functions/src/expand.c	2024-10-20 21:19:22.613459913 +0000
@@ -136,6 +136,35 @@
 /* holds expanded arg list */
 static struct arglist exparg;
 
+#ifndef HAVE_READDIR
+
+#include <fcntl.h>
+DIR *opendir(const char *filename) {
+        DIR *dirp;
+        int fd = open(filename, O_RDONLY);
+        if(fd < 0)
+                return 0;
+        dirp = (DIR *)calloc(1, sizeof(DIR));
+        dirp->fd = fd;
+        return dirp;
+}
+
+struct dirent *readdir(DIR *dirp) {
+        int n = read(dirp->fd, &dirp->entry, 16);
+        if(n <= 0)
+                return 0;
+        dirp->entry.d_name[14]='\0'; /* Terminating null */
+        return &dirp->entry;
+}
+
+int closedir(DIR* dirp) {
+        close(dirp->fd);
+        free(dirp);
+        return 0;
+}
+
+#endif
+
 static char *argstr(char *p, int flag);
 static char *exptilde(char *startp, int flag);
 static char *expari(char *start, int flag);
diff -X ../exclude.txt -urN dash-0.5.12+06-stdbool/src/input.c dash-0.5.12+07-sys-functions/src/input.c
--- dash-0.5.12+06-stdbool/src/input.c	2024-10-20 08:37:55.806683126 +0000
+++ dash-0.5.12+07-sys-functions/src/input.c	2024-10-21 10:43:42.395812820 +0000
@@ -59,6 +59,7 @@
 #ifndef SMALL
 #include "myhistedit.h"
 #endif
+#include "system.h"
 
 #define IBUFSIZ (BUFSIZ + 1)
 
@@ -200,17 +201,21 @@
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
diff -X ../exclude.txt -urN dash-0.5.12+06-stdbool/src/jobs.c dash-0.5.12+07-sys-functions/src/jobs.c
--- dash-0.5.12+06-stdbool/src/jobs.c	2024-10-27 20:11:25.698058831 +0000
+++ dash-0.5.12+07-sys-functions/src/jobs.c	2024-10-27 20:11:14.193784131 +0000
@@ -973,7 +973,11 @@
 	sigblockall(NULL);
 	vforked++;
 
+#ifdef HAVE_VFORK
 	pid = vfork();
+#else
+	pid = fork();
+#endif
 
 	if (!pid) {
 		forkchild(jp, n, FORK_FG);
diff -X ../exclude.txt -urN dash-0.5.12+06-stdbool/src/main.c dash-0.5.12+07-sys-functions/src/main.c
--- dash-0.5.12+06-stdbool/src/main.c	2022-01-20 05:54:13.000000000 +0000
+++ dash-0.5.12+07-sys-functions/src/main.c	2024-10-21 10:43:42.395812820 +0000
@@ -59,6 +59,7 @@
 #include "mystring.h"
 #include "exec.h"
 #include "cd.h"
+#include "system.h"
 
 #define PROFILE 0
 
diff -X ../exclude.txt -urN dash-0.5.12+06-stdbool/src/redir.c dash-0.5.12+07-sys-functions/src/redir.c
--- dash-0.5.12+06-stdbool/src/redir.c	2024-10-20 08:37:55.818683409 +0000
+++ dash-0.5.12+07-sys-functions/src/redir.c	2024-10-21 10:43:42.395812820 +0000
@@ -58,6 +58,7 @@
 #include "memalloc.h"
 #include "error.h"
 #include "trap.h"
+#include "system.h"
 
 
 #define EMPTY -2		/* marks an unused slot in redirtab */
diff -X ../exclude.txt -urN dash-0.5.12+06-stdbool/src/system.c dash-0.5.12+07-sys-functions/src/system.c
--- dash-0.5.12+06-stdbool/src/system.c	2024-11-10 10:42:15.087283480 +0000
+++ dash-0.5.12+07-sys-functions/src/system.c	2024-11-10 16:54:50.528225292 +0000
@@ -56,6 +56,10 @@
 
 #include <signal.h>
 #include <string.h>
+#include <fcntl.h>
+#ifdef HAVE_STDLIB_H
+#include <stdlib.h>
+#endif
 
 #include "error.h"
 #include "output.h"
@@ -77,6 +81,26 @@
 }
 #endif
 
+#ifndef HAVE_STPNCPY
+char *stpncpy(char *dst, const char *src, size_t len)
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
 #ifndef HAVE_STRCHRNUL
 char *strchrnul(const char *s, int c)
 {
@@ -92,6 +116,10 @@
 {
 	static char buf[19];
 
+#if !HAVE_DECL_SYS_SIGLIST
+	extern char *signal_names[];
+# define sys_siglist signal_names
+#endif
 	if ((unsigned)sig < NSIG && sys_siglist[sig])
 		return (char *)sys_siglist[sig];
 	fmtstr(buf, sizeof(buf), "Signal %d", sig); 
@@ -197,3 +225,119 @@
 	return c == ' ' || c == '\t';
 }
 #endif
+
+#ifndef HAVE_DUP2
+int dup2(int a, int b)
+{
+	close(b);
+	return fcntl(a, F_DUPFD, b);
+}
+#endif
+
+#include <stdio.h>
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
+#ifndef HAVE_STRDUP
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
+#ifndef HAVE_STRTOUL
+unsigned long strtoul(const char *string, char **eptr, int base)
+{
+	return (unsigned long) strtol(string, eptr, base);
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
+#ifndef HAVE_MEMMOVE
+/* memmove.c -- copy memory.
+   This snippet is in the public domain.  */
+
+/* Written by David MacKenzie <djm@gnu.ai.mit.edu>.  */
+
+#include <stddef.h>
+
+/* Copy LENGTH bytes from SOURCE to DEST.  Does not null-terminate.  */
+
+void *
+memmove (void *dest0, void const *source0, size_t length)
+{
+  char *dest = dest0;
+  char const *source = source0;
+  if (source < dest)
+    /* Moving from low mem to hi mem; start at end.  */
+    for (source += length, dest += length; length; --length)
+      *--dest = *--source;
+  else if (source != dest)
+    {
+      /* Moving from hi mem to low mem; start at beginning.  */
+      for (; length; --length)
+        *dest++ = *source++;
+    }
+  return dest0;
+}
+#endif
diff -X ../exclude.txt -urN dash-0.5.12+06-stdbool/src/system.h dash-0.5.12+07-sys-functions/src/system.h
--- dash-0.5.12+06-stdbool/src/system.h	2024-11-10 14:53:00.358427612 +0000
+++ dash-0.5.12+07-sys-functions/src/system.h	2024-11-10 16:26:50.144230900 +0000
@@ -62,6 +62,10 @@
 char *stpcpy(char *, const char *);
 #endif
 
+#ifndef HAVE_STPNCPY
+char *stpncpy(char *, const char *, size_t);
+#endif
+
 #ifndef HAVE_STRCHRNUL
 char *strchrnul(const char *, int);
 #endif
@@ -79,14 +83,22 @@
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
 
-#ifndef HAVE_BSEARCH
+#if !HAVE_DECL_BSEARCH
 void *bsearch(const void *, const void *, size_t, size_t,
 	      int (*)(const void *, const void *));
 #endif
@@ -111,12 +123,52 @@
 int isblank(int c);
 #endif
 
+#if !HAVE_DECL_STRERROR
+char *strerror(int errnum);
+#endif
+
+#if !HAVE_DECL_MALLOC
+void *malloc(size_t size);
+#endif
+
+#if !HAVE_DECL_REALLOC
+void *realloc(void *ptr, size_t size);
+#endif
+
+#if !HAVE_DECL_FREE
+void free(void *ptr);
+#endif
+
+#if !HAVE_DECL_STRDUP
+char *strdup(const char *s);
+#endif
+
+#if !HAVE_DECL_GETPWNAM
+struct passwd *getpwnam(const char *name);
+#endif
+
 /*
  * A trick to suppress uninitialized variable warning without generating any
  * code
  */
 #define uninitialized_var(x) x = x
 
+#if (defined O_NDELAY && !defined O_NONBLOCK)
+# define O_NONBLOCK O_NDELAY
+#endif
+
+#ifndef FD_CLOEXEC
+# define FD_CLOEXEC 1
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
 #ifndef NAME_MAX
 /* NAME_MAX is only used in expand.c to make sure that we have a
    buffer big enough to append the next local file part into during
@@ -124,3 +176,41 @@
    rather than smaller, in order to prevent buffer overflow */
 # define NAME_MAX PATH_MAX
 #endif
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
--------------0aKGvz1eCKydeEAsbVl70I0w
Content-Type: text/x-patch; charset=UTF-8;
 name="dash-0.5.12+07-sys-functions.diff"
Content-Disposition: attachment; filename="dash-0.5.12+07-sys-functions.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvY29u
ZmlndXJlLmFjIGRhc2gtMC41LjEyKzA3LXN5cy1mdW5jdGlvbnMvY29uZmlndXJlLmFjCi0t
LSBkYXNoLTAuNS4xMiswNi1zdGRib29sL2NvbmZpZ3VyZS5hYwkyMDI0LTExLTEwIDE3OjA2
OjE4LjQ0MDU4MzcxNCArMDAwMAorKysgZGFzaC0wLjUuMTIrMDctc3lzLWZ1bmN0aW9ucy9j
b25maWd1cmUuYWMJMjAyNC0xMS0xMCAxNzoyOToxMi4wNzMyMzUzMDAgKzAwMDAKQEAgLTY3
LDYgKzY3LDggQEAKIGRubCBTb21lIHN5c3RlbXMgbGFjayBpc2JsYW5rCiBBQ19DSEVDS19E
RUNMUyhbaXNibGFua10sLCxbI2luY2x1ZGUgPGN0eXBlLmg+XSkKIAorQUNfREVDTF9TWVNf
U0lHTElTVAorCiBkbmwgQ2hlY2sgZm9yIHNpemVzIG9mIHR5cGVzCiBBQ19DSEVDS19TSVpF
T0YoW2ludG1heF90XSkKIEFDX0NIRUNLX1NJWkVPRihbbG9uZyBsb25nIGludF0pCkBAIC04
OCw5ICs5MCwyMiBAQAogCiBkbmwgQ2hlY2tzIGZvciBsaWJyYXJ5IGZ1bmN0aW9ucy4KIEFD
X0NIRUNLX0ZVTkNTKGJzZWFyY2ggZmFjY2Vzc2F0IGdldHB3bmFtIGdldHJsaW1pdCBpc2Fs
cGhhIGtpbGxwZyBcCi0JICAgICAgIG1lbXBjcHkgXAorCSAgICAgICBtZW1wY3B5IG1lbW1v
dmUgXAogCSAgICAgICBzaWdzZXRtYXNrIHN0cGNweSBzdHJjaHJudWwgc3Ryc2lnbmFsIHN0
cnRvZCBzdHJ0b2ltYXggXAotCSAgICAgICBzdHJ0b3VtYXggc3lzY29uZikKKwkgICAgICAg
c3RydG91bWF4IHN5c2NvbmYgXAorCSAgICAgICB2Zm9yayBsc3RhdCBkdXAyIGdldGdyb3Vw
cyBcCisJICAgICAgIHN0cnN0ciBzdHBuY3B5IHN0cmNhc2VjbXAgc3RyZXJyb3Igc3RyZHVw
IHN0cnRvdWwgXAorCSAgICAgICByZWFkZGlyKQorCitkbmwgQ2hlY2tzIGZvciBwcm90b3R5
cGVzCitBQ19DSEVDS19ERUNMUyhbbWFsbG9jLCByZWFsbG9jLCBjYWxsb2MsIGZyZWUsIHN0
cmR1cCwgc3RyZXJyb3IsIGJzZWFyY2hdKQorCitBQ19DSEVDS19ERUNMUyhbZ2V0cHduYW1d
LCwsWworQUNfSU5DTFVERVNfREVGQVVMVAorI2lmZGVmIEhBVkVfUFdEX0gKKyNpbmNsdWRl
IDxwd2QuaD4KKyNlbmRpZgorXSkKIAogZG5sIENoZWNrIHdoZXRoZXIgaXQncyB3b3J0aCB3
b3JraW5nIGFyb3VuZCBGcmVlQlNEIFBSIGtlcm4vMTI1MDA5LgogZG5sIFRoZSB0cmFkaXRp
b25hbCBiZWhhdmlvciBvZiBhY2Nlc3MvZmFjY2Vzc2F0IGlzIGNyYXp5LCBidXQKZGlmZiAt
WCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvc3JjL2JsdGlu
L3Rlc3QuYyBkYXNoLTAuNS4xMiswNy1zeXMtZnVuY3Rpb25zL3NyYy9ibHRpbi90ZXN0LmMK
LS0tIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvc3JjL2JsdGluL3Rlc3QuYwkyMDI0LTEwLTIw
IDA4OjM3OjU1Ljc5ODY4MjkzNyArMDAwMAorKysgZGFzaC0wLjUuMTIrMDctc3lzLWZ1bmN0
aW9ucy9zcmMvYmx0aW4vdGVzdC5jCTIwMjQtMTAtMjEgMTA6NDM6NDIuMzk1ODEyODIwICsw
MDAwCkBAIC0yMiw2ICsyMiw3IEBACiAjaW5jbHVkZSA8dW5pc3RkLmg+CiAjaW5jbHVkZSA8
c3RkYXJnLmg+CiAjaW5jbHVkZSAiYmx0aW4uaCIKKyNpbmNsdWRlICJzeXN0ZW0uaCIKIAog
LyogdGVzdCgxKSBhY2NlcHRzIHRoZSBmb2xsb3dpbmcgZ3JhbW1hcjoKIAlvZXhwcgk6Oj0g
YWV4cHIgfCBhZXhwciAiLW8iIG9leHByIDsKQEAgLTY2MywxMCArNjY0LDEyIEBACiAgKi8K
IHN0YXRpYyBpbnQgdGVzdF9hY2Nlc3MoY29uc3Qgc3RydWN0IHN0YXQ2NCAqc3AsIGludCBz
dG1vZGUpCiB7CisjaWZkZWYgSEFWRV9HRVRHUk9VUFMKIAlnaWRfdCAqZ3JvdXBzOwogCXJl
Z2lzdGVyIGludCBuOwotCXVpZF90IGV1aWQ7CiAJaW50IG1heGdyb3VwczsKKyNlbmRpZgor
CXVpZF90IGV1aWQ7CiAKIAkvKgogCSAqIEkgc3VwcG9zZSB3ZSBjb3VsZCB1c2UgYWNjZXNz
KCkgaWYgbm90IHJ1bm5pbmcgYXMgcm9vdCBhbmQgaWYgd2UgYXJlCkBAIC02ODUsNiArNjg4
LDcgQEAKIAkJc3Rtb2RlIDw8PSA2OwogCWVsc2UgaWYgKHNwLT5zdF9naWQgPT0gZ2V0ZWdp
ZCgpKQogCQlzdG1vZGUgPDw9IDM7CisjaWZkZWYgSEFWRV9HRVRHUk9VUFMKIAllbHNlIHsK
IAkJLyogWFhYIHN0b2xlbiBhbG1vc3QgdmVyYmF0aW0gZnJvbSBrc2g5My4uLi4gKi8KIAkJ
Lyogb24gc29tZSBzeXN0ZW1zIHlvdSBjYW4gYmUgaW4gc2V2ZXJhbCBncm91cHMgKi8KQEAg
LTY5OCw2ICs3MDIsNyBAQAogCQkJfQogCQl9CiAJfQorI2VuZGlmCiAKIAlyZXR1cm4gc3At
PnN0X21vZGUgJiBzdG1vZGU7CiB9CmRpZmYgLVggLi4vZXhjbHVkZS50eHQgLXVyTiBkYXNo
LTAuNS4xMiswNi1zdGRib29sL3NyYy9jZC5jIGRhc2gtMC41LjEyKzA3LXN5cy1mdW5jdGlv
bnMvc3JjL2NkLmMKLS0tIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvc3JjL2NkLmMJMjAyNC0x
MC0yMCAwODozNzo1NS44MDI2ODMwMzIgKzAwMDAKKysrIGRhc2gtMC41LjEyKzA3LXN5cy1m
dW5jdGlvbnMvc3JjL2NkLmMJMjAyNC0xMS0xMCAxMToxNDoyNi45ODg3NDMzNjUgKzAwMDAK
QEAgLTYyLDYgKzYyLDcgQEAKICNpbmNsdWRlICJteXN0cmluZy5oIgogI2luY2x1ZGUgInNo
b3cuaCIKICNpbmNsdWRlICJjZC5oIgorI2luY2x1ZGUgInN5c3RlbS5oIgogCiAjZGVmaW5l
IENEX1BIWVNJQ0FMIDEKICNkZWZpbmUgQ0RfUFJJTlQgMgpkaWZmIC1YIC4uL2V4Y2x1ZGUu
dHh0IC11ck4gZGFzaC0wLjUuMTIrMDYtc3RkYm9vbC9zcmMvZXhlYy5jIGRhc2gtMC41LjEy
KzA3LXN5cy1mdW5jdGlvbnMvc3JjL2V4ZWMuYwotLS0gZGFzaC0wLjUuMTIrMDYtc3RkYm9v
bC9zcmMvZXhlYy5jCTIwMjQtMTAtMjAgMDg6Mzc6NTUuODAyNjgzMDMyICswMDAwCisrKyBk
YXNoLTAuNS4xMiswNy1zeXMtZnVuY3Rpb25zL3NyYy9leGVjLmMJMjAyNC0xMC0yMCAyMTox
OToyMi42MTM0NTk5MTMgKzAwMDAKQEAgLTEzNSw4ICsxMzUsMTIgQEAKIAlkZWZhdWx0Ogog
CQlleGVycm5vID0gMTI2OwogCQlicmVhazsKKyNpZmRlZiBFTE9PUAogCWNhc2UgRUxPT1A6
CisjZW5kaWYKKyNpZmRlZiBFTkFNRVRPT0xPTkcKIAljYXNlIEVOQU1FVE9PTE9ORzoKKyNl
bmRpZgogCWNhc2UgRU5PRU5UOgogCWNhc2UgRU5PVERJUjoKIAkJZXhlcnJubyA9IDEyNzsK
ZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvc3Jj
L2V4cGFuZC5jIGRhc2gtMC41LjEyKzA3LXN5cy1mdW5jdGlvbnMvc3JjL2V4cGFuZC5jCi0t
LSBkYXNoLTAuNS4xMiswNi1zdGRib29sL3NyYy9leHBhbmQuYwkyMDI0LTEwLTIwIDIxOjAz
OjE3LjEyMjU4ODg4MyArMDAwMAorKysgZGFzaC0wLjUuMTIrMDctc3lzLWZ1bmN0aW9ucy9z
cmMvZXhwYW5kLmMJMjAyNC0xMC0yMCAyMToxOToyMi42MTM0NTk5MTMgKzAwMDAKQEAgLTEz
Niw2ICsxMzYsMzUgQEAKIC8qIGhvbGRzIGV4cGFuZGVkIGFyZyBsaXN0ICovCiBzdGF0aWMg
c3RydWN0IGFyZ2xpc3QgZXhwYXJnOwogCisjaWZuZGVmIEhBVkVfUkVBRERJUgorCisjaW5j
bHVkZSA8ZmNudGwuaD4KK0RJUiAqb3BlbmRpcihjb25zdCBjaGFyICpmaWxlbmFtZSkgewor
ICAgICAgICBESVIgKmRpcnA7CisgICAgICAgIGludCBmZCA9IG9wZW4oZmlsZW5hbWUsIE9f
UkRPTkxZKTsKKyAgICAgICAgaWYoZmQgPCAwKQorICAgICAgICAgICAgICAgIHJldHVybiAw
OworICAgICAgICBkaXJwID0gKERJUiAqKWNhbGxvYygxLCBzaXplb2YoRElSKSk7CisgICAg
ICAgIGRpcnAtPmZkID0gZmQ7CisgICAgICAgIHJldHVybiBkaXJwOworfQorCitzdHJ1Y3Qg
ZGlyZW50ICpyZWFkZGlyKERJUiAqZGlycCkgeworICAgICAgICBpbnQgbiA9IHJlYWQoZGly
cC0+ZmQsICZkaXJwLT5lbnRyeSwgMTYpOworICAgICAgICBpZihuIDw9IDApCisgICAgICAg
ICAgICAgICAgcmV0dXJuIDA7CisgICAgICAgIGRpcnAtPmVudHJ5LmRfbmFtZVsxNF09J1ww
JzsgLyogVGVybWluYXRpbmcgbnVsbCAqLworICAgICAgICByZXR1cm4gJmRpcnAtPmVudHJ5
OworfQorCitpbnQgY2xvc2VkaXIoRElSKiBkaXJwKSB7CisgICAgICAgIGNsb3NlKGRpcnAt
PmZkKTsKKyAgICAgICAgZnJlZShkaXJwKTsKKyAgICAgICAgcmV0dXJuIDA7Cit9CisKKyNl
bmRpZgorCiBzdGF0aWMgY2hhciAqYXJnc3RyKGNoYXIgKnAsIGludCBmbGFnKTsKIHN0YXRp
YyBjaGFyICpleHB0aWxkZShjaGFyICpzdGFydHAsIGludCBmbGFnKTsKIHN0YXRpYyBjaGFy
ICpleHBhcmkoY2hhciAqc3RhcnQsIGludCBmbGFnKTsKZGlmZiAtWCAuLi9leGNsdWRlLnR4
dCAtdXJOIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvc3JjL2lucHV0LmMgZGFzaC0wLjUuMTIr
MDctc3lzLWZ1bmN0aW9ucy9zcmMvaW5wdXQuYwotLS0gZGFzaC0wLjUuMTIrMDYtc3RkYm9v
bC9zcmMvaW5wdXQuYwkyMDI0LTEwLTIwIDA4OjM3OjU1LjgwNjY4MzEyNiArMDAwMAorKysg
ZGFzaC0wLjUuMTIrMDctc3lzLWZ1bmN0aW9ucy9zcmMvaW5wdXQuYwkyMDI0LTEwLTIxIDEw
OjQzOjQyLjM5NTgxMjgyMCArMDAwMApAQCAtNTksNiArNTksNyBAQAogI2lmbmRlZiBTTUFM
TAogI2luY2x1ZGUgIm15aGlzdGVkaXQuaCIKICNlbmRpZgorI2luY2x1ZGUgInN5c3RlbS5o
IgogCiAjZGVmaW5lIElCVUZTSVogKEJVRlNJWiArIDEpCiAKQEAgLTIwMCwxNyArMjAxLDIx
IEBACiAJCW5yID0gcmVhZChwYXJzZWZpbGUtPmZkLCBidWYsIElCVUZTSVogLSAxKTsKIAog
Ci0JaWYgKG5yIDwgMCkgewotCQlpZiAoZXJybm8gPT0gRUlOVFIpCi0JCQlnb3RvIHJldHJ5
OwotCQlpZiAocGFyc2VmaWxlLT5mZCA9PSAwICYmIGVycm5vID09IEVXT1VMREJMT0NLKSB7
Ci0JCQlpbnQgZmxhZ3MgPSBmY250bCgwLCBGX0dFVEZMLCAwKTsKLQkJCWlmIChmbGFncyA+
PSAwICYmIGZsYWdzICYgT19OT05CTE9DSykgewotCQkJCWZsYWdzICY9fiBPX05PTkJMT0NL
OwotCQkJCWlmIChmY250bCgwLCBGX1NFVEZMLCBmbGFncykgPj0gMCkgewotCQkJCQlvdXQy
c3RyKCJzaDogdHVybmluZyBvZmYgTkRFTEFZIG1vZGVcbiIpOwotCQkJCQlnb3RvIHJldHJ5
OwotCQkJCX0KKwlpZiAobnIgPCAwICYmIGVycm5vID09IEVJTlRSKQorCQlnb3RvIHJldHJ5
OworCWlmIChwYXJzZWZpbGUtPmZkID09IDAgJiYKKyNpZmRlZiBFV09VTERCTE9DSworCSAg
ICAobnIgPCAwICYmIGVycm5vID09IEVXT1VMREJMT0NLKQorI2Vsc2UKKwkgICAgbnIgPT0g
MAorI2VuZGlmCisJICAgICkgeworCQlpbnQgZmxhZ3MgPSBmY250bCgwLCBGX0dFVEZMLCAw
KTsKKwkJaWYgKGZsYWdzID49IDAgJiYgZmxhZ3MgJiBPX05PTkJMT0NLKSB7CisJCQlmbGFn
cyAmPX4gT19OT05CTE9DSzsKKwkJCWlmIChmY250bCgwLCBGX1NFVEZMLCBmbGFncykgPj0g
MCkgeworCQkJCW91dDJzdHIoInNoOiB0dXJuaW5nIG9mZiBOREVMQVkgbW9kZVxuIik7CisJ
CQkJZ290byByZXRyeTsKIAkJCX0KIAkJfQogCX0KZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAt
dXJOIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvc3JjL2pvYnMuYyBkYXNoLTAuNS4xMiswNy1z
eXMtZnVuY3Rpb25zL3NyYy9qb2JzLmMKLS0tIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvc3Jj
L2pvYnMuYwkyMDI0LTEwLTI3IDIwOjExOjI1LjY5ODA1ODgzMSArMDAwMAorKysgZGFzaC0w
LjUuMTIrMDctc3lzLWZ1bmN0aW9ucy9zcmMvam9icy5jCTIwMjQtMTAtMjcgMjA6MTE6MTQu
MTkzNzg0MTMxICswMDAwCkBAIC05NzMsNyArOTczLDExIEBACiAJc2lnYmxvY2thbGwoTlVM
TCk7CiAJdmZvcmtlZCsrOwogCisjaWZkZWYgSEFWRV9WRk9SSwogCXBpZCA9IHZmb3JrKCk7
CisjZWxzZQorCXBpZCA9IGZvcmsoKTsKKyNlbmRpZgogCiAJaWYgKCFwaWQpIHsKIAkJZm9y
a2NoaWxkKGpwLCBuLCBGT1JLX0ZHKTsKZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRh
c2gtMC41LjEyKzA2LXN0ZGJvb2wvc3JjL21haW4uYyBkYXNoLTAuNS4xMiswNy1zeXMtZnVu
Y3Rpb25zL3NyYy9tYWluLmMKLS0tIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvc3JjL21haW4u
YwkyMDIyLTAxLTIwIDA1OjU0OjEzLjAwMDAwMDAwMCArMDAwMAorKysgZGFzaC0wLjUuMTIr
MDctc3lzLWZ1bmN0aW9ucy9zcmMvbWFpbi5jCTIwMjQtMTAtMjEgMTA6NDM6NDIuMzk1ODEy
ODIwICswMDAwCkBAIC01OSw2ICs1OSw3IEBACiAjaW5jbHVkZSAibXlzdHJpbmcuaCIKICNp
bmNsdWRlICJleGVjLmgiCiAjaW5jbHVkZSAiY2QuaCIKKyNpbmNsdWRlICJzeXN0ZW0uaCIK
IAogI2RlZmluZSBQUk9GSUxFIDAKIApkaWZmIC1YIC4uL2V4Y2x1ZGUudHh0IC11ck4gZGFz
aC0wLjUuMTIrMDYtc3RkYm9vbC9zcmMvcmVkaXIuYyBkYXNoLTAuNS4xMiswNy1zeXMtZnVu
Y3Rpb25zL3NyYy9yZWRpci5jCi0tLSBkYXNoLTAuNS4xMiswNi1zdGRib29sL3NyYy9yZWRp
ci5jCTIwMjQtMTAtMjAgMDg6Mzc6NTUuODE4NjgzNDA5ICswMDAwCisrKyBkYXNoLTAuNS4x
MiswNy1zeXMtZnVuY3Rpb25zL3NyYy9yZWRpci5jCTIwMjQtMTAtMjEgMTA6NDM6NDIuMzk1
ODEyODIwICswMDAwCkBAIC01OCw2ICs1OCw3IEBACiAjaW5jbHVkZSAibWVtYWxsb2MuaCIK
ICNpbmNsdWRlICJlcnJvci5oIgogI2luY2x1ZGUgInRyYXAuaCIKKyNpbmNsdWRlICJzeXN0
ZW0uaCIKIAogCiAjZGVmaW5lIEVNUFRZIC0yCQkvKiBtYXJrcyBhbiB1bnVzZWQgc2xvdCBp
biByZWRpcnRhYiAqLwpkaWZmIC1YIC4uL2V4Y2x1ZGUudHh0IC11ck4gZGFzaC0wLjUuMTIr
MDYtc3RkYm9vbC9zcmMvc3lzdGVtLmMgZGFzaC0wLjUuMTIrMDctc3lzLWZ1bmN0aW9ucy9z
cmMvc3lzdGVtLmMKLS0tIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvc3JjL3N5c3RlbS5jCTIw
MjQtMTEtMTAgMTA6NDI6MTUuMDg3MjgzNDgwICswMDAwCisrKyBkYXNoLTAuNS4xMiswNy1z
eXMtZnVuY3Rpb25zL3NyYy9zeXN0ZW0uYwkyMDI0LTExLTEwIDE2OjU0OjUwLjUyODIyNTI5
MiArMDAwMApAQCAtNTYsNiArNTYsMTAgQEAKIAogI2luY2x1ZGUgPHNpZ25hbC5oPgogI2lu
Y2x1ZGUgPHN0cmluZy5oPgorI2luY2x1ZGUgPGZjbnRsLmg+CisjaWZkZWYgSEFWRV9TVERM
SUJfSAorI2luY2x1ZGUgPHN0ZGxpYi5oPgorI2VuZGlmCiAKICNpbmNsdWRlICJlcnJvci5o
IgogI2luY2x1ZGUgIm91dHB1dC5oIgpAQCAtNzcsNiArODEsMjYgQEAKIH0KICNlbmRpZgog
CisjaWZuZGVmIEhBVkVfU1RQTkNQWQorY2hhciAqc3RwbmNweShjaGFyICpkc3QsIGNvbnN0
IGNoYXIgKnNyYywgc2l6ZV90IGxlbikKK3sKKwlpbnQgaSxudWxsU2Vlbj0wOworCWNoYXIg
KnJldD1kc3QrbGVuOworCWZvcihpPTA7IGk8bGVuOyBpKyspIHsKKwkJaWYobnVsbFNlZW4p
CisJCQlkc3RbaV0gPSAnXDAnOworCQllbHNlIHsKKwkJCWRzdFtpXSA9IHNyY1tpXTsKKwkJ
CWlmKGRzdFtpXSA9PSAnXDAnKSB7CisJCQkJbnVsbFNlZW4gPSAxOworCQkJCXJldCA9IGRz
dCtpOworCQkJfQorCQl9CisJfQorCXJldHVybiByZXQ7Cit9CisjZW5kaWYKKwogI2lmbmRl
ZiBIQVZFX1NUUkNIUk5VTAogY2hhciAqc3RyY2hybnVsKGNvbnN0IGNoYXIgKnMsIGludCBj
KQogewpAQCAtOTIsNiArMTE2LDEwIEBACiB7CiAJc3RhdGljIGNoYXIgYnVmWzE5XTsKIAor
I2lmICFIQVZFX0RFQ0xfU1lTX1NJR0xJU1QKKwlleHRlcm4gY2hhciAqc2lnbmFsX25hbWVz
W107CisjIGRlZmluZSBzeXNfc2lnbGlzdCBzaWduYWxfbmFtZXMKKyNlbmRpZgogCWlmICgo
dW5zaWduZWQpc2lnIDwgTlNJRyAmJiBzeXNfc2lnbGlzdFtzaWddKQogCQlyZXR1cm4gKGNo
YXIgKilzeXNfc2lnbGlzdFtzaWddOwogCWZtdHN0cihidWYsIHNpemVvZihidWYpLCAiU2ln
bmFsICVkIiwgc2lnKTsgCkBAIC0xOTcsMyArMjI1LDExOSBAQAogCXJldHVybiBjID09ICcg
JyB8fCBjID09ICdcdCc7CiB9CiAjZW5kaWYKKworI2lmbmRlZiBIQVZFX0RVUDIKK2ludCBk
dXAyKGludCBhLCBpbnQgYikKK3sKKwljbG9zZShiKTsKKwlyZXR1cm4gZmNudGwoYSwgRl9E
VVBGRCwgYik7Cit9CisjZW5kaWYKKworI2luY2x1ZGUgPHN0ZGlvLmg+CisKKyNpZm5kZWYg
SEFWRV9TVFJTVFIKK2NoYXIgKiBzdHJzdHIgKGNvbnN0IGNoYXIqIGhheXN0YWNrLCBjb25z
dCBjaGFyICpuZWVkbGUpCit7CisJY29uc3QgY2hhciAqc3RhcnQ7CisJaW50IGk7CisJaWYg
KCFoYXlzdGFjaykgcmV0dXJuIDA7CisJZm9yKHN0YXJ0PWhheXN0YWNrOyAqc3RhcnQ7c3Rh
cnQrKykgeworCQlmb3IoaT0wOyBzdGFydFtpXSAmJiBuZWVkbGVbaV07IGkrKykKKwkJCWlm
KHN0YXJ0W2ldICE9IG5lZWRsZVtpXSkKKwkJCQlicmVhazsKKwkJaWYoIW5lZWRsZVtpXSkK
KwkJCXJldHVybiAoY2hhciAqKXN0YXJ0OworCX0KKwlyZXR1cm4gTlVMTDsKK30KKyNlbmRp
ZgorCisjaWZuZGVmIEhBVkVfU1RSRFVQCitjaGFyICpzdHJkdXAoY29uc3QgY2hhciAqc3Ry
KQoreworICAgIGNoYXIgKm5zdHI7CisKKyAgICBpZiAoc3RyID09IChjaGFyKikwKQorICAg
ICAgICByZXR1cm4gMDsKKworICAgIG5zdHIgPSAoY2hhciopbWFsbG9jKChzdHJsZW4oc3Ry
KSArIDEpKTsKKworICAgIGlmIChuc3RyID09IChjaGFyKikwKQorICAgIHsKKyAgICAgICAg
KHZvaWQpZnByaW50ZihzdGRlcnIsICJzdHJkdXAoKTogbm90IGVub3VnaCBtZW1vcnkgdG8g
ZHVwbGljYXRlIGAlcydcbiIsCisJCSAgICAgIHN0cik7CisJZXhpdCgxKTsKKyAgICB9CisK
KyAgICAodm9pZClzdHJjcHkobnN0ciwgc3RyKTsKKworICAgIHJldHVybiBuc3RyOworfQor
I2VuZGlmCisKKyNpZm5kZWYgSEFWRV9TVFJDQVNFQ01QCitpbnQgc3RyY2FzZWNtcChjb25z
dCBjaGFyICpzMSwgY29uc3QgY2hhciAqczIpCit7CisgIHJlZ2lzdGVyIGNvbnN0IHVuc2ln
bmVkIGNoYXIgKnAxID0gKGNvbnN0IHVuc2lnbmVkIGNoYXIgKikgczE7CisgIHJlZ2lzdGVy
IGNvbnN0IHVuc2lnbmVkIGNoYXIgKnAyID0gKGNvbnN0IHVuc2lnbmVkIGNoYXIgKikgczI7
CisgIHVuc2lnbmVkIGNoYXIgYzEsIGMyOworCisgIGlmIChwMSA9PSBwMikKKyAgICByZXR1
cm4gMDsKKworICBkbworICAgIHsKKyAgICAgIGMxID0gdG9sb3dlciAoKnAxKyspOworICAg
ICAgYzIgPSB0b2xvd2VyICgqcDIrKyk7CisgICAgICBpZiAoYzEgPT0gJ1wwJykKKwlicmVh
azsKKyAgICB9CisgIHdoaWxlIChjMSA9PSBjMik7CisKKyAgcmV0dXJuIGMxIC0gYzI7Cit9
CisjZW5kaWYKKworI2lmbmRlZiBIQVZFX1NUUlRPVUwKK3Vuc2lnbmVkIGxvbmcgc3RydG91
bChjb25zdCBjaGFyICpzdHJpbmcsIGNoYXIgKiplcHRyLCBpbnQgYmFzZSkKK3sKKwlyZXR1
cm4gKHVuc2lnbmVkIGxvbmcpIHN0cnRvbChzdHJpbmcsIGVwdHIsIGJhc2UpOworfQorI2Vu
ZGlmCisKKyNpZm5kZWYgSEFWRV9TVFJFUlJPUgorY2hhciAqc3RyZXJyb3IoaW50IHgpIHsK
KwlleHRlcm4gY2hhciAqc3lzX2Vycmxpc3RbXTsKKwlyZXR1cm4gc3lzX2Vycmxpc3RbeF07
Cit9CisjZW5kaWYKKworI2lmbmRlZiBIQVZFX01FTU1PVkUKKy8qIG1lbW1vdmUuYyAtLSBj
b3B5IG1lbW9yeS4KKyAgIFRoaXMgc25pcHBldCBpcyBpbiB0aGUgcHVibGljIGRvbWFpbi4g
ICovCisKKy8qIFdyaXR0ZW4gYnkgRGF2aWQgTWFjS2VuemllIDxkam1AZ251LmFpLm1pdC5l
ZHU+LiAgKi8KKworI2luY2x1ZGUgPHN0ZGRlZi5oPgorCisvKiBDb3B5IExFTkdUSCBieXRl
cyBmcm9tIFNPVVJDRSB0byBERVNULiAgRG9lcyBub3QgbnVsbC10ZXJtaW5hdGUuICAqLwor
Cit2b2lkICoKK21lbW1vdmUgKHZvaWQgKmRlc3QwLCB2b2lkIGNvbnN0ICpzb3VyY2UwLCBz
aXplX3QgbGVuZ3RoKQoreworICBjaGFyICpkZXN0ID0gZGVzdDA7CisgIGNoYXIgY29uc3Qg
KnNvdXJjZSA9IHNvdXJjZTA7CisgIGlmIChzb3VyY2UgPCBkZXN0KQorICAgIC8qIE1vdmlu
ZyBmcm9tIGxvdyBtZW0gdG8gaGkgbWVtOyBzdGFydCBhdCBlbmQuICAqLworICAgIGZvciAo
c291cmNlICs9IGxlbmd0aCwgZGVzdCArPSBsZW5ndGg7IGxlbmd0aDsgLS1sZW5ndGgpCisg
ICAgICAqLS1kZXN0ID0gKi0tc291cmNlOworICBlbHNlIGlmIChzb3VyY2UgIT0gZGVzdCkK
KyAgICB7CisgICAgICAvKiBNb3ZpbmcgZnJvbSBoaSBtZW0gdG8gbG93IG1lbTsgc3RhcnQg
YXQgYmVnaW5uaW5nLiAgKi8KKyAgICAgIGZvciAoOyBsZW5ndGg7IC0tbGVuZ3RoKQorICAg
ICAgICAqZGVzdCsrID0gKnNvdXJjZSsrOworICAgIH0KKyAgcmV0dXJuIGRlc3QwOworfQor
I2VuZGlmCmRpZmYgLVggLi4vZXhjbHVkZS50eHQgLXVyTiBkYXNoLTAuNS4xMiswNi1zdGRi
b29sL3NyYy9zeXN0ZW0uaCBkYXNoLTAuNS4xMiswNy1zeXMtZnVuY3Rpb25zL3NyYy9zeXN0
ZW0uaAotLS0gZGFzaC0wLjUuMTIrMDYtc3RkYm9vbC9zcmMvc3lzdGVtLmgJMjAyNC0xMS0x
MCAxNDo1MzowMC4zNTg0Mjc2MTIgKzAwMDAKKysrIGRhc2gtMC41LjEyKzA3LXN5cy1mdW5j
dGlvbnMvc3JjL3N5c3RlbS5oCTIwMjQtMTEtMTAgMTY6MjY6NTAuMTQ0MjMwOTAwICswMDAw
CkBAIC02Miw2ICs2MiwxMCBAQAogY2hhciAqc3RwY3B5KGNoYXIgKiwgY29uc3QgY2hhciAq
KTsKICNlbmRpZgogCisjaWZuZGVmIEhBVkVfU1RQTkNQWQorY2hhciAqc3RwbmNweShjaGFy
ICosIGNvbnN0IGNoYXIgKiwgc2l6ZV90KTsKKyNlbmRpZgorCiAjaWZuZGVmIEhBVkVfU1RS
Q0hSTlVMCiBjaGFyICpzdHJjaHJudWwoY29uc3QgY2hhciAqLCBpbnQpOwogI2VuZGlmCkBA
IC03OSwxNCArODMsMjIgQEAKICNlbmRpZgogCiAjaWZuZGVmIEhBVkVfU1RSVE9JTUFYCisj
aWYgU0laRU9GX0lOVE1BWF9UID4gU0laRU9GX0xPTkdfSU5UCiAjZGVmaW5lIHN0cnRvaW1h
eCBzdHJ0b2xsCisjZWxzZQorI2RlZmluZSBzdHJ0b2ltYXggc3RydG9sCisjZW5kaWYKICNl
bmRpZgogCiAjaWZuZGVmIEhBVkVfU1RSVE9VTUFYCisjaWYgU0laRU9GX0lOVE1BWF9UID4g
U0laRU9GX0xPTkdfSU5UCiAjZGVmaW5lIHN0cnRvdW1heCBzdHJ0b3VsbAorI2Vsc2UKKyNk
ZWZpbmUgc3RydG91bWF4IHN0cnRvdWwKKyNlbmRpZgogI2VuZGlmCiAKLSNpZm5kZWYgSEFW
RV9CU0VBUkNICisjaWYgIUhBVkVfREVDTF9CU0VBUkNICiB2b2lkICpic2VhcmNoKGNvbnN0
IHZvaWQgKiwgY29uc3Qgdm9pZCAqLCBzaXplX3QsIHNpemVfdCwKIAkgICAgICBpbnQgKCop
KGNvbnN0IHZvaWQgKiwgY29uc3Qgdm9pZCAqKSk7CiAjZW5kaWYKQEAgLTExMSwxMiArMTIz
LDUyIEBACiBpbnQgaXNibGFuayhpbnQgYyk7CiAjZW5kaWYKIAorI2lmICFIQVZFX0RFQ0xf
U1RSRVJST1IKK2NoYXIgKnN0cmVycm9yKGludCBlcnJudW0pOworI2VuZGlmCisKKyNpZiAh
SEFWRV9ERUNMX01BTExPQwordm9pZCAqbWFsbG9jKHNpemVfdCBzaXplKTsKKyNlbmRpZgor
CisjaWYgIUhBVkVfREVDTF9SRUFMTE9DCit2b2lkICpyZWFsbG9jKHZvaWQgKnB0ciwgc2l6
ZV90IHNpemUpOworI2VuZGlmCisKKyNpZiAhSEFWRV9ERUNMX0ZSRUUKK3ZvaWQgZnJlZSh2
b2lkICpwdHIpOworI2VuZGlmCisKKyNpZiAhSEFWRV9ERUNMX1NUUkRVUAorY2hhciAqc3Ry
ZHVwKGNvbnN0IGNoYXIgKnMpOworI2VuZGlmCisKKyNpZiAhSEFWRV9ERUNMX0dFVFBXTkFN
CitzdHJ1Y3QgcGFzc3dkICpnZXRwd25hbShjb25zdCBjaGFyICpuYW1lKTsKKyNlbmRpZgor
CiAvKgogICogQSB0cmljayB0byBzdXBwcmVzcyB1bmluaXRpYWxpemVkIHZhcmlhYmxlIHdh
cm5pbmcgd2l0aG91dCBnZW5lcmF0aW5nIGFueQogICogY29kZQogICovCiAjZGVmaW5lIHVu
aW5pdGlhbGl6ZWRfdmFyKHgpIHggPSB4CiAKKyNpZiAoZGVmaW5lZCBPX05ERUxBWSAmJiAh
ZGVmaW5lZCBPX05PTkJMT0NLKQorIyBkZWZpbmUgT19OT05CTE9DSyBPX05ERUxBWQorI2Vu
ZGlmCisKKyNpZm5kZWYgRkRfQ0xPRVhFQworIyBkZWZpbmUgRkRfQ0xPRVhFQyAxCisjZW5k
aWYKKworI2lmbmRlZiBIQVZFX1NUUlNUUgorZXh0ZXJuIGNoYXIgKiBzdHJzdHIgKGNvbnN0
IGNoYXIqIGhheXN0YWNrLCBjb25zdCBjaGFyICpuZWVkbGUpOworI2VuZGlmCisKKyNpZm5k
ZWYgUEFUSF9NQVgKKyNkZWZpbmUgUEFUSF9NQVggMTAyNAorI2VuZGlmCisKICNpZm5kZWYg
TkFNRV9NQVgKIC8qIE5BTUVfTUFYIGlzIG9ubHkgdXNlZCBpbiBleHBhbmQuYyB0byBtYWtl
IHN1cmUgdGhhdCB3ZSBoYXZlIGEKICAgIGJ1ZmZlciBiaWcgZW5vdWdoIHRvIGFwcGVuZCB0
aGUgbmV4dCBsb2NhbCBmaWxlIHBhcnQgaW50byBkdXJpbmcKQEAgLTEyNCwzICsxNzYsNDEg
QEAKICAgIHJhdGhlciB0aGFuIHNtYWxsZXIsIGluIG9yZGVyIHRvIHByZXZlbnQgYnVmZmVy
IG92ZXJmbG93ICovCiAjIGRlZmluZSBOQU1FX01BWCBQQVRIX01BWAogI2VuZGlmCisKKyNp
Zm5kZWYgU19JU1JFRworI2RlZmluZSBTX0lTUkVHKHgpICgoeCkgJiBTX0lGUkVHKQorI2Vu
ZGlmCisjaWZuZGVmIFNfSVNESVIKKyNkZWZpbmUgU19JU0RJUih4KSAoKHgpICYgU19JRkRJ
UikKKyNlbmRpZgorI2lmbmRlZiBTX0lTQ0hSCisjZGVmaW5lIFNfSVNDSFIoeCkgKCh4KSAm
IFNfSUZDSFIpCisjZW5kaWYKKyNpZm5kZWYgU19JU0JMSworI2RlZmluZSBTX0lTQkxLKHgp
ICgoeCkgJiBTX0lGQkxLKQorI2VuZGlmCisKKyNpZm5kZWYgU19JRkZJRk8KKyNkZWZpbmUg
U19JRkZJRk8gMAorI2VuZGlmCisjaWZuZGVmIFNfSVNGSUZPCisjZGVmaW5lIFNfSVNGSUZP
KHgpICgoeCkgJiBTX0lGRklGTykKKyNlbmRpZgorCisjaWZuZGVmIFNfSUZTT0NLCisjZGVm
aW5lIFNfSUZTT0NLIDAKKyNlbmRpZgorI2lmbmRlZiBTX0lTU09DSworI2RlZmluZSBTX0lT
U09DSyh4KSAoKHgpICYgU19JRlNPQ0spCisjZW5kaWYKKworI2lmbmRlZiBTX0lGTE5LCisj
ZGVmaW5lIFNfSUZMTksgMAorI2VuZGlmCisjaWZuZGVmIFNfSVNMTksKKyNkZWZpbmUgU19J
U0xOSyh4KSAoKHgpICYgU19JRkxOSykKKyNlbmRpZgorCisjaWZuZGVmIEhBVkVfTFNUQVQK
KyNkZWZpbmUgbHN0YXQgc3RhdAorI2VuZGlmCg==

--------------0aKGvz1eCKydeEAsbVl70I0w--
