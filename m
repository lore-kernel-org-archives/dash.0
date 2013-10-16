From: Eric Blake <eblake@redhat.com>
Subject: Re: Replacement for declare in dash?
Date: Wed, 16 Oct 2013 08:41:15 -0600
Message-ID: <525EA58B.9050804@redhat.com>
References: <20131016121859.GA30169@yade.xx.vu> <525E9FF6.60401@case.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QDLJ16cq2HJdGaeuobUNbXSXx7nQQPQMa"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25064 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259Ab3JPOlX (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 16 Oct 2013 10:41:23 -0400
In-Reply-To: <525E9FF6.60401@case.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: chet.ramey@case.edu, Alexander Huemer <alexander.huemer@xx.vu>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QDLJ16cq2HJdGaeuobUNbXSXx7nQQPQMa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/16/2013 08:17 AM, Chet Ramey wrote:
> On 10/16/13 8:18 AM, Alexander Huemer wrote:
>> Hi,
>>
>> I wrote a shell script on a non-Debian system and assumed, in my=20
>> greenness, that testing it with #!/bin/bash --posix would ensure that =

>> the script would run under dash too. I was wrong. Of course that is th=
e=20
>> fault of bash and not dash.
>=20
> Maybe you should have verified your assumptions first.  That is simply =
not
> what the --posix option does.  Posix mode makes bash a superset of Posi=
x;
> it's not a nothing-but-what-posix-specifies mode.

If you want a shell that does nothing-but-what-posix-specifies, use posh
from the Debian project.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--QDLJ16cq2HJdGaeuobUNbXSXx7nQQPQMa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJSXqWLAAoJEKeha0olJ0NqGk4H/3MV8bmkcJ8ieHhnLd3l/MeW
7Xb3W49Ja5Kui3KJXFj4pc50vQhr8FuUXekj4yB4ZykTYUlPa7HvN0NPlfBKChZS
ZAe+PVOdWTwHKPvreG8XdrhuMRfKXmXOGoIlphpsJQ3nfE7oCYi39jZcF52yb8c0
ibB/ooSk8jp3ndL5hkIUDTDBSPuZ5JfJ7c/e+JiUS8kmzBqHZ9ANnz9pI47oqHb2
aQ281S0Oir+W+LIFm/4x3U2Bbhm7iEnqrklJyU3WcscteVbnY5OksRtJ2Zdsp6/R
tVrbMtwdFvfX6JeDJcFHRplFm/wuF2ZEdyolfC4uiwytrTe7fh4fbW0WR3SY4dU=
=4xR3
-----END PGP SIGNATURE-----

--QDLJ16cq2HJdGaeuobUNbXSXx7nQQPQMa--
