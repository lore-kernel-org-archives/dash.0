From: Eric Blake <eblake@redhat.com>
Subject: bug in handling of ignored traps
Date: Wed, 08 Feb 2012 10:27:29 -0700
Message-ID: <4F32B081.6090007@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigEF9996AD58C0F31FF8C941A3"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27853 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753964Ab2BHR1b (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Feb 2012 12:27:31 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q18HRUjS004495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <dash@vger.kernel.org>; Wed, 8 Feb 2012 12:27:31 -0500
Received: from [10.3.113.116] (ovpn-113-116.phx2.redhat.com [10.3.113.116])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q18HRUB5001748
	for <dash@vger.kernel.org>; Wed, 8 Feb 2012 12:27:30 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEF9996AD58C0F31FF8C941A3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Per POSIX requirements on trap, dash is properly refusing to let
non-interactive scripts reset signal handlers via trap if the shell was
started with an inherited ignored signal handler.  However, dash lies to
the user, making it impossible to tell if the user is invoking a shell
in an environment where a signal was inherited as ignored.  ksh and bash
are nicer about things, and at least let the user query whether a shell
is treating a particular signal as non-resettable.

This is important for shell scripts that WANT to guarantee a particular
behavior of SIGPIPE handling (such as this thread on writing a grep test
for covering the behavior of grep both with and without SIGPIPE
inherited as ignored:
https://lists.gnu.org/archive/html/bug-grep/2012-02/msg00016.html).

Bash behavior - you can learn about the ignored handler from the get-go:

$ (trap '' PIPE; bash -c 'trap; echo 0; trap "echo 1" PIPE; trap; \
     echo 2; kill -s PIPE $$; trap; echo 3')
trap -- '' SIGPIPE
0
trap -- '' SIGPIPE
2
trap -- '' SIGPIPE
3

Ksh behavior - you can learn about the ignored handler, but only after
trying to use something else:

$ (trap '' PIPE; ksh -c 'trap; echo 0; trap "echo 1" PIPE; trap; \
     echo 2; kill -s PIPE $$; trap; echo 3')
0
trap -- '' PIPE
2
trap -- '' PIPE
3

dash behavior - the trap is properly ignored, but you can't learn about
it (that is, trap lies and tells you that the handler was changed):

$ (trap '' PIPE; dash -c 'trap; echo 0; trap "echo 1" PIPE; trap; \
     echo 2; kill -s PIPE $$; trap; echo 3')
0
trap -- 'echo 1' PIPE
2
trap -- 'echo 1' PIPE
3

and proof that when the inheritance issue is not in play, the handler wor=
ks:

$ (trap - PIPE; dash -c 'trap; echo 0; trap "echo 1" PIPE; trap; \
     echo 2; kill -s PIPE $$; trap; echo 3')
0
trap -- 'echo 1' PIPE
2
1
trap -- 'echo 1' PIPE
3

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enigEF9996AD58C0F31FF8C941A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJPMrCCAAoJEKeha0olJ0NqS10H/ipkpypJPdERTH1dI0eF8QbA
0RSG7ptnjhntfvx58gL5tZKdlNn1Gd2tN5aVLgQNX7jedGEO0utc/ZmZYAQRE50t
jqvS/AzLlRTdxikgcMXI55RPj2Qc2txY42/puwgw581j0gLH+OdsfSjsZY8Gt422
QI0liUtlMreIkMXse9rr4XfUTsLIrt4KRRpnhQ8v85ZZQPZUkpSritkIBvf426Q0
cheMCEa6v2AdT+MtIJ5XjRXUoeucVxVPBRpI+WGsB1w4xwr2C1nQGwz5YpY5EGgB
nKt2wFFRp1dmO/2Q92G0vkJEujYwRrdrSmug9rxy/qC9OW3nu1T4p+oKdHtgc1Y=
=aD3/
-----END PGP SIGNATURE-----

--------------enigEF9996AD58C0F31FF8C941A3--
