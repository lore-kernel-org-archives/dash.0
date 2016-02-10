From: Joachim Breitner <mail@joachim-breitner.de>
Subject: Re: dash drops exported bash functions
Date: Wed, 10 Feb 2016 17:31:03 +0100
Message-ID: <1455121863.18345.68.camel@joachim-breitner.de>
References: <1455117533.18345.59.camel@joachim-breitner.de>
	 <56BB5D40.4070401@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-ZNMelk/ER+NQ9ZanKRV0"
Return-path: <dash-owner@vger.kernel.org>
Received: from hermes.serverama.de ([176.9.213.133]:56615 "EHLO
	hermes.serverama.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbcBJQbJ (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Feb 2016 11:31:09 -0500
In-Reply-To: <56BB5D40.4070401@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>, dash@vger.kernel.org


--=-ZNMelk/ER+NQ9ZanKRV0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Eric,

Am Mittwoch, den 10.02.2016, 08:54 -0700 schrieb Eric Blake:
> On 02/10/2016 08:18 AM, Joachim Breitner wrote:
> > Dear dash developers,
> >=20
> > a change in 0.5.8, very likely this one
> > http://git.kernel.org/cgit/utils/dash/dash.git/commit/?id=3D46d3c1a614f=
11f0d40a7e73376359618ff07abcd
> > broke the exporting of bash shell functions via the environment.
>=20
> Not a bug. POSIX says that on shell startup, the behavior of any
> inherited environment variables that do not start with a proper shell
> name is undefined; and allows shells to scrub such items out of the
> environment on startup.=C2=A0=C2=A0Just because bash does not scrub them =
(but
> instead treats them as shell function imports) does not mean dash has to
> behave the same.
>=20
> That said, preserving any unusable environment variables unchanged,
> rather than scrubbing them, may be slightly nicer behavior, but I'm not
> sure it's worth the bloat to dash to do so.

I=E2=80=99m not versed in reading POSIX,, so I won=E2=80=99t argue with tha=
t (although
I could not find a reference), but let me point out 8.1
"8.1 Environment Variable Definition" of "The Open Group Base
Specifications Issue 7" says
    =E2=80=9COther characters may be permitted by an implementation;
    applications shall tolerate the presence of such names.=E2=80=9D

But it is not a big deal now, as the application suffering from this
issue will likely have to work-around this (or fix this, depending on
the POV) anyways.


Greetings,
Joachim
--=20
Joachim =E2=80=9Cnomeata=E2=80=9D Breitner
=C2=A0 mail@joachim-breitner.de =E2=80=A2 https://www.joachim-breitner.de/
=C2=A0 XMPP: nomeata@joachim-breitner.de=C2=A0=E2=80=A2 OpenPGP-Key: 0xF0FB=
F51F
=C2=A0 Debian Developer: nomeata@debian.org


--=-ZNMelk/ER+NQ9ZanKRV0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABCAAGBQJWu2XHAAoJED2QirPw+/UfGRUP/3y62M25pSaijvuOjWFlZJJ6
b+bb4qfK6M+QkRRulVIYWWyl0gdAy73jsAn87+TUytQ3cMYmC1HpOfo0JP3Dg9Fq
8B3+7dgsojEPVljwp6iQU2jrlUOZ7oMn8dhDbELro7tIQG//PE/jtZGqVxXsIBzD
PoOLGZoR4OgrX3sTkglG57UkE+2jzEBHDFKro4DCXvvA82r/p/fjJLTixfNlKPW6
JKJ48LmCVQDm6dTBUaCPdysSeVpZMBIJL/8yPVb9e/ZqCGLNzOXYBdMwel/qeFOW
EkQd0QPPlLY3+OIsY35tbvpn6cSzE8KsHC0B59lNudqXtSsQVMfM4F2sPVru/hsu
ScAU9BttQ17UslhsKX/Mba6lN0nkCmulIGZ+AWVvaRIhjqyymbI6o5zvITB0KDmd
opY8XTsPNZYa8oFkxO/y+1QahArYq+UnUnHnp2PqPDTycePL49U4XzLNIszcT8s7
At/jjj+z8LuQdQxPzC8MNsfLd1fDsKaYtqPHiBgGaJLL/4/ogPJCm4E7X/C6XKx0
Cf+49cJsBF6EEkyXZ5ZC+G3RbaktB/CxNna+9SvQ7LYHN+TQKKg4o7YfTnVYHHQr
irP7d9P2H9L/VZDGXb3aiaVI3d9HdqqLZFlrie5soTsaB1UtJwwX2Lw2/sLaQAAp
CSjzuAYc1mSryTNi2lk5
=1X2J
-----END PGP SIGNATURE-----

--=-ZNMelk/ER+NQ9ZanKRV0--
