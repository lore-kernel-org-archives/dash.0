From: Eric Blake <eblake@redhat.com>
Subject: Re: echo "\\1"?
Date: Thu, 27 Jul 2017 07:54:23 -0500
Message-ID: <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com>
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M5VXtlIpL9APvO4GuMGGCCje7I23NQfM2"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbdG0MyY (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Jul 2017 08:54:24 -0400
In-Reply-To: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Bosco <jbosco.gg@gmail.com>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M5VXtlIpL9APvO4GuMGGCCje7I23NQfM2
Content-Type: multipart/mixed; boundary="8PrMh2xdl4aqbKWvfxL3ea6XkeIVjHKBr";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Bosco <jbosco.gg@gmail.com>, dash@vger.kernel.org
Message-ID: <7253a908-22d2-03e3-5493-418ca31e5590@redhat.com>
Subject: Re: echo "\\1"?
References: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
In-Reply-To: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>

--8PrMh2xdl4aqbKWvfxL3ea6XkeIVjHKBr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 07:23 AM, Bosco wrote:
> According the man pages,

Which man pages?  Echo is one of those programs that varies widely, and
you are MUCH better off using printf(1) instead of echo(1) if you are
trying to get newline suppression, trying to print something that might
begin with -, or trying to print something that might contain \.

> for echo command, "\\" should print '\'
> character, and \0digits should print the byte in octal base.
> But the command
>=20
> echo "\\1"

This is the same as
echo '\1'

which is NOT defined by POSIX as being a valid escape sequence that echo
must recognize.

(Did you mean to test
echo '\\1'
instead?)

Here's the POSIX list of required escape sequences:

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html

>=20
> outputs the byte 0x01 in hexadecimal (or 001 in octal).
> Is this a bad behavior or is intentional?

Arguably, since it is not required by POSIX, we don't have to do it. But
I also can't argue that POSIX forbids us to support \1 as an extension
(it says nothing about whether implementations can have additional
escape sequences).  So I'll argue that it is intentional as a dash
extension.  But if you can make dash smaller by getting rid of the
extension, that might be an acceptable patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8PrMh2xdl4aqbKWvfxL3ea6XkeIVjHKBr--

--M5VXtlIpL9APvO4GuMGGCCje7I23NQfM2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll54n8ACgkQp6FrSiUn
Q2q/lggApSmOeCunrP+z/lDk6Lj2+WdEUssobVT/nJoxeYm70P0j4d3EUnFsjo+9
5lf/Xj6kYpah169G6LY8H5B27zS34iqX6ikASDjT5wuYJCbPM43w0Pn0Sj1N0NJd
Pe40SShuYKA1FXm/SnNzEcn/sbjpQLGNWY3irqEFoCD5EoZE5YV+bam9wlXiOx7g
XGjqe2AFCOAC4YsxXWpFyqQrfVojw7k0raJnOmcsJtyYIuXsAc3yd+OBwEm/2kAg
MvdQE5f3AW9UApWHnlLbyPUslNeG0NecSxUB3gGk8TR/5R1C8Tl9mgfTdQKKgqSl
3fxKGI53nkfpAjhxHa4x9sH3N1thwg==
=o9Pt
-----END PGP SIGNATURE-----

--M5VXtlIpL9APvO4GuMGGCCje7I23NQfM2--
