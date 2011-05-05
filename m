From: Eric Blake <eblake@redhat.com>
Subject: positional argument bug
Date: Thu, 05 May 2011 08:15:25 -0600
Message-ID: <4DC2B0FD.1000802@redhat.com>
References: <BANLkTi=cmXee5Ej2fmhX2dp4FG6U3_1JqQ@mail.gmail.com>	<20110504024128.GB8187@elie>	<BANLkTimmAWkEne0SYFDpc4Kq-4ChBJ_dWg@mail.gmail.com>	<BANLkTimUJX-asm1rBoKHKMH6HU8asWdLPA@mail.gmail.com>	<20110504050223.GG8187@elie>	<m3oc3ic2sc.fsf@linux-m68k.org>	<BANLkTi=n37vhi63Rh1YRh8uqxZ6cyR65wQ@mail.gmail.com>	<4DC2A4E8.7020904@case.edu> <4DC2AFF7.7070007@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigEB47BF9F246DA21D5CD48785"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41315 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271Ab1EEOP0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 5 May 2011 10:15:26 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p45EFPma018894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <dash@vger.kernel.org>; Thu, 5 May 2011 10:15:26 -0400
Received: from [10.3.113.2] ([10.3.113.2])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p45EFP75002722
	for <dash@vger.kernel.org>; Thu, 5 May 2011 10:15:25 -0400
In-Reply-To: <4DC2AFF7.7070007@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB47BF9F246DA21D5CD48785
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[originally brought up on the bash list as a NetBSD bug, but dash is
also affected]

On 05/05/2011 08:11 AM, Eric Blake wrote:
>> I'd call that a pretty serious incompatibility on the part of ash and =
its
>> descendants (BSD sh, dash, etc.).  There's no good reason that
>>
>> set -- a b c d e f g h i j
>> echo $10
>>
>> should echo `j'.
>=20
> Also a POSIX violation:
>=20
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.htm=
l#tag_18_06_02
>=20
> "The parameter name or symbol can be enclosed in braces, which are
> optional except for positional parameters with more than one digit or
> when parameter is followed by a character that could be interpreted as
> part of the name."

Additionally from POSIX:

"If the parameter name or symbol is not enclosed in braces, the
expansion shall use the longest valid name (see XBD Name)"

"In the shell command language, a word consisting solely of underscores,
digits, and alphabetics from the portable character set. The first
character of a name is not a digit."

Therefore, in "$10", 10 is not a name, so the longest name is the empty
string, and the single-character symbol is used instead, such that this
MUST be parsed as ${1}0, not as ${10}.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigEB47BF9F246DA21D5CD48785
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNwrD9AAoJEKeha0olJ0Nqs40IALAt14IAGogVouFmYMcASXU2
ZAN0QksCww1jgoe6yqf7HA+bIayaVbhEH7/TofwkdAHmkYvKEaqpK+v52dem+3u1
viXD+figKGk1yFds6qNrxsvoUkmks+HECBrS/R36rppI0uaQ57rh4m7cPoGPIWkX
XJh+ooxRJEkVp5n5HhfjlAWC1yGsfwrocE2b/2x76BGAL5kU4uywcjzI9bZXZAj4
Vv2Rj+bwP+QGPV+e9zsoDwdQ7sJJQgCvImVyxspSjYwrYaMqvbEg745UUM2s9S4a
/uYJLB3a0S6NmfXptModF+bNfwrGBPIAypsL7/Wt/Jbd8hRPIKoOxdzsiIeldrs=
=wz1b
-----END PGP SIGNATURE-----

--------------enigEB47BF9F246DA21D5CD48785--
