From: Eric Blake <eblake@redhat.com>
Subject: Re: echo "\\1"?
Date: Thu, 27 Jul 2017 10:19:15 -0500
Message-ID: <bdcef3ab-073b-370b-011d-fc918210b568@redhat.com>
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
 <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com>
 <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
 <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com>
 <CAC4gepcv49NcWqS-3jB50YrhJP8xYOhHyTFeL2TkifeJXRrQXA@mail.gmail.com>
 <bf53bb8a-a967-023f-a83b-c0245702c1a4@redhat.com>
 <CAC4gepdMmWSdheZbfw44fn3eexJ4Wg3gSkj7pMChLNodB3UyTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="njAnv3wDh9uN5VWmcJpgIi996B6rM5uRR"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751601AbdG0PTR (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Jul 2017 11:19:17 -0400
In-Reply-To: <CAC4gepdMmWSdheZbfw44fn3eexJ4Wg3gSkj7pMChLNodB3UyTw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Bosco <jbosco.gg@gmail.com>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--njAnv3wDh9uN5VWmcJpgIi996B6rM5uRR
Content-Type: multipart/mixed; boundary="AoOCWl7PvpedPCHNmAFbAska7olUhhV5E";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Bosco <jbosco.gg@gmail.com>
Cc: dash@vger.kernel.org
Message-ID: <bdcef3ab-073b-370b-011d-fc918210b568@redhat.com>
Subject: Re: echo "\\1"?
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
 <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com>
 <CAC4gepdsPNvUJyW4Zwto9wZGc1Naq5kMsnz+RdCyAurEZzGLZw@mail.gmail.com>
 <68dddf01-263e-77bd-ffc7-8e7df386ee8f@redhat.com>
 <CAC4gepcv49NcWqS-3jB50YrhJP8xYOhHyTFeL2TkifeJXRrQXA@mail.gmail.com>
 <bf53bb8a-a967-023f-a83b-c0245702c1a4@redhat.com>
 <CAC4gepdMmWSdheZbfw44fn3eexJ4Wg3gSkj7pMChLNodB3UyTw@mail.gmail.com>
In-Reply-To: <CAC4gepdMmWSdheZbfw44fn3eexJ4Wg3gSkj7pMChLNodB3UyTw@mail.gmail.com>

--AoOCWl7PvpedPCHNmAFbAska7olUhhV5E
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 10:10 AM, Bosco wrote:
> That script of zziplib isn't mine, I only had to compile it once
> because it was necessary for compile other program (TeX Live).
>=20
> I'm not talking about POSIX, and I don't mind what it said. I'm
> talking about the man page of dash, that said:
>=20

> when \\ is reached is replaced by \.

When \\ is reached AS THE ARGUMENT to echo.

> Then, in the command
>   echo \\\\
> because \\ is reached first, then it will be replaced by '\'

No, you are demonstrating a gap in your understanding of shell quoting
rules.

echo \\\\
echo "\\\\"
echo '\\'
echo '\'"\\"

are all the same way to pass the two-character argument to echo.  That
two-character argument is a valid escape sequence, which in turn means
echo outputs a single \ character then a newline.

> character, immediately after that another \\ is reached, then it will
> be replaced by another '\' character. It turns out the ouput '\\'.

If you want two \ as output, you have to pass four characters (not two)
to echo, so your input has to be one of these (or other) valid quotings:

echo '\\\\'
echo "\\\\\\\\"
echo \\'\'"\\"\\'\'"\\"\\'\'
etc.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AoOCWl7PvpedPCHNmAFbAska7olUhhV5E--

--njAnv3wDh9uN5VWmcJpgIi996B6rM5uRR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll6BHMACgkQp6FrSiUn
Q2oAzQf9Fp7hifjIXPuF4JPmR97Jv8T2wfA2gD70WWLF85aG8XiOBgEHwi5ipEUB
7T8iCg5zRRr/K5YBdDF+s0FgtAU3YrkYPiypNpsIgMPVzwcP5FlSnBnrnc2/+6g9
lhrgL3uzfBInIxhdAbw5piXxWopp/AU1SHraF2DC8Z5kei1sA2A2MVAHG0ngsHEV
hXGfKOYO2KYAPnXPwgSzbVn8Wo0LdsQgTkLwXfnAUEijMFn7z3MdSPNezLJicNuh
JAJLaRs9LrTHK6vTk55Xdw4GDyTONxhi+Jn8Weyj4f0f5P0zhb3gSlp9p9DzwV+L
8R7DC9cyhQzNpV2UqEtmQWofulIsGA==
=DC9h
-----END PGP SIGNATURE-----

--njAnv3wDh9uN5VWmcJpgIi996B6rM5uRR--
