Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1513C636D3
	for <linux-dash@archiver.kernel.org>; Tue,  7 Feb 2023 19:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjBGTeC (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjBGTdz (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 7 Feb 2023 14:33:55 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BDBF3EFF7
        for <dash@vger.kernel.org>; Tue,  7 Feb 2023 11:33:49 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3882F1700;
        Tue,  7 Feb 2023 20:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1675798428;
        bh=XSavRGu0cDLQdSb1Y1rEcZmnlDRJe1qhHq/2iQgR5ZY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=SCzLVzd/ZsLZE6IZx68gnCZQBnhslJHOZ8CokRd/2c01IupnnFGQLKz1qNJJToopP
         d9pql9dzYVxk11xbk6Q8PQhrnd/swQFBW4NVej4CB9wbMfzD0kBMm5lMawSrWUJmxl
         /97qGPlgdxzLDSjOZ0OHKBFozVlz9qeZJrrrzDpwCAzb+B4y+EPc0y7JP1Yf+7TDlU
         PnOVw3L7zEGTMkMkiI8/mKChQv+7dbdbGTezy2DE9DNVKNrRBr7M6p1P/GN5UWpIDq
         9hVGyWTD4Q44WZyac1g5NqC1NFiePx4iKEGEHhPMGRO50yOYWjpOTBwffBK/YK7RWX
         v2VqYN5mT8k+A==
Date:   Tue, 7 Feb 2023 20:33:47 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: [PATCH 6/6] fc: don't include the current fc in out-of-range last
Message-ID: <d2d5de626bafa4e1b76eb136c1d63cb8f4ce7fa1.1675798292.git.nabijaczleweli@nabijaczleweli.xyz>
References: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z7yk2caa3tfvv2j6"
Content-Disposition: inline
In-Reply-To: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--z7yk2caa3tfvv2j6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

POSIX states:
  When a range of commands is used, it shall not be an error to specify
  first or last values that are not in the history list; fc shall
  substitute the value representing the oldest or newest command in the
  list, as appropriate. For example, if there are only ten commands in
  the history list, numbered 1 to 10:
    fc -l
    fc 1 99
  shall list and edit, respectively, all ten commands.

Which would seem to imply that the current fc shouldn't be included
(well, in the POSIX model, no non--l fc enters the history,
 so that reinforces that).

zsh, bash, mksh, yash all agree with this; oddly, ksh includes it.

Before:
  $ 1
  src/dash: 1: 1: not found
  $ 2
  src/dash: 2: 2: not found
  $ 3
  src/dash: 3: 3: not found
  $ 4
  src/dash: 4: 4: not found
  $ 5
  src/dash: 5: 5: not found
  $ 6
  src/dash: 6: 6: not found
  $ fc 1 999
  21
  ,p
  1
  2
  3
  4
  5
  6
  fc 1 999
After:
  $ fc 1 9999
  12
  ,p
  1
  2
  3
  4
  5
  6

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Reported-in: https://marc.info/?l=3Ddash&m=3D154707728009743&w=3D2
---
 src/histedit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/histedit.c b/src/histedit.c
index 502ad40..7692776 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -476,6 +476,8 @@ str_to_event(const char *str, int last)
 				 */
 				retval =3D history(hist, &he,
 						last ? H_FIRST : H_LAST);
+				if (retval !=3D -1 && last)
+					retval =3D history(hist, &he, H_NEXT);
 			}
 		}
 		if (retval =3D=3D -1)
--=20
2.30.2

--z7yk2caa3tfvv2j6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmPip5oACgkQvP0LAY0m
WPFKjw/+L9Q3YO8ToZUPmabhxq+UFNRU4DJPSPzpaJ265/xMvd08X0v8nSs52nKg
ZaW5vqsj1Z+VkV8pS0pbN+Vn+kXJhGGs8WK2C8rVXEN2XSI0s9dxL3ARpaCtv/a8
kDuDgG7oc3cwZ971Mf0H0aEbkT/m39jYIt0FoGh9fCZktOhYhuNy8JbGzmWODzZs
57aU4W28SLXlla45SjiYnXT8Zk0shGw+M8whi4PUFR7zvKA8+6lqrGtD5vzKuRyp
tABIEFHWfrrNf8ZvCSrnTo+SDAqDkCKpcAdrJOaSUtitx1BGeutFAfPKr3i8UwmF
5IWRpyHmqaXVZLaDzDEX8w9WVhcOR8obVV/IOU/KprFFpP3HWKqIUTqdljN6MQYm
YuBEWC0F0DQKdTLv8W4T4lKuAsmCK0ckdVUHKPg+g6bxu2BxQOQAj3Z/1MsJE5I0
BQcUp52gHbkPgLadMj5puXTVLj2pNqLA7RLdyrdAcXiGriKb/BEIjn/tImSATKhR
PzoUcudkOMIc2GkrbJfT3Kd606ayOTa4HKOqIujmkzS9yMVbI+U8rZjq+AUtqju2
Nu2Y26L09LyTdQlCc4OEhVJVGRNnMA0c6mxK2MzbPA70aXQj4PFlz6bH4asNCpup
axMf2adAmLrF+wLUk3riSXSkY9NUgG5pr0Qps3/LD3/JrWFF0H0=
=N8Vt
-----END PGP SIGNATURE-----

--z7yk2caa3tfvv2j6--
