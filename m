From: Eric Blake <eblake@redhat.com>
Subject: Re: 'set' leaks garbage from environment
Date: Tue, 30 Sep 2014 09:20:52 -0600
Message-ID: <542ACA54.50201@redhat.com>
References: <542AC5C7.5090307@redhat.com> <20140930151449.GB22440@brutus.ethup.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="krS20hbobmkgOnx1uRgo5RTKMLdnSnmDQ"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4980 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbaI3PUz (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 30 Sep 2014 11:20:55 -0400
In-Reply-To: <20140930151449.GB22440@brutus.ethup.se>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Olof Johansson <olof@ethup.se>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--krS20hbobmkgOnx1uRgo5RTKMLdnSnmDQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/30/2014 09:14 AM, Olof Johansson wrote:
> On 2014-09-30 09:01 -0600, Eric Blake wrote:
>> $ dash -c 'unset "a|b"
>> $ echo $?
>> 0
>=20
> Works for me (tested on both Debian package versions 0.5.7-3 (wheezy)
> and 0.5.7-4 (unstable)):

Serves me right from testing on multiple machines :(
I mixed up my test results.

Fedora 20 using dash 0.5.7 works:

$ dash -c 'unset "a|b"'
dash: 1: unset: a|b: bad variable name
$ rpm -q dash
dash-0.5.7-8.fc20.x86_64

But RHEL 6 fails:

$ dash -c 'unset "a|b"'
$ rpm -q dash
dash-0.5.5.1-4.el6.x86_64

so this is at least one bug that has already been fixed upstream.

>> $ env 'a|b=3D' dash -c 'set | grep a"."b'
>> a|b=3D''
>=20
> This I can reproduce though.

Meanwhile, I just tested the latest dash.git (commit f21016a12) and this
behavior is no longer present:

$ env 'a|b=3D' ./src/dash -c 'set | grep a"."b'

so it has also been fixed in the meantime.  Sorry for not doing my
homework; nothing to fix here...

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--krS20hbobmkgOnx1uRgo5RTKMLdnSnmDQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJUKspUAAoJEKeha0olJ0Nq37MH/39l4cpNjOo2HHreqcmgGN13
P6mJO7UwY2+gp9zE61FBGRjh/Lx/8rAaojL6uiw1z9PBnNFV5K877W2qi3zOVm67
7Q3EQqbHwsU+L13r0v/bpzcea3E1TKG13s8RWVnaIjIKgrxhv0ulXx5QYi+fVroV
2gvlEIlUS2bXtEWENd20MUFG5lddoamW68bQOIluamTFBt2uAbPuuOOk6OTcuLAu
cgHKeOA0ibjwKx1mmkQFcjVh7XJ3mHYU0CIqV7Z3zps4EkYXRn7Y/ol+b5CKaFyz
qMpGJ+VyXOliO8waj432T4QJJr9Vntbh2b5iXn9vxQz3sBjf7NimKy1CDKPsFes=
=Oo5F
-----END PGP SIGNATURE-----

--krS20hbobmkgOnx1uRgo5RTKMLdnSnmDQ--
