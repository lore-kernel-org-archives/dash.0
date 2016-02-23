From: Eric Blake <eblake@redhat.com>
Subject: Re: [BUG] Illegal function names are accepted after being used as
 aliases
Date: Tue, 23 Feb 2016 14:49:43 -0700
Message-ID: <56CCD3F7.3070802@redhat.com>
References: <56CCA25E.5020809@openmailbox.org> <56CCA879.1070208@gigawatt.nl>
 <56CCABD6.40001@redhat.com> <56CCB121.60808@gigawatt.nl>
 <56CCB3F7.8090301@redhat.com> <56CCC868.8040900@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9gdaxIvLKT4ioEwrBbCea6AUL5XBNDI9C"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55199 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461AbcBWVto (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Feb 2016 16:49:44 -0500
In-Reply-To: <56CCC868.8040900@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>, Jan Verbeek <ring@openmailbox.org>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9gdaxIvLKT4ioEwrBbCea6AUL5XBNDI9C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2016 02:00 PM, Harald van Dijk wrote:
>=20
> I was under the impression that the intent from the dash side was to
> handle all commands the same, and that impression was based on the fact=

> that the . command has received additional code to handle -- even thoug=
h
> there's no requirement for that. However, looking into the original bug=

> report that prompted that change in more detail I see that the standard=

> will very likely require support for -- in the . command in the future,=

> so that doesn't hold up.

Here's the link for dot and exec supporting --:
http://austingroupbugs.net/view.php?id=3D252

>=20
> If that intent isn't there (I'm not saying it's not; I'm unsure now),
> the list of utilities that should be extended is far smaller, if I'm no=
t
> overlooking anything:
> - alias
> - getopts
> - type
> - exec?
> - local?

Weird that unalias already works.  Oh, because of 'unalias -a'.  I
didn't spot any others that you missed (doesn't mean there aren't any,
just that I didn't spot them).

>=20
> exec is like .: there's currently no requirement to support --, but tha=
t
> requirement is likely to come in the future.

See the above link; exec must support -- if '.' does.  I also found
http://austingroupbugs.net/view.php?id=3D163 which confirms that 'eval' i=
s
not required (nor it is prevented) from recognizing --.  There's also
http://austingroupbugs.net/view.php?id=3D960 which mentioned the exit
status of export and several other special builtins, but added no
requirements related to --.

>=20
> local is currently non-standard and it's hard to guess whether it will
> require support for -- if standardised.

If standardized, I expect it to require support for --, on the grounds
that 'local -r' already has meaning in bash, so local is definitely a
candidate for taking options.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9gdaxIvLKT4ioEwrBbCea6AUL5XBNDI9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWzNP3AAoJEKeha0olJ0Nq1IUH/2v8gKBZ4h+nmHZjhNKAttPf
a99vYXj5RwN3z4vUaECaTXN115BKJrjx24x8Nz97H+9hlvI3lQ8QN5nbaASNJCaR
1WukUr5WE8E4+sNCr7PsKpawbZSkip7PxWRWsyD5M0zn5lXrCb8i/r6gHO/MNTHd
RoqBrbxkLWc0GuX0x45/oQjNAGAUsgDCPsGlxD+YvkEIc5F6d6alD8I/s/vl+m7f
CdW6XGI4PQrO5HI+SqHQ0V9HfoQXuR0OdrGeGESX3eAZrJfR7SfUw1YJAC7jNWyp
zUGZW8GcuJMFne6lLMd8lV7Xkn0y6aQmY4+2HZtCarB6fL3WWAzCbUCBTFRxYLg=
=DzrR
-----END PGP SIGNATURE-----

--9gdaxIvLKT4ioEwrBbCea6AUL5XBNDI9C--
