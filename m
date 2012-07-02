From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] [BUILTIN] Allow SIG* signal names.
Date: Mon, 02 Jul 2012 08:22:20 -0600
Message-ID: <4FF1AE9C.7040307@redhat.com>
References: <4ff0274f.c54fb40a.47e2.6814@mx.google.com> <4FF1A76F.6020307@redhat.com> <2D2FC58C-ACD5-4113-9A1D-C53A854C3CD7@aim.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig67EB6DB71DB07A61C9DC85E1"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22096 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161Ab2GBOW3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 2 Jul 2012 10:22:29 -0400
In-Reply-To: <2D2FC58C-ACD5-4113-9A1D-C53A854C3CD7@aim.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Paul Gilmartin <PaulGBoulder@aim.com>
Cc: dash <dash@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig67EB6DB71DB07A61C9DC85E1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/02/2012 08:11 AM, Paul Gilmartin wrote:
> On Jul 2, 2012, at 07:51, Eric Blake wrote:
>>
>> ... non-required bloat ...
>> =20
> The key phrase.  And one value of a shell lacking such
> extensions is that it provides an excellent test bed for
> code intended to be portable within the POSIX spec.

That argues that we should drop our strcasecmp() for the much simpler
strcmp(), in order to remove the bloat we already have.

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org




--------------enig67EB6DB71DB07A61C9DC85E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJP8a6cAAoJEKeha0olJ0Nqj5oIAK+A12TwQKR2fPR+OGwg0/Q+
AYCDgyCw7zj3Ix2yo2zRF0e+jvZWgp4/hzT7CT5gHH8XTmzFt9SHlncyq6kT6/ot
lDHXi5pWPPOpOLfXJkmyu5SBXnhhe5U9BOg/6zp+qyv4uOs0+orbw8nRz53Rs/Km
sJWtwGYDEt4Nu9tHvgq/FXXhN0hvTeg/p/KzF75eHulAdVVVZwCLk7MrKz8KXKCR
C5HA5OO5SYt9OKWUyWVChvFB1wKmeAfyy2hRrG9zcKI/C7uHUZudGbA72oWoFtrb
jqCFNk3k6ZxSNSUWZiY/siKtACsfnfjqpNHZRCMDo26UyS7aVjrgcmlILlVxELQ=
=Pskm
-----END PGP SIGNATURE-----

--------------enig67EB6DB71DB07A61C9DC85E1--
