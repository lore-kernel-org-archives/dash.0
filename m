Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1634EC433EF
	for <linux-dash@archiver.kernel.org>; Wed, 10 Nov 2021 06:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB976117A
	for <linux-dash@archiver.kernel.org>; Wed, 10 Nov 2021 06:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhKJGzy (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 10 Nov 2021 01:55:54 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:56644 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhKJGzy (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 10 Nov 2021 01:55:54 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mkhTm-0005hn-CJ; Wed, 10 Nov 2021 14:53:06 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mkhTj-00017a-Qk; Wed, 10 Nov 2021 14:53:03 +0800
Date:   Wed, 10 Nov 2021 14:53:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc:     dash@vger.kernel.org, 874264@bugs.debian.org
Subject: [PATCH] exec: Check executable bit when searching path
Message-ID: <20211110065303.GA4283@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b960ec52-7a7a-db68-cd9d-bc303f82b54f@collabora.co.uk>
X-Newsgroups: apana.lists.os.linux.dash
Organization: Core
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Andrej Shadura <andrew.shadura@collabora.co.uk> wrote:
> 
> Here’s an old bug from 2017, but it was brought to my attention in some 
> recent discussion about which "which" is which. There’s also a patch in 
> one of the follow-ups, but I’m afraid I don’t know enough about that 
> part of code to judge the consequences of it being applied:
> 
> https://bugs.debian.org/874264
> 
> -------- Forwarded Message --------
> Subject: dash: 'command -v' mistakenly returns a shell script whose 
> executable is not set
> Date: Mon, 04 Sep 2017 10:45:48 -0400
> From: Norman Ramsey <nr@cs.tufts.edu>
> To: Debian Bug Tracking System <submit@bugs.debian.org>
> 
> Package: dash
> Version: 0.5.8-2.4
> Severity: normal
> 
> Dear Maintainer,
> 
> 
> I tracked a build bug in s-nail to a problem with dash.  Symptom:
> building s-nail tries to run /home/nr/bin/clang, a script whose
> executable bit is not set.  We tracked the problem to the result of
> running `command -v clang` with /bin/sh:
> 
>   nr@homedog ~/n/s-nail> /bin/sh -c 'command -v clang'
>   /home/nr/bin/clang
>   nr@homedog ~/n/s-nail> ls -l /home/nr/bin/clang
>   -rw-rw-r-- 1 nr nr 1009 Aug 29  2011 /home/nr/bin/clang
>   nr@homedog ~/n/s-nail> ls -l /bin/sh
>   lrwxrwxrwx 1 root root 4 Jan 24  2017 /bin/sh -> dash
>   nr@homedog ~/n/s-nail> ksh -c 'command -v clang'
>   /usr/bin/clang
>   nr@homedog ~/n/s-nail> bash -c 'command -v clang'
>   /usr/bin/clang
>   nr@homedog ~/n/s-nail> sh -c 'command -v clang'
>   /home/nr/bin/clang
>   nr@homedog ~/n/s-nail> dash -c 'command -v clang'
>   /home/nr/bin/clang
>   nr@homedog ~/n/s-nail> fish -c 'command -v clang'
>   /usr/bin/clang
> 
> When I run `command -v clang` I expect it to answer /usr/bin/clang.
> 
> -- System Information:
> Debian Release: 9.1
>   APT prefers stable
>   APT policy: (990, 'stable'), (500, 'stable'), (1, 'experimental')
> Architecture: i386 (x86_64)
> Foreign Architectures: amd64
> 
> Kernel: Linux 4.9.0-3-amd64 (SMP w/4 CPU cores)
> Locale: LANG=C, LC_CTYPE=C (charmap=UTF-8) (ignored: LC_ALL set to 
> en_US.utf8), LANGUAGE=C (charmap=UTF-8) (ignored: LC_ALL set to en_US.utf8)
> Shell: /bin/sh linked to /bin/dash
> Init: systemd (via /run/systemd/system)
> 
> Versions of packages dash depends on:
> ii  debianutils  4.8.1.1
> ii  dpkg         1.18.24
> ii  libc6        2.24-11+deb9u1
> 
> dash recommends no packages.
> 
> dash suggests no packages.
> 
> -- debconf information:
> * dash/sh: true

This is inherited from NetBSD.  There is even a commented-out
block of code that tried to fix this.

Anyway, we now have faccessat so we can simply use it.

Reported-by: Norman Ramsey <nr@cs.tufts.edu>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/bltin/test.c b/src/bltin/test.c
index c7fc479..fd8a43b 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -18,6 +18,7 @@
 #include <unistd.h>
 #include <stdarg.h>
 #include "bltin.h"
+#include "../exec.h"
 
 /* test(1) accepts the following grammar:
 	oexpr	::= aexpr | aexpr "-o" oexpr ;
@@ -148,11 +149,6 @@ static int isoperand(char **);
 static int newerf(const char *, const char *);
 static int olderf(const char *, const char *);
 static int equalf(const char *, const char *);
-#ifdef HAVE_FACCESSAT
-static int test_file_access(const char *, int);
-#else
-static int test_access(const struct stat64 *, int);
-#endif
 
 #ifdef HAVE_FACCESSAT
 # ifdef HAVE_TRADITIONAL_FACCESSAT
@@ -527,7 +523,7 @@ static int has_exec_bit_set(const char *path)
 	return st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH);
 }
 
-static int test_file_access(const char *path, int mode)
+int test_file_access(const char *path, int mode)
 {
 	if (faccessat_confused_about_superuser() &&
 	    mode == X_OK && geteuid() == 0 && !has_exec_bit_set(path))
@@ -657,7 +653,7 @@ static int test_file_access(const char *path, int mode)
  * (euid==uid&&egid==gid), but uses st_mode for '-x' iff running as root.
  * i.e. it does strictly conform to 1003.1-2001 (and presumably 1003.2b).
  */
-static int test_access(const struct stat64 *sp, int stmode)
+int test_access(const struct stat64 *sp, int stmode)
 {
 	gid_t *groups;
 	register int n;
diff --git a/src/exec.c b/src/exec.c
index 87354d4..184717f 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -458,20 +458,14 @@ loop:
 			stunalloc(fullname);
 			goto success;
 		}
-#ifdef notdef
-		/* XXX this code stops root executing stuff, and is buggy
-		   if you need a group from the group list. */
-		if (statb.st_uid == geteuid()) {
-			if ((statb.st_mode & 0100) == 0)
-				goto loop;
-		} else if (statb.st_gid == getegid()) {
-			if ((statb.st_mode & 010) == 0)
-				goto loop;
-		} else {
-			if ((statb.st_mode & 01) == 0)
-				goto loop;
-		}
+		if ((statb.st_mode & 0111) != 0111 &&
+#ifdef HAVE_FACCESSAT
+		    !test_file_access(fullname, X_OK)
+#else
+		    !test_access(&statb, X_OK)
 #endif
+		   )
+			continue;
 		TRACE(("searchexec \"%s\" returns \"%s\"\n", name, fullname));
 		if (!updatetbl) {
 			entry->cmdtype = CMDNORMAL;
diff --git a/src/exec.h b/src/exec.h
index 423b07e..8707d36 100644
--- a/src/exec.h
+++ b/src/exec.h
@@ -62,6 +62,8 @@ union node;
 
 extern const char *pathopt;	/* set by padvance */
 
+struct stat64;
+
 void shellexec(char **, const char *, int)
     __attribute__((__noreturn__));
 int padvance_magic(const char **path, const char *name, int magic);
@@ -78,6 +80,9 @@ void unsetfunc(const char *);
 int typecmd(int, char **);
 int commandcmd(int, char **);
 
+int test_file_access(const char *path, int mode);
+int test_access(const struct stat64 *sp, int stmode);
+
 static inline int padvance(const char **path, const char *name)
 {
 	return padvance_magic(path, name, 1);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
