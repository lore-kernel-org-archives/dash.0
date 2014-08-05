From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH dash] [BUILTIN] ensure LC_COLLATE is not overriden
Date: Tue, 05 Aug 2014 11:09:14 -0600
Message-ID: <53E10FBA.5070905@redhat.com>
References: <1407256813-30944-1-git-send-email-chema@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UnDoXjlaQ1TrMfwsKi5kSFdUuj7eafp1q"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4218 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829AbaHERJX (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 5 Aug 2014 13:09:23 -0400
In-Reply-To: <1407256813-30944-1-git-send-email-chema@google.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Chema Gonzalez <chema@google.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UnDoXjlaQ1TrMfwsKi5kSFdUuj7eafp1q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/05/2014 10:40 AM, Chema Gonzalez wrote:
> If the user environment has either LC_ALL or LANG defined, the setting
> of LC_COLLATE in src/mkbuiltins is overriden. With a non-POSIX locale,
> the orders of dotcmd (remember that '.' is 0x2e in ascii) and truecmd
> (':' is 0x3a in ascii) are reversed, which makes the ":" command fail
> in the bsearch.
>=20

> -	}}' $temp | LC_COLLATE=3DC sort -k 1,1 | tee $temp2 | awk '{
> +	}}' $temp | LC_ALL=3D LANG=3D LC_COLLATE=3DC sort -k 1,1 | tee $temp2=
 | awk '{

Setting LC_ALL=3D to the empty string risks implementation-defined
behavior.  Also, LC_ALL overrides LANG and LC_COLLATE.  It should be
sufficient to merely do:

	}}' $temp | LC_ALL=3DC sort -k 1,1 | tee $temp2 | awk '{

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UnDoXjlaQ1TrMfwsKi5kSFdUuj7eafp1q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJT4Q+6AAoJEKeha0olJ0NqwzAIAIoxpcKfdugpy4Ov/YXFTvcT
6CaLqU0QkyHDer57HXjRyaj6noWvWFTP3WzzN6TjwZn1Q5suz8GQQoyUDOQbIIdB
QmFrUEY9tAIRg2QEve5PaKD6ZFjZLIrQvZQXHLbhT2mEg4SPhOjHI4N88qAG9QmZ
G9re4K0jlGAyP7KXTkC2beUX9HqVBXIB0O76hK9F60m7QfxT3sj3XiFj+5JyaknI
iBUqiEQF+E+seHaRX2Bvx5El20cs7+N3a/ts336YsYa/TgVCxoAK/kA3E9u4MMUQ
Fj0T/wn+tjFnVXUknPCvHulaEh8Mx6LpHKYq756tZrw6FTAg755LcFQbcc5oFKo=
=J7wB
-----END PGP SIGNATURE-----

--UnDoXjlaQ1TrMfwsKi5kSFdUuj7eafp1q--
