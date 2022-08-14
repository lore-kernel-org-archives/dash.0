Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCC6C25B0F
	for <linux-dash@archiver.kernel.org>; Sun, 14 Aug 2022 00:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiHNA2N (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 13 Aug 2022 20:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiHNA2M (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 13 Aug 2022 20:28:12 -0400
X-Greylist: delayed 488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 Aug 2022 17:28:09 PDT
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCD05760F9
        for <dash@vger.kernel.org>; Sat, 13 Aug 2022 17:28:09 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9BE0317AA
        for <dash@vger.kernel.org>; Sun, 14 Aug 2022 02:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1660436398;
        bh=bf4FTOJLlrRBjMMa1IE29u7ggChikm1JGVa0QmaR2MU=;
        h=Date:From:To:Subject:From;
        b=Ws4uLy34bNSOTOyrVJdjqF5WltE2aqykHNOJNmcoxuAxrV4qR/GJ8mbgvsLLpMYPI
         7934ff1R1DgDGEFbDTjyibAWh3+8RlmZsN8kBHXXHJpCrpvWE7y4N6V9BwH7MkaMJl
         hdW/ABIEOQawRE0TxXAwINsOQPqf2qTW7qelxLYVUHHTInORbQsaSfjHaL5u/EO0Xm
         ME0GLez0SDWaRRaKRHQrkvjKEDVuyazls9JJ0vFw5boH+ml9kRP0YikPVWbyLNoG+z
         A6zmAsemieAnoOrFdYNWGXVnVI43N6X7JKKKIVf7xdJiFn36bKyYu/cg7LGX04eZYD
         LkYJPACH3VHlPf0qy5pZLt4/e2yZIuQ5Q9VSZ0S1f+ph7OtrRa0tNa7mHYIyEdAmS5
         iLvqF12ZRj5Vf1dITdYcxTW5hEzLuOZ6Is9a3VxMtdLd2wFKnKnSgSXDT1j7BpIFb0
         6q0VbjfZAvgO9nybRetIwhDgLBaRIHN776kyI+0lKK+htOYtXZlGo9yyslLSPW6zk0
         dUMGDd8fsEnu3GYb5Z6nZ6gH808OnJdQFOXyk2QygRwZyK+fufzbcaBP0aEV9IK9J8
         XOsQ86gWcXImcC3FTEdvtDPK4TkPKMBVO+YOX3Y3DjlT8PbAKo3EZ83+nziSVHOAR+
         YgbmNPtbL4pfE2DKoMXmnVHI=
Date:   Sun, 14 Aug 2022 02:19:57 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH 1/2] man: printf: all Ar arguments are processed identically
Message-ID: <ba1440bf05e22d3cae38521a25cb3ca90b30680d.1660436383.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h4lrbutfu5ebuw42"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--h4lrbutfu5ebuw42
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current wording says that given
  printf a b c d
a is the format, c and d are processed as noted,
but b is unspecified

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 src/dash.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dash.1 b/src/dash.1
index ff02237..bd5c311 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1544,7 +1544,7 @@ each of which causes printing of the next successive
 .Pp
 The
 .Ar arguments
-after the first are treated as strings if the corresponding format is
+are treated as strings if the corresponding format is
 either
 .Cm b ,
 .Cm c
--=20
2.30.2


--h4lrbutfu5ebuw42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmL4P60ACgkQvP0LAY0m
WPG0WA//QGX4/grojglIUddxf1/WyyP+idu58OidcYaAMU32y/howPJCGgLQgnM2
YygdECStNXEUh7cSKhEuJQW75eXnQbVMqojiLIAVtOGgMXMqBRgWFbTzFB48VaOb
tO98aVKlI0fAa8nzJfwJBGRFUr1/3zgzAFYotuaJZjM7Xo/H46aFUafVCtqdQ00T
vtwAqDDzJSqsLg8HwgYim7kKWL5nvb2GJ14Zai/AogyWrSgKV0Tg3KGI0lo9y6Fm
CC7wMJ7wFDwEo4M9I4vQ4OZ1ortdTjdSjUcYIcvjH3nDkqB0anIbYCwESKz803TD
d4oSAwNO3lkAq5nzWlvvbl8ss89B9ZMK2Q9hX4RY5wVstRyUe07U2/1zRGANp6mF
VMeJZpMO0BA0qjMEWKovA/zwVg6yUy1jgDvq4HwOtmnCoTFEuJu2DF8eWxMS7QD7
Ha/QdsOCOTMZwLhTDP0gt9XtN3JjkrpFbqqsc92h6FPg657fygm1Gdg5P/MuubJd
jpSGa45BFOd9wDdtmWr7lJVzqx+SXQ05caEbU5wTLymCWY/1RBfvbjibBP7NINY5
ZJJKm7rRLnwOdlynRgBQbdRxi4A6/qTeHKKC1UbSemjnlnY48hht3qjsEVIpiJM+
k1AkXb3hue3DTzTSNhWTs/eMQrq0pvDuvua3q4GjearG/4VBaOI=
=hbZi
-----END PGP SIGNATURE-----

--h4lrbutfu5ebuw42--
