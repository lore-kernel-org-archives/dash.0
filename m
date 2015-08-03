From: Eric Blake <eblake@redhat.com>
Subject: Re: builtin read -r and backslash-char escape sequences
Date: Mon, 3 Aug 2015 11:03:16 -0600
Message-ID: <55BF9ED4.2020301@redhat.com>
References: <EDC4419D-6669-4211-9005-8970B5499D9A@sanger.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NQOVCDKnj1uVEPIimJLOxf7D7RSGkIBAB"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57937 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254AbbHCRFq (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 3 Aug 2015 13:05:46 -0400
In-Reply-To: <EDC4419D-6669-4211-9005-8970B5499D9A@sanger.ac.uk>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: John Marshall <john.marshall@sanger.ac.uk>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NQOVCDKnj1uVEPIimJLOxf7D7RSGkIBAB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2015 10:37 AM, John Marshall wrote:
> Problems with one of my scripts appear to have been caused by dash's re=
ad -r translating escape sequences (like \t) whereas several other shells=
 read them literally.  For example:
>=20
> $ printf '%s' '\a\t\x' > backslashes=20
> $ dash -c 'read -r foo < backslashes; echo "$foo"' | cat -t
> ^G^I\x
> $ bash -c 'read -r foo < backslashes; echo "$foo"' | cat -t
> \a\t\x
> $ ksh -c 'read -r foo < backslashes; echo "$foo"' | cat -t
> \a\t\x
>=20
> POSIX says of -r, "Do not treat a <backslash> character in any special =
way. Consider each <backslash> to be part of the input line" [1].  Transl=
ating them as escape sequences doesn't appear to be particularly compatib=
le with this, but conceivably the translation is occurring at some other =
stage.

Bingo. The "some other stage" is your mistaken use of 'echo "$foo"'.
echo is not portable with backslashes.

$ bash -c 'shopt -s xpg_echo; read -r foo < backslashes; echo "$foo"' |
cat -t
^G^I\x
$ dash -c 'read -r foo < backslashes; printf %s\\n "$foo"' | cat -t
\a\t\x

>=20
> Is this the intended behaviour?

No bug here except in your usage of echo when you should have been using
printf.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--NQOVCDKnj1uVEPIimJLOxf7D7RSGkIBAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJVv57ZAAoJEKeha0olJ0Nq6nkIAJy58poQa9ItRWRbCgNSRmwp
jzLgZu8T0gCk4vb2dbsewhI6KeP8MsvAunEKQW+wmsQMlPU1vzngC+Bs6LQesJ2Q
nVLpvlehsyxXV6JOzp1rzBVd1DEfILD4C7Jq/JWVqCI0yPGugeeNshCm08px6m1v
M8s/vSsb1G4Wa66Ut2ZOIVAkFrV9lLfUFtNhE4yKJMeK/P+Rk0/zzGg8oGPDDYZR
ULOlPO36kvq3SvdVLbDoZxzbYwt9dL/fONic5tL05mUAEN25GSM2NkijQPH/4evr
mC+/lDUC+9H9b6uAkKT4favfkky97EqIqMqO29ErlyK17mmyGZauhlirjBxxHWM=
=ecnK
-----END PGP SIGNATURE-----

--NQOVCDKnj1uVEPIimJLOxf7D7RSGkIBAB--
