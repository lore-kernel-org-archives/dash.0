From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] \e in "echo" and "printf" builtins
Date: Mon, 30 Jun 2014 07:08:34 -0600
Message-ID: <53B16152.6040408@redhat.com>
References: <20140628045653.GA5097@angband.pl> <53AEF2E3.5080205@gigawatt.nl> <3DBAFEEE-9555-483E-8260-7D5E9B47F9AD@aim.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xNFowE93Tl7DdNGJUArUDx75ingOv4RAu"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46225 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbaF3NKO (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 30 Jun 2014 09:10:14 -0400
In-Reply-To: <3DBAFEEE-9555-483E-8260-7D5E9B47F9AD@aim.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Paul Gilmartin <PaulGBoulder@aim.com>, Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xNFowE93Tl7DdNGJUArUDx75ingOv4RAu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2014 11:33 AM, Paul Gilmartin wrote:
>=20
> OTOH, there's a POSIX requirement that builtins be indistinguishable
> (except in performance) from the corresponding executables.=20


The POSIX requirement only applies to portable uses of the builtin - ie.
those that are prescribed by POSIX.  Since POSIX does not require \e,
dash is not failing compliance, even if it differs from extensions
provided by corresponding executables.  I do not think dash needs to
bloat for \e unless POSIX standardizes it first.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xNFowE93Tl7DdNGJUArUDx75ingOv4RAu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJTsWFeAAoJEKeha0olJ0NqhPoH+gL0arrpk4v0chSjfE9ot9hA
GR46bwo5OuvQiJ2HQDN/dBUKH/2njacJp3d/F56a/V+8lbvWrD+D8lexZkdv8aBz
9AJX0h+7mSJvWQV7Mx3bRYDotLWYJTSiT8qBWQkI7pHxfLojVfYpvxY7l3mMC22Z
oSJusGZE25cl8ePxyBxaTli4xNKH19xNZIe5vtvxqMpZkuXgxBCULZt8kTHH7WJE
SPvQNz4U7JzyOZK5Iui25ZS9RBtMQTDvWPBde5o/D5GCE9invu2ZZ2HP1iSk8kE6
DwRtuoq+o4vZ6ykHmC4EJJlpY4UJMWnDJZCc3OWwEcZS1vFYaavkko9Uf2tG9sU=
=iH70
-----END PGP SIGNATURE-----

--xNFowE93Tl7DdNGJUArUDx75ingOv4RAu--
