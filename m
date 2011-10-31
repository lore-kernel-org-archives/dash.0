From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] echo: fix octal escaping with \1...\7
Date: Mon, 31 Oct 2011 00:23:44 -0400
Message-ID: <201110310023.45138.vapier@gentoo.org>
References: <20111031034146.GA19477@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2509388.ZlXCmKD8hu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:35407 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab1JaEX7 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Oct 2011 00:23:59 -0400
In-Reply-To: <20111031034146.GA19477@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

--nextPart2509388.ZlXCmKD8hu
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday 30 October 2011 23:41:58 Herbert Xu wrote:
> Mike Frysinger wrote:
> > POSIX states that octal escape sequences should take the form \0num
> > when using echo.  dash however additionally treats \num as an octal
> > sequence.  This breaks some packages (like libtool) who attempt to
> > use strings with these escape sequences via variables to execute sed
> > (since sed ends up getting passed a byte instead of a literal \1).
>=20
> OK this is a bit of problem.  From our conversation I had the
> impression that you were referring to the lack of support of
> escape codes, rather than unwanted support.
>=20
> If it was the former I could easily add it if POSIX said so,
> however, as this is an existing feature there may well be scripts
> out there that depend on it.  So removing it is not an option
> unless it is explicitly forbidden by POSIX.

i'm not seeing how this jives with dash's goal.  if it intends to be a=20
fast/small POSIX compliant shell while punting (almost) all the rest, then =
why=20
carry additional functionality that POSIX doesn't even mention in passing ?=
 =20
this isn't "documented but optional extended functionality", but rather the=
=20
realm of "anything goes".  otherwise we approach the same realm that dash w=
as=20
created to avoid -- carrying lots of cruft that slow things down because=20
scripts use it rather than POSIX mandating it.

as a comparison, bash/ksh/tcsh/zsh/busybox[ash] all behave the way my patch=
=20
updates dash to operate ... i would test more shells, but these tend to be =
the=20
standards that everyone compares against.  i can't see people writing scrip=
ts=20
that only work under dash either.

> In any case, scripts that rely on escape codes like this are
> simply broken and should either be fixed to use printf or just
> run with #!/bin/bash.

they're relying on these escape codes not being interpreted as escape codes=
=20
(which every other shell appears to do), not the other way around
=2Dmike

--nextPart2509388.ZlXCmKD8hu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOriLRAAoJEEFjO5/oN/WBVMMQANIYrDy/HZ6OqTce/AWc9X6x
mYVXO41EI93YhWykcG96hpLhsqP+F5jFQ/3/9Cq27gpeCp4KJPSmNYGX8aZHlK7W
1cs8kuD/3sX1fhihVMf21DOlaiE6Buid3MfnMES9OpcBoSx2yzQ2HKr0iPzBijB/
nhA0BIdb+uXP7vrrzbsR+mNL8gDpDkNVg4G7xuKsTlbORbx6UYORfEqYFHtHzgBy
srW91T6Puu1Ix38fmkHGmi8OY4iURUTfLDGi7ut2vGyFvaUQJ/e1PJ+ZiKe/C9po
icXXP8S9S2ihKKFoZy9UdzldFLqCLWoY75Beyl9BuQAUDm5zW6h3NGsCe1R+HzIx
Z6HoVA+ALH22V5f+LaWymHuptEI7YKxwZ7mdrCgY1wgvpPS1ug0c2NuQxmBzTlZ9
6cQ3nE85NiGIuE5CJRFjMBN3NQZfbWcggwMebIAYNi9ipziPiHj2lb7fVgp8g/46
HoN557rNc2Nan+eSfbX74A6mCFeAhNHLJVCd0BVoG0z0EJsqnWZ9OkF7xnI42FYg
mjuaxJmWLt5sXxZxo2t1QwsbWSbBHU2ZZeEoaweHY+Vd9nzZ5Nv66x3tMbZnj0Jg
Yfbo6ZAarqlc/WXOlp6zuXSS3VBFTC2pIImCuFkKQvBUm6NKm9SXD2XboWiiBnGz
FoAexJ+NeLh3328NPATp
=uPrC
-----END PGP SIGNATURE-----

--nextPart2509388.ZlXCmKD8hu--
