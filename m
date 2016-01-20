From: Eric Blake <eblake@redhat.com>
Subject: Re: echo do not print NUL byte
Date: Wed, 20 Jan 2016 15:19:00 -0700
Message-ID: <56A007D4.4000207@redhat.com>
References: <20160120223850.25cdf852@enterprise>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jMscNfR1x3uE0dmI9WH4gVJCIgUTAirRU"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60660 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbcATWTD (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 20 Jan 2016 17:19:03 -0500
In-Reply-To: <20160120223850.25cdf852@enterprise>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Trek <trek00@inbox.ru>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jMscNfR1x3uE0dmI9WH4gVJCIgUTAirRU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2016 02:38 PM, Trek wrote:
> there is no way to print the NUL byte with the echo utility

POSIX says you should use 'printf', not 'echo', if you expect to use any
\ in the arguments.  That said, the man page says:

     echo [-n] args...
=2E..
            \0digits
                    Output the character whose value is given by zero to
three
                    octal digits.  If there are zero digits, a nul charac=
ter
                    is output.


> with dash (XSI, no -e argument):
>=20
>   $ dash -c 'echo \\0 | od -An -c'
>     \n

So this is behavior in disagreement with the documentation, so you
definitely have discovered a bug.  Of course, since POSIX already says
the use of \ is implementation-defined if XSI is not in force, and dash
doesn't necessarily strive for full XSI compliance, it might be easier
to patch the docs than to output a NUL byte.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jMscNfR1x3uE0dmI9WH4gVJCIgUTAirRU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWoAfUAAoJEKeha0olJ0Nq2HQH/iigC+hSJ5eMPW6bnNJXCqR2
aMHp6lsjS2oVgACvTIv7Q2rnFxRFBBBVbfNBcQUYN3edRHuxFZ6nzi3HC/FsIF7P
+kf70YAv7wYpiN+H4S2JrMGmidgZcNvNLmwm01sNMude+2L24kdsAcGZvW5pZJtp
KohezkeXEWy+yh+OFnsyMDECMzhfCkiXcUvBO5xc+oAUGgqrjZMOs+vhi7mRC7HM
pQjDdSzNt0rIIEdjEnBMjGokrgjs/vVfyYQFbI0hPm0vKQGVV3nGmtSuMbdwamUK
trtj/KvKJCmAPTEUO1FwFupXGSiPpKYd8mU9GZIwpqqn9AriSrEO59wReG56rks=
=+qjG
-----END PGP SIGNATURE-----

--jMscNfR1x3uE0dmI9WH4gVJCIgUTAirRU--
