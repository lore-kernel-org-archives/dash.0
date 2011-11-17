From: Eric Blake <eblake@redhat.com>
Subject: Re: Dashhh
Date: Thu, 17 Nov 2011 10:56:10 -0700
Message-ID: <4EC54ABA.6050607@redhat.com>
References: <4EC53397.2030005@am-anger-1.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig22F9619CB3103078CC77BE7F"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17994 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847Ab1KQR4O (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 17 Nov 2011 12:56:14 -0500
In-Reply-To: <4EC53397.2030005@am-anger-1.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Heiko Gerstung <heiko@am-anger-1.de>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig22F9619CB3103078CC77BE7F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2011 09:17 AM, Heiko Gerstung wrote:
> What this tiny patch does:
> - shift does not return a critical error when no arguments are left, it=
 simply does nothing

This came up in the Austin Group (the folks in charge of POSIX), and the
consensus there was that dash is compliant (POSIX says that the problem
is with the script, not the shell, if you call shift with too few
positional parameters set; and that you should rewrite your script to
avoid tickling unspecified behavior).

http://austingroupbugs.net/view.php?id=3D459

> - "[[" works exactly as "["

Wrong.  [[ is NOT exactly like [.  And the Austin Group is currently
considering a proposal to add [[ to the shell (if that is done, then
dash will HAVE to implement it as specified by POSIX; but the jury's
still out on whether the proposal will be accepted):

http://austingroupbugs.net/view.php?id=3D375

> - "=3D=3D" works like "=3D"

That same Austin Group proposal is also talking about adding [ a =3D=3D b=
 ];
this particular addition is much less controversial than the [[
addition, so it is likely that the proposal will be split and each
separate addition individually balloted for inclusion.

> - the variable FUNCNAME contains the name of the currently running shel=
l function or nothing (when not inside a function)

That's fluff - POSIX doesn't speak either way, and dash prefers to be as
light as possible when POSIX doesn't require it, so I'm not sure if
you'll get any enthusiastic response on this front.

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enig22F9619CB3103078CC77BE7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJOxUq6AAoJEKeha0olJ0Nq0ssIAJ1OMUplnQheD1mFXvEy9QMN
Zl1BNEnlbnFRstJ0xzs9y0fDpRTAPBshTeW3bXKlrQUDgPeQHU3a5OrwkuLdHIUG
xSz37y/gDpNzeBormw1Rh+VB/QIptW+IFGWgrp8mOGZZIA6AD+ukXfwMLVrXUkJd
1p2acZbz9tqkaFGya8AtKuIYYJhH1F3vpK4kqjKqiiUaFyy7Ci9fWEv6BBcY5Tc5
ynKuewew/YfPfLZ3fCEbkmaW5ZEp0qno7YOSj20ERlR0bpYo1BItLdWDZxnpbdj+
X7KYk25x+7W4c6KjsTQGg0h8xcOI/WIR4Cu81z1LK0WPciRp47H0Vg6uaBEHbZg=
=yAf9
-----END PGP SIGNATURE-----

--------------enig22F9619CB3103078CC77BE7F--
