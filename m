From: Luke <g4jc@openmailbox.org>
Subject: File integrity of dash source
Date: Thu, 3 Nov 2016 22:28:01 -0400
Message-ID: <389bec45-040e-f34c-dc01-35fd040075d4@openmailbox.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="354ADrxVkJ3hltXXNIHflpMq0R01P5qnQ"
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp8.openmailbox.org ([62.4.1.42]:40807 "EHLO
        smtp8.openmailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755671AbcKDCgX (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 3 Nov 2016 22:36:23 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--354ADrxVkJ3hltXXNIHflpMq0R01P5qnQ
Content-Type: multipart/mixed; boundary="omFnmdPP89orkMBTFdXcGFKo2DrElXNID";
 protected-headers="v1"
From: Luke <g4jc@openmailbox.org>
To: dash@vger.kernel.org
Message-ID: <389bec45-040e-f34c-dc01-35fd040075d4@openmailbox.org>
Subject: File integrity of dash source

--omFnmdPP89orkMBTFdXcGFKo2DrElXNID
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,
I am contacting you as a package maintainer of Parabola GNU/Linux-libre,
a fully free operating system in compliance with the Free Software
Foundation's GNU FSDG. We also have a focus on privacy and security.

We attempt to ensure that all of our packages and upstream are secure.
As such I discovered a problem with your package "dash".

There is currently no GPG signature to verify that the
source is actually the one you have created.
This is particularly important since there have been recent attacks
which replaced files on upstream servers. Take for example the Linux
Mint hack earlier this year.
(https://micahflee.com/2016/02/backdoored-linux-mint-and-the-perils-of-ch=
ecksums/)

I would like to request that you please upload a SHA512 checksum of your
dash tar.gz files, as well as sign the SHA512 with a GPG signature.

Technical documentation on how to do this:
http://docs.oracle.com/cd/E36784_01/html/E36870/sha512sum-1.html
sha512sum * > SHA512SUMS

https://help.ubuntu.com/community/GnuPrivacyGuardHowto
https://access.redhat.com/solutions/1541303
gpg --clearsign -o SHA512SUMS.sign SHA512SUMS


The resulting files, SHA512SUMS and SHA512SUMS.sign, can then be
uploaded to your site (or on another site/server for added security), so
that package maintainers can verify that the source is accurate and
unhacked by a third-party prior to packaging.

Thank you for your time and concern.


Sincerely,
Luke
Parabola GNU/Linux-libre Packager



--omFnmdPP89orkMBTFdXcGFKo2DrElXNID--

--354ADrxVkJ3hltXXNIHflpMq0R01P5qnQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYG/IyAAoJEMP0/88+roaXzlUP/11VfffoeADAKxJQk6l/pT5i
GBF4UBxOGS/zJmtLIVC3t2pobSb3mIlqUNtF0WpOJrz1ZAUhXd7ojDN2GNi6mvz1
WqiwjwqSWVVGL0urC6l3OJ8isIrkuIB2AnGh4rEPbZWrJfX5Ql0e8qWTAaR0lEin
achQVlW7jpbo5we+sijIHAcLlN6aL49ZAki6upcQ/GCwFZfOks3hEvyUob+Kz/Zv
pa3HfgiqGrjdQQbHPcJjbSsq/Jjco/2OZtR1fR36x1vuiWWn5BNAXUL+ubodih4X
AQ7t+P1Dh8lTf9XPvbeas5uQqM5R170FlAOyFYVq0lv4bTEVI7mntdhHBFMm5d9V
W+Q94W+KQTkNI7CCNL4TuwqrCaRe57c1ulRb7mH8k7kgfN+4KXM++too0rgc3feC
uvZuMpLLvLkjH8PZMVXnZaYFJbjL+H+ACBM5zsMJ+IHeOIbni/WVMezwkecVtZLv
2Xwfxxt7TiQSMKfrHB/q6JX4i1fZEzkxN9vco6kXVbspOMSQmKtyAnSJqJq/7O8i
jsbaRTd5DBqAwKb1gciEKk/uBKQVmSn+M6LmwmGt4Q7tUP4sgZjyelsGhUUXMSyx
+EmWKlq/0P1ZoxzaJM4TiPIeQrk1q51uvNJa1ccHQD613wzRjyxzZkiiWq0TUGsG
Dl9r+pVeT8ADTYdp6V++
=I4lB
-----END PGP SIGNATURE-----

--354ADrxVkJ3hltXXNIHflpMq0R01P5qnQ--
