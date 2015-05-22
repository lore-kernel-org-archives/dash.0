From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] Set LC_ALL instead LC_COLLATE in mkbuiltins
Date: Fri, 22 May 2015 07:02:57 -0600
Message-ID: <555F2901.1080108@redhat.com>
References: <20150522042531.GA30829@gondor.apana.org.au> <555EB333.6000201@redhat.com> <20150522044515.GA32740@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1lERMmRw74WRbSPcAqG52vNv7Bw5VBlB9"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51758 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbbEVNDN (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 May 2015 09:03:13 -0400
In-Reply-To: <20150522044515.GA32740@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Fredrik Fornwall <fredrik@fornwall.net>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1lERMmRw74WRbSPcAqG52vNv7Bw5VBlB9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/21/2015 10:45 PM, Herbert Xu wrote:
>> Setting LC_ALL has the nice property that LC_COLLATE and LC_CTYPE are
>> guaranteed to be compatible; if you just set LC_COLLATE but leave
>> LC_CTYPE unchanged and unset LC_ALL, it is possible to attempt a
>> collation that assumes one character set while still living in a ctype=

>> that assumes another, and get garbled results.
>=20
> Show me an actual pair of values for these two that produce
> incorrect results for mkbuiltins and I'll happily change both.

'sort -b' uses isspace() to determine which characters to strip.  There
are locales with a larger set of characters where isspace() returns true
than for the LC_CTYPE=3DC locale.  Suppose that I can find a single-byte
locale where isblank('\xff') is true.  If that is the case, then the
input '\xffa\nb\n' will sort differently for 'LC_ALL=3DC sort -b' (output=

'b\n'\xffa\n') than for 'LANG=3DC LC_CTYPE=3D$locale' (output '\xffa\nb\n=
')
because the change in CTYPE changes whether the \xff is ignored as a
blank or included as part of the name being sorted.

However, the man pages for 'locale(1)' and 'localedef(1)' did not make
it obvious for me how to perform a search that would easily find such a
locale, so I'm open to suggestions on how to prove my point via more
than just analysis.

And there's still the point that mkbuiltins is being run on controlled
input, where you are sticking only to a subset of characters that happen
to be portable (that is, you are unlikely to be tripped up by a locale
where \xff is a blank, since you are not using \xff in your input).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1lERMmRw74WRbSPcAqG52vNv7Bw5VBlB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJVXykBAAoJEKeha0olJ0Nqr20H/R7ksPpwYL4G2RkIlZ4O6fUf
JoPjy+cWO6ZvmhK5oKwpmM09fGqW/I8FnH3Fkyi7+WA/qtAxuba0b3UhCF0QBYcD
kFYB9WTMfaKgShAk+XjpmWNNx2LrEQnrNF4xjkBVDUnGgTC4ouGfEuhz77IBLTfv
Lt1vDYN+uoJ//B9u9MMh80fRMHJZWZ6HflDsodKlHbmNG8O16X89Fn6zNU1GI2Jl
QA+6dNHuuE8lBQVuMgAC3UOJFBG7U6utwLfiDZNH3zV11ujSvFp9D+pvOhn/A2yu
xJmkWwswwZWXwfdGdvDyaD4Q59inp5WyNa+uRnP0k8YV2aQdPx7b4YOLGVuv6G8=
=pYH+
-----END PGP SIGNATURE-----

--1lERMmRw74WRbSPcAqG52vNv7Bw5VBlB9--
