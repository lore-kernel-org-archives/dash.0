From: Eric Blake <eblake@redhat.com>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Fri, 2 Sep 2016 09:54:10 -0500
Message-ID: <a7438682-33b0-0f6f-3baf-190c1141d974@redhat.com>
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
 <20160902144646.GA13296@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vWu3SLWUnbOP6AwOwate9MXa0Rbd5TSep"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754239AbcIBOyL (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 10:54:11 -0400
In-Reply-To: <20160902144646.GA13296@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, olof@ethup.se, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vWu3SLWUnbOP6AwOwate9MXa0Rbd5TSep
Content-Type: multipart/mixed; boundary="krBDOohokXN0ol01HmpWJi0pkSNPsotum"
From: Eric Blake <eblake@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, olof@ethup.se, dash@vger.kernel.org
Message-ID: <a7438682-33b0-0f6f-3baf-190c1141d974@redhat.com>
Subject: Re: Parameter expansion, patterns and fnmatch
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
 <20160902144646.GA13296@gondor.apana.org.au>
In-Reply-To: <20160902144646.GA13296@gondor.apana.org.au>

--krBDOohokXN0ol01HmpWJi0pkSNPsotum
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2016 09:46 AM, Herbert Xu wrote:
> On Fri, Sep 02, 2016 at 09:25:15AM -0500, Eric Blake wrote:
>>
>> 2.13.1 Patterns Matching a Single Character
>>
>> [
>>     If an open bracket introduces a bracket expression as in XBD RE
>> Bracket Expression, except that the <exclamation-mark> character ( '!'=
 )
>> shall replace the <circumflex> character ( '^' ) in its role in a
>> non-matching list in the regular expression notation, it shall introdu=
ce
>> a pattern bracket expression. A bracket expression starting with an
>> unquoted <circumflex> character produces unspecified results. Otherwis=
e,
>> '[' shall match the character itself.
>=20
> BTW, this last sentence is not present in
>=20
> http://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.htm=
l#tag_02_13
>=20

That's the 2004 edition (TC1 of the 2001 spec, aka Issue 6).

> So I presume it's a newer unreleased revision.

Newer but released (TC2 of the 2008 spec, aka Issue 7):
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#=
tag_18_13_01

The requirement has been there for 8 years now.

>=20
> Seriously, you guys are turning POSIX into a joke by introducing
> all these new requirements.  At this point I think we should
> pretty much give up on POSIX compliance the way it's headed.

I hope you're just stating that out of frustration, and not something
that you actually intend to follow through with.  And if there is a
requirement being considered in the Austin Group that you disagree with,
please speak up on the Austin Group - membership is free.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--krBDOohokXN0ol01HmpWJi0pkSNPsotum--

--vWu3SLWUnbOP6AwOwate9MXa0Rbd5TSep
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJXyZKSAAoJEKeha0olJ0Nqyc4H/Ah/ODO+tOtcfIQAUwLhXAZn
PgqlbqsTqsaE+S+Efym5T+yNqIG3tkA0PEcbB9X5ZGXtGmVhJyXokwrTEnXOEY1A
9RTSUHgsbtfgDiiNDKF3HkUCmxPGXlXrvQSLh9Uso4uHd5F7XSBFaV8UyTRdSSva
xrSHXyEFynwB7gyO59coHbBd4gkhC8PUBqYZRXFgWAJPl6SKyUuC7Zy8pDda36aS
kHNfp7NUlPmhx6m8id36HMFFBLy3OyVhFFnCWNKNxcOE4rNueQbUZIGAh9JAuP+M
NWM/VJ37gNBq9xXcElZq6K5D+ArmcsXnBhP3RzYobU+0B3fxP5lyDJFvN0tdtUA=
=TBXb
-----END PGP SIGNATURE-----

--vWu3SLWUnbOP6AwOwate9MXa0Rbd5TSep--
