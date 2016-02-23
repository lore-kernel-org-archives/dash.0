From: Eric Blake <eblake@redhat.com>
Subject: Re: [BUG] Illegal function names are accepted after being used as
 aliases
Date: Tue, 23 Feb 2016 12:33:11 -0700
Message-ID: <56CCB3F7.8090301@redhat.com>
References: <56CCA25E.5020809@openmailbox.org> <56CCA879.1070208@gigawatt.nl>
 <56CCABD6.40001@redhat.com> <56CCB121.60808@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WPs1VhJhwVtVLX7uUpurJonUtIUphexdj"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48390 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753738AbcBWTdM (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Feb 2016 14:33:12 -0500
In-Reply-To: <56CCB121.60808@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>, Jan Verbeek <ring@openmailbox.org>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WPs1VhJhwVtVLX7uUpurJonUtIUphexdj
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2016 12:21 PM, Harald van Dijk wrote:
> On 23/02/2016 19:58, Eric Blake wrote:
>> On 02/23/2016 11:44 AM, Harald van Dijk wrote:
>>
>>> This matches bash's behaviour, aside from bash requiring -- to preven=
t
>>> detection of invalid flags to the alias command:
>>>
>>> bash-4.3$ alias -- -=3Dtrue
>>
>> Then dash DOES have a bug:
>=20
> Indeed, I wasn't trying to suggest otherwise, my apologies if it came
> across that way. It's not limited to the alias command though, I spotte=
d
> at least the exit and getopts commands having the same problem, and it
> should probably be fixed for all of them at once.

getopts - definitely needs a fix
exit - fuzzy.  exit is a special built-in (unlike getopts); and XCU 2.14
states:

 "Some of the special built-ins are described as conforming to XBD
Utility Syntax Guidelines. For those that are not, the requirement in
Utility Description Defaults that "--" be recognized as a first argument
to be discarded does not apply and a conforming application shall not
use that argument. "

Conforming apps cannot expect 'exit -1' to work, and therefore, cannot
also expect 'exit -- -1' to work, since the only standards-defined
values for an argument to exit is a non-negative decimal integer less
than 256.  Of course, if you want to fix it along with all the others,
that's fine; I'm just pointing out that 'exit' isn't broken as-is.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--WPs1VhJhwVtVLX7uUpurJonUtIUphexdj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWzLP3AAoJEKeha0olJ0NqZZcH/jjtb1XESSDkUU28Jle1A8k0
MLoV/SXE6iKlzIIcHP9ZX5ucIhfMYDGr+gbLrv5XqE7JMaip0GvbPw36hmYiSrXq
vz695WgtXatZUQYtYyJoBNP2kl7GfBB4Qij9Lr6swsTAIIGP65TthnWqI8+Arsfk
5Jl5djsroHYAsJ/qHR5NxlwyYv6prdbIE09rCBfuC9iUshbjYYqxKwbHEINKPCJW
ivejg9Qts0h5UDuuUni+a0y9t7c5WfXam1EMlb/oFF1riHZM77ztO7l7ERaHh4Vl
Q9sMDD25glTTnP2QsZAYGrR3IXdg+Wwr7WZQ2/WXQCekwA+NshKNyKvZ+SdKzwM=
=ZB8+
-----END PGP SIGNATURE-----

--WPs1VhJhwVtVLX7uUpurJonUtIUphexdj--
