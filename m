From: Eric Blake <eblake@redhat.com>
Subject: Re: static vs. dynamic scoping
Date: Wed, 10 Nov 2010 08:13:47 -0700
Message-ID: <4CDAB6AB.5080004@redhat.com>
References: <4CD9C280.60007@redhat.com> <4CDA6301.1010703@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig531E2BE5FC63412F320BBEA7"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17817 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756482Ab0KJPNs (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Nov 2010 10:13:48 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id oAAFDmom007106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <dash@vger.kernel.org>; Wed, 10 Nov 2010 10:13:48 -0500
Received: from [10.3.113.96] (ovpn-113-96.phx2.redhat.com [10.3.113.96])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id oAAFDlst002697
	for <dash@vger.kernel.org>; Wed, 10 Nov 2010 10:13:47 -0500
In-Reply-To: <4CDA6301.1010703@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig531E2BE5FC63412F320BBEA7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[redirecting back to the list, so others can benefit]

On 11/10/2010 02:16 AM, Marc Herbert wrote:
> Le 09/11/2010 21:52, Eric Blake a =C3=A9crit :
>> I'm trying to standardize the notion of local variables for the next
>> revision of POSIX, but before I can do so, I need some feedback on two=

>> general aspects:
>> [...]
>> Here's a sample shell script that illustrates the difference between t=
he
>> two scoping methods.
>=20
> Hi Eric,
>=20
>   I found your sample script quite confusing. To make your point, does
> this script really need to:
> - use unquoted language keywords as string values?

No; I could have used other strings.

> - use deprecated "typeset" instead of declare?

Yes - the current Austin Group thoughts are to standardize 'typeset' and
NOT 'local', since 'typeset' can be used with arguments outside of
functions, and more existing shells provide 'typeset' than 'local' (dash
being the odd one out) or 'declare'.  Shells can continue to provide
'local' as a synonym for the most basic use of typeset.

> - use the not (or less?) standard "function" keyword?

Yes - ksh93 ONLY supports function-local scoping when using the function
keyword, rather than when using POSIX functions (although David Korn
agreed that if POSIX standardizes function-local scoping, he'd make the
next build of ksh support it in POSIX functions).

So, here's the example again, with those points addressed:

# Demonstrate ksh local scoping is static - requires ksh's 'function'

$ ksh -c 'function f1 { typeset a=3Dtemp; f2; echo "in f1: $a"; };
function f2 { echo "in f2: $a"; a=3Dchanged; }; a=3Dglobal; f1; echo "top=

level: $a"'
in f2: global
in f1: temp
top level: changed

# Demonstrate that with POSIX functions, ksh has global scoping

$ ksh -c 'f1 () { typeset a=3Dtemp; f2; echo "in f1: $a"; }; f2 () { echo=

"in f2: $a"; a=3Dchanged; }; a=3Dglobal; f1; echo "top level: $a"'in f2: =
temp
in f1: changed
top level: changed

# Demonstrate that dash local scoping is currently dynamic

$ dash -c 'f1 () { local a=3Dtemp; f2; echo "in f1: $a"; }; f2 () { echo
"in f2: $a"; a=3Dchanged; }; a=3Dglobal; f1; echo "top level: $a"'
in f2: temp
in f1: changed
top level: global

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig531E2BE5FC63412F320BBEA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJM2rarAAoJEKeha0olJ0NqFO0H/RCo7oreqkaS58hk18n7e2pC
LImoPgT03V/SvwsfZc2tRbbuoX+I51icfGNKGPN1CckDMidGFD9x1/JMBd3eRk+v
rBnGSEpo8BEUfQJSGCz/sJdUE6kkxocmTQ0l6eKVYW5baDEY2V+OuTAVrwTyuYhs
FW8JmWEUyzjUvjdSlwWDd6TZkP0O0GKJ+9xFqxMTwp1gxpjL2JozazI9gAX2JqMl
+1ICAUDH88n8t9LULSdkj1pQ+tEQTHqLhbUvqxB8Dux8ZeNcO2L7dRYDau2y+by+
hBwkO3eMwAYL77KfpsrlIFaYX+6T+FXof3fbiaMJcVYxhPFw+ntPJ+SesXUemCU=
=VxHN
-----END PGP SIGNATURE-----

--------------enig531E2BE5FC63412F320BBEA7--
