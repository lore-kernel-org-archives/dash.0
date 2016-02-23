From: Eric Blake <eblake@redhat.com>
Subject: Re: [BUG] Illegal function names are accepted after being used as
 aliases
Date: Tue, 23 Feb 2016 11:58:30 -0700
Message-ID: <56CCABD6.40001@redhat.com>
References: <56CCA25E.5020809@openmailbox.org> <56CCA879.1070208@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ocb849DNeTC4ORxJQJUlXU8k3S1CbAlpH"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39366 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932074AbcBWS6b (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Feb 2016 13:58:31 -0500
In-Reply-To: <56CCA879.1070208@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>, Jan Verbeek <ring@openmailbox.org>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ocb849DNeTC4ORxJQJUlXU8k3S1CbAlpH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2016 11:44 AM, Harald van Dijk wrote:

> This matches bash's behaviour, aside from bash requiring -- to prevent
> detection of invalid flags to the alias command:
>=20
> bash-4.3$ alias -- -=3Dtrue

Then dash DOES have a bug:

# dash
$ alias -- -=3D'echo hi'
alias: -- not found
$ echo $?
1
$ -
hi
$

POSIX XCU 1.4 is clear:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap01.html

"Default Behavior: When this section is listed as "None.", it means that
the implementation need not support any options. Standard utilities that
do not accept options, but that do accept operands, shall recognize "--"
as a first argument to be discarded."

and alias takes operands, stating "OPTIONS: None.", which means POSIX
_requires_ 'alias -- -=3Dname' to (attempt to) define only the single
alias '-', and NOT to also attempt to define '--' as an alias.

It's okay if dash allows 'alias -=3Dblah' to define '-' as an alias as an=

extension, but it MUST ignore '--' the way bash does.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ocb849DNeTC4ORxJQJUlXU8k3S1CbAlpH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWzKvWAAoJEKeha0olJ0Nqh3IH/jPH6cCTSShqloktxkmfZPOt
70q1+olZZpi8VTTKWFfrW1slB9xZEoFYKl2x80gj+5tWqvCpU6TleJ5RolhsIT2C
8Z4DMru9MggzJ2P9ubOnmylENax6cuXMNtrPjPUB89sqaHNtfhpQ49Vn1rIMRc0C
JGQGWpQvXinN0Rm2Fgz845kPp+UpR6HxhxI+ay129yQlg1kXvMiB5uPC2Uajw/Va
sPNM77Sg0tHETCAFnwTuy6SgSKbcSE9iH2F2NnAbryYbAQOz5tSQ/SPb70nY8pnR
x26eFn6DwAcDtUDARvHSkgi7/UP5vymOr3/cGWAtwqyzEkhrJHrLrMOOW12tkOM=
=HJ2s
-----END PGP SIGNATURE-----

--ocb849DNeTC4ORxJQJUlXU8k3S1CbAlpH--
