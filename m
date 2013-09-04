From: Eric Blake <eblake@redhat.com>
Subject: Re: test incorrectly rejecting valid expression with confusing !
 placement
Date: Wed, 04 Sep 2013 06:09:31 -0600
Message-ID: <522722FB.5040702@redhat.com>
References: <20130904015629.GA19007@gondor.apana.org.au> <52269D18.3090200@redhat.com> <20130904032000.GA19583@gondor.apana.org.au> <20130904050323.GA20305@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d9gmnadNnGqJ3ShBNdJIC24Som0pJTGOg"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4871 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762533Ab3IDMKb (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 4 Sep 2013 08:10:31 -0400
In-Reply-To: <20130904050323.GA20305@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.hengli.com.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org, Austin Group <austin-group-l@opengroup.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d9gmnadNnGqJ3ShBNdJIC24Som0pJTGOg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[adding the Austin Group]

On 09/03/2013 11:03 PM, Herbert Xu wrote:
> On Wed, Sep 04, 2013 at 01:20:00PM +1000, Herbert Xu wrote:
>> =20
>>> "test ! -o !" is a three-argument test, where $2 (-o) is a binary
>>> primary, so it is the binary test of $1 and $3, and the end result is=
 an
>>> exit status of 0.  Bash and ksh get it right, dash fails.
>>
>> Both zsh and posh do it like dash:
>>
>> $ zsh -c 'test ! -o !'; echo $?
>> zsh:test:1: too many arguments
>> 1
>> $ zsh -c 'test ! =3D !'; echo $?
>> 0
>> $
>=20
> Another case in point is 'test ! =3D -o a', here bash differs with
> every other shell installed on my system, which all return 0, just
> like dash.

GNU coreutils behaves like bash; the POSIX wording justifies bash:

4 arguments:

        If $1 is '!', negate the three-argument test of $2, $3, and $4.

        [OB XSI] [Option Start] If $1 is '(' and $4 is ')', perform the
two-argument test of $2 and $3. [Option End]  On systems that do not
support the XSI option, the results are unspecified if $1 is '(' and $4
is ')'.

        Otherwise, the results are unspecified.

That is, "test ! =3D -o a" should be parsed as "test ! \( =3D -o a \)"
(bash's behavior, per the first bullet), not "test \( ! =3D \) -o a"
(ksh's behavior, per the third bullet).

Yet another reason why the XSI -a and -o make the parsing precedence of
test a pain to decipher.  Do we need to open yet another bug against
POSIX to allow for ksh's behavior?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--d9gmnadNnGqJ3ShBNdJIC24Som0pJTGOg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJSJyL7AAoJEKeha0olJ0NqNIsH/1tT1eZDrQ6c3ie2uEX2/dj2
aH3pLVyPSwHNlgoc6j+N8ecJ3GxNp0XuVJXvt5TsWGDLnvnJt4ZbbJL9Eyox06WE
WOInaNrJh8dvaGxlzhyOlwHpqpR5BgbUEB6pEQvtMPliavlLKp4ATjW31ncTxR6K
ceXcCPGe8FDvYXWjYNx7ve3gNJ/tAi6pwMfLs9Py6TR7pdjz28PTpFXEqKNHpe2l
gpQHoRzx1+ioqpYZgg7sFGTOKgQHOz48YJis7XOokGwBjVrolIj63lmFFh/z6Mjz
vs/dYv+wzEWPD9swjyoxznW2RzhjAxF5lWR++aAjNKU+Pw472Np48X7t9AqPNiY=
=EvpG
-----END PGP SIGNATURE-----

--d9gmnadNnGqJ3ShBNdJIC24Som0pJTGOg--
