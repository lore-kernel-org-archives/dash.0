Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059C7EC4
	for <dash@vger.kernel.org>; Sun, 28 Jul 2024 02:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722135105; cv=none; b=Tflni/xm1wF/nF1zUwvPFD1gvat+bgS0+3WtvQ9gRgL176jnKVGtN+11Ez9mmNkKvt+P0SiXvaFYc4YrbVO+L0SflhKXcoUERoF34/Mmb+1T/hTu+yKJbBr42BRMrOni4BfdmtMQUeOihw1LF9neqgmAAOBe/9Q2Eo36c2WnNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722135105; c=relaxed/simple;
	bh=DQDagQ8ZuJ7CH+h1rYjAJgRnPgVIPdI/yrGaF0f8xXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgLm8WnEW3YKwRwBlZ9QUsyYbtIpCtfQpFGa+vvBsdMXab3k17DgyqdM6iU6fRTzxAD/ZpsrUKNzQvIDlorvROsJV3P5YIFxySE9eCPb2WLFZvpJ972BV1uMor3fm7aq1lDff/CVRphoeIsn890bCMLM0GMThfirgTWR/+wlYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=WRUVIcU5; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="WRUVIcU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1722134572;
	bh=DQDagQ8ZuJ7CH+h1rYjAJgRnPgVIPdI/yrGaF0f8xXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRUVIcU57V/9wduChX+/aLe2zOUc8I04zOSkxjsJKJqrIUF+2tK/VhYu5Xq3w3G4E
	 dHSHiuwR3eBOBxmg5LtPaHpmcog/xX7FFNmNT6a1wT+G01IMbyLyvJ87a91mwRjhyl
	 yxkKsZGEMJqTTnDBVYE/GhD7MM0KYextAKkDdrGlgy1mNPE5oDFE+Cl06YqMCIl6rq
	 r7dgn32Qu/zWDhxOu3JevHHbnjObEadU7m4TRP5bII/EnLBPchl9veyBWgLjaNDHHy
	 0vcvFsh28pTluPuJU+ew+OvDv3eP+2XRvuMDqJtucupQdSeKU7nc0eY3gXgC0QKqkz
	 SjPBo8Z4Bvl3g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6E7F59CB6;
	Sun, 28 Jul 2024 04:42:52 +0200 (CEST)
Date: Sun, 28 Jul 2024 04:42:52 +0200
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: [PATCH v2] bltin/test: align -nt and -ot with POSIX.1-2024
Message-ID: <cvvclqjh5f7lkvwzrcv4akogr3ko7bqdwqilrw5rslebgovdyh@tarta.nabijaczleweli.xyz>
References: <ZqWuqe25h-VkDqnj@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7lkgu3uye7jvfab3"
Content-Disposition: inline
In-Reply-To: <ZqWuqe25h-VkDqnj@gondor.apana.org.au>
User-Agent: NeoMutt/20240329


--7lkgu3uye7jvfab3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

117027  pathname1 =E2=88=92nt pathname2
117028    True if pathname1 resolves to an existing file and pathname2 cann=
ot be resolved, or if
117029    both resolve to existing files and pathname1 is newer than pathna=
me2 according to
117030    their last data modification timestamps; otherwise, false.
117031  pathname1 =E2=88=92ot pathname2
117032    True if pathname2 resolves to an existing file and pathname1 cann=
ot be resolved, or if
117033    both resolve to existing files and pathname1 is older than pathna=
me2 according to
117034    their last data modification timestamps; otherwise, false.

The correct output is
  $ [ 2024 -nt 2023 ] && echo yes
  yes
  $ [ 2023 -nt 2024 ] && echo yes
  $ [ 2023 -nt ENOENT ] && echo yes
  yes
  $ [ ENOENT -nt 2024 ] && echo yes
and
  $ [ 2024 -ot 2023 ] && echo yes
  $ [ 2023 -ot 2024 ] && echo yes
  yes
  $ [ 2023 -ot ENOENT ] && echo yes
  $ [ ENOENT -ot 2024 ] && echo yes
  yes
but dash currently returned only the first yes out of both blocks.
---
 src/bltin/test.c | 31 +++++++++++++++++--------------
 src/dash.1       | 14 ++++++++++++--
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/src/bltin/test.c b/src/bltin/test.c
index 2db4d0f..d7996df 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -17,6 +17,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include "bltin.h"
 #include "../exec.h"
=20
@@ -471,16 +472,17 @@ newerf (const char *f1, const char *f2)
 {
 	struct stat64 b1, b2;
=20
+	if (stat64(f1, &b1) !=3D 0)
+		return false;
+	if (stat64(f2, &b2) !=3D 0)
+		return true;
+
 #ifdef HAVE_ST_MTIM
-	return (stat64(f1, &b1) =3D=3D 0 &&
-		stat64(f2, &b2) =3D=3D 0 &&
+	return
 		( b1.st_mtim.tv_sec > b2.st_mtim.tv_sec ||
-		 (b1.st_mtim.tv_sec =3D=3D b2.st_mtim.tv_sec && (b1.st_mtim.tv_nsec > b2=
=2Est_mtim.tv_nsec )))
-	);
+		 (b1.st_mtim.tv_sec =3D=3D b2.st_mtim.tv_sec && (b1.st_mtim.tv_nsec > b2=
=2Est_mtim.tv_nsec )));
 #else
-	return (stat64(f1, &b1) =3D=3D 0 &&
-		stat64(f2, &b2) =3D=3D 0 &&
-		b1.st_mtime > b2.st_mtime);
+	return b1.st_mtime > b2.st_mtime;
 #endif
 }
=20
@@ -489,16 +491,17 @@ olderf (const char *f1, const char *f2)
 {
 	struct stat64 b1, b2;
=20
+	if (stat64(f2, &b2) !=3D 0)
+		return false;
+	if (stat64(f1, &b1) !=3D 0)
+		return true;
+
 #ifdef HAVE_ST_MTIM
-	return (stat64(f1, &b1) =3D=3D 0 &&
-		stat64(f2, &b2) =3D=3D 0 &&
+	return
 		(b1.st_mtim.tv_sec < b2.st_mtim.tv_sec ||
-		 (b1.st_mtim.tv_sec =3D=3D b2.st_mtim.tv_sec && (b1.st_mtim.tv_nsec < b2=
=2Est_mtim.tv_nsec )))
-	);
+		 (b1.st_mtim.tv_sec =3D=3D b2.st_mtim.tv_sec && (b1.st_mtim.tv_nsec < b2=
=2Est_mtim.tv_nsec )));
 #else
-	return (stat64(f1, &b1) =3D=3D 0 &&
-		stat64(f2, &b2) =3D=3D 0 &&
-		b1.st_mtime < b2.st_mtime);
+	return b1.st_mtime < b2.st_mtime;
 #endif
 }
=20
diff --git a/src/dash.1 b/src/dash.1
index 6c4ee2d..96ce89e 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -2019,7 +2019,12 @@ .Ss Builtins
 exist and
 .Ar file1
 is newer than
-.Ar file2 .
+.Ar file2 ,
+or if
+.Ar file1
+exists but
+.Ar file2
+doesn't.
 .It Ar file1 Fl ot Ar file2
 True if
 .Ar file1
@@ -2028,7 +2033,12 @@ .Ss Builtins
 exist and
 .Ar file1
 is older than
-.Ar file2 .
+.Ar file2 ,
+or if
+.Ar file2
+exists but
+.Ar file1
+doesn't.
 .It Ar file1 Fl ef Ar file2
 True if
 .Ar file1
--=20
2.39.2

--7lkgu3uye7jvfab3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmalsCsACgkQvP0LAY0m
WPHF2g//bgNCeTQFuoExKIOPBuyDEErWuXeB4+v5yCefFHOaTifl8xkdhDaQG88x
wqnf0JAvKGjlyc/32Tt1Qk5znghMPaYDUm3V2m1fW0xCzK/wy9O8wGlLW3drR3Ef
pwjjHkWIBYWdnvDh+Cno4RCbO4s+un9ykhA9oC26emjT/LCx2nLKC5/X7cDqM0QK
O63lbOFdLNl3NeTsgQdu66a23SASZW9a+/HHB4lTXiL01nSypbkvzsahSgGzjHDQ
EglStMoiBKvIqVvtTr8xNuLmSBO1aNAXNxNmPZNigddd+5fHfOuIjo0TWczzGNS7
+4dPk1Qmq54ZnfeRO1Yz2wJ0VKU1bQtKaYlMFHRhc81Aa0OEt5+rzqQ0OX03YHaA
L31oBnfow057Un5V4NZI8r+53irNCcUFo4evg7A+JHAOLC7BQFqdy+aJFzrJ9vEW
X1+Af0gjpHxxMQkJkddd/IG4W+ZVrwLkMNZOBrgfcg9yHoSj/dXHFw8/ebVG4ppC
9ZV2tFIm9S4vEeOpbU0wc6xQZE2jK0yG1sMagxDFoEIU5+CixtLwdewlebI/hZn8
cQTi6gpeAQX2LWEWIJpnFhxz8CztlK5tndGKb+YwmuqOT3g1jw7o+8QYm2s/GVuI
l+fO9d+27TFec+OkKOGHvPRdKK195JqEPBDAB7dGmAX5m3e88XA=
=A5dm
-----END PGP SIGNATURE-----

--7lkgu3uye7jvfab3--
