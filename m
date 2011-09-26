From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] [BUILTIN] Make "test -x" sane again when run as root
Date: Mon, 26 Sep 2011 16:16:37 -0500
Message-ID: <20110926211636.GA6645@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42114 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab1IZVQw convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 26 Sep 2011 17:16:52 -0400
Received: by gyg10 with SMTP id 10so4533903gyg.19
        for <dash@vger.kernel.org>; Mon, 26 Sep 2011 14:16:51 -0700 (PDT)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Christoph Egger <christoph@debian.org>, Petr Salinger <Petr.Salinger@seznam.cz>, Herbert Xu <herbert@gondor.apana.org.au>

When dash switched from its own emulation to the true faccessat in
v0.5.7~54 (2010-04-02), on some platforms (e.g., old versions of
glibc-bsd), "test -x <path>" started returning true on all files when
run as root.  This violates POSIX.1-2008 =C2=A74.4 "File Access
Permission", which says:

	If execute permission is requested, access shall be granted
	if execute permission is granted to at least one user by the
	file permission bits or by an alternate access control
	mechanism; otherwise, access shall be denied.

Unfortunately, for historical reasons, access() and faccessat() are
allowed by POSIX to return success for X_OK when the current process
is privileged even when the above condition is not fulfilled and
actual execution would fail.  Work around this by checking the
permissions bits when mode =3D=3D X_OK and geteuid() =3D=3D 0.

Reported-by: Christoph Egger <christoph@debian.org>
Analysis-by: Petr Salinger <Petr.Salinger@seznam.cz>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks, all, and sorry to take so long in sending this patch out.

Thoughts?

 src/bltin/test.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/src/bltin/test.c b/src/bltin/test.c
index 90135e14..1093b59f 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -485,8 +485,19 @@ equalf (const char *f1, const char *f2)
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
+	if (mode =3D=3D X_OK && geteuid() =3D=3D 0 && !has_exec_bit_set(path)=
)
+		return 0;
 	return !faccessat(AT_FDCWD, path, mode, AT_EACCESS);
 }
 #else	/* HAVE_FACCESSAT */
--=20
1.7.7.rc1

