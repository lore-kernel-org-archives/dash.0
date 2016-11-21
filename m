From: "Matias A. Fonzo" <selk@dragora.org>
Subject: --with-libedit errors
Date: Mon, 21 Nov 2016 20:36:43 -0300
Message-ID: <20161121203643.68a26b1a@rafaela>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/xVLRdBgwdF6.t3UTL53_rgQ"; protocol="application/pgp-signature"
Return-path: <dash-owner@vger.kernel.org>
Received: from dragora.org ([69.61.93.52]:38640 "EHLO mail.dragora.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752774AbcKUXck (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Nov 2016 18:32:40 -0500
Received: from rafaela (unknown [200.3.217.68])
        by mail.dragora.org (Postfix) with ESMTPSA id 9A0D7342239
        for <dash@vger.kernel.org>; Mon, 21 Nov 2016 23:24:30 +0000 (UTC)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

--Sig_/xVLRdBgwdF6.t3UTL53_rgQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi there,

I was trying to compile dash against libedit under a native musl-based
environment, using --with-libedit.  In the first instance, I was getting
this error:

  http://sprunge.us/BKWK

I solved this issue adding #include <getopt.h> (suggested by Laurent
Bercot) to the file src/histedit.c -- as my patch shows at:

  http://dragora.org/repo.fsl/artifact/068a14902e390487

Next, I've started receiving this error messages:

  http://sprunge.us/iQjf

To sort out this problem I've removed the option --with-libedit, using
LIBS=3D-ledit for the ./configure invocation.  "ldd" reports:

  libedit.so.0 =3D> /lib/libedit.so.0 (0x7f2db97a3000)
and
  libncursesw.so.6 =3D> /lib/libncursesw.so.6 (0x7f2db954e000)

Right now I have a working dash compiled with libedit support.  :-)

Also, my default LDFLAGS has the value "-s" to strip all the symbols,
but dash/configure does not seem to pick up the value...


--Sig_/xVLRdBgwdF6.t3UTL53_rgQ
Content-Type: application/pgp-signature
Content-Description: Firma digital OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQJ8BAEBCgBmBQJYM4ULXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQzNUJEQjlENDZCNTZCNUZBQ0I2NDdDOUIz
QUFGMUNFQzIwM0E5OUQ1AAoJEDqvHOwgOpnVnq0P/irnBW/Qz+u1icTOCd/Ku7QZ
0DpqAdqQ7uPxy7ZAd0hTxK3c+3DqUOjAYmO+l0dVSov81ZzSmcULKSdHyf79E1GG
pE77NOVtydXDQFSsLTnwAhMM3dtN4llQSgXtu34t9ykNWYiYbPTyn4ZUhWM3Es4l
43t9wHVdflBPgNvzQGpD2Gm9PaKUFNpVbYxqOU9WZ0ZBVsK2PkfshKGccT/F2dhD
s0Zhwz2EiUuJKfrUjrnVoyDCtXv+DWC7NN+k/q4SS6/q+fHTOFhAM4vzoKOwQnfK
T0CFBikTKEzzwM+ojx9YX3DekvJz8Zd4WCNi4V4IEfoJOxiPSqBgwpNoQF3FmUkl
oMmKlHhbkH+UDLvL5bEMFPC2T6ZDPeJBhcu5xXf8GYtbIh11J3ox+xZWwcV4ZvlW
lyuuOjQkiqLE2dpxHegv0C30Z9b4M0+9GGt3RQ4eedFxjacQzmfZCNfNOyD0wRTS
kYH4jaIegScOEKKQd6yPkCt6MWaRl2CrVFaBmvLeKQdCjQ1M3iG5rdLq5yD7qT1c
+IvGOjrpjuPbVmbJ8NUfb21CbhgysqKA3LTE10otNveYui75t445k4h1tM3awA6G
cvRlyMGoYXLU4mud3Z7ZdrtvmMcej/RT/kH6+jkrb7nMrlxQfBzypqL/aIyJLOog
KfYGXEgc2Ds67ans1RRx
=XI0w
-----END PGP SIGNATURE-----

--Sig_/xVLRdBgwdF6.t3UTL53_rgQ--
