From: Petr Sabata <contyk@redhat.com>
Subject: Re: set -o vi
Date: Mon, 22 Aug 2011 10:45:22 +0200
Message-ID: <20110822084522.GB31885@rincewind.brq.redhat.com>
References: <9AD96B5F-3C88-4E01-9582-B75184164026@aim.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18149 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722Ab1HVIp7 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 22 Aug 2011 04:45:59 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7M8jwab007972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <dash@vger.kernel.org>; Mon, 22 Aug 2011 04:45:58 -0400
Received: from rincewind.brq.redhat.com (dhcp-25-238.brq.redhat.com [10.34.25.238])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p7M8jwtO032018
	for <dash@vger.kernel.org>; Mon, 22 Aug 2011 04:45:58 -0400
Content-Disposition: inline
In-Reply-To: <9AD96B5F-3C88-4E01-9582-B75184164026@aim.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 21, 2011 at 10:01:24AM -0600, Paul Gilmartin wrote:
> (Damn! I clicked the wrong link in the confirmation notice.
> Apologies.)
>=20
> For some time now, on both Ubuntu and Cygwin, "set -o vi"
> is ineffective.
>=20
> The command is accepted and a query indicates it's in effect:
>=20
> \! $ uname -a
> Linux Linux-Mac 2.6.38-11-generic #48-Ubuntu SMP Fri Jul 29 19:05:14 UTC =
2011 i686 i686 i386 GNU/Linux
> \! $ set -o vi
> \! $ set -o
> Current option settings
>     ...
> vi              on
> emacs           off
>     ...
>=20
> But when I press ESC to enter command history, it simply
> echoes the ESC as "^[" and calls the next command illegal:
>=20
> \! $ ^[
> dash:  not found
>=20
> Thanks,
> gil

I think this requires dash to be built with libedit support to work.
Check your packages.

Regards,
--=20
# Petr Sabata

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iF4EAREIAAYFAk5SFyIACgkQT+hZYwG3Kb4nRQD9HUOJncf8skqJ9V5gcjNPkhrM
QEiJe7DaJzPOH+siPOcA/RQXq54PUmIXIUaqSYtMMpZPTsdh5H038NJn9AQrvEHs
=rdSo
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
