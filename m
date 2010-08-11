From: Eric Blake <eblake@redhat.com>
Subject: Re: How to inherent non-zero exit status using pipe? (dash)
Date: Wed, 11 Aug 2010 07:51:45 -0600
Message-ID: <4C62AAF1.4060103@redhat.com>
References: <AANLkTimi+MdwWVLceKdNgjCaK5B=dm_+raH++Owdh_QS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig6AEBB51C1794A228A31C1837"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13316 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab0HKNwt (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Aug 2010 09:52:49 -0400
In-Reply-To: <AANLkTimi+MdwWVLceKdNgjCaK5B=dm_+raH++Owdh_QS@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Peng Yu <pengyu.ut@gmail.com>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6AEBB51C1794A228A31C1837
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/11/2010 06:34 AM, Peng Yu wrote:
> Hi,
>=20
> The following example returns the exit status of the last command in a
> pipe. I'm wondering if there is a way to inherent non-zero exit status
> using pipe. That is, if there is any command in a pipe that return a
> non-zero status, I'd like the whole pipe return a non-zero status.

Generally not possible using only POSIX constructs (bash's 'set -o
pipefail' and '${PIPESTATUS[@]}' are extensions).  But what you _can_ do
is play with exec to be able to propagate non-zero status from a
particular portion of a pipeline through a temporary variable or file:

$ exec 3>&1 # duplicate original stdout
$ result=3D$(
  exec 4>&1 >&3 3>&- # move cmd subst stdout, and restore original
  { ./main.sh; echo $? >&4 # run command, and record its status
  } | head -n 3)
$ echo $? # status from head
$ echo $result # status from ./main.sh
$ exec 3>&-

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig6AEBB51C1794A228A31C1837
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Red Hat - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJMYqrxAAoJEKeha0olJ0NqR5AH/2z7AJFeiLKLoK06CxxyTYtu
3+HCCJW2oElc+DCmMftDWxGSIQ1l7/BCLRHfFc/DNhzctigBnEY0EiU4ayoDmTRJ
nX+y6j8MIWKlrDY0qxjqOXLC4Cy/qqNCaWjr7r5Bfk+XZ1BKTmJX7JFsBV3HEzKD
iYcGbh3Ixvsu06xDn7STpqezbVf9CTsY8OYrjU3ntI4DhUyXJEFb8tz26ysOLNIM
sYacOLEAIWwYk3c4NnML9yHi5MXFylMsUkOM72ju+C8F19lw5AdzQNXX6bqBPmFN
ajc8XGlA5mxaSbceK+2x3FYlxOLyiLrAkuYYZITjd8JFBAyuHBxMXBKGkLDylqY=
=SPRM
-----END PGP SIGNATURE-----

--------------enig6AEBB51C1794A228A31C1837--
