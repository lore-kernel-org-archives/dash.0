From: Eric Blake <eblake@redhat.com>
Subject: Re: How to list functions?
Date: Tue, 22 Oct 2013 14:56:03 +0100
Message-ID: <526683F3.1030604@redhat.com>
References: <20131022120556.GD12206@yade.xx.vu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d0ww0NKUjxIREtBCIILMF5Ri3fnTmRQrw"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37528 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab3JVN4H (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 22 Oct 2013 09:56:07 -0400
In-Reply-To: <20131022120556.GD12206@yade.xx.vu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alexander Huemer <alexander.huemer@xx.vu>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d0ww0NKUjxIREtBCIILMF5Ri3fnTmRQrw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/22/2013 01:05 PM, Alexander Huemer wrote:
> Hi,
>=20
> posh has support for functions.

Wrong list.  posh is a different shell than dash, so there's nothing
this list can do to change posh.

>=20
> $ f() { echo foo; }
> $ f
> foo
> $=20
>=20
> Unfortunately I am unable to list the defined functions.
> I tried `typeset`, `declare` and `set` without success in posh 0.10.2 o=
n=20

posh tries hard to limit itself to POSIX (which does not yet define
'typeset', lacks 'declare', and where 'set' does not list function
bodies).  As far as I can see, POSIX doesn't require shells to be able
to output function bodies.  For posh to provide this, they'd have to
give you an extension beyond POSIX; but that goes against the goals of
posh.  Sorry.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--d0ww0NKUjxIREtBCIILMF5Ri3fnTmRQrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJSZoPzAAoJEKeha0olJ0Nq2KAH/1fnRXNr389SRM6kryiY30tN
lcibjwAGtDIdo606NzAOXE3IVAx0bdnOCUZcBZ7lwazIYja+/NGOw0mFg2YNfqu8
46doeJLDm/KXyPg9FjkGpJoiOzV+1O/CzKmIjIGw44C2UyIdpupumpJLQjrPB608
dXR3Uba9BQXFX5THZ9PXep4+1pG3e2N/O7nTgzZ4yCTjlOl1x0m02eAVe2QMXglK
Gah+MqHaPGNXF+8OYaMlNzyOK9pSLthEfgZO0A3fcmoRK/Bn1na11bZqIbwK2N+p
wGvWGf/saPQnkfq2n26V44kYQpIEVoHTCBkACQdc4c4vA19wCYXff/EpnegHA/4=
=UcWv
-----END PGP SIGNATURE-----

--d0ww0NKUjxIREtBCIILMF5Ri3fnTmRQrw--
