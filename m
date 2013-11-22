From: Eric Blake <eblake@redhat.com>
Subject: Re: sed script fails to run in dash
Date: Fri, 22 Nov 2013 12:26:03 -0700
Message-ID: <528FAFCB.5090807@redhat.com>
References: <528F9E5E.4020807@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iH5QCMsqfXvH5FAXlAskF637co1mirmMB"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50189 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755588Ab3KVT0F (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 Nov 2013 14:26:05 -0500
In-Reply-To: <528F9E5E.4020807@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Tormen <quickhelp@gmail.com>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iH5QCMsqfXvH5FAXlAskF637co1mirmMB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2013 11:11 AM, Tormen wrote:

>     sed -e 1$'{w/dev/stdout\n;d}' -i /tmp/x
>=20
> in a dash script will yield the error message:
>=20
>     sed: -e expression #1, char 2: unknown command: `$'
>=20
> But why ? :(

Because $'' is not (yet) in POSIX.  It will be required in a future
release, but dash hasn't implemented it yet.

http://austingroupbugs.net/view.php?id=3D249

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iH5QCMsqfXvH5FAXlAskF637co1mirmMB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJSj6/LAAoJEKeha0olJ0Nqp/sIAIOuIapT1mVQBIF0IrSQ9Z9M
16/AfXZ7iP6uZpC7ZxUYPDvDJKvs9Q3CRWiSFraEq2DiBkJkhK/UW6PhKyhiw6AH
zlBslHG8CisJLo+GWWm4d1OkUIIw0MVcqfpgdK29dONAQLy5SYYV8TEIUzT4hTuK
jBbl19bRKSWvfthdR78tRjgPexDokvgAroedhgPTRrB0wFbHtfkIz/CMvQ0t6v3u
/9Rfi9hxnGeVQSjHRN0MO5Fv8V8ksPJSlGRpBGUdZ2spvV74Figkq8pYf5V5FVw2
7BRGkpz/682JyQYBZ1nD9q9qyK4ItzVAJ1LZQ3bccEcUWMVG5/mJLnovKPwCoCg=
=qaAj
-----END PGP SIGNATURE-----

--iH5QCMsqfXvH5FAXlAskF637co1mirmMB--
