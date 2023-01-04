Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889ADC4332F
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 11:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjADLfQ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 06:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjADLfP (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 06:35:15 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D7D2EAF
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 03:35:15 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6B299652;
        Wed,  4 Jan 2023 12:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672832114;
        bh=JIvJ+jmIdHcZ41bhPHwL9sdN33SD7wo41BhW/RjdjHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKN7PFTBhP59dOgbTxNzXlhzmmg8yJD2otl85/uicy8xF4WOczkiUHuNn+30FV/in
         D5Und+P2iItzWiOrIAIfR5CpdXxNVf+imhYT3xPiLW38/FgOkHDyOSDNv6lsucmn+x
         sGu0TjVwkp26ZvW5vVWpZTfpnsrs02nWxNGmNQpa67UhqB2wMGh7ZNt7wOLeFs8qD6
         hOCPC7VsHJrjMVLEB0ZoUduD7hmmWEbi3xRL4iTYhOlYT4/6S/6Qwsz3UHuYKGDK0x
         1xZ7EJfz+fZkv3MzZC/hfDKrrM6NVm37fSfMRCa6LvPxmZA358XYXDH0scjb51qVBQ
         2cwVf+FVr0JvA==
Date:   Wed, 4 Jan 2023 12:35:13 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: [PATCH v2 2/2] exec: type: ignore first -- for consistency
Message-ID: <dc50c4f40f0a265897dfe202b978902656a30c1a.1672831998.git.nabijaczleweli@nabijaczleweli.xyz>
References: <Y7TgIM0PFC5HaZk6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r2n662y3slyrpfkk"
Content-Disposition: inline
In-Reply-To: <Y7TgIM0PFC5HaZk6@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--r2n662y3slyrpfkk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This appears to be the only remaining built-in that doesn't use
nextopt() to parse its arguments (and isn't forbidden from doing so) =E2=80=
=92
users expect to be able to do this, and it's nice to be consistent here.

Test with: type -- ls --
Correct output lists ls=3D/bin/ls, then --=3DENOENT
Wrong output lists --=3DENOENT, ls=3D/bin/ls, --=3DENOENT

Fixes: https://bugs.debian.org/870317
---
 src/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/exec.c b/src/exec.c
index 87354d4..d61881d 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -760,11 +760,11 @@ unsetfunc(const char *name)
 int
 typecmd(int argc, char **argv)
 {
-	int i;
 	int err =3D 0;
=20
-	for (i =3D 1; i < argc; i++) {
-		err |=3D describe_command(out1, argv[i], NULL, 1);
+	nextopt(nullstr);
+	while (*argptr) {
+		err |=3D describe_command(out1, *argptr++, NULL, 1);
 	}
 	return err;
 }
--=20
2.30.2

--r2n662y3slyrpfkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO1ZHAACgkQvP0LAY0m
WPH8Vg//WIorfrvOV2cyfFRb7L1GISS5B8z82Oxd9+ijE08hmRvNO/FSDkjjVGKM
UfTErLTe6Wg8+ppxtcNzBt5of0eTeW+2RWLZNOSWuo5zXK7l8cEkjPObLTKkOOeg
ZT3nYk4h9Vu9Oi/Y3XjIreV6s86XRaUO/iieOuJQ919GE3tGnVuHwWNFVwR2R9TF
UYxyEajnd3TGf06NG4wbJxRlxCObXOcFhJng4Y2z9s1a34FlRTImZMR+2U2QAhee
9JM0r/xW3hBoWacJ6LO3KcUmK7EIrIAHuKZge7PF5iYEDRXw4deFeZ+J2buXZso4
qIgnfvTjqP7+v0f3IsLKrUrZblGbx+2ga9uDEiLg/Rb28tkAw9ZaXrZa9bIZHFOS
1scI1E5QGUlnl2jlWhaxnbqse2ICIpC5jXzdTvkOQ8QwgBpBIy7MI4yDoI5kA+NN
X53ST/1y5tD4Qp0zfH7lRUBIISRYMl6kXnplamKKFCvHp2Sia+lX5MPtFBE7lcaN
uaDihyU4XRlxm6eHuv2M44LH4S+zSOOhLBEkaodqHLf74neRhUQOJ4pBL7sYwwu9
WlFollCszPuWnp2RwBYuDZpZXatsL4PcdvA1WHVSCZq/HJR602IrdyfVDOh7N759
afqFJc3yVVjLCadKEm5xWBj8R6Eq4fGY1NgDhr8hg04scWFcTx4=
=1/0Y
-----END PGP SIGNATURE-----

--r2n662y3slyrpfkk--
