Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA87CC25B06
	for <linux-dash@archiver.kernel.org>; Sun, 14 Aug 2022 14:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiHNOTJ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 14 Aug 2022 10:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiHNOTI (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 14 Aug 2022 10:19:08 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC141DED2
        for <dash@vger.kernel.org>; Sun, 14 Aug 2022 07:19:05 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 90A371232;
        Sun, 14 Aug 2022 16:19:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1660486743;
        bh=Zbt28bNoI5pN5Xg7J9S2Tlj/ctTHzXIQZrSNc9gOnrw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=nXD2aUG0AhnvPxXTS+pWfB88xLhwVQpDEb5j3VXLwh7tHuV3PvI2RK0etCVvIzrmS
         BjHUBVdX1xhXXjmvwGJVJ83bvByw5wERUCWF7QXafi18UPTNpGTmfyRaf5CKkRq+zQ
         4S+48EbmPMc2VW3Jvdq2PVHbBNSaBwEQY9OpRPLmH2B0t9hzsW2vHpZP/nGbehG0ev
         5CWI2beKAuxiM4S1LkI3PFlF5Z0EThd5dHoRzEq80KhJBaodIZtDgcP0TCnXvpndsa
         OXwb4x8zN+arYE8wjlv750k8TjWwDbwAxIRUY2jUTbTZLyY686pnsFrrKXjBJhgCSt
         P0NDsn5ez7VqWYBp3mkQIw8/RnKTH57AwSpnlLMTFrKbAjhlPXD6Cg1GbISw4/KS6x
         j2S3D6IlkGP1qfvSTG3TVhYnmw8w21YbPlyQyD9nZpygqHXojEDooPFDv5xg+obsRH
         ToHYS8kactphY4Zfl6n66i81mt1S+lG5HGVVziUaL1HfmHZOg4hChJEdyVdIHgKPet
         eusoG5GoeUqubHa+yiqsaBfmr9PLtWi3abEHrEhYFxCasq0Vei6GJG+4ZqBBydc9bc
         +qUmrLwAA3JrRK18bLdWlk/FwwkCyAn2zsKjMfj0HMr1Usp1/ucUM8VcqHRFzusXKp
         eb2v8MCM75a0aD2hJ4damoEQ=
Date:   Sun, 14 Aug 2022 16:19:02 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org, Harald van Dijk <harald@gigawatt.nl>
Subject: [PATCH v2 1/2] man: printf: reword to avoid confusion v/v Ar
 argument[s]/arguments
Message-ID: <0d82c5a6b3a84ec3c6f5eb3513e4800f2f1f601a.1660486650.git.nabijaczleweli@nabijaczleweli.xyz>
References: <af8be241-f3cc-4ca9-ee49-e856e658c683@gigawatt.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hldaxgosbgjyl6fy"
Content-Disposition: inline
In-Reply-To: <af8be241-f3cc-4ca9-ee49-e856e658c683@gigawatt.nl>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--hldaxgosbgjyl6fy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current wording says that given
  printf a b c d
a is the format, c and d are processed as noted,
but b is unspecified

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
That's a fair cop, considering the manual already abuses Ar arguments as
Ar argument and arguments.

Please consider the following updated patch, which calls the arguments
consumed by conversions "value"s.

 src/dash.1 | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index ff02237..310f34e 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1528,30 +1528,26 @@ With the
 option specified the output will be formatted suitably for non-interactive=
 use.
 .\".Pp
 .It Xo printf Ar format
-.Op Ar arguments  ...
+.Oo Ar value Oc Ns ...
 .Xc
 .Ic printf
-formats and prints its arguments, after the first, under control
-of the
-.Ar format  .
-The
-.Ar format
-is a character string which contains three types of objects: plain charact=
ers,
+formats and prints its arguments according to
+.Ar format ,
+a character string which contains three types of objects: plain characters,
 which are simply copied to standard output, character escape sequences whi=
ch
 are converted and copied to the standard output, and format specifications,
 each of which causes printing of the next successive
-.Ar argument  .
+.Ar value .
 .Pp
-The
-.Ar arguments
-after the first are treated as strings if the corresponding format is
+Each
+.Ar value
+is treated as a string if the corresponding format specification is
 either
 .Cm b ,
-.Cm c
+.Cm c ,
 or
 .Cm s ;
-otherwise it is evaluated as a C constant, with the following extensions:
-.Pp
+otherwise it is evaluated as a C constant, with the following additions:
 .Bl -bullet -offset indent -compact
 .It
 A leading plus or minus sign is allowed.
@@ -1561,8 +1557,9 @@ If the leading character is a single or double quote,=
 the value is the
 code of the next character.
 .El
 .Pp
-The format string is reused as often as necessary to satisfy the
-.Ar arguments  .
+The format string is reused as often as necessary until all
+.Ar value Ns s
+are consumed.
 Any extra format specifications are evaluated with zero or the null
 string.
 .Pp
--=20
2.30.2


--hldaxgosbgjyl6fy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmL5BFYACgkQvP0LAY0m
WPFAMw/+I4GsEcarBQ38IJ3QU9LlyDoESRdxve6+AzhtL4ph/8kDiX6TGbpsY4AW
5JUa0dWuJnO1nnuzPWngo2AgFPKvpwKFz+blfzlvgOJPm9oAsKs8VfjZv7nhfhKF
7PNryZ9WBHnvSCoQgWxc1dI+sXO9jJxRljgpBzCIVsc+vq2WhyGd8fiW3zvsOiEb
o8n1wl5oaRkqILanClhBOQ973rPTm64wTxhs3leF3k+ksg9X43Ce6xPB1P3bBAEL
a9qwY9XPKQrhvpPTvt8eBRU4Lo6E/7he/H5F2WgvwAUFOJ4tG2jWl7Ro2zn1tyeh
pATmqOmCD+MtgAcY9sukIM5MRAx6zYEjAxAsSwvspHJDg/FtEYMvnoFpxB5gBOvp
RWX1O/E5sVvnnmUcb8vvB8Z5ZH/pkWg0+6osCCPId3rP6tdCYrHB3yfCVBLGcE6v
/9s0FKMORvf9bYDAX4vmc2tkWgzRTZCG9qX30UNpUneTqOskMEKNK6AuRgavb2eA
xtJf/HSg3WSiQ/b5vokOTRp2HNRgW+6FPy0nsFpnryaZPL/SYfMorjbJn7TNMtl1
sLyEyk/HTsYGTaCLC3w2G1SuNqYPZEJMVverHlp5YfD7ihegpo/SVJty4yr+2BHt
acsr0UQrFnl/59O1WuOzwsBKsXvBXH4NRy1Ig+zX+xp/2YQbVtE=
=U0VU
-----END PGP SIGNATURE-----

--hldaxgosbgjyl6fy--
