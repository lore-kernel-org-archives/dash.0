Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3825C4332F
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 11:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjADLdv (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 06:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjADLdu (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 06:33:50 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 720CFF0D
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 03:33:49 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 7790C650;
        Wed,  4 Jan 2023 12:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672832026;
        bh=+9ZYAQnw0dnvfNmHkoJ6pachmekwMilPvZFeSybxkLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1o26AOW1V48+i8/jgVvwJ1Y8Nxy1DVjyDbRZxiayh5gNh1u5Z8JLJ9N+ILJRLrY2
         BhdQLNhJRsdclpKeqtmmZjZmB1AnnBZS6hVMK7Ian/9sYGOhz5vOqRFSmNg2MXRCRN
         n54wzQrQAMJSuBM9hUQK0jP1/TtHpJfhekoQIK0hYLsbuox8lsHw5zjLiyA8wy5JiE
         5DZq8uAKZyhRrZtpmDezy0h8Xk8QkCD4tmiFZ2zFjkAjv++CBx2WtpEbCDPwkVzIrQ
         Ow2lTnHlcaLjqadAEPk0ZHfpjkIgeQa6yVBlxgEC/wN5rkJB90w3V/Wih7lPV0C2qb
         M9XcG4li1Gvnw==
Date:   Wed, 4 Jan 2023 12:33:45 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: [PATCH v2 1/2] options: getopts: ignore first --, per POSIX
Message-ID: <728796762ed62a1e9a38cf62762e57509e5027a2.1672831998.git.nabijaczleweli@nabijaczleweli.xyz>
References: <Y7TgIM0PFC5HaZk6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4dio53pphmti4peh"
Content-Disposition: inline
In-Reply-To: <Y7TgIM0PFC5HaZk6@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--4dio53pphmti4peh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Issue 7, XCU, getopts, OPTIONS reads "None.",
and getopts isn't a special built-in listed in sexion 2.14 =E2=80=92
this means that XCU, 1. Introduction, 1.4 Utility Description Defaults,
OPTIONS, Default Behavior applies:
  Default Behavior: When this section is listed as "None.", it means
  that the implementation need not support any options. Standard
  utilities that do not accept options, but that do accept operands,
  shall recognize "--" as a first argument to be discarded.

Test with: getopts -- d: a
Correct output is no output, exit 1
Wrong output errors out with d: being an invalid argument name
---
 src/options.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/options.c b/src/options.c
index a46c23b..337a8ee 100644
--- a/src/options.c
+++ b/src/options.c
@@ -409,6 +409,9 @@ getoptscmd(int argc, char **argv)
 {
 	char **optbase;
=20
+	nextopt(nullstr);
+	argc -=3D argptr - argv - 1;
+	argv =3D argptr - 1;
 	if (argc < 3)
 		sh_error("Usage: getopts optstring var [arg]");
 	else if (argc =3D=3D 3) {
--=20
2.30.2


--4dio53pphmti4peh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO1ZBgACgkQvP0LAY0m
WPEzlA/+LNOxJhriZ9xEaaZhKCo8pSIlf04BUsmagzoXbMbjGIqODEuY5sBO1Tht
/8CHMemh5Zz8p7ooU4gXeDswrJDAGO7IarrE0k5bFhfYd5aibVmr2zMQAKosZeET
909T4vxcx1973rJDtc02wKTKBeJklUusBHoUSgXe2h0XFumNIWuzEYjctgixib7I
iYMjKRiZ5DF6EvK1udbbCngiph1zEg7fTX4Ks97qifG/gc8i9h3hNcIkR+3JAAJg
XdY6+XgvjQA0tCLwlfF9cidpIV/KXbxW9pliWq3DHMkxLUT2ywGZTEIGnFBvAjrE
r3VtX9dzvtEUbORMyj6VYk3sEKEN5/KLFGeL7ntueNgcXo3JsG0BZgmmExoex9CU
uezrjA9zMwxKkIU10BG1+ZBSPMTF+hNWOq9TGu+E9knjb1pidk9rYK6YrRCgw9py
ew3d6zb/DAx/Jqyjt+RzJOkMu+l34mxoPJzBlY6V27kupw2Z+b1FIqzDJz4xUTm9
EeU4HONfS5il27jJjCRx/2C5m2E1ww3ufQzr2XvR9fh7mZ8t9jLoG9O5Ww0g+QsS
6xvtOC9HBHftigG+MUCAyY3aVkYcZPdyyDwEt15sWbpO8N0fA7TvztTlyYuicNIA
MjWZSdJ/9F6WgFxoAosIXYV2TifvO9xNoa0UnoNqAqFbr5M/2pY=
=iDMg
-----END PGP SIGNATURE-----

--4dio53pphmti4peh--
