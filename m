From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] Support DOS paths in dash
Date: Tue, 30 Sep 2014 16:02:42 -0600
Message-ID: <542B2882.9030400@redhat.com>
References: <announce.4A5C7A2B.4020700@byu.net>  <4B5860C9.50100@sidefx.com>  <4B591221.10501@byu.net>  <4B91105B.7050205@sidefx.com>  <20100305152637.GK7980@calimero.vinschen.de>  <4B913788.40301@sidefx.com>  <4B913AF2.3070102@redhat.com> <20100305172048.GN7980@calimero.vinschen.de> <4EDA9E99.9030307@redhat.com> <51545CD9.4050607@sidefx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tdnBWEcuf6Wjh6fvx1iheqfc2a7kj2lLH"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40866 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbaI3WCo (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 30 Sep 2014 18:02:44 -0400
In-Reply-To: <51545CD9.4050607@sidefx.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Edward Lam <edward@sidefx.com>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tdnBWEcuf6Wjh6fvx1iheqfc2a7kj2lLH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[I noticed an old thread in my inbox while packaging dash 0.5.8 for Cygwi=
n]

On 03/28/2013 09:08 AM, Edward Lam wrote [to the cygwin list]:

>> The problem is that dash tries to convert c:/windows to an absolute
>> path, since it doesn't start with /.  I suppose I could teach dash to
>> recognize [letter]:/ as absolute paths, although that makes dash large=
r,
>> and puts a burden on me (since I can guarantee upstream dash won't
>> accept such a patch).
>>
>>> I just don't care enough for DOS paths so I won't fix.
>>
>> Me neither.  And since you can use /cygdrive/c, not c:/, I won't bothe=
r
>> to fix it.
>>

> Hi Folks,
>
> I finally got down to looking at how to fix this in dash and came up
> with the attached patch (against dash-0.5.7). It's simple enough and so=

> cd now works.
>
> Please consider this for Cygwin.
>

I'm not interested in burdening the cygwin build of dash with a one-off
patch, so I'd like to gauge the upstream thoughts - is it worth
including platform-specific patches like this (no penalty to build size
of non-cygwin platforms, and on cygwin, it allows 'cd c:/' to behave as
shorthand for 'cd /cygdrive/c/')?  If the patch lands in dash.git, then
I'll rebuild the cygwin port of dash to include a backport (rather than
waiting for 0.5.9 to be released).  If there is no interest, I'd rather
just drop the patch.  The cygwin community already states that
/cygdrive/c notation is the official way to access drive letters, and
that if 'c:/' works it is nice, but it is not a design goal to always
have it work.

> --- src/cd.c	2011-03-15 03:18:06.000000000 -0400
> +++ src/cd.new.c	2013-03-28 11:03:32.649576500 -0400
> @@ -38,6 +38,9 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <limits.h>
> +#ifdef __CYGWIN__
> +#include <sys/cygwin.h>
> +#endif
> =20
>  /*
>   * The cd and pwd commands.
> @@ -194,6 +197,11 @@
>  	char *cdcomppath;
>  	const char *lim;
> =20
> +#ifdef __CYGWIN__
> +        char pathbuf[PATH_MAX + 1];
> +        cygwin_conv_to_full_posix_path (dir, pathbuf);

By the way, cygwin_conv_to_full_posix_path() is deprecated (it suffers
from possible buffer overflow); these days, it's preferred to use:

cygwin_conv_path (CCP_WIN_A_TO_POSIX | CCP_RELATIVE, string, pathbuf,
                  sizeof(pathbuf))

So, if there is interest in this patch upstream, I can respin it.

> +	 dir =3D pathbuf;
> +#endif
>  	cdcomppath =3D sstrdup(dir);
>  	STARTSTACKSTR(new);
>  	if (*dir !=3D '/') {
>=20
>=20


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--tdnBWEcuf6Wjh6fvx1iheqfc2a7kj2lLH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJUKyiCAAoJEKeha0olJ0Nql80IAKhXMKrdDVeANjJ3ZaE7PgT9
AhxT4sIku9UWbBR1hgVorBmZ79rgHoyXuTnXqPriNkCjR1Xy6+ri9MCxKzumU0Hb
F5xwEi6ZxULGP/DvjSumVAPfabcxhFk5kWcFNHk/ypoXXpdYmlKp/lilOKNq6CVO
S5CevNVAU/lCEBytaqENXcRt2xYhb87k7ALq0oFOPvahOBbL3O6vRE2/NEqG3Vax
K0Foj/CQv8pmO1sgV2IOMew4BsnAUF8ubap2wYkR+oIXGqPMcGKXktcMl5DFZs2s
ZpNOYboRppd0gSFCBDcgMwzI00MUCS70yvsm9/VP9jF2c7WxkpRs4DrQf3W0294=
=iL9S
-----END PGP SIGNATURE-----

--tdnBWEcuf6Wjh6fvx1iheqfc2a7kj2lLH--
