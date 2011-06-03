From: Eric Blake <eblake@redhat.com>
Subject: Re: positional argument bug
Date: Fri, 03 Jun 2011 15:38:01 -0600
Message-ID: <4DE95439.2090404@redhat.com>
References: <20110520235950.GA1839@gondor.apana.org.au> <1305968012.28004.6.camel@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigA89A6BB144915783188B2725"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50145 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756091Ab1FCVik (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 3 Jun 2011 17:38:40 -0400
In-Reply-To: <1305968012.28004.6.camel@linux>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA89A6BB144915783188B2725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/21/2011 02:53 AM, Harald van Dijk wrote:
>>> Additionally from POSIX:
>>>
>>> "If the parameter name or symbol is not enclosed in braces, the
>>> expansion shall use the longest valid name (see XBD Name)"
>>>
>>> "In the shell command language, a word consisting solely of underscor=
es,
>>> digits, and alphabetics from the portable character set. The first
>>> character of a name is not a digit."
>>>
>>> Therefore, in "$10", 10 is not a name, so the longest name is the emp=
ty
>>> string, and the single-character symbol is used instead, such that th=
is
>>> MUST be parsed as ${1}0, not as ${10}.
>>
>> I don't think any of this explicitly states that $10 cannot be
>> interpreted as ${10}.  All it says is that where the first character
>> is an underscore or alphabetic, then the longest name should be
>> used, and that to use $10 portably you must put braces around it.
>=20
> I agree that the last quotes are not convincing. In fact, they seem to
> be saying that $10 must be interpreted as ${}10: there's no "if there i=
s
> no name, use a single-character symbol". The first, however:
>=20
>> "The parameter name or symbol can be enclosed in braces, which are
>> optional except for positional parameters with more than one digit or
>> when parameter is followed by a character that could be interpreted as=

>> part of the name."
>=20
> does say the braces are optional in ${1}0, so if a script author change=
s
> ${1}0 to $10, there should be no change in behaviour.

Given the confusing wording in POSIX, I've opened up a bug report:

http://austingroupbugs.net/view.php?id=3D458

Once it is resolved, it will either put the burden on dash to become
compliant ($10 is unambiguously ${1}0, Option 1), or put the burden on
compliant shell scripts to avoid $10 (both historical ${1}0 and dash
${10} behaviors are permitted, Option 2).  It will be interesting to see
which way the POSIX folks go on this one.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigA89A6BB144915783188B2725
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJN6VQ5AAoJEKeha0olJ0Nq304H/R9qEcwKY4XhhgD8+7QKSSZm
SaviKQsxqmJ3q6bXeO7AWuBRz4qI4+SGCuQ25KAke+kEn6jjKH8TNYE+SE+V1Frt
LosKJGT+u6ERoh88R/vo6QXIzr/SV+euMe8j2Gm9EP52zeccez4i2WhLGgDE5H28
3YRL9l+UgU2lJgwhCFy+jeOBDcZgdfheuTsfJkSvyt1JgQN2Ft5CEyJ+R8bkQ+Rt
7Y1IsUBZKDduxS6Pe7OrD34RSbofvC+rNcEKl7j4WnesNM1dkshjgf1SbgH3+eI5
tnEH8sqA+5Ppbp3bX/4F2AmP0uzplp17j3/M7M/SzFRaoLAD1cGC5WFP4wbzJEA=
=u+WR
-----END PGP SIGNATURE-----

--------------enigA89A6BB144915783188B2725--
