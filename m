From: Eric Blake <eblake@redhat.com>
Subject: Re: dash drops exported bash functions
Date: Wed, 10 Feb 2016 08:54:40 -0700
Message-ID: <56BB5D40.4070401@redhat.com>
References: <1455117533.18345.59.camel@joachim-breitner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eCcwuINRxdROXdMWGoRRlW06XD67g5dPq"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbcBJPyl (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Feb 2016 10:54:41 -0500
In-Reply-To: <1455117533.18345.59.camel@joachim-breitner.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Joachim Breitner <mail@joachim-breitner.de>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eCcwuINRxdROXdMWGoRRlW06XD67g5dPq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/10/2016 08:18 AM, Joachim Breitner wrote:
> Dear dash developers,
>=20
> a change in 0.5.8, very likely this one
> http://git.kernel.org/cgit/utils/dash/dash.git/commit/?id=3D46d3c1a614f=
11f0d40a7e73376359618ff07abcd
> broke the exporting of bash shell functions via the environment.

Not a bug. POSIX says that on shell startup, the behavior of any
inherited environment variables that do not start with a proper shell
name is undefined; and allows shells to scrub such items out of the
environment on startup.  Just because bash does not scrub them (but
instead treats them as shell function imports) does not mean dash has to
behave the same.

That said, preserving any unusable environment variables unchanged,
rather than scrubbing them, may be slightly nicer behavior, but I'm not
sure it's worth the bloat to dash to do so.

>=20
> Exporting bash functions via the environment might be a rarely used
> feature, but it is used in practice, unfortunately (otherwise I
> wouldn=E2=80=99t have noticed this).

Exporting bash functions is only usable if you plan on directly invoking
bash.  Don't drag dash into the mess.  Inserting a dash child in between
a bash parent and grandchild means all bets are off for whether the
grandparent can export anything to the grandchild.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eCcwuINRxdROXdMWGoRRlW06XD67g5dPq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWu11AAAoJEKeha0olJ0NqLvQH/01iSML6NnYoSz78er05vuH0
8lish/mHPiRjlWyPU80Ag7C68iK94wW2f3obc+wNlj8neHMo3NYjaAe/bwJfJ3bK
4uxmkIKRNO/kW7d1lzIAIrybF6O2wb0r9PezCAoLwCMnf+iM5tb/wKifopwY7i3Q
HcbGdSskVZRuPWXEZ7ByYszSwk6SifSNFCGf9rygNbv+SEpxwRl/T3W1dSfR5dYH
NU2TDegYNtHRi0XtZy13cjxD4TnOR87TdKnE+o2RiRxyILy0OER+1n3fWm9Ujh2M
QInMp8OOfM0USqnQiSUP2G7nKziW22k3k2NkUm03zyZWTU3XxjspWy0c8ia/KeM=
=V0Bm
-----END PGP SIGNATURE-----

--eCcwuINRxdROXdMWGoRRlW06XD67g5dPq--
