Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07799C636CC
	for <linux-dash@archiver.kernel.org>; Tue,  7 Feb 2023 19:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjBGTdz (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjBGTdr (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 7 Feb 2023 14:33:47 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E5DB3CE2A
        for <dash@vger.kernel.org>; Tue,  7 Feb 2023 11:33:32 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5E7E2168C;
        Tue,  7 Feb 2023 20:33:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1675798411;
        bh=oG85JYBGvLuuf1f9mnO1Hi0KC6QwnxIWND62LdFm5YM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=MTsGBSNvbWymwlR9Ok6vZ9koUNk122Gt6GjTSDh0baTUoAlmuS7hEyGmZqXb6Dmqs
         OpqEpmWHFNL7lqO1DAclYNnpWgYiuy4uUR46WqE803jfsP+10AQujqd8sop4zH41qN
         JUb5qDceZbB1rgbAjQ8E5MxO5zcRu/sZKezvrhMvYnS12ipsh/tCkKbq3YXm97Thqj
         RKjVEnjsJVjEsL4g+FBM2+eBec755xoU4cZyHJJIZg5gsI/MxCfq0S9EWMDQQMEz87
         /UYcbt5XUK56bw/QzejfJ0/ZdNnRoGjkNl1jATwWTgicAZtxj4yscC+s0KNEzfcwg1
         H3td1uF5yjKaQ==
Date:   Tue, 7 Feb 2023 20:33:30 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: [PATCH 2/6] fc -s: don't loop forever when executing the latest entry
Message-ID: <7166822efa32d227a28d86bd1fb505f09bb7cf0c.1675798292.git.nabijaczleweli@nabijaczleweli.xyz>
References: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7n7zq2eejlb3d54c"
Content-Disposition: inline
In-Reply-To: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--7n7zq2eejlb3d54c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quoting CVS comment:
  Ensure [...] that we break out of the loop after executing it.
  With the previous code, because the re-executed command was added to
  the history, it would think that it still had to execute it,
  leading to an infinite loop.

  The last thing which differs from ksh is that we get the "fc -s"
  command into the history, but this is actually rather a feature
  in my humble opinion.

POSIX disagrees:
  [W]hen the -l option is not specified, the resulting lines shall be
  entered at the end of the history list and then re-executed by sh.
  The fc command that caused the editing shall not be entered into the
  history list.

But this is a separate issue, since even without -s dash puts fc into
the history (i.e. id; ls; fc 1 2; fc -l; yields 1=3Did, 2=3Dls, 3=3Dfc -l).

Test cases:
  $ id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  $ fc -s 1
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  $ fc -l
      1 id
      2 fc -s 1
      3 id
-- >8 --
  $ ls
  autogen.sh  ChangeLog  ...
  $ id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  $ fc -s -1
  id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
-- >8 --
  $ ls
  autogen.sh  ChangeLog  ...
  $ id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  $ fc -s -2
  ls
  autogen.sh  ChangeLog  ...
-- >8 --
  $ ls
  autogen.sh  ChangeLog  ...
  $ id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  $ fc -s -2
  ls
  autogen.sh  ChangeLog  ...
  $ id 1
  uid=3D1(daemon) gid=3D1(daemon) groups=3D1(daemon)
  $ id 2
  uid=3D2(bin) gid=3D2(bin) groups=3D2(bin)
  $ fc -s 3
  fc -s -2
  id 1
  uid=3D1(daemon) gid=3D1(daemon) groups=3D1(daemon)
  $ fc -l
      1 ls
      2 id
      3 fc -s -2
      4 ls
      5 id 1
      6 id 2
      7 fc -s 3
      8 id 1
-- >8 --
  $ id 1
  uid=3D1(daemon) gid=3D1(daemon) groups=3D1(daemon)
  $ fc -s 2
  fc -s 2
  fc -s 2
  fc -s 2
  fc -s 2
  src/dash: 1: fc: called recursively too many times
and I'm happy to call this "behaving exactly as I expected when I was
typing it in", so removing the XXX.

Adapted-from: NetBSD src bin/sh/histedit.c rev 1.38 by aymeric@
---
 src/histedit.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/histedit.c b/src/histedit.c
index fc87283..28956ec 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -382,12 +382,10 @@ histcmd(int argc, char **argv)
=20
 				evalstring(s, 0);
 				if (displayhist && hist) {
-					/*
-					 *  XXX what about recursive and
-					 *  relative histnums.
-					 */
 					history(hist, &he, H_ENTER, s);
 				}
+
+				break;
 			} else
 				fputs(s, efp);
 		}
--=20
2.30.2


--7n7zq2eejlb3d54c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmPip4kACgkQvP0LAY0m
WPGg6g/+JjlnoDgOV9gBjmWiqDNJpAWNoTNdu13G3bOQlEXz9HnTAHvxq/o20ONn
lyl+/zvBeMepCZPjYJdKfuLu2QdZJTjaTaeZo6APACywrZtI7wPnZjfQYY2PJaU0
WQAk/sUDf/ZX7PV4ymui3kJJJca4Ifb2dJqGGJVhejOf4uM6LQW36beX9akNZTs4
s2Pl4IfRyartdFe81ikHHRNhRGI1c4njF5li/6VhoMI8Dy8vkVB5WRoGmI2dJ+Ba
TVBywrUvhdnasNCTOO/XWe48FYYE3tulkiv9V00vzV3qX85CrI2CccttvAehqCzo
KGM17zRXnXt1RAarselyi52SXWjEgKhJ2FDeKko9xzWQq7KUkjgTWCS2H4K0zoRH
ENtOtNEpAx+1+lYmUp9CB++HWKrjZKrDDOJuAFL51DjrVV4kvxZ4EweYo8az98kR
fHMiW9pci1p+Rnf1a3MJl/E6WUi6R7BIlWOGMXbyexBoHe3dKZQ2ExOy0g4O+DAd
+LU4teUGZbV/tkY97fRueO6mhlXFHbGDetS9IT24RrNh3MaDq8BTEzxJ8giwn3DZ
3Yyv9ubczrqshYLVj081NP2oYqCfnG2oTzvPdlfy669XrPAQmpy3ca+658xR1Ap4
66dKfZwhA5uB8sMh9cm7DiTfPWAY+1IB+7gt+M9sDfAevvMlodU=
=YNuh
-----END PGP SIGNATURE-----

--7n7zq2eejlb3d54c--
