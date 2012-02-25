From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] var.c: check for valid variable name before printing
 in "export -p"
Date: Sat, 25 Feb 2012 07:53:24 -0700
Message-ID: <4F48F5E4.2010109@redhat.com>
References: <1329216528-8462-1-git-send-email-harald@redhat.com> <20120225073636.GA19041@gondor.apana.org.au> <20120225143004.GA8575@stack.nl> <20120225143155.GA31891@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigC5CDA84E7C55BC92DD9081C5"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22350 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756699Ab2BYOxd (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 25 Feb 2012 09:53:33 -0500
In-Reply-To: <20120225143155.GA31891@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.hengli.com.au>
Cc: Jilles Tjoelker <jilles@stack.nl>, harald@redhat.com, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5CDA84E7C55BC92DD9081C5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/25/2012 07:31 AM, Herbert Xu wrote:
> On Sat, Feb 25, 2012 at 03:30:04PM +0100, Jilles Tjoelker wrote:
>>
>> Most shells pass the environment variable through, such as bash, zsh,
>> ksh93 and most ash derivatives. However, the original Bourne shell and=

>> pdksh/mksh do not.
>=20
> Do you know of any genuine uses of such environment variables?

POSIX states that applications must not rely on such pass-through:
http://austingroupbugs.net/view.php?id=3D168

So while it might indeed be useful to pass through invalid names, such
an application is broken for expecting it to work, and I'm okay with
this patch as-is.

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enigC5CDA84E7C55BC92DD9081C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJPSPXlAAoJEKeha0olJ0NqH40H/2hU45smoP7xworI31PleICe
hiAOkJH1Yu1VZ06vsp15n1wHQ5dOJb7fuNry6KZ5XrHmZdoI2lm3A6WzHfwLdBoc
APkAvutEJ8rmnE1UNynkmLXg8DNQkmSeav0wS0x3cuoXmdBM+xQ8h4FZt7vtp+w2
K41ibdTZddtlVpn2r57BR9unm7ktDl8dQqZRfrZyKe1DDFRWp0IZAlOAbNwJX16C
vbTRJgD/hpAzuP/6aeTwgUIQWA8RiAXAYl2pUov8HGX8zI9tBSrdfZ9UjpGEU5jq
dU5QB5aU9fSEE3FPgPFvE0ttm/AWcOs5sGAqUz0EGfyz4qr4l7LLGmiEcHOUhVs=
=ma5s
-----END PGP SIGNATURE-----

--------------enigC5CDA84E7C55BC92DD9081C5--
