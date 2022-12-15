Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3CBC10F1E
	for <linux-dash@archiver.kernel.org>; Thu, 15 Dec 2022 20:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLOUv0 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 15 Dec 2022 15:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLOUvY (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 15 Dec 2022 15:51:24 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2687C1EEC5
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 12:51:22 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3AEBDF7A
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 21:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671137480;
        bh=CFsEq4PWcbWdBwLyPgEIw97elek4I4TckN3r4S6iOuo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=B4tGQn7EJaOvwdgFJfmXgTUaeAGJD+U7AR4aXPHXCXVNHaU/67BUVZcWD+g25GFj/
         nCMdKI05QsEA5nMUFSCFTPhnzkiUpwB5pZwH2roYHFnOfIUe9DYwN42xAP+zGIHdaI
         y0u6B8DMzdlnrx9FECoDEb4ljcmz0BbvpQrhO5ra7KTzS89OXfFxoyfgDI0zs8R2Ak
         /1iwx5XoLMfGsB7scFGTwLa5IhBHOHB6PxFpJzecPUHqzvcN5coN3pAT6Ay0coE9E/
         ODeXDvCbRH+BV0hYkm/Ojuox6kgu6XP0GU+upryLmz2on05H3fNmj90NTol/gZjw2b
         140sdtJFCxdEQ==
Date:   Thu, 15 Dec 2022 21:51:19 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH v2 4/3] man: document false built-in
Message-ID: <20221215205119.sihav7onr3l77el4@tarta.nabijaczleweli.xyz>
References: <ce831de5c91ebd75b6da5fbdd7de79159a765e6f.1671063677.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i5whyngkrjyht2h2"
Content-Disposition: inline
In-Reply-To: <ce831de5c91ebd75b6da5fbdd7de79159a765e6f.1671063677.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--i5whyngkrjyht2h2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Only true was documented, add false just below it
(out of order, but so is true, and the grouping makes much more sense).
---
 src/dash.1 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dash.1 b/src/dash.1
index 514fcfe..f06efb6 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1095,6 +1095,8 @@ etc).
 .It :
 .It true
 A null command that returns a 0 (true) exit value.
+.It false
+A null command that returns a 1 (false) exit value.
 .It \&. file
 The commands in the specified file are read and executed by the shell.
 .It alias Op Ar name Ns Op Ar "=3Dstring ..."
--=20
2.30.2

--i5whyngkrjyht2h2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmObiMYACgkQvP0LAY0m
WPGXng/8C7maE9ArPeYgf+HDrCau2/b9Ok+/j9OQBJCCSwxfIgPftwLGJ+Sn4HF7
OQY7hbV1yhtlCCYeUXcS4sx7rB92tzhDViBlFaS6X8mn0Cqw7Eo4esXSYkr0OpeN
UTOt3fmYrSp1u1KcO66NcKSvmPWrd4Equ5x9TrruuIupBVHFzREkqcFgnxqge8bp
D+k3BaA9Dihp7uajD1K9F/XFkeeGxFS9hE1eHg+CkyriiQpR0G2kL/9WVKV9/T7O
dh/rPHwh6pvDHHCp1mxIupKO4S9S+YP3wMApYC+bl87uBazdRTMSk5d8r4VR2i1/
XJWLqxKkpTgL4NIzZNvjI51/2IlKwJtBvNC2IVsoJdy4XZzN4cES0hE5fiUqp3+4
ZCwcPxFp5h8QipqeaRBRC+GIJP2Kid88P3Mt6V+6dFR7RnBOr3myhjViV5Af6SC/
0A4Hh1+KP2bsr69nkhzMUdqgiQiSi7nSobpYnnxYxVU5BHcPSRZJqU4of9LYisam
rfA97ZlSHFBw9NBC0Maz/BSBoPUHyd1BIhcnmrFxNRgHkShQpVIooJY5pkDHnxtt
m8TAZQ6MimVuCoh/J5U0/cm1SZJK5/8OJ6QEgvhq2MdheMy/4IE2bb6QW1kzlYAk
xyGstIFIvo8T0G9im8H857Z+U5A6hlNFrRyn87kR+nlRb00U2e0=
=/vAY
-----END PGP SIGNATURE-----

--i5whyngkrjyht2h2--
