From: Eric Blake <eblake@redhat.com>
Subject: Re: positional argument bug
Date: Thu, 05 May 2011 09:53:19 -0600
Message-ID: <4DC2C7EF.3050001@redhat.com>
References: <BANLkTi=cmXee5Ej2fmhX2dp4FG6U3_1JqQ@mail.gmail.com>	<20110504024128.GB8187@elie>	<BANLkTimmAWkEne0SYFDpc4Kq-4ChBJ_dWg@mail.gmail.com>	<BANLkTimUJX-asm1rBoKHKMH6HU8asWdLPA@mail.gmail.com>	<20110504050223.GG8187@elie>	<m3oc3ic2sc.fsf@linux-m68k.org>	<BANLkTi=n37vhi63Rh1YRh8uqxZ6cyR65wQ@mail.gmail.com>	<4DC2A4E8.7020904@case.edu>	<4DC2AFF7.7070007@redhat.com>	<4DC2B0FD.1000802@redhat.com> <BANLkTikk977F6f_ZTjGFroVXyont_gCWOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigFAAB0D01EFB2FF6E3F08ABEA"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16871 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913Ab1EEPxV (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 5 May 2011 11:53:21 -0400
In-Reply-To: <BANLkTikk977F6f_ZTjGFroVXyont_gCWOw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Verych <olecom@gmail.com>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFAAB0D01EFB2FF6E3F08ABEA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2011 09:47 AM, Oleg Verych wrote:
> 2011/5/5 Eric Blake <eblake@redhat.com>:
>> [originally brought up on the bash list as a NetBSD bug, but dash is
>> also affected]
>=20
> So what? I was happy (years back) to have ability to create adressable
> arrays using $####... or ${####} if it matters.

You can always create an addressable array with ${####} - the bug in
question is only about dash's treatment of $####.  POSIX already
requires that the user use braces for multi-digit positional parameters.

>=20
>> Therefore, in "$10", 10 is not a name, so the longest name is the empt=
y
>> string, and the single-character symbol is used instead, such that thi=
s
>> MUST be parsed as ${1}0, not as ${10}.
>=20
> IMHO this would be step back.

No, making $10 different from ${10} would be making things
POSIX-compliant.  And I can envision using things like:

set a
eval echo \$$10

as a way to specifically echo the contents of $a0, but where that usage
only works if all shells follow the same rules.  But given the current
difference in behavior, I guess:

eval echo \$${1}0

is the best I can expect.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigFAAB0D01EFB2FF6E3F08ABEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNwsfvAAoJEKeha0olJ0Nq2RsIAIiiVzga0FHKXDMvHBlALSsW
3GaOfRpsV5xpWFhpgMD10KwU4N5uyZcOYKUUhpBEXUm0epJSARu79TAb5lk0aTE8
l2XSEG4y6ULoPwmdUO/CGI92di2lM/RBMT+ub7rkXS6gRF5k+X0UvCxF2x1Slc6y
rSWtiiIELk7H2jibuDszb5WRCxCzBF+hqolg2X2SIIAZoDcnax6weZbtqjAyG/xn
u0MeBxZ9WeVNwTA8fOhlHBA/D0aFe0rpnoLHIWovICoqQKex+kZY/77XlcA+Kgu3
g5rgAd2EzDdW0F+y4ujmbMJX8CpNhdS3wUH5MF5RvS3xETIT0K+Q7sL3KOp6Rkk=
=64Tj
-----END PGP SIGNATURE-----

--------------enigFAAB0D01EFB2FF6E3F08ABEA--
