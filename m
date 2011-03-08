From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] Allow == as synonym for = in test
Date: Mon, 07 Mar 2011 17:03:11 -0700
Message-ID: <4D75723F.3030207@redhat.com>
References: <E1PwMwp-0001iy-B5@fenris.runbox.com> <20110306234845.GC18385@elie> <E1PwOzt-0007C2-Qw@fenris.runbox.com> <20110307103457.GA5987@wopr.local.invalid> <E1Pwbqm-00056z-0V@garm.runbox.com> <20110307220048.GE15732@elie> <E1PwjSv-0004ZG-3B@fenris.runbox.com> <20110308000557.GC5987@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigECC49B07BE6D4964A9A89A88"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56305 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756800Ab1CHADQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 7 Mar 2011 19:03:16 -0500
In-Reply-To: <20110308000557.GC5987@wopr.local.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "David A. Wheeler" <dwheeler@dwheeler.com>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigECC49B07BE6D4964A9A89A88
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/07/2011 05:05 PM, Guido Berhoerster wrote:
> * David A. Wheeler <dwheeler@dwheeler.com> [2011-03-08 00:03]:
>> Dan Muresan:
>>> ...the crusade against "bashisms" has broken so many scripts and wast=
ed so
>>> many man-hours for Debian / Ubuntu users.
>=20
> The hard work of many Debian maintainers fixing broken shell
> scripts and pushing these changes upstream is certainly not
> wasted time but a great service to other platforms as well by
> improving portability. If you want bash or ksh scripts to work
> why do you use dash?
>=20
>> Right.  Many existing scripts depend on "=3D=3D", not "=3D", and its i=
mplementation is trivial.
>=20
> That is a very weak argument as it applies to many such features,
> the question is whether to create precendent here and where that'll
> go.

Personally, I _don't_ want to see this in dash _until_ the Austin Group
makes their ruling on the pending discussion item of whether the next
version of POSIX will be requiring support for '=3D=3D'.  But if the Aust=
in
Group ultimately requires it, then we've proven that it's very easy to
add to dash at that time.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigECC49B07BE6D4964A9A89A88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNdXI/AAoJEKeha0olJ0Nqr8gH/3qAK0QZmZjJqhnqRyY5HefI
eR6b/Z9pKQsDKvoZ30ymC4hVDqGMvU5Pji7FmOSjy289XZ89L3XwEcCA79IVMpSc
YYndpvIEdebSFk0owsKQpvIuxEO2WS9O8tQMYSoDfXO2o2tUdvH4aKE+YYsUq7hI
OgZerQfTOWGKApxy4dJB76DTFBaMHu9v3lFXoV5gua2HcdGjaVDXqe3yflxAwMdO
+ZIaZkiH1p1GGka1ZihldhrcsaWEtVGW3I3fLhAZWmSWhdGHxB9ku8ovAzq9jcEO
tBP+JEFV6A+6NfqCa5GRKkC3mbgqVDFIoGRUqXdnlpbP6eYwjQiRiTvxMmxHl2g=
=6jxf
-----END PGP SIGNATURE-----

--------------enigECC49B07BE6D4964A9A89A88--
