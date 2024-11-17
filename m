Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16C482ED
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731836374; cv=none; b=NCgS2K9/PZAvDZODeBDpJQwt2pc4WaXhGth5nPxaX0WhMoghbakCGNUIw0zV4TVGTFaK1yyVhimhGp8snnWmdVcbpLzN4cF13KvJ83B206GaH77TjHRzTPaJRArKbr/eoSkrqQ0Gxwd9na9U6tk4s30iW2wbHRerXhbWgd0oL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731836374; c=relaxed/simple;
	bh=ORRObNR8/tmXOhq7c54fc61ufqCd9sgnppJAH9JRiEw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=t2izlMho/3TpI+xApUKteA+nSEuT7r+ebCLsjDHdBDLUy/dsa2kZPa2hf4EHYQsJnV6tofuBWoNaECpBKPFOfAR13PVROYBcAvkmCR6G3wteIFPTtbVXP4ldFwcol1Bj9hrtK18XaYDDyI1eqvto43gzKZE1TfY6V+Eu5ivL+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AH9dJxs207336
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 10:39:20 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AH9dHqo414293
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 17 Nov 2024 10:39:19 +0100
Message-ID: <a1755801-1b50-4b05-bb15-99e238f3ed25@knaff.lu>
Date: Sun, 17 Nov 2024 10:39:17 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: P*rtability of dash to legacy systems, such as AT&T Unix PC :
 05-sys-headers
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The 5th patch probes for header files which might not exist on some
platforms such as UnixPC

Regards,

Alain

diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/configure.ac dash-0.5.12+05-sys-headers/configure.ac
--- dash-0.5.12+04-mksignames/configure.ac	2024-11-10 16:05:19.061451348 +0000
+++ dash-0.5.12+05-sys-headers/configure.ac	2024-11-10 17:06:10.308390356 +0000
@@ -44,7 +44,8 @@
 dnl Checks for libraries.
 
 dnl Checks for header files.
-AC_CHECK_HEADERS(alloca.h paths.h)
+AC_CHECK_HEADERS(alloca.h paths.h pwd.h dirent.h \
+		getopt.h sys/resource.h termios.h sys/time.h)
 
 dnl Check for declarations
 AC_CHECK_DECL([_PATH_BSHELL],,AC_DEFINE_UNQUOTED([_PATH_BSHELL], "/bin/sh", [Define to system shell path]),[
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/alias.c dash-0.5.12+05-sys-headers/src/alias.c
--- dash-0.5.12+04-mksignames/src/alias.c	2024-10-20 06:46:55.242147520 +0000
+++ dash-0.5.12+05-sys-headers/src/alias.c	2024-10-20 08:37:55.798682937 +0000
@@ -32,7 +32,9 @@
  * SUCH DAMAGE.
  */
 
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include "shell.h"
 #include "input.h"
 #include "output.h"
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/arith_yacc.c dash-0.5.12+05-sys-headers/src/arith_yacc.c
--- dash-0.5.12+04-mksignames/src/arith_yacc.c	2020-06-03 01:19:23.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/arith_yacc.c	2024-10-20 08:37:55.798682937 +0000
@@ -32,8 +32,12 @@
  * SUCH DAMAGE.
  */
 
+#ifdef HAVE_INTTYPES_H
 #include <inttypes.h>
+#endif
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include "arith_yacc.h"
 #include "expand.h"
 #include "shell.h"
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/arith_yylex.c dash-0.5.12+05-sys-headers/src/arith_yylex.c
--- dash-0.5.12+04-mksignames/src/arith_yylex.c	2020-06-03 01:19:23.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/arith_yylex.c	2024-10-20 08:37:55.798682937 +0000
@@ -32,8 +32,12 @@
  * SUCH DAMAGE.
  */
 
+#ifdef HAVE_INTTYPES_H
 #include <inttypes.h>
+#endif
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include <string.h>
 #include "arith_yacc.h"
 #include "expand.h"
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/bltin/printf.c dash-0.5.12+05-sys-headers/src/bltin/printf.c
--- dash-0.5.12+04-mksignames/src/bltin/printf.c	2020-06-03 01:19:23.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/bltin/printf.c	2024-10-20 08:37:55.798682937 +0000
@@ -33,10 +33,14 @@
 
 #include <ctype.h>
 #include <errno.h>
+#ifdef HAVE_INTTYPES_H
 #include <inttypes.h>
+#endif
 #include <limits.h>
 #include <stdarg.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include <string.h>
 #include <unistd.h>
 
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/bltin/test.c dash-0.5.12+05-sys-headers/src/bltin/test.c
--- dash-0.5.12+04-mksignames/src/bltin/test.c	2020-06-03 02:46:56.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/bltin/test.c	2024-10-20 08:37:55.798682937 +0000
@@ -12,8 +12,12 @@
 #include <sys/types.h>
 
 #include <fcntl.h>
+#ifdef HAVE_INTTYPES_H
 #include <inttypes.h>
+#endif
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/cd.c dash-0.5.12+05-sys-headers/src/cd.c
--- dash-0.5.12+04-mksignames/src/cd.c	2020-06-03 02:46:56.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/cd.c	2024-10-20 08:37:55.802683032 +0000
@@ -34,7 +34,9 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include <string.h>
 #include <unistd.h>
 #include <limits.h>
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/error.c dash-0.5.12+05-sys-headers/src/error.c
--- dash-0.5.12+04-mksignames/src/error.c	2020-06-03 01:19:23.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/error.c	2024-10-20 08:37:55.802683032 +0000
@@ -37,7 +37,9 @@
  */
 
 #include <signal.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/eval.c dash-0.5.12+05-sys-headers/src/eval.c
--- dash-0.5.12+04-mksignames/src/eval.c	2022-12-11 06:29:21.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/eval.c	2024-10-20 08:37:55.802683032 +0000
@@ -32,7 +32,9 @@
  * SUCH DAMAGE.
  */
 
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include <signal.h>
 #include <unistd.h>
 #include <sys/types.h>
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/exec.c dash-0.5.12+05-sys-headers/src/exec.c
--- dash-0.5.12+04-mksignames/src/exec.c	2020-06-03 02:23:24.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/exec.c	2024-10-20 08:37:55.802683032 +0000
@@ -36,7 +36,9 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #ifdef HAVE_PATHS_H
 #include <paths.h>
 #endif
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/expand.c dash-0.5.12+05-sys-headers/src/expand.c
--- dash-0.5.12+04-mksignames/src/expand.c	2022-12-11 06:29:21.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/expand.c	2024-11-10 15:30:16.271361150 +0000
@@ -33,16 +33,37 @@
  */
 
 #include <sys/types.h>
+#ifdef HAVE_SYS_TIME_H
 #include <sys/time.h>
+#endif
 #include <sys/stat.h>
+
+#ifdef HAVE_DIRENT_H
 #include <dirent.h>
+#else
+struct dirent {
+        ino_t d_ino;
+        char d_name[15]; /* One more than physically read, in order
+                          * to have a terminating character */
+};
+
+typedef struct DIR {
+        int fd;
+        struct dirent entry;
+} DIR;
+#endif
+
 #include <unistd.h>
-#ifdef HAVE_GETPWNAM
+#ifdef HAVE_PWD_H
 #include <pwd.h>
 #endif
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include <stdio.h>
+#ifdef HAVE_INTTYPES_H
 #include <inttypes.h>
+#endif
 #include <limits.h>
 #include <string.h>
 #ifdef HAVE_FNMATCH
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/expand.h dash-0.5.12+05-sys-headers/src/expand.h
--- dash-0.5.12+04-mksignames/src/expand.h	2022-12-07 08:27:49.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/expand.h	2024-10-20 08:37:55.806683126 +0000
@@ -34,7 +34,9 @@
  *	@(#)expand.h	8.2 (Berkeley) 5/4/95
  */
 
+#ifdef HAVE_INTTYPES_H
 #include <inttypes.h>
+#endif
 
 struct strlist {
 	struct strlist *next;
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/histedit.c dash-0.5.12+05-sys-headers/src/histedit.c
--- dash-0.5.12+04-mksignames/src/histedit.c	2020-06-03 01:19:23.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/histedit.c	2024-10-20 19:15:19.545396934 +0000
@@ -37,9 +37,16 @@
 #include <paths.h>
 #endif
 #include <stdio.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
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
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/input.c dash-0.5.12+05-sys-headers/src/input.c
--- dash-0.5.12+04-mksignames/src/input.c	2022-12-07 08:30:24.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/input.c	2024-10-20 08:37:55.806683126 +0000
@@ -35,7 +35,9 @@
 #include <stdio.h>	/* defines BUFSIZ */
 #include <fcntl.h>
 #include <unistd.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include <string.h>
 
 /*
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/jobs.c dash-0.5.12+05-sys-headers/src/jobs.c
--- dash-0.5.12+04-mksignames/src/jobs.c	2024-10-27 19:53:36.384519682 +0000
+++ dash-0.5.12+05-sys-headers/src/jobs.c	2024-10-27 20:11:25.698058831 +0000
@@ -35,7 +35,9 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <unistd.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #ifdef HAVE_PATHS_H
 #include <paths.h>
 #endif
@@ -43,14 +45,20 @@
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
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/jobs.h dash-0.5.12+05-sys-headers/src/jobs.h
--- dash-0.5.12+04-mksignames/src/jobs.h	2020-06-03 01:19:23.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/jobs.h	2024-10-20 08:37:55.806683126 +0000
@@ -34,7 +34,9 @@
  *	@(#)jobs.h	8.2 (Berkeley) 5/4/95
  */
 
+#ifdef HAVE_INTTYPES_H
 #include <inttypes.h>
+#endif
 #include <sys/types.h>
 
 /* Mode argument to forkshell.  Don't change FORK_FG or FORK_BG. */
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/mail.c dash-0.5.12+05-sys-headers/src/mail.c
--- dash-0.5.12+04-mksignames/src/mail.c	2020-06-03 01:19:23.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/mail.c	2024-10-20 08:37:55.810683220 +0000
@@ -37,7 +37,9 @@
  */
 #include <sys/types.h>
 #include <sys/stat.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 
 #include "shell.h"
 #include "nodes.h"
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/memalloc.c dash-0.5.12+05-sys-headers/src/memalloc.c
--- dash-0.5.12+04-mksignames/src/memalloc.c	2020-06-03 02:23:24.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/memalloc.c	2024-10-20 08:37:55.810683220 +0000
@@ -32,7 +32,9 @@
  * SUCH DAMAGE.
  */
 
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include <unistd.h>
 
 #include "shell.h"
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/memalloc.h dash-0.5.12+05-sys-headers/src/memalloc.h
--- dash-0.5.12+04-mksignames/src/memalloc.h	2020-06-03 02:24:30.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/memalloc.h	2024-10-20 08:37:55.810683220 +0000
@@ -35,7 +35,9 @@
  */
 
 #include <stddef.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 
 struct stackmark {
 	struct stack_block *stackp;
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/miscbltin.c dash-0.5.12+05-sys-headers/src/miscbltin.c
--- dash-0.5.12+04-mksignames/src/miscbltin.c	2020-06-03 01:19:23.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/miscbltin.c	2024-10-20 19:15:19.545396934 +0000
@@ -39,12 +39,20 @@
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
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include <ctype.h>
+#ifdef HAVE_INTTYPES_H
 #include <inttypes.h>
+#endif
 
 #include "shell.h"
 #include "options.h"
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/mystring.c dash-0.5.12+05-sys-headers/src/mystring.c
--- dash-0.5.12+04-mksignames/src/mystring.c	2024-10-20 18:59:37.047164717 +0000
+++ dash-0.5.12+05-sys-headers/src/mystring.c	2024-10-20 08:37:55.814683315 +0000
@@ -44,9 +44,13 @@
 
 #include <ctype.h>
 #include <errno.h>
+#ifdef HAVE_INTTYPES_H
 #include <inttypes.h>
+#endif
 #include <limits.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include "shell.h"
 #include "syntax.h"
 #include "error.h"
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/mystring.h dash-0.5.12+05-sys-headers/src/mystring.h
--- dash-0.5.12+04-mksignames/src/mystring.h	2022-12-07 08:27:49.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/mystring.h	2024-10-20 08:37:55.814683315 +0000
@@ -34,7 +34,9 @@
  *	@(#)mystring.h	8.2 (Berkeley) 5/4/95
  */
 
+#ifdef HAVE_INTTYPES_H
 #include <inttypes.h>
+#endif
 #include <string.h>
 
 #ifdef HAVE_FNMATCH
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/nodes.c.pat dash-0.5.12+05-sys-headers/src/nodes.c.pat
--- dash-0.5.12+04-mksignames/src/nodes.c.pat	2020-06-03 01:19:23.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/nodes.c.pat	2024-10-20 08:37:55.814683315 +0000
@@ -34,7 +34,9 @@
  *	@(#)nodes.c.pat	8.2 (Berkeley) 5/4/95
  */
 
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 /*
  * Routine for dealing with parsed shell commands.
  */
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/options.c dash-0.5.12+05-sys-headers/src/options.c
--- dash-0.5.12+04-mksignames/src/options.c	2020-06-03 02:24:30.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/options.c	2024-10-20 08:37:55.814683315 +0000
@@ -34,7 +34,9 @@
 
 #include <signal.h>
 #include <unistd.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 
 #include "shell.h"
 #define DEFINE_OPTIONS
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/output.c dash-0.5.12+05-sys-headers/src/output.c
--- dash-0.5.12+04-mksignames/src/output.c	2020-06-03 02:24:30.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/output.c	2024-10-20 08:37:55.814683315 +0000
@@ -50,7 +50,9 @@
 #include <stdio.h>	/* defines BUFSIZ */
 #include <string.h>
 #include <unistd.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #ifdef USE_GLIBC_STDIO
 #include <fcntl.h>
 #endif
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/parser.c dash-0.5.12+05-sys-headers/src/parser.c
--- dash-0.5.12+04-mksignames/src/parser.c	2022-12-11 06:29:21.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/parser.c	2024-10-20 08:37:55.818683409 +0000
@@ -36,7 +36,9 @@
 #include <alloca.h>
 #endif
 
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 
 #include "shell.h"
 #include "parser.h"
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/redir.c dash-0.5.12+05-sys-headers/src/redir.c
--- dash-0.5.12+04-mksignames/src/redir.c	2022-12-07 08:27:49.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/redir.c	2024-10-20 08:37:55.818683409 +0000
@@ -39,7 +39,9 @@
 #include <string.h>
 #include <fcntl.h>
 #include <unistd.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 
 /*
  * Code for dealing with input/output redirection.
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/show.c dash-0.5.12+05-sys-headers/src/show.c
--- dash-0.5.12+04-mksignames/src/show.c	2020-06-03 01:19:23.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/show.c	2024-10-27 19:46:51.818856150 +0000
@@ -34,6 +34,9 @@
 
 #include <stdio.h>
 #include <stdarg.h>
+#ifdef HAVE_STDLIB_H
+#include <stdlib.h>
+#endif
 
 #include "shell.h"
 #include "parser.h"
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/trap.c dash-0.5.12+05-sys-headers/src/trap.c
--- dash-0.5.12+04-mksignames/src/trap.c	2020-07-08 07:05:35.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/trap.c	2024-10-20 08:37:55.818683409 +0000
@@ -34,7 +34,9 @@
 
 #include <signal.h>
 #include <unistd.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #include <string.h>
 
 #include "shell.h"
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/var.c dash-0.5.12+05-sys-headers/src/var.c
--- dash-0.5.12+04-mksignames/src/var.c	2020-06-03 02:46:56.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/var.c	2024-10-20 08:37:55.818683409 +0000
@@ -34,7 +34,9 @@
 
 #include <unistd.h>
 #include <stdio.h>
+#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
+#endif
 #ifdef HAVE_PATHS_H
 #include <paths.h>
 #endif
diff -X ../exclude.txt -urN dash-0.5.12+04-mksignames/src/var.h dash-0.5.12+05-sys-headers/src/var.h
--- dash-0.5.12+04-mksignames/src/var.h	2020-06-03 02:25:38.000000000 +0000
+++ dash-0.5.12+05-sys-headers/src/var.h	2024-10-20 08:37:55.822683504 +0000
@@ -34,7 +34,9 @@
  *	@(#)var.h	8.2 (Berkeley) 5/4/95
  */
 
+#ifdef HAVE_INTTYPES_H
 #include <inttypes.h>
+#endif
 
 /*
  * Shell variables.
