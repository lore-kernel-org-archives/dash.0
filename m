From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] Fix variable assignments in function invocations
Date: Fri, 09 Jan 2015 10:39:14 -0700
Message-ID: <54B01242.9000907@redhat.com>
References: <54B00D36.7070707@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="N36h1jejnH7SrIijXu530sU8VAkqT8iIp"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49537 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbbAIRkY (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 9 Jan 2015 12:40:24 -0500
In-Reply-To: <54B00D36.7070707@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>, dash <dash@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N36h1jejnH7SrIijXu530sU8VAkqT8iIp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2015 10:17 AM, Harald van Dijk wrote:
> Hello all,
>=20
> A long-standing problem with dash has been how it deals with variable
> assignments in function invocations, and several packages are affected
> by it, two I've come across recently being autogen and pkg-config (only=

> their test suites, luckily).
>=20
> A short test script:
>=20
>   f() {
>     echo inside f, VAR is $VAR
>     sh -c 'echo inside sh called from f, VAR is $VAR'
>   }
>=20
>   VAR=3Dvalue f

This behavior is tricky.  Here's the latest POSIX wording:
http://austingroupbugs.net/view.php?id=3D654#c1559

      * If the command name is a function that is not a standard
        utility implemented as a function, variable assignments shall
        affect the current execution environment during the execution
        of the function. It is unspecified:

          - Whether or not the variable assignments persist
            after the completion of the function

          - Whether or not the variables gain the export
            attribute during the execution of the function

          - Whether or not export attributes gained as a result of the
            variable assignments persist after the completion of
            the function (if variable assignments persist after the
            completion of the function)

So the existing dash behavior is compliant, even if different from bash.

>=20
> Quoting SUSv4 Shell Command Language 2.9.1 Simple Commands:
>=20
>   If no command name results, variable assignments shall affect the
>   current execution environment. Otherwise, the variable assignments
>   shall be exported for the execution environment of the command and
>   shall not affect the current execution environment (except for
>   special built-ins).

This is the text that was rendered obsolete by the above POSIX bug 654.

> Fixing this seems trivial, see the attachment, and the test suites of
> both autogen and pkg-config pass with this change. Does this look corre=
ct?

I have no opinion on whether to take the patch in order to behave more
like bash, or whether to tell script-writers to fix their script to
avoid unspecified behavior because dash is already compliant in
providing a different behavior than bash.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--N36h1jejnH7SrIijXu530sU8VAkqT8iIp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJUsBJCAAoJEKeha0olJ0Nq9gcH/RLxkidHgJf32cDprsxM2f5f
nr1x1H67etjprMHtrxaRGxP3jZ0Rff+Y3CVNrtTewbO77rG6g4JK2j/0iB/+ig7t
H3pRSIalWuu/65pe93Jwo3N2uthin58ppN4CYtMNYAP2OzxnXd1Z0kDzZeCfONuP
GXBpg7HfXT0ZRoPImg2eZRl/XLGWtZ5eysmWI7KLGNdt7rOrXD3l9QUNttzwDYyi
lEjRiEXj7lZ1ehOJstG09yWGQKup8Ea/G5NBc2tcd2mp6uoLV6TYz7Db6NIA3guw
twESPTTqxyLVOYbJhRhGqTWOv/h7cjMU+K1jwMw2ejyvZQozm3w+d35WfKpQ3b0=
=ETHn
-----END PGP SIGNATURE-----

--N36h1jejnH7SrIijXu530sU8VAkqT8iIp--
