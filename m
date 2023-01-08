Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C32C54EBD
	for <linux-dash@archiver.kernel.org>; Sun,  8 Jan 2023 16:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjAHQK2 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 11:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAHQK1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 11:10:27 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E4F3BC39
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 08:10:23 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D11E8FD2
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 17:10:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1673194218;
        bh=yiCn7OUqFMlq/edu4kr2RW2bAh1VD5zIgfLlFmmHsxY=;
        h=Date:From:To:Subject:From;
        b=ZXnJLYOCvsRlXEA0X0u0Yb8iBq6PlKOgtyy0GTw+83GpCmDr56hAYy2PQH3Mcfgve
         G37qelMXyQhGm+b6Aabyb1y6+sXVlNzWWU4FcSHp8nqD3ayq/xQ82Yp2mPZGzZLYwA
         JADoXO7TPgAMIl8ibJrTbOGawA2hpGjr/0y8Ksyb1wi/gjQhX2IYQV7Jdm+IX3/pIF
         /5aNfrbZK5GBBUWShfb1xpjkbgwm7dHcKWwZ9JUKCg0dND7gj7bW/3oMXiN8LUiHzB
         UkUseuNhff6pfJIKvJwOPClP145H1hSu/nTJbNuoD4YoEJ3wU1ynQREfkt6E8osA1c
         wHQ3SpMrwLnIQ==
Date:   Sun, 8 Jan 2023 17:10:17 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: dash repeats first line in history entry forever with fc -s
Message-ID: <20230108160906.xf7w5vsd74kr22pc@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fuptc3aoemw2qu5b"
Content-Disposition: inline
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--fuptc3aoemw2qu5b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Fun test for ya (--with-libedit):
  $ printf '%s\n' id 'fc 1' a ls . w q 'fc -s 1' | src/dash -i
  $ uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  $ 3
  6
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  002         autogen.sh      compile       config.status  install-sh   mis=
sing        q.cpp           q-ksh-stderr   q-zsh-stdout         stamp-h1
  003         autom4te.cache  config.h      configure      ll           q  =
            q-dash2-stderr  q-ksh-stdout   reject_filtered_cmd  test.sh
  004         back            config.h.in   configure.ac   Makefile     q-b=
ash-stderr  q-dash2-stdout  q-mksh-stderr  sh-stdin.sh          traptest
  005         ChangeLog       config.h.in~  COPYING        Makefile.am  q-b=
ash-stdout  q-dash-stderr   q-mksh-stdout  sh-stdin.sh-f        tst.sh
  aclocal.m4  ChangeLog.O     config.log    depcomp        Makefile.in  q.c=
            q-dash-stdout   q-zsh-stderr   src                  x1.sh
  $ id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  fc -s 1
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  id
  ...
  ^C
  $
  src/dash: 1: Cannot set tty process group (No such process)

Interactively, if you ^C you can then
  $ fc -l
    426 id
    427 id
    428 id
    429 id
    430 id
    431 id
    432 id
    433 id
    434 id
    435 id
    436 id
    437 id
    438 id
    439 id
    440 id
    441 id
(or, as the case may be, something in the 30000 range)
of the first command in the history entry.

I've never used the POSIX history mechanism so idk what the correct
thing it should do there is, but it's probably not this.

libedit 3.1-20191231-2+b1, dash trunk (f96ec8765cf37eb0c222a563de2f767ebfbf=
56db).

Best,
=D0=BD=D0=B0=D0=B1

--fuptc3aoemw2qu5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO66ukACgkQvP0LAY0m
WPHEgxAAkVbKXKOk5+x5boq4+QEePx067ZyFqYYPqPrkhruISAu1UsLB6kFR8w0Y
UN1drXHBcd4MltyUDOxJzwgB7BPfIkkw/ZmAcCYSuwEFk0wQDMa+d/2lsxTUDCfP
d5LoQL4CY7wrPZGpXGIv+KCWjnmoRs8kc0PYRQk4S9uy2sAG4O/z/Pna79816WPA
5eN1Xoiabi9XEaalnTq0hjYzzQFMLxnHpmsNokOmdpUC3JyrSfxt0rYBO6oMvCPS
G8bLoDbqM9B39+FC6Dfmnonhn+lv52wO765VUgkeNsvjSFtfeIevGnI+FVCGXo+R
vNv/2dnDF9SleOCrki2XxfoIfi4H9B+Sz40qzWp9fMhRLSuBVaT67nMbwGZ5lSni
AR4Lfoyyi/1o/alJPdNWb7sYmEWFpmT0DmzBNz4jU+/1paJKIh8M22xtWKuY26wN
pme7KxUufxlbsejLBXcSXmwF0fAfyL2kgcU2QxznHRWxGs36NUWhO7LMAChHrq+F
afkNapcL1l+qRUFOB/Pw9PAa2Q0+Z8T4n4XvhE34CNWb1SzPYamM40JE4DBsDHXg
Zg/ms6hW+siOZWYb6wqiFRX9AkIwwBJc5ZmusuTDTBcmrdSQeRG6691axmNVTLjG
FiPbnE9/XykMHnMgqFcFJojucmVx/nMDkMY4YLt3Dz1RigaBOmA=
=MHjz
-----END PGP SIGNATURE-----

--fuptc3aoemw2qu5b--
