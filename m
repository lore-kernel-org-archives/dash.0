From: Romain =?iso-8859-1?Q?Tarti=E8re?=
	<romain.tartiere@healthgrid.org>
Subject: Inconsistent parameter expansion
Date: Thu, 15 May 2008 16:26:02 +0200
Message-ID: <20080515142601.GA73886@healthgrid203d.healthgrid.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <dash-owner@vger.kernel.org>
Received: from ccpntc21.in2p3.fr ([134.158.69.181]:54731 "EHLO
	ccpntc21.in2p3.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbYEOPAN (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 15 May 2008 11:00:13 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Baptiste Grenier <baptiste.grenier@healthgrid.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

When migrating a shell script from Debian to Ubuntu GNU/Linux, I ran
into trouble with parameter expansion being handled differently between
bash and dash.

The script was originally developed on a FreeBSD box, hence using
FreeBSD's bourne shell (not bash nor dash) which is POSIX plus some
extra Berkeley extensions (not the same as bash).  The idea is that the
shell script was supposed to be POSIX and therefore not supposed to
fail.

After some investigation, I succeeded in locating the problem.

> $ for L in A B C D; do mkdir $L && touch $L/FILE; done
> $ echo *
> A B C D
> $ echo */FILE
> A/FILE B/FILE C/FILE D/FILE
> $ echo *"/FILE"
> */FILE
> $=20

I can't figure out why '*/FILE' and '*"/FILE"' are not expanded the same
way...

Thank you for your lights,
Romain

--=20
Romain Tarti=E8re <romain.tartiere@healthgrid.org>     HealthGrid SysAdmin
pgp: 3BB8 9543 B4F2 3EFA 7478  0BA0 0F8D DB2D B9E4 7019 (ID: 0xB9E47019)
(plain text =3Dnon-HTML=3D PGP/GPG encrypted/signed e-mail much appreciated)

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (FreeBSD)

iEYEARECAAYFAkgsR/kACgkQD43bLbnkcBmLsACg7AOpRkK0gKOPsO/hYjjG89qq
/SAAoIKUPoVkMDLcaozissnosFdx5794
=s/d3
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
