From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] Improved LINENO support
Date: Fri, 12 Nov 2010 11:35:52 -0700
Message-ID: <4CDD8908.9010206@redhat.com>
References: <4CD85E90.6000308@gigawatt.nl> <20101110220008.GC17871@stack.nl> <4CDD8481.1060306@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig371C7AF2E73D2785A6FEE9B6"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35031 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab0KLSgL (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 12 Nov 2010 13:36:11 -0500
In-Reply-To: <4CDD8481.1060306@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig371C7AF2E73D2785A6FEE9B6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/12/2010 11:17 AM, Harald van Dijk wrote:
>   (
>     :
>     :
>     :
>     :
>     :
>   ) >test-$LINENO
>=20
> should write to file test-1, not test-7, even though the only word is o=
n
> line 7. bash gets this wrong, pdksh gets this almost right.

Umm - there was more than one word in that example (each : in the
subshell is a word).  But I agree that the subshell command itself
started on line 1, but the word containing $LINENO is on line 7.

There are _so many_ variations on what this example would do that it's
hard to say that any one version is definitively correct.  In general,
the standard tends to favor the ksh93 interpretation of things; but on
your example, it touches the file test-6 (not test-7 nor test-1).

All I can see in the standard is:

"Set by the shell to a decimal number representing the current
sequential line number (numbered starting with 1) within a script or
function before it executes each command."

with no hint as to whether LINENO auto-increments over the number of
newlines encountered while parsing that command.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig371C7AF2E73D2785A6FEE9B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJM3YkIAAoJEKeha0olJ0NqhG8H/jhvi2p/76Fw14vxrt4W8d0a
rExKjY/dht4AsRwudw/n4KEHV+Snf4X7KUJvjCOyy1bK3+iOUlFXkmraDanETYAh
n3HXsRAOL6meLfHSE7IZNHOUvkv0FRDJVnaixupm+8hhrpgyDuhC/CYsJriIntzD
O8hjpyN1IYHa6cwGnCOli+mPQsAxoVb46Ac7pyh+1uRrMmHLMq+MFqWPSPiNVwTH
SAxPdfpiVSSgUCWlqO6LSoSUZ8R20sV323Mp+Ym/L1+Lcr1KPSPzujDmHjNN4Dls
5LYtit+adyUMyFAFgfYnZbGm5UDJbeqFJenum8Yaq1RG3sPYKPHHKvdEeW6a+5c=
=evxO
-----END PGP SIGNATURE-----

--------------enig371C7AF2E73D2785A6FEE9B6--
