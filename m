From: Eric Blake <eblake@redhat.com>
Subject: Re: test incorrectly rejecting valid expression with confusing !
 placement
Date: Tue, 03 Sep 2013 20:38:16 -0600
Message-ID: <52269D18.3090200@redhat.com>
References: <20130904015629.GA19007@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4APclj9c08OUI2MfhopCvMRgTRstxgbro"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49491 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761702Ab3IDCjZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 3 Sep 2013 22:39:25 -0400
In-Reply-To: <20130904015629.GA19007@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.hengli.com.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4APclj9c08OUI2MfhopCvMRgTRstxgbro
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2013 07:56 PM, Herbert Xu wrote:
> Harald van Dijk <harald@gigawatt.nl> wrote:
>> Hi,
>>
>> Now that Herbert fixed the reported crash in test (in a far simpler
>> manner than I had suggested, which I like), I did some more testing, a=
nd
>> came across one case that does not currently work, and did not work in=

>> the past, but is perfectly valid:
>>
>> $ src/dash -c 'test ! ! =3D !'
>> src/dash: 1: test: =3D: unexpected operator
>=20
> Agreed.
> =20
>> $ src/dash -c 'test ! -o !'
>> src/dash: 1: test: -o: unexpected operator
>=20
> Nope, the rule is quite clear that it only applies to binary
> primaries, not operators.  -o is an operator.

Huh?
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html
states that there are only two operators "!" and "()", and specifically
mentions that -a and -o are binary primaries:

expression1 -a  expression2
    [OB XSI] [Option Start]
    True if both expression1 and expression2 are true; otherwise, false.
The -a binary primary is left associative. It has a higher precedence
than -o. [Option End]
expression1 -o  expression2
    [OB XSI] [Option Start]
    True if either expression1 or expression2 is true; otherwise, false.
The -o binary primary is left associative. [Option End]

"test ! -o !" is a three-argument test, where $2 (-o) is a binary
primary, so it is the binary test of $1 and $3, and the end result is an
exit status of 0.  Bash and ksh get it right, dash fails.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--4APclj9c08OUI2MfhopCvMRgTRstxgbro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJSJp0YAAoJEKeha0olJ0NqXRIIAKSO+luDFGwCiTzalvuxZ4r7
Vwhj0g86iJpeneD0R6xKqIXIDlS92d+D9rvzRJnw7FS6IZBDegCXaDIlkvt8cD9x
1CMQpcybKsMlzDE+yyq9nakZyRnuVVzESR65a7aMlbrUAJK4Ye5RHsQfWGdYNWnn
PldA25FXO6bnKbQBbQfFXDIeAxvHhFCmMM6Qz/g47Lmn+BwLmVE1uQBUHfEuxLB1
4uygcOjmRBFo7x76QY/OSEk9vY3+UaOSI9ZyOYkaxYfuJPHMwo4lrrP9Jo3EoXhg
rleo/Hh4s0IpqTEoTWHch+GmGkefhV/tmS+mSdAEZPtwVQcKMJrvaUJA5zyVPO4=
=AXYD
-----END PGP SIGNATURE-----

--4APclj9c08OUI2MfhopCvMRgTRstxgbro--
