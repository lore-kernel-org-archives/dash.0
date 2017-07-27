From: Eric Blake <eblake@redhat.com>
Subject: Re: echo "\\1"?
Date: Thu, 27 Jul 2017 09:51:25 -0500
Message-ID: <bf53bb8a-a967-023f-a83b-c0245702c1a4@redhat.com>
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
 <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com>
 <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
 <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com>
 <CAC4gepcv49NcWqS-3jB50YrhJP8xYOhHyTFeL2TkifeJXRrQXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JXPtD0oMqvjDv7J3wCl3NvGVoBDLHn5ig"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbdG0Ov1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Jul 2017 10:51:27 -0400
In-Reply-To: <CAC4gepcv49NcWqS-3jB50YrhJP8xYOhHyTFeL2TkifeJXRrQXA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Bosco <jbosco.gg@gmail.com>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JXPtD0oMqvjDv7J3wCl3NvGVoBDLHn5ig
Content-Type: multipart/mixed; boundary="4mDxjGBoPquoVqNh3iOvj22IJqlSnk7QK";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Bosco <jbosco.gg@gmail.com>
Cc: dash@vger.kernel.org
Message-ID: <bf53bb8a-a967-023f-a83b-c0245702c1a4@redhat.com>
Subject: Re: echo "\\1"?
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
 <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com>
 <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
 <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com>
 <CAC4gepcv49NcWqS-3jB50YrhJP8xYOhHyTFeL2TkifeJXRrQXA@mail.gmail.com>
In-Reply-To: <CAC4gepcv49NcWqS-3jB50YrhJP8xYOhHyTFeL2TkifeJXRrQXA@mail.gmail.com>

--4mDxjGBoPquoVqNh3iOvj22IJqlSnk7QK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 09:44 AM, Bosco wrote:
> I don't have any problem, I only show you one case where I had to fix
> an script in order to work a compilation in dash.
>=20
> I'm using dash because of simplicity, unfortunately I don't understand
> how things work.
>=20
> I think the problem is of dash, I only want to report that dash fails
> at parse scape sequence.
> For instance, the command
>=20
>   echo \\\\
>=20
> prints
>=20
>   \

Correct, per POSIX.  Incorrect, for portable code (since not all echo
implementations obey POSIX; many require to type

echo -e \\\\

to get single output, but -e is not POSIX).

>=20
> I think it should print
> \\

Wrong per POSIX, but it matches what you get on bash if you don't turn
on 'shopt -s xpg_echo' and 'set -o posix' simultaneously (yes, bash has
two separate knobs that BOTH have to be on to get POSIX behavior).

>=20
> I don't have to decided how dash should understand things because it
> isn't my project. I only advise of a bad behavior, of course from my
> point of view.

The bad behavior is not in dash, but in your non-portable use of echo
with a \ in the argument.  Use printf instead, if you want your script
to work in more than one shell.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4mDxjGBoPquoVqNh3iOvj22IJqlSnk7QK--

--JXPtD0oMqvjDv7J3wCl3NvGVoBDLHn5ig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll5/e0ACgkQp6FrSiUn
Q2qURQgAoXqFp+syrmKy7YJBcTu0z4kJjgZVMX2gu18QoGOZ7aDs3cIajBjouPeB
TwVt06QfrabCwvr8Rjs6Cv22brD8TTcMuJdHF8oCORON43u6asJ7jqYuyVNN+5zW
cQ2sOq9DyP71ZINpBQTnqJsnyvzSMf+cxdvlcT4mQwxOmBMso6hLd3aDbvsWKOaU
uXt+C+yHfq6TCeRjAWkR8Wmsib0DlGWqbm1Sk2KZyEPiSFtnR5M/2HXngqHILyXK
j9DpPfHlfdK8063wQ+i6RE23Fd/ixJ9O8d0Ww6W6UOQZjgn1TDCrQZ8q/Q0WZBJa
6x5FRrZVbNev7KJnrDU9nUnbQJ2a6Q==
=lYpn
-----END PGP SIGNATURE-----

--JXPtD0oMqvjDv7J3wCl3NvGVoBDLHn5ig--
