Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D6AC3DA7D
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 12:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjAEMni (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 07:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjAEMn1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 07:43:27 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ACD4338
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 04:43:25 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D937B2FE;
        Thu,  5 Jan 2023 13:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672922602;
        bh=T9De0AIRSu4r7rq1VxkLx/MIhspPRfZcx1a20CBjQfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPYfEA4bgIL5v9mJCeaXkBZEKttKitKWcFCLLLMFhGAwG6NiBIarIdyxX7ePLeaNS
         15trK0yv5Blv7FZgeAf2I0ghtlGGAx28HIzCmPRi1n8XyRDaY27FVbVCkyknPgcg3A
         BdHeZkOrK5/yFfYSdSNu0rcd7dQ9O9a+H1cPn5gU8h0+onYoi0AalY9v2GGhtFbpxE
         MuZc5S+wk4HjF9oDDaka35wbnXcpRUbBXjf09siIgglpGzftgTerxfXfoN4rqB0LSb
         ZbaxVpsOMn+d+pntGTg7g49mF7nWqT09ksqVT0LqZez0Vx2AIwWqS1YzWkJXp9n5/9
         zaJY70WEIIBsw==
Date:   Thu, 5 Jan 2023 13:43:21 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     jilles@stack.nl, dash@vger.kernel.org
Subject: [PATCH v2] redir: savefd: use F_DUPFD_CLOEXEC instead of
 F_DUPFD+F_SETFD, if available
Message-ID: <20230105124321.gsmk7h7xpuss75hw@tarta.nabijaczleweli.xyz>
References: <Y7aVs5pglzAvbnfn@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xy524m7ou3xub4a6"
Content-Disposition: inline
In-Reply-To: <Y7aVs5pglzAvbnfn@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--xy524m7ou3xub4a6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This saves a syscall on every source file open, &c.;
F_DUPFD_CLOEXEC is a mandatory part of POSIX since Issue 7
(Austin Group Interpretation 1003.1-2001 #171).
---
 configure.ac | 11 +++++++++++
 src/redir.c  |  7 ++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 52aa429..5524650 100644
--- a/configure.ac
+++ b/configure.ac
@@ -177,6 +177,17 @@ if test "$have_st_mtim" =3D "yes"; then
 		[Define if your `struct stat' has `st_mtim'])
 fi
=20
+dnl F_DUPFD_CLOEXEC is a mandatory part of POSIX since Issue 7
+AC_MSG_CHECKING(for F_DUPFD_CLOEXEC)
+AC_COMPILE_IFELSE(
+[AC_LANG_PROGRAM([#include <unistd.h>
+#include <fcntl.h>],
+[return fcntl(0, F_DUPFD_CLOEXEC, 0)])],
+have_dupfd_cloexec=3D1, have_dupfd_cloexec=3D0)
+AC_MSG_RESULT($(expr yes \& $have_dupfd_cloexec \| no))
+AC_DEFINE_UNQUOTED([HAVE_F_DUPFD_CLOEXEC], [$have_dupfd_cloexec],
+	[Define to 1 your system supports F_DUPFD_CLOEXEC])
+
 AC_ARG_WITH(libedit, AS_HELP_STRING(--with-libedit, [Compile with libedit =
support]))
 use_libedit=3D
 if test "$with_libedit" =3D "yes"; then
diff --git a/src/redir.c b/src/redir.c
index 5a5835c..631ddc9 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -446,13 +446,18 @@ savefd(int from, int ofd)
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
-		else
+		else if(!HAVE_F_DUPFD_CLOEXEC)
 			fcntl(newfd, F_SETFD, FD_CLOEXEC);
 	}
=20
--=20
2.30.2

--xy524m7ou3xub4a6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO2xekACgkQvP0LAY0m
WPF5kQ//QNAzU2G3Kwyui//yL4LmDQ0G4DmNzhOORTU9z/XeJlUjyALyBdAzroYE
gWiF+LTT8TklJmyZlkIwCo2kecrWos5ki4BEnwZ0Ouc7aXL/ItuwU4UfHncV81eT
vLYwFlXF4Rm4BW64hhmwBO8rLNSpy8wsKPaQPvTutO0zCH+3A7mG3g1swHTXaHld
mJVju8uZBZmXE/kiClUD6g+nDBmTKgRAdpiaM44n0+P1e1+ST45LwnBSXSIjp2c1
d8AN/0mbcQP0vXOSokHtiQPczR2bUDTPZC4SgdGTVjTA1GKYiU0e6Q5OMc1OxMy3
aOXoyEabJUZIYv+dxzpfEMX6dnFI8RvGakaVUqgsS26LqrMefihYN7FjMV/IOwWu
KcSdF8MYD0NwBSsgLtr0ABCRNltQILb55ise5DGh/9gEWhR5BIG5DR/EiR3gRq+7
0vjOCZ6y7OZd8nLIUJBXNjtzkecj9ahpdlGCdeMJ0tlxxAukoX0nTgW0iGOtZqP8
aWbm8AGa+3kAsQk/QiRRx186g/0yUvBfjtnkCjQYLYdW69xkuvOd1iXq1Dx6UGoC
Bhv3UTL7UdzNBGdcre6BheOZhL5lv4+IQY0e+VvLuOznWcdoXBynG+juxlT/deaI
mk2BVusgJOc4AQO3I1TpI4/SwSZS4iTUVniaRNpkR74PzP5/3eU=
=RjQD
-----END PGP SIGNATURE-----

--xy524m7ou3xub4a6--
