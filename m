From: Eric Blake <eblake@redhat.com>
Subject: Re: heredoc and subshell
Date: Tue, 23 Feb 2016 16:16:38 -0700
Message-ID: <56CCE856.1050502@redhat.com>
References: <2978711456265264@web9h.yandex.ru> <56CCE1E3.1060805@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bnwK5S1pJ4h7VOsex5wrJqnniWrmtw88b"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43824 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755658AbcBWXQl (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Feb 2016 18:16:41 -0500
In-Reply-To: <56CCE1E3.1060805@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org, Austin Group <austin-group-l@opengroup.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bnwK5S1pJ4h7VOsex5wrJqnniWrmtw88b
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2016 03:49 PM, Eric Blake wrote:
> [adding the Austin Group]
>=20
> On 02/23/2016 03:07 PM, Oleg Bulatov wrote:
>> Hello,
>>
>> trying to minimize a shell code I found an unobvious moment with hered=
ocs and subshells.
>=20
> Thanks for a cool testcase.
>=20
>>
>> Is it specified by POSIX how next code should be parsed? dash output f=
or this code differs from bash and zsh.
>=20
> XCU 2.3 says:
>=20
> When an io_here token has been recognized by the grammar (see Shell
> Grammar), one or more of the subsequent lines immediately following the=

> next NEWLINE token form the body of one or more here-documents and shal=
l
> be parsed according to the rules of Here-Document.
>=20
> and 2.7.4 says:
>=20
> The here-document shall be treated as a single word that begins after
> the next <newline> and continues until there is a line containing only
> the delimiter and a <newline>, with no <blank> characters in between.
> Then the next here-document starts, if there is one.
>=20
> but with no mention of what happens if you somehow manage to make the
> next <newline> be part of an incomplete shell word on the line
> containing the here-doc operator.

As it is, all shells I tested have a shorter test case that proves they
don't always start looking for the heredoc body after the first newline:

$ dash -c 'cat <<ONE && cat \''
<<TWO
a
ONE
b
TWO
'
a
b

The newline immediately after the backslash is NOT used to start the
first heredoc.

> Maybe we need a defect against the standard that says behavior is
> unspecified if the next <newline> after a here-doc operator occurs in
> the middle of a shell word.

Or maybe refine the wording to state the first unescaped newline, since
backslash escaping seems to consistently work (and only newlines inside
incomplete command substitution is where the confusion begins).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--bnwK5S1pJ4h7VOsex5wrJqnniWrmtw88b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWzOhWAAoJEKeha0olJ0NqeJsH/1AirS0FYSQ0iynVyULW43QF
omGNigvsJWJnYFhUbji0VAbvkYNs8rCLSBWK0+AiHyGbkjbXlw4AEO6sTUY0UYas
aqs0IVYlgaO5SLAa6OeN7QVTo93WatOGLDHePzIvQzcgZxYPN3frhBF9Twldf68Q
Bfmt1EZ2nYjUyYmCXYlm4UN1acxys1geXE4ltUV65j6+HLZHD34inooLTcAG7+9F
X78cc25cXC8BOtO8vi7AlTtm1fXOeifYXtU+XCu0Z5YUVzo3XXBSTBxXkgaOdmCD
Qk4KKwrF96u882imxGX+pVBplI9VkcTlHN9kh1J/CoeGD48sggLFS5tcPb2fHNU=
=I0Da
-----END PGP SIGNATURE-----

--bnwK5S1pJ4h7VOsex5wrJqnniWrmtw88b--
