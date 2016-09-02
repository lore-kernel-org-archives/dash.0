From: Eric Blake <eblake@redhat.com>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Fri, 2 Sep 2016 09:25:15 -0500
Message-ID: <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
References: <20160902140437.GA12639@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T8l2f1I4I99UFatqLdrCuhM1vO1am8iWp"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932197AbcIBOZS (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 10:25:18 -0400
In-Reply-To: <20160902140437.GA12639@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, Harald van Dijk <harald@gigawatt.nl>
Cc: olof@ethup.se, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T8l2f1I4I99UFatqLdrCuhM1vO1am8iWp
Content-Type: multipart/mixed; boundary="1p1oAiuN7exhC0Xg6cwhDf2Hmi3dbTU0M"
From: Eric Blake <eblake@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Harald van Dijk <harald@gigawatt.nl>
Cc: olof@ethup.se, dash@vger.kernel.org
Message-ID: <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
Subject: Re: Parameter expansion, patterns and fnmatch
References: <20160902140437.GA12639@gondor.apana.org.au>
In-Reply-To: <20160902140437.GA12639@gondor.apana.org.au>

--1p1oAiuN7exhC0Xg6cwhDf2Hmi3dbTU0M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2016 09:04 AM, Herbert Xu wrote:

>> Yes, this looks like a bug in dash. With the default --disable-fnmatch=
=20
>> code, when dash encounters [ in a pattern, it immediately treats the=20
>> following characters as part of the set. If it then encounters the end=
=20
>> of the pattern without having seen a matching ], it attempts to reset =

>> the state and continue as if [ was treated as a literal character righ=
t=20
>> from the start.

>=20
> POSIX says:
>=20
> 9.3.3 BRE Special Characters
>=20
> A BRE special character has special properties in certain contexts.
=2E..
> An
> expression containing a '[' that is not preceded by a backslash
> and is not part of a bracket expression produces undefined results.


Ah, but POSIX also says:

2.13.1 Patterns Matching a Single Character

[
    If an open bracket introduces a bracket expression as in XBD RE
Bracket Expression, except that the <exclamation-mark> character ( '!' )
shall replace the <circumflex> character ( '^' ) in its role in a
non-matching list in the regular expression notation, it shall introduce
a pattern bracket expression. A bracket expression starting with an
unquoted <circumflex> character produces unspecified results. Otherwise,
'[' shall match the character itself.

So while a lone '[' is unspecified in a normal BRE, it is well-defined
in a shell filename pattern matching context.  Since '[' is not a
bracket expression, it MUST be treated as a literal '[', so ${foo#[}
MUST strip the leading [ from the contents of foo, without requiring
that the [ be quoted.

>=20
>> This also affects
>>
>>     case [a in [?) echo ok ;; *) echo bad ;; esac
>>
>> which should print ok.
>=20
> Even ksh prints bad here.

So ksh is also buggy.

>=20
> I would however consider a patch that simplifies the code in the
> undefined case.

Except that it is well-defined by POSIX, not undefined.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1p1oAiuN7exhC0Xg6cwhDf2Hmi3dbTU0M--

--T8l2f1I4I99UFatqLdrCuhM1vO1am8iWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJXyYvLAAoJEKeha0olJ0NqYm8H/0gsohMEO9rJdArn5/yrlgUa
jkwpMCDBG1ci3MIo1aZqUc4QIeqjZ6Svp6qcC75tbYQeKWmBHu1rT0COaPVa4rz8
kwHptuvaCYeGKkNwPIXufGgBVF1Rs/C1QDboq5e6UHoSr4mS5JJ2GOwoRvd9i4Ra
H2BfmcqBURKShtHAl881aV0+f1ZseRD2iWthz4CGFk9VKwHLD8aRzQEvCbNgstU/
JEA10F8o7HlvY4tpC6qIFO3tZ68BeUJPFK4qnrjzzkoRP5bukXxm1ePY+Lvk1/tL
qhzLzVWjbxAGOJJ+hB3pj7ARNjLBfm8hcOSsyx1APK9G75K2IJtfynU/Kx/v114=
=yvYv
-----END PGP SIGNATURE-----

--T8l2f1I4I99UFatqLdrCuhM1vO1am8iWp--
