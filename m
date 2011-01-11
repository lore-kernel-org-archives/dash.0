From: Eric Blake <eblake@redhat.com>
Subject: Re: setvar MIA?
Date: Tue, 11 Jan 2011 10:00:33 -0700
Message-ID: <4D2C8CB1.4070204@redhat.com>
References: <4D2C7D44.1060904@phat.za.net> <4D2C810E.4070707@redhat.com> <4D2C8B2C.3060001@phat.za.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig21CDB0AFAC7FF622D0E90664"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64435 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932276Ab1AKRAj (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Jan 2011 12:00:39 -0500
In-Reply-To: <4D2C8B2C.3060001@phat.za.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Aragon Gouveia <aragon@phat.za.net>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig21CDB0AFAC7FF622D0E90664
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/11/2011 09:54 AM, Aragon Gouveia wrote:
> I wasn't sure of its status in POSIX.  It is useful for declaring
> variable variables - tidier than eval and I imagine faster, eg.
>=20
> index=3D"1"
> setvar var_${index} "value"
>=20
> Will emulate it with a local function - thanks.

Indeed, it looks like FreeBSD introduced it as shorthand for:

setvar() { eval $1=3D\$2; }

The speed difference between that function doing an eval and a shell
builtin would be in the noise.  I don't know why FreeBSD even bothered
to pollute the namespace with a builtin like that.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig21CDB0AFAC7FF622D0E90664
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNLIyxAAoJEKeha0olJ0Nq1zcH/0RyRN7cYGZPN+BG0sMrapTe
gvJTMOv8Zfln0KpfSOl3h6UO2iBcpWu9BkP2xfXTyULNn3syybLDfvpy5bPPxcVb
Z7hqL3ncZNBnAosj7JePBdvw8bM/H6p68RZZqhuZt61qMsf/T/odSaGyluN6Q03C
IAdN90LvLFazUPzk/qjP1+7+03lPDUjPqCrCtSNcY6TjDoiC4vr4nQ9jpnXb3xEF
BTjVNIsrrwgCGQZsJhYz5349/tLCC0rGV0ErZ8AmcbPqU3z4oXffCSiOB600q94g
sAfCiQMw3GKRxjg8p2Pvu7bwmQFjG1l0K/NTAHUb93d9jHa1pKm8eGSS52GaEpI=
=8gXi
-----END PGP SIGNATURE-----

--------------enig21CDB0AFAC7FF622D0E90664--
