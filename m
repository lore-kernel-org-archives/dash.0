From: Eric Blake <eblake@redhat.com>
Subject: Re: if then elif then else fi -- Problem report
Date: Mon, 28 Jun 2010 07:22:02 -0600
Message-ID: <4C28A1FA.1090306@redhat.com>
References: <201006282226.22001.malcolm.kay@internode.on.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig707F5421176DEC1052B484A6"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13972 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753980Ab0F1NXG (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 28 Jun 2010 09:23:06 -0400
In-Reply-To: <201006282226.22001.malcolm.kay@internode.on.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Malcolm Kay <malcolm.kay@internode.on.net>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig707F5421176DEC1052B484A6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/28/2010 06:56 AM, Malcolm Kay wrote:
> Should I create a problem report? Where should I send it?

You just did.

> The problem is that 'dash' bombs out with an empty list in:
>=20
> if ...
> then
>   list
> elif ...
> then
>   list
> fi
>=20
> or in:
>=20
> if ...
> then
>   list
> else
>   list
> fi

POSIX requires a non-empty list in these syntax setups.

> The latter gives for example:
>   Syntax error: "else" unexpected.

Correct.

> Yet the man pages clearly state that a list consists of zero=20
> or more commands --
> <quote>
> Lists -- Generally Speaking
>      A list is a sequence of zero or more commands separated by=20
> newlines,

Therefore, the bug is in the man page.  Per POSIX,
http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#t=
ag_18_09_03
"A list is a sequence of one or more AND-OR lists separated by the
operators ';' and '&' and optionally terminated by ';' , '&' , or
<newline>."

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig707F5421176DEC1052B484A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJMKKH6AAoJEKeha0olJ0NqxNQIAIbbv0RtWN5IDBrssBrqGhr6
ZRdDwPT0Pmx9f5VcFz4l9qTOC6+fi7W+PTckjGWg++rR2I2lWTjJIhpVmcIi4Ft/
ZK9Wt/CWmLuXzNLLZWOBiVO9wGx+pEBZ78QsB+fev/pTlx+5hp5YtXG1snFNIzVO
FAME5jpEY2Oh65TYNQDbAGq4ZOiMDH0EfksCnH0+aRcqwyx7UAErxzXFEx2R0vPp
r3dnfRrZECsPODlMX2GzldMX8lVfYBY3BSes/Nj+XuliFIrRxskKiCxndHiGZJrp
ydaMaX6SBGd+TcFZ8NyIg6BmB/z8F2DWgh4PewSfQvS5vaQqJblOlg1IKIlnwzE=
=tyvG
-----END PGP SIGNATURE-----

--------------enig707F5421176DEC1052B484A6--
