From: Eric Blake <eblake@redhat.com>
Subject: bug with <&- under ulimit -n
Date: Wed, 27 Oct 2010 15:33:41 -0600
Message-ID: <4CC89AB5.3050207@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig6C38B24AF1C426D42B62160D"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3020 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757236Ab0J0Vdp (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 27 Oct 2010 17:33:45 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o9RLXjof016051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <dash@vger.kernel.org>; Wed, 27 Oct 2010 17:33:45 -0400
Received: from [10.3.113.124] (ovpn-113-124.phx2.redhat.com [10.3.113.124])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id o9RLXi7U008345
	for <dash@vger.kernel.org>; Wed, 27 Oct 2010 17:33:45 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C38B24AF1C426D42B62160D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dash does not behave well when under artificial fd pressure due to
ulimit -n.  It insists on copying a to-be-closed fd to another fd
greater than 10, then complains when the dup fails, rather than just
flat-out closing the fd in the first place.  Compare this with ksh93

$ ksh -c 'ulimit -n 10; : <&-'; echo $?
0
$ dash -c 'ulimit -n 11; : <&-'; echo $?
0
$ dash -c 'ulimit -n 10; : <&-'; echo $?
dash: 0: Invalid argument
2

See this thread on the bug-tar list for more details:
http://thread.gmane.org/gmane.comp.gnu.tar.bugs/4010/focus=3D4020

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig6C38B24AF1C426D42B62160D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJMyJq1AAoJEKeha0olJ0NqwAUIAJtfXTnjP0w3qU7KBMHYPoUl
lG4WgeCFQa+3s6O5XvXPdCs18NzO1NoVN3+j7c3WhwWUMqTjKzymGKDe6jD+/5Z4
XZha+7VZml/F/Qh0FICNn/NSAesCUDqWS30ILlCW6eLG9IQXEN86NzI1AIu8p3lr
tQp2HqGHFFKHGMhdcP7KNZvF6qAqCanEaquDlmeXBX/IM9haHqADyhjVj2/0DmYd
fYM4zLb95betM45l7vC2G1oVWWnNE7MCU1XyFQnoqWB3bkg1ThPMNboJlkoaILif
3UkPmgCTFJ+Cgs4CFLqZBatsTstmzn9pQbfTec2bYTDoNhF0Eo4Y1ipTxDiW9rs=
=8Rig
-----END PGP SIGNATURE-----

--------------enig6C38B24AF1C426D42B62160D--
