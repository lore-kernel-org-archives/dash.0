From: Eric Blake <eblake@redhat.com>
Subject: Re: "if [ s1 > s2 ]" broken, writing a s2 file
Date: Mon, 08 Dec 2014 10:39:41 -0700
Message-ID: <5485E25D.9080100@redhat.com>
References: <CAE4vF2dip455tXT4K3XwJy1Pp_qrw0fupd3xoAKUgbCG7vcFzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VBhGBbPlkNaxkjNcchnMfU4ODRWebIN3X"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44043 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbaLHRjp (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Dec 2014 12:39:45 -0500
In-Reply-To: <CAE4vF2dip455tXT4K3XwJy1Pp_qrw0fupd3xoAKUgbCG7vcFzg@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: solsTiCe d'Hiver <solstice.dhiver@gmail.com>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VBhGBbPlkNaxkjNcchnMfU4ODRWebIN3X
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2014 10:32 AM, solsTiCe d'Hiver wrote:
> hello,
> folowing that bug
> https://bugs.launchpad.net/ubuntu/+source/update-notifier/+bug/1400357,=

> I follow through to investigate and I found out
> that whatever I try, when comparing 2 strings I always end up with a
> file written to disk
>=20
>>From the man page
> test expression
>      [ expression ]
> [...]
> s1 > s2       True if string s1 comes after s2 based on the ASCII
> value of their characters.

You HAVE to escape the > so that it is interpreted as an argument and
not a redirection operator.  The bug is not in dash, but in your usage.

>=20
> when I try to use it:
> a=3D"ert"
> b=3D"aze"
> if [ $a > $b ] ; then

Wrong.  Use:

if [ "$a" ">" "$b" ]; then


>=20
> so this "if syntax" is broken or I don't knwo how to use it.

The latter.

>=20
> Also it is really dangerous  to use a syntax similar to file
> redirection and this is exactly what is happening here.

POSIX is proposing the addition of the shell builtin [[ ]], where
because it is a syntactical part of the shell, it would have safe
semantics (that is, [[ $a > $b ]] would be perfectly safe and do the
right thing). But until the POSIX standardization is complete, dash does
not implement [[; and as long as only '[' is portable (with its
unfortunate but historically-mandated semantics of operating as if it
were NOT a builtin, in that shell parsing happens before test sees its
arguments), then you have to quote anything that might otherwise be
misinterpreted during parsing.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VBhGBbPlkNaxkjNcchnMfU4ODRWebIN3X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJUheJdAAoJEKeha0olJ0NqCBgH/3y4DwGJnDTJgkWEZ8tAmJzh
W/gOPdAVQ01IQWVgMeVIFEfftekQmU4LcOnf5vBE3xKSpfss8jf4iZthzlpqiBLS
XavBqPbHylO0oozSlpalJAqoOQPQLg+Anw32Lq90ARfWmLekmdUHncjWOhici8LM
l/0T4Rxq6kgEkdNtzqHyG8acA6fyiQ8K3v8PeaxEHBlq7jPt/HD1eWAbInwG7h6N
ayd0QZPIbZ8F4eZ1Xs7HMIFYLXPTTwZMN6tzFJCV7n1YQJrzRKvWsDPgyX76TDDH
l0PferFx7IJQbHa274LqjaUJmWUtZou8R+PSKRvTA9cGpzFbCdXfb4+p3ZhNdHk=
=5eim
-----END PGP SIGNATURE-----

--VBhGBbPlkNaxkjNcchnMfU4ODRWebIN3X--
