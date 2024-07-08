Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5906D1420DF
	for <dash@vger.kernel.org>; Mon,  8 Jul 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461694; cv=none; b=nsdJqrJ2Nbuh0dFF0lzyBYGUeX+kgWqopsg/GpxI6V6TO5tO17jDwL4gp7aTVSJSg40RMq14GxM4vuB1u5tptM25CCiZOAu4gDpXtBENeVM0clYT2vPof6O0Qpbze7vU/5hYgceUc8Rzj+3zLgz+pkIGHOada7yLhKAfjjwS71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461694; c=relaxed/simple;
	bh=A8ZRvCRHKOVjfkQGJ7h2AVH8RPlmb23HYUrd7OVZ/h8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MLA75A4jeU5h4SWkKtr9Vg9TQrzG5u8CoK2LgVdVBG9KMxEudJDRdWCJlWV9hdFC9B1o7ZyM6LFE1IwlNkhy6XS1YdYn/Vz2Uvzd9wy1VF2jy3I9iAxRdAuMxp+QEwUMHsNtMjbeleqUizggOCY+sjZpR4kAEWyN7kXopA1Y9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=XHCZ1OhG; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="XHCZ1OhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1720461685;
	bh=A8ZRvCRHKOVjfkQGJ7h2AVH8RPlmb23HYUrd7OVZ/h8=;
	h=Date:From:To:Cc:Subject:From;
	b=XHCZ1OhGpjo2ncE5ZJgkpUN0aBirRI1M72vPqwSilxZdpySr64Kl5eAi33VyiCJ3u
	 hFI9YfYCWc80KNEhcELejLsXCbiCqZK7Hc/Sa83jBWf0irM393NU5Dpp6GKA4G2vgN
	 /6i1GtugIvcLfFUmssCehtcYUB0DFsQkpi8BQiPetHrlPGQiKn17at1RKXpNLp2VlU
	 HRrCZRYbhP+SPRfgwQ+GTjGHTgYWTFMyq6x5GynjTF2kyssJDK1fRmTptEEYHQmEWh
	 tD2nDTepOgMYUVpqJ/pO9OQFOzArIxELXQU2IP6TJFnQYSlu/8S61lZ138srvFTZ3U
	 CROAdFiG1HP9w==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 881528766;
	Mon,  8 Jul 2024 20:01:25 +0200 (CEST)
Date: Mon, 8 Jul 2024 20:01:25 +0200
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: [PATCH] bltin/test: align -nt and -ot with POSIX.1-2024
Message-ID: <qup6njf3q6f5nharnzzvq55dggdollemf6hifsudqn5sx7spwb@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gnlmfr3yuiqs4wd4"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--gnlmfr3yuiqs4wd4
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
Currently updating voreutils for POSIX.1-2024, so looked at dash
built-ins as well.

 src/bltin/test.c | 31 +++++++++++++++++--------------
 src/dash.1       | 14 ++++++++++++--
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/src/bltin/test.c b/src/bltin/test.c
index 2db4d0f..06f6818 100644
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
+	if(stat64(f1, &b1) !=3D 0)
+		return false;
+	if(stat64(f2, &b2) !=3D 0)
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
+	if(stat64(f2, &b2) !=3D 0)
+		return false;
+	if(stat64(f1, &b1) !=3D 0)
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


--gnlmfr3yuiqs4wd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmaMKXQACgkQvP0LAY0m
WPG6FxAArQM8pdQdvMUNahGcIRMqOc42jxyfUe/x8gexvDboarskA5IReqPvDirK
J1KkbgB43g/zcfVyfFMSxXmDX6AICx25H045jD++BCSJCbAyrForgZZ1uVUvAL+1
g2OKp27tIpk3vGwkUg6MJttM6Iwfei9N2bwZ3q+4AYVsKsT7l8Evh2yVpdusvX+p
ZSTAEOwPK9aOjMHYzFnyopAHjZyeFfzSKz3ReQa9Mo5jKM00ksIfHzsLjdoCOoRl
B23tj1QaOkPfjFgSpMG3pABFFghr/FeZsyPaOWeG5T9lIKP+2c6g4BrtyH+KM55T
fKqXiVUChCM1CRmA9STzWuHVecROV4xhy/JN9aBV/JaG2oK0gDGhrHAFM9n8/5Cd
InbTU812MKCjpEIHGR9H/qfG2Jvt6DDIENKryY5GjdY6Ner4Kpk3jCMxXvrZIwTP
sM0jdTHz2mjRxWn8zfSlZ0LhlgE8rG+9Z4W7hXtPz5My513J45gDzpuN9XVxD5Pr
RTvDfY5lulab8csi24ZTAO3usNfVFMJQ8AfWxcSHXgENQQVTB97QGgCDsMhw7Zft
on7h9IGMkkzPhMcAaXR8HYEazdMlQLEJMLyWhuITzif3gBEOpD5z49HvND4jRmQg
qSHbc3R/UA+z8Rent9gkzkFwtAEJEf/5t2ZGS34w6CJXjeDriVQ=
=9UoT
-----END PGP SIGNATURE-----

--gnlmfr3yuiqs4wd4--
