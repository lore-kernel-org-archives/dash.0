From: Eric Blake <eblake@redhat.com>
Subject: Re: `local' built-in POSIX?
Date: Sat, 26 Mar 2011 16:56:20 -0600
Message-ID: <4D8E6F14.4050600@redhat.com>
References: <AANLkTimpYYu8toHmxwTtG2GmqE90d59OLgyQ+qcaoRnr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig9ABEE3D88399A9A9389ADAAA"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20932 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364Ab1CZW4X (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 26 Mar 2011 18:56:23 -0400
In-Reply-To: <AANLkTimpYYu8toHmxwTtG2GmqE90d59OLgyQ+qcaoRnr@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9ABEE3D88399A9A9389ADAAA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/26/2011 04:50 PM, Michael Witten wrote:
> I can't find POSIX documentation for the `local' built-in, which is
> available in both dash and bash for the creation of function-local
> variables.
>=20
> Is it not standard POSIX? If it is not, should it be removed from dash?=


No, it is not standard POSIX (yet).  There has been talk on the Austin
Group mailing list of standardizing local (perhaps by the name typeset)
for the next revision; the biggest issue is that ksh uses typeset only
for statically scoped variables, while bash uses it only for dynamically
scoped variables, so a consensus has to be reached among shell writers
which scoping rules to standardize.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig9ABEE3D88399A9A9389ADAAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNjm8UAAoJEKeha0olJ0NqOd8H/2j+jn39rniwJGUKzPhyHSoo
Yphn+QlEj+xNGmwKiH52tIgdTKyTTxKPlS9ly8uN8zz7cz0mqMajfE5pBz/qBHTV
7Yi9TwpDDLzDTMcxQeQAGH87DEslV0M1Uf2ibVIVMn7w+tzm+0H3VSfE+mfe0SpC
CwsMLkfwsm8f6J/gZzrcul1htV1aWyk8np/+C+AbvpykLOPOfR/rD582nsMiaL4N
28UYdp88lDoL80Mj9Q7urVL0yMuc883/agMTotpSH46Yvi7TmDKYXXsOI+mEeGYg
EdzQSV2kxmHjzBiBY4N2f2+FtHbz1YoaOmy+FfmCvnk7XiLrgztNoj9GIyY04h8=
=hQRR
-----END PGP SIGNATURE-----

--------------enig9ABEE3D88399A9A9389ADAAA--
