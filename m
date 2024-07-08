Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845326AC1
	for <dash@vger.kernel.org>; Mon,  8 Jul 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461780; cv=none; b=nq7T1PrPOtqlHg0ADDzpw0hGP1eCMhOsaP972PYtcuMtAUBJc/YaRfPOHEDTmdrM3UuwN6/FAa6YMzyyf+ROARJmkGSFtz1I9r1Mc8txbOPeqHR3XMH9GlPEMlZWyJRb0v9wtISc+8hfoe4SWIqDvbwh/fz2m+AxszEhPJAvRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461780; c=relaxed/simple;
	bh=xdY+w1PBnzNJefqa5xriro0FJYsPVdgqWvKvF2SiENA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=um+3Qc7t/zAT1syblyS4fAJg95c6ewcYOQntms6ymN/XbasS0HtHsSIa/ZcQArDT+osVItFkbkHhLHhTt+57rUxJw1veJrU+140BQeKC/iLdTxNIFlDNCOEK4hQg2J01Iiy95/mYwiS4gc8C2wwFjaxcYg29ZM0iy2iXxZK7114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=NAi93vca; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="NAi93vca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1720461774;
	bh=xdY+w1PBnzNJefqa5xriro0FJYsPVdgqWvKvF2SiENA=;
	h=Date:From:To:Cc:Subject:From;
	b=NAi93vca6JXOlU6VFCVFuE21V4fs6pbrAsdcaeX31p2X/4zCC64+8T3Vb3LHgoxK2
	 rejDnOJQ2kjgOos6NIB/0PgLgbh4kD7RwmVZwXn2xhaaeHLk1JVY903d869H4XeZ+f
	 7RcQvwE7bmYJITvaV4/k5wihkU1s9kHg71MIU6Fgn32UyWYYtSYIGmjaCRDf1cTUC4
	 Ft3dWcM8qkxMktU1xfKWyKYeXQdWNmOYaxaBPlSGFkmdTiQQVWuQg+NwqL+ubG8XQF
	 maqqaI1SJwpnSbnwzt4tCeoGiR1zXTx5xlsvPPzXqDBRMz1zW9fvbMN6HorqrOz7tX
	 II7nFSZbh/6Pg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0DF018572;
	Mon,  8 Jul 2024 20:02:54 +0200 (CEST)
Date: Mon, 8 Jul 2024 20:02:53 +0200
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: [PATCH] bltin/test: = and != are strcmp, not strcoll
Message-ID: <t3tjfncwhu5shadny7kikk5ulsycsqk6in3ieuof3ibivekd5c@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dgecq3v2wyqycurs"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--dgecq3v2wyqycurs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

117067  s1 =3D s2  True if the strings s1 and s2 are identical; otherwise, =
false.
117068  s1 !=3D s2 True if the strings s1 and s2 are not identical; otherwi=
se, false.
117069  s1 > s2  True if s1 collates after s2 in the current locale; otherw=
ise, false.
117070  s1 < s2  True if s1 collates before s2 in the current locale; other=
wise, false.

"identical" does not mean "collate equally";
this is the difference between sort | uniq and sort -u
---
This bug violates every POSIX issue i can find.

The manual is already correct.

 src/bltin/test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/bltin/test.c b/src/bltin/test.c
index 06f6818..2e2790f 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -354,9 +354,9 @@ binop(void)
 		/* NOTREACHED */
 #endif
 	case STREQ:
-		return strcoll(opnd1, opnd2) =3D=3D 0;
+		return strcmp(opnd1, opnd2) =3D=3D 0;
 	case STRNE:
-		return strcoll(opnd1, opnd2) !=3D 0;
+		return strcmp(opnd1, opnd2) !=3D 0;
 	case STRLT:
 		return strcoll(opnd1, opnd2) < 0;
 	case STRGT:
--=20
2.39.2

--dgecq3v2wyqycurs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmaMKc0ACgkQvP0LAY0m
WPH0ow//ZIuguMhxHsSfGfno7M6nBbqjuqqsuUNKu/zw8DFtsSAucJy/5X7DvjAL
R+49T1vH1Kv9zoMtMMpczFn6yFK4Wh111yIwNCd2I27CxEuEojVWx9x+P7HEm3oD
/vRQyhdDP5ISPc2YCjsskOa+h4Z2LsXXBbKtV3XKrdB/iRqQJdQseXjsB+Xb9MgQ
Ly/wCwAswNNrxoqGvygGPmpeDjeepYgIaQ/uvsQCyDKh/LSdMeKI3Ls756W9OHjf
MFPgsQcvcVG+9yySuwLOx09kCKwctYvbUF7aWU3CNtcN4EXLO0nVTs6w3LL7jOqG
0NfsTea2fGcmDaJimfBnt910+epLp0SihlZ6rTKXfFZeyJ6gOCN5zLiYMT+eDr/y
yu99yjhWufP6lFwKzic3awuVqz+VO8vDbkZvJerV8VU6cQ9dtKRr9Q8TOjtv8IOw
l1rS0VmYwiM63KTu5RLl1/cbPMN9dHaRPQg/LOw4cNknis8Ps5jhT4rlO0bR7Agz
4+1ChFCjNEcQwH+dQwARmV6TmEeMJH5UgMNDMiZ5RWDDLXJAL3xvAuwNE/xrDvzs
+pkDJThImqTfbmp4cciUzlKtOM0KO93TojWSBN8sTu/u3/4kN0gETiD7h8rpLEjj
WVI6kqoTW51JdD7b10h6VfwRXGD/0NQUDZI2VffARto5w0HKm3U=
=Hh9Z
-----END PGP SIGNATURE-----

--dgecq3v2wyqycurs--
