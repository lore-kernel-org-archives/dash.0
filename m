From: Eric Blake <eblake@redhat.com>
Subject: Re: Line continuation and variables
Date: Tue, 26 Aug 2014 06:34:42 -0600
Message-ID: <53FC7EE2.7000309@redhat.com>
References: <1554581409055304@web13g.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lQex1ewtAiIoLu2KSh00Tkiwigo4AATuI"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45473 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbaHZMet (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 26 Aug 2014 08:34:49 -0400
In-Reply-To: <1554581409055304@web13g.yandex.ru>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lQex1ewtAiIoLu2KSh00Tkiwigo4AATuI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/26/2014 06:15 AM, Oleg Bulatov wrote:
> Hi!
>=20
> While playing with sh generators I found that dash and bash have differ=
ent
> interpretations for <slash><newline> sequence.
>=20
> $ dash -c 'EDIT=3Dxxx; echo $EDIT\
>> OR'
> xxxOR

Buggy.

> $ bash -c 'EDIT=3Dxxx; echo $EDIT\
> OR'
> /usr/bin/vim

Correct behavior.

>=20
> $ dash -c 'echo "$\
> (pwd)"'
> $(pwd)
>=20
> Is it undefined behaviour in POSIX?

No, it's well-defined, and dash is buggy.  POSIX says:

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#=
tag_18_03

"the shell shall break its input into tokens by applying the first
applicable rule below to the next character in its input"

Rule 4 covers backslash handling, while rule 5 covers locating the end
of a word to be subject to $ expansion.  Therefore, rule 4 should happen
first.  Rule 4 defers to the section on quoting, with the caveat that
<newline> joining is the only substitution that happens immediately as
part of the parsing:

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#=
tag_18_02

"If a <newline> follows the <backslash>, the shell shall interpret this
as line continuation. The <backslash> and <newline> shall be removed
before splitting the input into tokens. Since the escaped <newline> is
removed entirely from the input and is not replaced by any white space,
it cannot serve as a token separator."

So the fact that dash is treating the elided backslash-newline as a
token separator, and parsing your input as if ${EDIT}OR instead of
${EDITOR} is a bug in dash.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lQex1ewtAiIoLu2KSh00Tkiwigo4AATuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJT/H7iAAoJEKeha0olJ0NqMs4H/Rg6/TeHVqS7Xy185U8jRXMK
JXIBHGdDAIYk62oy1mz+FBax0gk1eZvsyl6WoQF2FBdx5lmeT8ag1VXJGY6NT6Lq
AhW7EQl0NoOtJ46WFMNznyyaoGgQR4DImsEO/Khkb/OIeuCOWu/ra27vzI1gIPC7
m0lPP44Myt8b0e56csYGendjNmDIDv+3N4mUgN3o4lZ6XR0aye/lYe24er4bua3J
fPhyhfqcyHo2RZtMWgBCrh/ysGoQJckHW4MS4NrfM2FMi+4+9cCknmdfZq2i2Ysb
UsAyfqVjT4gAq58v6Cea8Pe4IETHOkBrxmZYJ63mtS3CYv2IMXuKArS8O3FKv30=
=b5pZ
-----END PGP SIGNATURE-----

--lQex1ewtAiIoLu2KSh00Tkiwigo4AATuI--
