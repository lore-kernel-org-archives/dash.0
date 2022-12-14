Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E23C4332F
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 01:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbiLNBG1 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 13 Dec 2022 20:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbiLNBGR (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Dec 2022 20:06:17 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADE451D302
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 17:06:16 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 047361424;
        Wed, 14 Dec 2022 02:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1670979976;
        bh=Ym0a7d4SCo8fZNa76cLln2JmAYoCNhoWl1FcrOiHFH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TxGpSJtOYDmGq12Y9UEbhBX1I/C0cm/kiZZMkBZEVK3LYq5hoot0MifosiqEaa9kJ
         QUuLaxhgUTxUDEGNwTWpDuqDMM5y6KOKclwTq9jdWQEvjCShbDvQ+xEJjvEHUw5hSE
         gkvRcnOhq8s/RkHIPfy41Mn6BKJlL7QFGXGnrbD9mhWS959h2ErJ7HgmipI7xERrhy
         /T8ZUDIn/XgVGYcepv8TBocHaBA9Uexj83quhbHFMh5SPZDT+uGjsnWfrbwaYiNvlD
         Lyh4JeRfiTmgks/g0MVNRm06WhL6xMBdQWdBXvqpyI5sH1918p6sDRCPXdC+T4I19b
         xmjmpAt6N5mXg==
Date:   Wed, 14 Dec 2022 02:06:14 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Cc:     Harald van Dijk <harald@gigawatt.nl>
Subject: [PATCH v2 3/3] input: preadfd: read standard input byte-wise
Message-ID: <42d2b629549d8be07d14acb6cdd7d0f853ed1a6e.1670979949.git.nabijaczleweli@nabijaczleweli.xyz>
References: <20221214010539.g3zy2jtzdrhsyrrz@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l6pn5y43h77muru3"
Content-Disposition: inline
In-Reply-To: <20221214010539.g3zy2jtzdrhsyrrz@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--l6pn5y43h77muru3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

POSIX Issue 7, XCU, sh, STDIN says:
  When the shell is using standard input and it invokes a command that
  also uses standard input, the shell shall ensure that the standard
  input file pointer points directly after the command it has read when
  the command begins execution. It shall not read ahead in such a manner
  that any characters intended to be read by the invoked command are
  consumed by the shell (whether interpreted by the shell or not) or
  that characters that are not read by the invoked command are not seen
  by the shell.

I.e.
  sh <<EOF
  id
  cat
  good!
  EOF
must execute id, then execute cat, then the cat must copy "good!"
to the standard output stream, and similarly
  sh <<"EOF"
  id
  read Q
  good!
  echo Q$Q
  EOF
must execute id, then read "good!" into Q, then echo "Qgood!".

Heretofor the output was as such:
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  ./dash: 3: good!: not found
and as such (with -x):
  + id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  + read Q
  + good!
  sh: 3: good!: not found
  + echo Q
  Q
and a strace confirms:
  read(0, "id\ncat\ngood!\n", 8192)       =3D 13
  read(0, "id\nread Q\ngood!\necho Q$Q\n", 8192) =3D 25

Reading the standard input byte-by-byte is the obvious solution to this
issue, Just Works, and is how all of shells do it on non-seekable input
(we could, theoretically, read regular files block-wise,
then seek within them after parsing, but the complexity out-weighs
the rarity of running sh < program; we could also do whole-line reads
on teletypes in icanon mode, but, again, the gain here is miniscule
for an interactive session, and the mode can change at any time, so...).
Naturally, we keep reading block-wise from not-standard-input.

With this patch, we observe the correct
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  good!
and
  + id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  + read Q
  + echo Qgood!
  Qgood!

Fixes: https://bugs.debian.org/862907
---
 src/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/input.c b/src/input.c
index ec075f5..6b6113e 100644
--- a/src/input.c
+++ b/src/input.c
@@ -195,7 +195,7 @@ retry:
=20
 	} else
 #endif
-		nr =3D read(parsefile->fd, buf, IBUFSIZ - 1);
+		nr =3D read(parsefile->fd, buf, parsefile->fd =3D=3D 0 ? 1 : IBUFSIZ - 1=
);
=20
=20
 	if (nr < 0) {
--=20
2.30.2

--l6pn5y43h77muru3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOZIYYACgkQvP0LAY0m
WPFAKw/9E7ZyNAsI8zf6MAn7A/6X6iau1fhePediJKHs+c1/kpOwTe7iLyaddTV5
Uobwh732HQvvFPYpF3Wrg/YndbBjfQvpR6o6990x2btwZtUQetKpmSHzOAtHnjhT
q7pEsWgE1VKXYj5q7V3SfwhsplcsYKurnTm1/94xpAS9YdyPV8B0XkxkmuZVDOO1
8k5CfkzBKp2Rma2mVm8FouZ9tpv+1YXJMTUMYcsVX4xSwK49+usNmi9O2TVDcsuS
8ZYKQ29rm5pUIsqJV5NBxuqo5fuJRh+hyxV1S970ZoUkpUUAf7O4qRkg/0DNBopw
JY59VK9YZnt7fTGCXdad0kNr2s8Nt3AC+abPYXdB4VTe++Zs7S9SJ5XumftSnuF1
clT0SVih2kpgOOZ1jaD4lrd0MMmFu3G9pOc5ZJwnxnQi6Xb/ah3ysx4EaWnIqrfV
aVXTbHzhIg7hWJiDn4dbioUL6JrbDpc2H22YirxrkLJepeNwCS4K+KG4FIcgDDeg
r++w++MMzgR/yUCKOmkO6Iz8CKwQerOv/Ea2qZ10l0squISOaUn3NxNESlbi2tRP
sXSGyX09Vhrxf6Ugtl2sXK36diJZeDM5RZoRr0NtEb/cus07+YBfCAcWKJ+Jq6FD
ffRuQ+l9w/A/STVaSUCBDd4hcmd2xOYhRJGpGmtjE7liIeem/jM=
=LjPR
-----END PGP SIGNATURE-----

--l6pn5y43h77muru3--
