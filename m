From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH dash] [BUILTIN] ensure LC_COLLATE is not overriden
Date: Tue, 05 Aug 2014 11:14:53 -0600
Message-ID: <53E1110D.7050309@redhat.com>
References: <1407256813-30944-1-git-send-email-chema@google.com>	<53E10FBA.5070905@redhat.com> <CA+ZOOTOU31MTtLm13J2hiCmwMWMPPrvx6zjqZ_NQahjU31SqpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gDx4LhxSUlMdxM8ahPcJVGjFbGe3kCSvW"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4299 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755189AbaHERPP (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 5 Aug 2014 13:15:15 -0400
In-Reply-To: <CA+ZOOTOU31MTtLm13J2hiCmwMWMPPrvx6zjqZ_NQahjU31SqpA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Chema Gonzalez <chema@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gDx4LhxSUlMdxM8ahPcJVGjFbGe3kCSvW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/05/2014 11:12 AM, Chema Gonzalez wrote:
>> Setting LC_ALL=3D to the empty string risks implementation-defined
>> behavior.  Also, LC_ALL overrides LANG and LC_COLLATE.  It should be
>> sufficient to merely do:
>>
>>         }}' $temp | LC_ALL=3DC sort -k 1,1 | tee $temp2 | awk '{
>=20
> Maybe:
>     }}' $temp | LC_ALL=3DC LANG=3DC sort -k 1,1 | tee $temp2 | awk '{

No need to specify LANG=3DC when LC_ALL is set.  I stand by my shorter li=
ne.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gDx4LhxSUlMdxM8ahPcJVGjFbGe3kCSvW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJT4RENAAoJEKeha0olJ0NqHvQH/j8HviCv0+gqx0GATPFsBsQL
P9j+mONt1plQzKjbaKqL68q3xHWX+ADU0G2riF8L2J6QFVabJ1H/WoMajKrJNWYd
o1nW0DvV8XcvZz3W23dWKX584lOuGRUF+PEsdKwjYw+18bgcaX6wu3RJZEsqSccp
Ys5GtAEcvWFekh+TiJAhDAS2P4hlO7A13cvIvx5rNER4iPsdvHui9SwsCkY/T11e
+oe7rZcMG50zXrEvF58Tf3I1kQGDCyEJaabPVXdCVyZIbatV/ykaUZ2w3lGe/2mm
wgHmkuKUZeY49BzjhJz4qLuaPRzIWiNcwN7gOP8rcN3xlNiKBvCTttjQViIVrN8=
=Jhgg
-----END PGP SIGNATURE-----

--gDx4LhxSUlMdxM8ahPcJVGjFbGe3kCSvW--
