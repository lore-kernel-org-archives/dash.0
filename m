From: Raphael Geissert <geissert@debian.org>
Subject: [PATCH] sleep builtin
Date: Thu, 1 Nov 2012 19:48:47 -0600
Message-ID: <201211011948.48456.geissert@debian.org>
Reply-To: dash@vger.kernel.org, geissert@debian.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AaykQvxPJEG8oDe"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48774 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762211Ab2KBBsz (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 1 Nov 2012 21:48:55 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3207873obb.19
        for <dash@vger.kernel.org>; Thu, 01 Nov 2012 18:48:54 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

--Boundary-00=_AaykQvxPJEG8oDe
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

A while ago I wrote a sleep builtin mainly to test its impact in the boot 
process. The non-scientific results were not very impressive: around 1 
second.

So, I was cleaning up some directories and found the builtin. Instead of 
just nuking it, I'm forwarding it in case anyone wants to play with it or 
even merge it. If merged it will annoy those who are used to GNU's sleep(1) 
which supports the s/m/h/d suffixes, but not those using fractions as I added 
support for them.

Back then, I also payed attention to the resulting size of the binary, which 
obviously increased by a few KBs. However, I do remember that when switching 
from gcc 4.4 to 4.6 the resulting binary with the sleep builtin was smaller 
than the binary built with 4.4 and without sleep.

(interestingly, Debian's 0.5.7-3 dash is bigger than in 0.5.5.1-7)

Cheers,
-- 
Raphael Geissert - Debian Developer
www.debian.org - get.debian.net

--Boundary-00=_AaykQvxPJEG8oDe
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-BUILTIN-Add-sleep-1-built-in-similar-to-GNU-s.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-BUILTIN-Add-sleep-1-built-in-similar-to-GNU-s.patch"

=46rom 2dbe1edd6d355de98569175f7f76319778496d5d Mon Sep 17 00:00:00 2001
=46rom: Raphael Geissert <atomo64@gmail.com>
Date: Tue, 23 Nov 2010 21:47:20 -0600
Subject: [PATCH 1/2] [BUILTIN] Add sleep(1) built-in, similar to GNU's

Using an external command results in an unecessary number of syscalls.

While at it, provide an implementation that allows sleeping for
fractions of seconds (pretty much like GNU coreutil's sleep(1).)
Along with the reduced overhead, this provides a more fine-grained
sleep period.

Signed-off-by: Raphael Geissert <atomo64@gmail.com>
=2D--
 src/Makefile.am     |    3 +-
 src/bltin/sleep.c   |   97 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/builtins.def.in |    1 +
 src/dash.1          |    8 +++++
 4 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 src/bltin/sleep.c

diff --git a/src/Makefile.am b/src/Makefile.am
index ba68d55..3289805 100644
=2D-- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -21,7 +21,8 @@ dash_CFILES =3D \
 	alias.c arith_yacc.c arith_yylex.c cd.c error.c eval.c exec.c expand.c \
 	histedit.c input.c jobs.c mail.c main.c memalloc.c miscbltin.c \
 	mystring.c options.c parser.c redir.c show.c trap.c output.c \
=2D	bltin/printf.c system.c bltin/test.c bltin/times.c var.c
+	bltin/printf.c system.c bltin/test.c bltin/times.c var.c \
+	bltin/sleep.c
 dash_SOURCES =3D \
 	$(dash_CFILES) \
 	alias.h arith_yacc.h bltin/bltin.h cd.h error.h eval.h exec.h \
diff --git a/src/bltin/sleep.c b/src/bltin/sleep.c
new file mode 100644
index 0000000..5a167d3
=2D-- /dev/null
+++ b/src/bltin/sleep.c
@@ -0,0 +1,97 @@
+/*
+ * Copyright (c) 2010 Raphael Geissert <geissert@debian.org>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURP=
OSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENT=
IAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STR=
ICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY W=
AY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#include <errno.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <time.h>
+#include "error.h"
+#include "system.h"
+
+/*
+ * Built-in implementation of the sleep utility
+ * Conforms to POSIX-2001/SUSv3 and is still valid for POSIX-2008
+ * Extra features: support fractions of seconds,
+ *  just like GNU coreutil's sleep(1).
+
+ * Exit status: 0: ok, 1: user error, 2: sys error
+ */
+
+int sleepcmd(int argc, char **argv) {
+	struct timespec t;
+	double dt, diff;
+	uint64_t nsecs;
+	char *end;
+
+	if (argc !=3D 2)
+		goto usage;
+
+	errno =3D 0;
+	dt =3D strtod(argv[1], &end);
+
+	/* parsing errors */
+	if (argv[1] =3D=3D end || (argv[1]+strlen(argv[1])) > end)
+		goto invalid;
+	/* invalid numeric values */
+	if (dt < 0 || errno !=3D 0)
+		goto invalid;
+
+	/* optimisation, avoid the syscall */
+	if (dt =3D=3D 0)
+	    return 0;
+
+	/* no attempt to detect an overflow is made, let nanosleep fail */
+	t.tv_sec =3D dt;
+	t.tv_nsec =3D 0;
+	diff =3D (dt - (double)t.tv_sec);
+	if (diff < 0) {
+		diff *=3D -1;
+		t.tv_sec--;
+	}
+	t.tv_nsec =3D nsecs =3D diff * 1000000000;
+	/*
+	 * a double's fraction is 52 bits, so we need a variable of 64bits
+	 * to look for "would-overflows" without assuming that vars can
+	 * in fact overflow.  Since 1 billion fits in 32 bits, we only
+	 * look for it to find invalid values (10^9 ns =3D=3D 1s)
+	 */
+	if (nsecs >=3D 1000000000)
+		goto invalid;
+
+	if (nanosleep(&t, NULL) !=3D 0)
+		return 2;
+	return 0;
+
+invalid:
+	sh_warnx("invalid sleep interval");
+	return 1;
+usage:
+	sh_warnx("usage: sleep seconds");
+	return 1;
+}
diff --git a/src/builtins.def.in b/src/builtins.def.in
index 4441fe4..88f9cc9 100644
=2D-- a/src/builtins.def.in
+++ b/src/builtins.def.in
@@ -92,3 +92,4 @@ ulimitcmd	ulimit
 #endif
 testcmd		test [
 killcmd		-u kill
+sleepcmd	-u sleep
diff --git a/src/dash.1 b/src/dash.1
index ddeb52b..0398e50 100644
=2D-- a/src/dash.1
+++ b/src/dash.1
@@ -1816,6 +1816,14 @@ by one.
 If n is greater than the number of positional parameters,
 .Ic shift
 will issue an error message, and exit with return status 2.
+.It sleep Ar seconds
+.It sleep Ar seconds.fraction
+Sleep for at least the given number of seconds.
+.Va fraction
+has a precision of 1s-1ns.
+The number of seconds it can sleep is up to the system's limit. The
+current implementation does not attempt to sleep as most as the system
+allows when the requested amount is greater than the limit.
 .It test Ar expression
 .It \&[ Ar expression Cm ]
 The
=2D-=20
1.7.10


--Boundary-00=_AaykQvxPJEG8oDe
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-BUILTIN-Optimise-sleep-1-built-in.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-BUILTIN-Optimise-sleep-1-built-in.patch"

=46rom 01eacc35c00da455f3e5d3a3d2e26e6fceb952e3 Mon Sep 17 00:00:00 2001
=46rom: Raphael Geissert <atomo64@gmail.com>
Date: Tue, 7 Dec 2010 19:53:53 -0600
Subject: [PATCH 2/2] [BUILTIN] Optimise sleep(1) built-in

Avoid an extra variable and a useless call to strlen(3)

Signed-off-by: Raphael Geissert <atomo64@gmail.com>
=2D--
 src/bltin/sleep.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/src/bltin/sleep.c b/src/bltin/sleep.c
index 5a167d3..b8b10b9 100644
=2D-- a/src/bltin/sleep.c
+++ b/src/bltin/sleep.c
@@ -29,7 +29,6 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <stdint.h>
=2D#include <string.h>
 #include <time.h>
 #include "error.h"
 #include "system.h"
@@ -45,7 +44,7 @@
=20
 int sleepcmd(int argc, char **argv) {
 	struct timespec t;
=2D	double dt, diff;
+	double dt;
 	uint64_t nsecs;
 	char *end;
=20
@@ -55,8 +54,11 @@ int sleepcmd(int argc, char **argv) {
 	errno =3D 0;
 	dt =3D strtod(argv[1], &end);
=20
=2D	/* parsing errors */
=2D	if (argv[1] =3D=3D end || (argv[1]+strlen(argv[1])) > end)
+	/*
+	 * parsing errors
+	 * the first condition is needed to err out on *argv[1]=3D=3D'\0'
+	 */
+	if (argv[1] =3D=3D end || *end !=3D '\0')
 		goto invalid;
 	/* invalid numeric values */
 	if (dt < 0 || errno !=3D 0)
@@ -64,17 +66,17 @@ int sleepcmd(int argc, char **argv) {
=20
 	/* optimisation, avoid the syscall */
 	if (dt =3D=3D 0)
=2D	    return 0;
+		return 0;
=20
 	/* no attempt to detect an overflow is made, let nanosleep fail */
=2D	t.tv_sec =3D dt;
=2D	t.tv_nsec =3D 0;
=2D	diff =3D (dt - (double)t.tv_sec);
=2D	if (diff < 0) {
=2D		diff *=3D -1;
+	t.tv_sec =3D (time_t)dt;
+	dt -=3D (double)t.tv_sec;
+	/* detect if it was rounded up */
+	if (dt < 0) {
+		dt *=3D -1;
 		t.tv_sec--;
 	}
=2D	t.tv_nsec =3D nsecs =3D diff * 1000000000;
+	t.tv_nsec =3D nsecs =3D dt * 1000000000;
 	/*
 	 * a double's fraction is 52 bits, so we need a variable of 64bits
 	 * to look for "would-overflows" without assuming that vars can
=2D-=20
1.7.10


--Boundary-00=_AaykQvxPJEG8oDe--
