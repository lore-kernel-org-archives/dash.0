From: Eric Blake <eblake@redhat.com>
Subject: Re: [BUG] Illegal function names are accepted after being used as
 aliases
Date: Tue, 23 Feb 2016 11:40:48 -0700
Message-ID: <56CCA7B0.5080507@redhat.com>
References: <56CCA25E.5020809@openmailbox.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uV13VAhTATK0lGJTXKJMiMs0eawOqEonM"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43704 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201AbcBWSkt (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Feb 2016 13:40:49 -0500
In-Reply-To: <56CCA25E.5020809@openmailbox.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jan Verbeek <ring@openmailbox.org>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uV13VAhTATK0lGJTXKJMiMs0eawOqEonM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2016 11:18 AM, Jan Verbeek wrote:
> Function definitions that use a bad function name (such as "-" and "=3D=
")
> are accepted if the function name already exists as an alias. For examp=
le:

Not necessarily a bug.

>=20
> $ -
> dash: 1: -: not found
> $ - () { echo hello; }
> dash: 2: Syntax error: Bad function name
> $ -
> dash: 2: -: not found
> $ alias -=3Dtrue
> $ -

This is equivalent to running 'true'.

> $ - () { echo hello; }

This is equivalent to running 'true () { echo hello; }' - the alias
expansion happens BEFORE the function definition is even parsed.  You
are NOT defining a function named '-', but one named 'true'.

> $ -

This is again equivalent to running 'true' - except that now the
function name 'true' exists and bypasses the shell builtin.

> hello
> $

So the only thing remaining is to determine if it is legal to have a
function override the name of a regular shell builtin.  But
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#=
tag_18_09_01
under "Command Search and Execution" states that function names have
priority over regular built-ins (so yes, creating a function named
'true' is doable, although stupid).


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--uV13VAhTATK0lGJTXKJMiMs0eawOqEonM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWzKewAAoJEKeha0olJ0NqjtAH/RhFVZzKdrnSmEPlsSXXRxvm
RBDp7SQn4N5r23GMKM3uRfVTUPh4yK4ugXdyUOEdeT+IqxT9KsV7zoqc87fnc7gp
Mh/f9IKiqRLeVWCMHoeg3AD/qaMYQujamZ8nfkf4jvDi3CywEN6/Od9akk4DjKJ7
9AQmolf5UblXAv9gV6pA5Giq6iNyHE0DI+vMgR4y7skoUkvlJ1ER2FYcUMw1ak89
kwVoeXEoWAQazLmud+vrfuN/EOEXA6nO3c2mBxU1HX9IK1bJrQIcOt/l3eD0uYRo
3EyPxX8JLdXwkmq0ecW+Lju5OCmMS+x5zxKBU2SDZH8vaHGEBCppsWbmCSe1QyQ=
=X446
-----END PGP SIGNATURE-----

--uV13VAhTATK0lGJTXKJMiMs0eawOqEonM--
