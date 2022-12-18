Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B39C4167B
	for <linux-dash@archiver.kernel.org>; Sun, 18 Dec 2022 02:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLRC7s (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 17 Dec 2022 21:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLRC7o (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 17 Dec 2022 21:59:44 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3F0CF012
        for <dash@vger.kernel.org>; Sat, 17 Dec 2022 18:59:38 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C8AB1B00;
        Sun, 18 Dec 2022 03:59:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671332375;
        bh=of+AmGp7ddEP64mi0oGVyY9wIpcmENb8uiszZZ/7NjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PXExfDmLlCgE0b7a9pMslh9DbGbXqdBZfdm0qPpwzTTZ8cWw4o/yO5AD3jwqKMICV
         1hvN1tqk1r5VImb4Np7zLV9DcsZQoiOcGHnE6/uLNWedobCP+29FFO1ZQXmh+Mjui2
         C0kF1Go8pwujb+ZXG0l8prb9BBYkheryniyUdRWcyxX5rncDwdQMOm9cIzGsTMp0Uw
         aKC+ormUIEqM2D5Z1fKZqRPizod4i/DvhVhpJBNyRskbJxM79pI9APn13oXnHxWcdD
         Y0D57b2CfMH5y9347w2hzgwjA8FTUPB7pvMjfptinvhxlk38ZvL8fNfM4K/nJGfc8W
         TXYmxNxD/vHVQ==
Date:   Sun, 18 Dec 2022 03:59:34 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org
Subject: [PATCH v2] redir: savefd: use F_DUPFD_CLOEXEC instead of
 F_DUPFD+F_SETFD, if available
Message-ID: <20221218025934.hgg6zzq4pwvja7t4@tarta.nabijaczleweli.xyz>
References: <20221217144420.GA3954@stack.nl>
 <Y557CKtBkfwavGYP@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="islxwfklayas7op7"
Content-Disposition: inline
In-Reply-To: <Y557CKtBkfwavGYP@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--islxwfklayas7op7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This saves a syscall on every source file open, &c.;
F_DUPFD_CLOEXEC is a mandatory part of POSIX since Issue 7
(Austin Group Interpretation 1003.1-2001 #171).
---
autoconf bits adapted almost-verbatim from the st_mtim check above

 configure.ac | 13 +++++++++++++
 src/redir.c  |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/configure.ac b/configure.ac
index 52aa429..b870a59 100644
--- a/configure.ac
+++ b/configure.ac
@@ -177,6 +177,19 @@ if test "$have_st_mtim" =3D "yes"; then
 		[Define if your `struct stat' has `st_mtim'])
 fi
=20
+dnl F_DUPFD_CLOEXEC is a mandatory part of POSIX since Issue 7
+AC_MSG_CHECKING(for F_DUPFD_CLOEXEC)
+AC_COMPILE_IFELSE(
+[AC_LANG_PROGRAM([#include <unistd.h>
+#include <fcntl.h>],
+[return fcntl(0, F_DUPFD_CLOEXEC, 0)])],
+have_dupfd_cloexec=3Dyes, have_dupfd_cloexec=3Dno)
+AC_MSG_RESULT($have_dupfd_cloexec)
+if test "$have_dupfd_cloexec" =3D "yes"; then
+	AC_DEFINE([HAVE_F_DUPFD_CLOEXEC], [1],
+		[Define if your system supports F_DUPFD_CLOEXEC])
+fi
+
 AC_ARG_WITH(libedit, AS_HELP_STRING(--with-libedit, [Compile with libedit =
support]))
 use_libedit=3D
 if test "$with_libedit" =3D "yes"; then
diff --git a/src/redir.c b/src/redir.c
index 5a5835c..c923bfa 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -446,14 +446,21 @@ savefd(int from, int ofd)
 	int newfd;
 	int err;
=20
+#if HAVE_F_DUPFD_CLOEXEC
+	newfd =3D fcntl(from, F_DUPFD_CLOEXEC, 10);
+#else
 	newfd =3D fcntl(from, F_DUPFD, 10);
+#endif
+
 	err =3D newfd < 0 ? errno : 0;
 	if (err !=3D EBADF) {
 		close(ofd);
 		if (err)
 			sh_error("%d: %s", from, strerror(err));
+#if !HAVE_F_DUPFD_CLOEXEC
 		else
 			fcntl(newfd, F_SETFD, FD_CLOEXEC);
+#endif
 	}
=20
 	return newfd;
--=20
2.30.2

--islxwfklayas7op7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOeghYACgkQvP0LAY0m
WPERVw/+KJM7zDPUjojOQ32yOxEVjegawKhdgplJuC02SkytVP+ppxiS2So5kw1G
Fr2xnSKY1T255Cb8oA8+wb1bogNJUMxC+BiNdOtO9TVYR3JcDjpu73CPdLT1vhKS
ZCw91eKaP5jk4uFMUwM+c4gNHYJfFDmIq9S6JDng+e+uTZ3mv5qSKZ+oERe1nhrh
UEs2yJ/hO27XNXhaRI1jV3ZSaVqS0ZxMGtK0bDLQGyvqvQZ99SJsAjyt/tlUByY+
neTw4vQa3/PbXdQk6O1uKk7uCS8jdxN/CbTMGwbQwX0UGnd0bYiE0uSkT97kUNdn
g77AbM3PtRyn7w2oi6sxyS/yEWeBNg69G+SHyj3rY3rgnsiOQe7m2WrXNNHJ/OiI
L09V3um+EOIM4xWHeQzJ11ulQ61cSvYEYdMAhTGARnTsKe5k0oW4eyhXlw/Ex70D
izPt6KkVT/8xuApyrmoxJ8PwXq1Gsmu0zYT2nMC4MB6I1P5hUMsyQuWDKlfaOM7e
47a2RBgPUUhDyqSl0UQ7irfqh1BD7PF6ZamBOrYLm/BQZU4UwoEQ4RHjxEd/7fs+
LScz4MzxpPqn6kqCEoxi7ACBd2SKBNHtiCOBLNlyLeIdyWDB3jtnL8QVEWHJ3pks
lJ0i6gL+H1uIOqiF2RwHPkGo8TCmUsGlB5bt9cueXzFj6bPB+uk=
=NNig
-----END PGP SIGNATURE-----

--islxwfklayas7op7--
