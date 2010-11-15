From: Eric Blake <eblake@redhat.com>
Subject: Re: static vs. dynamic scoping
Date: Mon, 15 Nov 2010 14:45:07 -0700
Message-ID: <4CE1A9E3.6080008@redhat.com>
References: <4CD9C280.60007@redhat.com>	<4CDA6301.1010703@gmail.com>	<4CDAB6AB.5080004@redhat.com> <AANLkTinMbDZdL0LEt4Xq1SbFT_xWHoKJt9QNhw6Yk+u_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig5767CD57478EDBFA908E6397"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33402 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758442Ab0KOVpK (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 15 Nov 2010 16:45:10 -0500
In-Reply-To: <AANLkTinMbDZdL0LEt4Xq1SbFT_xWHoKJt9QNhw6Yk+u_@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Cedric Blancher <cedric.blancher@googlemail.com>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5767CD57478EDBFA908E6397
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/15/2010 02:11 PM, Cedric Blancher wrote:
>=20
> Why is the debate static-vs-dynamic scoping coming up again?

Because before 'typeset' can be standardized in POSIX, we have to get
consensus from all the shell implementers that they will agree to
implement static scoping.

For ksh, the question is moot - ksh93 already does static only.

For dash, the question is valid - the current dash implementation is
dynamic only, but given that switching to static only could probably be
made more efficient, and dash values efficiency, it's a reasonable goal.

For bash and zsh, which currently are dynamic only, the problem stems
that there are now a number of shell script libraries for these two
shells that have exploited dynamic scoping, and which would break if we
aren't careful to standardize something that can still allow dynamic
scoping as an extension.  In other words, this was a probe of the
various shell implementers to figure out how easily static scoping can
be added on after the fact to a dynamic scoping implementation, so that
the shell could conform to a future POSIX revision that mandates static
and permits dynamic as an extension.

> With this background I doubt any proposal for dynamic scoping will
> make it into the next POSIX standard.

There's no desire for dynamic scoping in POSIX; David Korn has already
made that point clear on the Austin Group mailing list.  Rather, there
is a desire for minimal effort for complying with a new POSIX
requirement of static scoping on shells that currently lack it, as well
as backwards compatibility for shells that wish to continue to provide
dynamic scoping as an extension to the standard.

My take of the Austin Group list discussion is that the next revision of
the standard is most likely to have consensus if it just mandates
'typeset' for static scoping, and leaves 'local' as an implementation
extension for dynamic scoping.  Please, chime in on the Austin Group
conversation if you have something useful to add.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig5767CD57478EDBFA908E6397
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJM4anjAAoJEKeha0olJ0Nqmy0H/0cz2cZoOeKGjEuLEJisEbEt
m+pEJZuvnFVdYwl5VttSIhyqAGCQuE4QiMdjz6x36hcSAbgPDri8KxQ37aDnz3nN
RyOWYfaaz6E9d2sSYjm2+R8gdAxGNeYPfXHL0bpFaPS+1wG+qcWyVD+hA61p1flt
r9sMXdtg61heeFHac9EU427kKc8ww9ZRmvkTvDH8GhqG1SljpuzCRTgMvztP4EC9
pCGTPAON7p9KBtKXR4CiWTRLW5nieM4UPSPkD44xtEO3JR0ITb6UPy/twwUHnka5
iz16POnqb9bSP0kG7/b2C34auJQr8NNjcaOhV7CjcXINce+hNyuSIpaOSLq0WeQ=
=xwUI
-----END PGP SIGNATURE-----

--------------enig5767CD57478EDBFA908E6397--
