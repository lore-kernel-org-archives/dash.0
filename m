Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ACFC4332F
	for <linux-dash@archiver.kernel.org>; Thu, 15 Dec 2022 00:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLOAZ5 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOAZ5 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Dec 2022 19:25:57 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EB34D92
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 16:25:56 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id AFB4A10B4
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 01:25:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671063955;
        bh=KMrXQXyBVRt/LsW9dokblyY0M9e7a9S/s0A7Jk7tIPo=;
        h=Date:From:To:Subject:From;
        b=oBl0WD6rLmpWi7VTz8GfpikB7EgwwtwJbmOae1kOEbmdnJ2wMdfIRPTNOv8a7avR8
         omhsRcoNMuDipFgZXHb36RSi+ff48SfNtjFdhnm48UwDlEveVjsy1nBxYwup4ehtoH
         mBG6Y6Tb/gfzRQePnKG/8Yq7YB/uRNTTRgAtcgCRo4hSp3SzAdYhG6borVj5Nu+T+w
         TTwrX7aiAXbkF0BIDu8SbBKFhog3DgOd6MxcM28ZbKJA4/lKe0BOE7GnkTS1UA46hO
         RRO0XEZqV1hyYesxsyX/ez86zrXmKsHFx+Sa+KV9Atwxljhp9W1pUYiOApNBJw1ovW
         wPT1NnQAam6RQ==
Date:   Thu, 15 Dec 2022 01:25:54 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH v3 1/2] man: printf: reword to avoid confusion v/v Ar
 argument[s]/arguments
Message-ID: <50b331b19b78fd56c5b2190f1f922a755e5f3270.1671063918.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y7gonyl2bkmqtdbs"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--y7gonyl2bkmqtdbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current wording says that given
  printf a b c d
a is the format, c and d are processed as noted,
but b is unspecified
---
Resending my patchset from August

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


--y7gonyl2bkmqtdbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOaaZIACgkQvP0LAY0m
WPEXDg/9EsChLx4Pf01TrC3RowiMZW9QzJKR1KowWtv+S/vzhwufQNheR/9Af2WA
bzAimfAnBpNDp84Bn/VfMhWMdoqwWiL+Qw9vspyVOgpABAqg+ybGSQZQ9efD7d4Q
ewHE//VN9m+MBuLFYlg89js753mxnl29SkFTuhfvm7xvNSmlGNHYJXJjD+yv+l7e
iT87p1YSxR37dM9FGXhnde/ktmSlLZ3SuVc7Lykjj10YNdC45mlqNg1qDcCLjXzu
bj6DIhgOldEbt046LnSvM4YZ5a88BJdVO9BEGnADmOzysXUsiE4Iv1LBM/ZRXdTP
fqaVFSdYUq5eL2p9twSBqgPn1PUn+lVvdFmJ2LSqj5X3rs8KeuUND4OdS7ikkXAr
9fWRdGX2iT2bAJ//SuxM9k4guSSnNHENslaeEcmyx+86nyqRw5VZX0KI3Jfyy+UY
i/A7PnIMHqfJ/nUDKrwGeXiekvUbZVRSBjtq27EStE/m3rTR4MEU/mtUGD4yrAeG
PXnK2UfdpPd//dkTQK0LR6L1uLjNdKCZx/cTT313d92z02KO94Iqs1hVCsAiVoyQ
g2Gbe+u6OgFjC1NITQKocT6mI8Vaq4Ix6Mz19lFIAsy+/bHYQ0sW+Z4WpgBnC+v1
O+FLsDLKdwrKTW6aguNzk+lNWrGnk/ZiLh0usdyr82xtXdUM/O0=
=FH3g
-----END PGP SIGNATURE-----

--y7gonyl2bkmqtdbs--
