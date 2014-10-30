From: Eric Blake <eblake@redhat.com>
Subject: Re: POSIX compliant trap signal names
Date: Thu, 30 Oct 2014 09:26:46 -0600
Message-ID: <545258B6.7020501@redhat.com>
References: <CAN5MFOrmT4U+A+4jS_NGybFjH1uw1HGoRbpa2megL_LshsTuGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5oJq9gbeObCKkse7h36FC0uAJEdUTXhw7"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43883 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932940AbaJ3P0t (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 30 Oct 2014 11:26:49 -0400
In-Reply-To: <CAN5MFOrmT4U+A+4jS_NGybFjH1uw1HGoRbpa2megL_LshsTuGA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Sylvain Bertrand <sylvain.bertrand@gmail.com>, dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5oJq9gbeObCKkse7h36FC0uAJEdUTXhw7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/30/2014 09:23 AM, Sylvain Bertrand wrote:
> Hit the issue while compiling linux 3.16.3 with dash,
> ${linux-src}/scripts/link-vmlinux.sh line 114 .
> The signal names for trap built-in must be prefixed with SIG to be
> POSIX compliant. dash expect trap signal names without a SIG prefix.

Wrong.  Per
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#=
trap

The condition can be EXIT, 0 (equivalent to EXIT), or a signal specified
using a symbolic name, without the SIG prefix, as listed in the tables
of signal names in the <signal.h> header defined in XBD Headers; for
example, HUP, INT, QUIT, TERM. Implementations may permit names with the
SIG prefix or ignore case in signal names as an extension.

Thus, POSIX requires 'trap ... INT' to work, but says 'trap ... SIGINT'
and 'trap ... int' are up to the implementation whether they are
supported as an extension.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5oJq9gbeObCKkse7h36FC0uAJEdUTXhw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJUUli2AAoJEKeha0olJ0Nq+oMH/2MFhbMfDnXD3/d4f4oh2Tnk
0/YsBFtfEpwDKMkWhfDGGW7QabCq2+oe66WCLnxFdV2XyzNQmATTdIB0mDfbt3SJ
ZE68ryPAhoAeP0PQLbJfebD8DEdDLAl1XpF9ejXha7GGBQFqb+NQWZnEh9s7r5V+
3yVoa3G2AbgVYjAHhOkxV93NhS3+slwBcU1DGNd9rlbc2Knea5T/eGJohS6vhnZA
aiSs4yCQbesQlXQK2wg2zcOMWlj/UfPIEYfRvhRHv7NLKUU3eroNYzRZq20WnpcR
UgcBqTuHXoIajcmR27lEomvML/zulv6RjoyYaCWNM5IdNwMPy4nJcxzdUuPwxsY=
=hJo6
-----END PGP SIGNATURE-----

--5oJq9gbeObCKkse7h36FC0uAJEdUTXhw7--
