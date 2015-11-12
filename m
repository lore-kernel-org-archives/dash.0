From: Petr =?utf-8?Q?=C5=A0abata?= <contyk@redhat.com>
Subject: Re: [bug?] echo -n does not work as described
Date: Thu, 12 Nov 2015 11:03:29 +0100
Message-ID: <20151112100329.GA1841@kralicek.brq.redhat.com>
References: <5643F1B2.5050207@sanitarium.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59573 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753642AbbKLKMJ (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 12 Nov 2015 05:12:09 -0500
Content-Disposition: inline
In-Reply-To: <5643F1B2.5050207@sanitarium.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kevin Korb <kmk@sanitarium.net>
Cc: dash@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2015 at 08:56:02PM -0500, Kevin Korb wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> I am on dash version 0.5.8.2 on Gentoo Linux (USE=3Dlibedit -static).
>=20
> The echo builtin does not work as described.  In the man page:
>  echo [-n] args...
>    Print the arguments on the standard output, separated by spaces.
>    Unless the -n option is present, a newline is output following the
>    arguments.
>=20
> However, in actual usage:
> % dash
> $ echo testing
> testing
> $ echo -n testing
> - -n testing
> $ /bin/echo -n testing
> testing$
>=20
> This is causing me problems when I attempt to switch /bin/sh from bash
> to dash.

Hmm, where does the 0.5.8.2 version come from, I wonder?
The latest release is 0.5.8 [0] and I cannot reproduce your
issue with it on Fedora [1] (and note that, afaik, Fedora doesn't
apply any special patches that could affect this behavior).

Try rebuilding dash with USE=3D-libedit and see if it changes
anything.  If not -- I would bug the Gentoo maintainers.

P

[0] http://gondor.apana.org.au/~herbert/dash/
[1] dash-0.5.8-3.fc23.x86_64

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRGPxAAoJEPaFUazsAhFFZvcQAJ++EZeLLeCcSlmycuEMGSJw
sjA2JR1x8bWmxgFab1gnujlEm+uyk0RTYKIIdxrwY41ZrCe31LPucXwp8ZPouwFc
e28D0GZ2JNHCIlXAwoLM+HbNqtLNY7orkP6opo9iVnPkmMZNIlEU6+P19X7oIaoN
DFOQk4eqrnaKEOoNAK6apGj08HB+BlRMlrkYCOdMUVwuFmvHRwtxS7iT3Tyc2vJG
2v7BDWyNoPldQawNAkI/qv2hv0zLNCwSDNJOjTVeu4dFdVJXobudTqhxNfmgQz88
0Z6k4LjjYdjN4xYg+l2h3XdcOYRd36kFpFxoPhU0NXrTjEV59VU/Td74TOvC1keu
A3CdhHxNquyCm55/AeT4CPANFS4ere0b9agJlPXe3BTC3SROLQUAx80t2JIzEqba
aMqivLuDt8pT2qLwTPBh+a2pLtqPZw982uMxYgajOp8wj/WLJiqRHz33b64f7sxy
cPgKYmnXT89BMdrziqv/Ha/hYbCbk3AsJQXEXU9b5VNBrk5mtOI0pK02swyIubxf
ayaEqlEkzpzgQiXKtKKpHDpd9g1gwl+CjpfkD05yFXBXBJhBQ21MBOnBrirCqp/k
CY2gZ6ez4g1vQ+vBvliigoPWotmnOh9GvihRYpgY2TbgIeY9N54L1mhCsXj3Z68/
/yVB57C+a946f/4i83UY
=SH3M
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
