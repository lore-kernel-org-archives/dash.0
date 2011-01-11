From: Eric Blake <eblake@redhat.com>
Subject: Re: setvar MIA?
Date: Tue, 11 Jan 2011 09:10:54 -0700
Message-ID: <4D2C810E.4070707@redhat.com>
References: <4D2C7D44.1060904@phat.za.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig38CE1E16B666556A221D0FF7"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29680 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756163Ab1AKQLC (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Jan 2011 11:11:02 -0500
In-Reply-To: <4D2C7D44.1060904@phat.za.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Aragon Gouveia <aragon@phat.za.net>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig38CE1E16B666556A221D0FF7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/11/2011 08:54 AM, Aragon Gouveia wrote:
> Hi,
>=20
> I'm working on making a number of shell scripts cross compatible betwee=
n
> FreeBSD and Linux, but one thorn in my side has been dash's lack of a
> setvar builtin.  Does anyone know if this is a work in progress, or a
> decidedly void feature in dash?

Decidedly missing.  POSIX doesn't require it.  Neither bash nor ksh
provides setvar as a builtin, either.  And what does setvar do anyways?
 Perhaps it is some alias or shell function that you have inherited from
startup files in one of your other shells, but I've never heard of a
'setvar' program.  So why bloat dash to include it?

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig38CE1E16B666556A221D0FF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNLIEOAAoJEKeha0olJ0NqcHwH+gJ3yKz2J5qrO+/+mPR7seic
PC0iJ7QPtwGmzYtB77kNytjnU1xBGtENkyUdOhdr/ZrCbYtrf5mEI5eqMuqjFh4/
YU7jCgUCQGzSZJGcFKFhiK9OL5b7/sEyCjSPtoGIdbzlGJIYB9WLWC4AFkeN8R2n
dOR7Vx9JPeR7vbSxi9uYFQlblFDTXfzrqpOogOSjL2SJtiO19obixJxk+cr7vifx
bR4qnDOb3IZC78v4pDMVL2/4SJQJqah2SRGEsDUSVh81lb17p5LyzODgb5YI7n/h
qrxyjUybpgx/4G7iokrFk5B9SvdXTVmLI6hKJnXuWS3+jsVm8zBx/+cimVe9vj0=
=eksO
-----END PGP SIGNATURE-----

--------------enig38CE1E16B666556A221D0FF7--
