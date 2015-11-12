From: Eric Blake <eblake@redhat.com>
Subject: Re: [bug?] echo -n does not work as described
Date: Wed, 11 Nov 2015 20:14:14 -0700
Message-ID: <56440406.7000201@redhat.com>
References: <5643F1B2.5050207@sanitarium.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0hSqoSbfFVFW4xVuITDSR02oHbaNngaU9"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39298 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598AbbKLDOU (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Nov 2015 22:14:20 -0500
In-Reply-To: <5643F1B2.5050207@sanitarium.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kevin Korb <kmk@sanitarium.net>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0hSqoSbfFVFW4xVuITDSR02oHbaNngaU9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/11/2015 06:56 PM, Kevin Korb wrote:
> I am on dash version 0.5.8.2 on Gentoo Linux (USE=3Dlibedit -static).
>=20
> The echo builtin does not work as described.  In the man page:

Which man page? Coreutils'?

Read it further:

>  NOTE: your shell may have its own version of echo, which usually super=
=E2=80=90
> sedes the version described here. Please refer to your shell's docu=E2=80=
=90
> mentation for details about the options it supports.

By the way, 'echo -n' is non-portable, and POSIX says you should use
'printf' instead.

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html

    A string to be written to standard output. If the first operand is
-n, or if any of the operands contain a <backslash> character, the
results are implementation-defined.

> $ echo -n testing
> -n testing

Dash's implementation-defined behavior for -n is to treat it the same as
every other string.  Thus, this is not a bug in dash, at least according
to POSIX.

> This is causing me problems when I attempt to switch /bin/sh from bash
> to dash.

It's probably not the only bashism you've been relying on.  You may want
to try using checkbashisms
(http://sourceforge.net/projects/checkbaskisms/) to help you find other
portability pitfalls.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0hSqoSbfFVFW4xVuITDSR02oHbaNngaU9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWRAQGAAoJEKeha0olJ0NqdrgH/iL+tXBdeF3YW4NFWcQf68Jv
ZTrnx/GWuABNKUbyvwsD9QERdI9eHLjf6dYwyWX/pxUhUP5/dAuvlnhAdoawwx5d
xkSrwK3qzhvgmW9G2tHytWarzxqslHBji8i+4zWSKxesQV16HjVw8mmkbaYStonT
aH49rskvMMIMuQ7HX3OcwevK4gMYhqXKksbnhZO2eyyx8kSm0FiUC0ukSOe/7WLQ
JFNtvwYg+nFLhHb2A7xqCOheMs1rDa1LkH2gP1e8U9Xv950mf+S6RBawx/15QqBD
2kHPxWTJhNfRTD9j8539S+QjKFLFL3WBe2IQwxg5dNYOoR/sjFK6PyW7KAudbvk=
=yT/q
-----END PGP SIGNATURE-----

--0hSqoSbfFVFW4xVuITDSR02oHbaNngaU9--
