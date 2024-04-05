Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D601607BF
	for <dash@vger.kernel.org>; Fri,  5 Apr 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310937; cv=none; b=jRAzjT0YJfepbkamL8NMmd11Lt0cbcx5kFOstD2tPIh1N4QcJo2CCyBBgDwsyhs/wcrSyrt8tue81YqcLrK/lqpAhb3tgvVQ5Az5JtX3XwWlmCgxy870so35bns5+2Pjt/zpxFzM+oL9n9DMAWZVAy/Fw7RfdpoN6BfQgtDdDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310937; c=relaxed/simple;
	bh=dRBCByotM9fnT7+fmmZbnkEnRxLPEQ3czEqI1mK1uh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfwRCD5ZQ0lQWPdd8XYppGKoPym5zL7aZTkWftZ9PIrVlJhtwq02ygThOaZbu7VqO1oY74dUVIrO6dxg9Hu0uhqoLtF46NBMFx0ZI8ZEf0BBGOd8YJbiZaU6/hPt0STW3CubzY1C6N4lDwHcfA4sbIPvKgZ+WBpvfmeEfrcl+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsgID-00FWue-HH; Fri, 05 Apr 2024 17:55:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 17:55:46 +0800
Date: Fri, 5 Apr 2024 17:55:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nicola Lamacchia <nicola.lamacchia@gmail.com>
Cc: dash@vger.kernel.org, Andrej Shadura <andrew.shadura@collabora.co.uk>,
	874264@bugs.debian.org
Subject: [v2 PATCH] exec: Check executable bit when searching path
Message-ID: <Zg/Kom9EMBrBPqr5@gondor.apana.org.au>
References: <CA+z1gfX9ZexoQC8tm9V0hV_Vo3kMxxDw5GJdeNTy_DFGu_CMKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+z1gfX9ZexoQC8tm9V0hV_Vo3kMxxDw5GJdeNTy_DFGu_CMKg@mail.gmail.com>

On Mon, May 30, 2022 at 07:02:30PM +0200, Nicola Lamacchia wrote:
> 
> the following patches `command -v` to make it abide by POSIX
> specifications[1] as previously described by orbea in this mailing
> list[2]. Behavior comparison at the bottom[5].
> 
> Please note that POSIX does not specify the exit status in this
> case[1]: "Otherwise, no output shall be written and the exit status
> shall reflect that the name was not found." Although it requires the
> exit status to be 127 in case of command not found[3].
> 
> Also note that in order for a command to be considered "found" when
> using the PATH variable, it has to be an executable file[4]: "The list
> shall be searched from beginning to end, applying the filename to each
> prefix, until an executable file with the specified name and
> appropriate execution permissions is found."
> 
> Therefore an exit status of 127 seems to be suitable in this case.
> Which would leave the exit status 126 to be used when the user tries
> to execute a file while not having the right permissions to do so.

Thanks for the report.  This is really the same issue as

https://lore.kernel.org/all/20211110065303.GA4283@gondor.apana.org.au/

However, that patch doesn't actually work.  Here is an updated
version which should fix this properly:

---8<---
Andrej Shadura <andrew.shadura@collabora.co.uk> wrote:
>
> Here's an old bug from 2017, but it was brought to my attention in some
> recent discussion about which "which" is which. There's also a patch in
> one of the follow-ups, but I'm afraid I don't know enough about that
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
Reported-by: Nicola Lamacchia <nicola.lamacchia@gmail.com>
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
index 83cba94..ca68462 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -325,7 +325,22 @@ printentry(struct tblentry *cmdp)
 	out1fmt(snlfmt, cmdp->rehash ? "*" : nullstr);
 }
 
+static int test_exec(const char *fullname, struct stat64 *statb)
+{
+	if (!S_ISREG(statb->st_mode))
+		return 0;
 
+	if ((statb->st_mode & 0111) != 0111 &&
+#ifdef HAVE_FACCESSAT
+	    !test_file_access(fullname, X_OK)
+#else
+	    !test_access(statb, X_OK)
+#endif
+	   )
+		return 0;
+
+	return 1;
+}
 
 /*
  * Resolve a command name.  If you change this routine, you may have to
@@ -354,9 +369,12 @@ find_command(char *name, struct cmdentry *entry, int act, const char *path)
 				if (errno == EINTR)
 					continue;
 #endif
+absfail:
 				entry->cmdtype = CMDUNKNOWN;
 				return;
 			}
+			if (!test_exec(name, &statb))
+				goto absfail;
 		}
 		entry->cmdtype = CMDNORMAL;
 		return;
@@ -451,9 +469,6 @@ loop:
 				e = errno;
 			goto loop;
 		}
-		e = EACCES;	/* if we fail, this will be the error */
-		if (!S_ISREG(statb.st_mode))
-			continue;
 		if (lpathopt) {		/* this is a %func directory */
 			stalloc(len);
 			readcmdfile(fullname);
@@ -464,20 +479,9 @@ loop:
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
-#endif
+		e = EACCES;	/* if we fail, this will be the error */
+		if (!test_exec(fullname, &statb))
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
