From: Eric Blake <eblake@redhat.com>
Subject: Re: Dashhh
Date: Thu, 17 Nov 2011 13:38:11 -0700
Message-ID: <4EC570B3.7040408@redhat.com>
References: <4EC53397.2030005@am-anger-1.de> <slrnjcaqkf.lrr.stephane.chazelas@spam.is.invalid>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig724E4F349CA83BC2E97750FF"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1026 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225Ab1KQUiM (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 17 Nov 2011 15:38:12 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAHKcCAJ019521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <dash@vger.kernel.org>; Thu, 17 Nov 2011 15:38:12 -0500
Received: from [10.3.113.130] (ovpn-113-130.phx2.redhat.com [10.3.113.130])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id pAHKcBYJ018675
	for <dash@vger.kernel.org>; Thu, 17 Nov 2011 15:38:11 -0500
In-Reply-To: <slrnjcaqkf.lrr.stephane.chazelas@spam.is.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig724E4F349CA83BC2E97750FF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2011 01:11 PM, Stephane CHAZELAS wrote:
>> 4. The bash FUNCNAME variable was very valuable for debugging purposes=
 and is nonexistent in dash
>=20
>=20
> If your functions are written as
>=20
> f() {
>   ...
> }
>=20
> sed 's/^[[:blank:]]*\([^[:blank:]]*\)[[:blank:]]*()[[:blank:]]*{/& loca=
l FUNCNAME=3D\1;/'

Except that 'local' is not part of POSIX, so while this conversion may
work for dash, it's not a portable catch-all for other compliant shells.

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enig724E4F349CA83BC2E97750FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJOxXCzAAoJEKeha0olJ0NqqJAH/j/LjtYXJ69KyZFd+dFiwvIA
1CQKQWeNKy/PY+FaSSb3+NxBjqdfpZ5MW6zYSxZf3cBFlcy4yqSZSRvYk+fFzOdt
rIiv1mF1Bc5Zzz4vYX2MDeZZxxEbeg3/jXEVfBY+H7AiOKNblBko6qJmmSSqHNv4
p3b1Jeje5is9L6HiA6A6nabFVGurWARSv3DvDRfpfk9gt61tGA6DdVy/wolGrTct
dr1cupw7VEaQEjuxIL/Yv3AtgrAopuh6/garM3t+D8CA/Zx/jJDFUXGQJLJbZw1P
TwyAOp47F+xF9wrR78sksPMDqWaOGgYWyTl8dKhl8R8bNfE1O7m+4wmsy1Ee1R8=
=BNwT
-----END PGP SIGNATURE-----

--------------enig724E4F349CA83BC2E97750FF--
