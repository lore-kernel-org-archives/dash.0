From: Eric Blake <eblake@redhat.com>
Subject: 'set' leaks garbage from environment
Date: Tue, 30 Sep 2014 09:01:27 -0600
Message-ID: <542AC5C7.5090307@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KSsoi9gb5OpeL9Ho3TSi6ldLc4J5C35JR"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33861 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaI3PB2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 30 Sep 2014 11:01:28 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8UF1Sid005725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <dash@vger.kernel.org>; Tue, 30 Sep 2014 11:01:28 -0400
Received: from [10.3.113.28] (ovpn-113-28.phx2.redhat.com [10.3.113.28])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s8UF1SL2019916
	for <dash@vger.kernel.org>; Tue, 30 Sep 2014 11:01:28 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KSsoi9gb5OpeL9Ho3TSi6ldLc4J5C35JR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The recent changes in bash have prompted me to look closer at dash's
behavior with unusual name/value settings in the environment.  I found
at least two bugs:

Per the documentation of set,
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#=
set
"If no options or arguments are specified, set shall write the names and
values of all shell variables in the collation sequence of the current
locale.... The output shall be suitable for reinput to the shell,
setting or resetting, as far as possible, the variables that are
currently set;"

Elsewhere,
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html
"Environment variable names used by the utilities in the Shell and
Utilities volume of IEEE Std 1003.1-2001 consist solely of uppercase
letters, digits, and the '_' (underscore) from the characters defined in
Portable Character Set and do not begin with a digit. Other characters
may be permitted by an implementation; applications shall tolerate the
presence of such names."

Here's the behavior I observe with dash 0.5.7 (as built for Fedora 20):

$ env 'a|b=3D' dash -c 'set | grep a"."b'
a|b=3D''

Oops - set is claiming that 'a|b' is the name of a current shell
variable; but this is impossible.  Worse, the text quoted from POSIX
means that I should be able to safely do:

$ dash -c 'eval "$(set)"'

but if "a|b=3D' is in the environment, this will try to invoke the comman=
d
named 'a', rather than set a variable named a|b.  This is NOT as severe
as the bash Shell Shock bug (Shell Shock only required control over
values, while this requires control over arbitrary names in the
environment), but I still wonder if someone might be able to exploit
this into causing some dash script into executing code of the caller's
choice under the elevated permissions that the script is running under.

Dash should follow the lead of bash, and refuse to list any inherited
environment variable that is not a valid variable name.  However, it's
probably up to you to either remove those non-names from the environment
entirely, or to act like bash and merely hang on to those name-value
pairs to hand on to the child process even though it is untouchable from
within dash.

Next bug:

$ dash -c 'unset "a|b"
$ echo $?
0

This should fail (as in bash and ksh), rather than silently succeeding,
since it is not possible to unset a non-valid name.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KSsoi9gb5OpeL9Ho3TSi6ldLc4J5C35JR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJUKsXHAAoJEKeha0olJ0NqphQH/iRWrQYj0JHyle+95LGdHNPl
ZciqauA1oUXOUHrJwmvyTRH0gXufzyiumm877V6NlNuKT2RRYYGwC3hz3A7cvFEP
OGHGTGyOcc26/lZGkmKCOHsw9YnjoPgsa6aPAVTvvOrldILXu4Gg7rzuzQWQXh3i
NBEmDUQA8dHTejJv+nE1HpQRYuB8P2iAzbUWDsfafhrwObXMj3+xz63oP6H4UCBx
szMHW/yiREmy1X71+muPhG5BEv8U2u6e3QPcdjrNhJS/8tegOOyJddAF3Ojd1nGQ
vjxLof/Ve/C1ipFjd2jDBTBJ0v5bnQ4g0em+zbZoosDJUhjIc8GMEn0ORpWy6zI=
=TZmB
-----END PGP SIGNATURE-----

--KSsoi9gb5OpeL9Ho3TSi6ldLc4J5C35JR--
