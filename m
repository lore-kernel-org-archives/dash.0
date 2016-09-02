From: Eric Blake <eblake@redhat.com>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Fri, 2 Sep 2016 09:48:40 -0500
Message-ID: <4c4957a9-23be-7e0f-3f23-509bb617ad55@redhat.com>
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="N9VgucBoRu2tO23NGqrrB2gKeoSjiWRHg"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754304AbcIBOsm (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 10:48:42 -0400
In-Reply-To: <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, Harald van Dijk <harald@gigawatt.nl>
Cc: olof@ethup.se, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N9VgucBoRu2tO23NGqrrB2gKeoSjiWRHg
Content-Type: multipart/mixed; boundary="pf9BTrpxJqqRBJttUAQPmTJOlXdswioWv"
From: Eric Blake <eblake@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Harald van Dijk <harald@gigawatt.nl>
Cc: olof@ethup.se, dash@vger.kernel.org
Message-ID: <4c4957a9-23be-7e0f-3f23-509bb617ad55@redhat.com>
Subject: Re: Parameter expansion, patterns and fnmatch
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
In-Reply-To: <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>

--pf9BTrpxJqqRBJttUAQPmTJOlXdswioWv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2016 09:25 AM, Eric Blake wrote:
>=20
> So while a lone '[' is unspecified in a normal BRE, it is well-defined
> in a shell filename pattern matching context.  Since '[' is not a
> bracket expression, it MUST be treated as a literal '[', so ${foo#[}
> MUST strip the leading [ from the contents of foo, without requiring
> that the [ be quoted.

Rationale: The '[' shell builtin is not undefined behavior.  This was a
specific addition made in POSIX 2008 that was not present in POSIX 2001
(although I can't easily find the bug report that justified it, since
the bugs for POSIX 2008 predate the current austingroupbugs.net database)=


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--pf9BTrpxJqqRBJttUAQPmTJOlXdswioWv--

--N9VgucBoRu2tO23NGqrrB2gKeoSjiWRHg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJXyZFIAAoJEKeha0olJ0NqYVsIAKh9gg/hV6A4AyINixGel07f
ejznmAAKWtxfxLiCmsQ/KZMQlTKzyiMZZFHLnMjWpQnwbTACeaTcoe/WvLyzd/Yc
YTuLbuXzz6UbKBrYg8MCIpqWxbu7W9OZMHJtBdQ+KRY/R9Klh+p8Uzd8iS6bBsMp
4tZhX+4aXok1aV7XEgOHFFCAfBw3yv5hHMJXvg20N2gx6EM3x8wtEE56Qfgpsr2+
zrG/G7R7Drl2j7Gv7xQqu1U8adHnxraPVFPFtSjfk11Od0BXsgKfn5m5EG0bQB8M
haHLI0ynya0xHFdL1GUzZ6oqF2tqTd94D6StJGjvnq4BrxnwonPzaM2lOOtqPO4=
=xc99
-----END PGP SIGNATURE-----

--N9VgucBoRu2tO23NGqrrB2gKeoSjiWRHg--
