From: Eric Blake <eblake@redhat.com>
Subject: Re: command lookup and POSIX
Date: Fri, 07 Mar 2014 14:53:38 -0700
Message-ID: <531A3FE2.8050109@redhat.com>
References: <20140307194318.GA2317@home.jasonmmiller.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2UI4beHFijWpKJCGhQ8cdoThQMavrPigi"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28302 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbaCGVxl (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 7 Mar 2014 16:53:41 -0500
In-Reply-To: <20140307194318.GA2317@home.jasonmmiller.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jason Miller <jason@milr.com>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2UI4beHFijWpKJCGhQ8cdoThQMavrPigi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/07/2014 12:43 PM, Jason Miller wrote:
> Reading this:
>=20
> http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.htm=
l#tag_02_09_01_01
>=20
> Any built-in other than the special built-ins, or listed in the table
> there should not be run unless it is present in the PATH.
>=20
> dash however doesn't follow that:
>=20
> PS1=3D"% " dash
>=20
>     % PATH=3D

Stop right there.

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html#t=
ag_08

"If PATH is unset or is set to null, the path search is
implementation-defined."

Therefore, you have triggered implementation-defined behavior, rather
than exposing a bug in dash.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2UI4beHFijWpKJCGhQ8cdoThQMavrPigi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJTGj/iAAoJEKeha0olJ0NqfkAH/3ngs7CEOqC4Pp19rjI/qQ6q
4L7gqSFQxhKna6CRwHrjcyAGTmcc+GvZiuHHQEIJyjXKyZEeB5pWvG3InPgDemZX
hPSsZpWxoe088a55eNBVK7cxpZ4gSIYkzQC1PvaV0oS/2ozO/4kDAx6GNedaf9x4
aWP78w3/K8wMVUmQrgkvE5uGJlbzHKitnybE80/RHjXAZ5ALC6kSIPYLEHfwa+jg
RPVDlB3Ti8RyKXUbOIlNgu89vOmBzwDxdo4UJouzM5IZoV/vTwnKlTdhO3gXLg1X
a4jKgtCcxynlFglZnMDnT7/7bgRujW8tnntJbaevbPsNVwne924GNlBuBndBdXI=
=nJ+/
-----END PGP SIGNATURE-----

--2UI4beHFijWpKJCGhQ8cdoThQMavrPigi--
