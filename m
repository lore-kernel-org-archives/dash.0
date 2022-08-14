Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B24C3F6B0
	for <linux-dash@archiver.kernel.org>; Sun, 14 Aug 2022 14:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiHNOTK (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 14 Aug 2022 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiHNOTJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 14 Aug 2022 10:19:09 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3588DED2
        for <dash@vger.kernel.org>; Sun, 14 Aug 2022 07:19:08 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 22F361334;
        Sun, 14 Aug 2022 16:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1660486748;
        bh=aIo9lbtxL8JOAgFX2rC44I4tFexK3ClRBEXR2xsBNDc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=uctEt+t52DU/MTBMlSMTOVf8DgzVwD9NrYPGAT/lcXhs8FzVm5X2sJy/YfRfUfJvC
         XnQ67WWwnSsyXdfrQ2wlqVoFM7jOVkM9L1VeFibd9E0D+JQsijKmhbJB4Zle9ABNkC
         BLOMgg2v1eFovZlClatsyCsDBsyzKjl5XZDMbm7WbsRLnFP4Z0F3tIP7ElBxPz9PdL
         JhGH558SMrKubqEUAg/R6psxPnUY81xLZ+P9Y7hSRs+yFljHML/faNbek+PArxNrrW
         PkM8+nyXp9R6CVhn4AGxRZOZRQ2Ad/RGstVLJ7yM9P16WHrPnOaH1ZnElSqo0wqdHr
         L3YCG8W4bdLyimJp6FcV/da+ai7xe5HeJvptZ9S+uuCP8lG7BJjRMU5nhsD0QPwbxM
         YHwunzDRUFMEhHj6lO6meo17c55KJJwcGetE5LZqnwVIMJOwu83qn9MsIJsDBgTmfZ
         NpGaZJ2tGjEg0gIk4Ilt6GaccYoqP+3KfnDwGDPF9ZtfMxvS8h/Xf8sG8iLc3U1lFG
         R08WpkYUTe6lwLxOrgHSz6sl3vQ5ujscgBXaNLw8cxNEp7r5kwr8FESx7S/wOwo1w5
         +XQYBxhYaCeWLFME+LBt8WhrUYFYaHt9lUPaqZKFVDXcoEsvauWShjHCbnaOQydpmR
         uHW4oUzSOGa49ZkWegHvXx3o=
Date:   Sun, 14 Aug 2022 16:19:07 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org, Harald van Dijk <harald@gigawatt.nl>
Subject: [PATCH v2 2/2] man: printf: in 'X, X is a byte under dash
Message-ID: <c7b48630f0f5e9c19bedb8298d591a01c12581af.1660486650.git.nabijaczleweli@nabijaczleweli.xyz>
References: <af8be241-f3cc-4ca9-ee49-e856e658c683@gigawatt.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zjihjifloub2pqef"
Content-Disposition: inline
In-Reply-To: <af8be241-f3cc-4ca9-ee49-e856e658c683@gigawatt.nl>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--zjihjifloub2pqef
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Multiple issues:
  * the encoding is not always ASCII
  * what ASCII code is assigned to =D1=8F
  * dash isn't internationalised
    (this is nonconformant but out of scope),
    and uses the next /byte/; in a UTF-8 locale:
      $ printf %d\\n \'=C4=85
      196
      $ printf %d\\n \'=D1=8F
      196
    this is in contrast to POSIX (and bash), which says:
      > If the leading character is a single-quote or double-quote,
      > the value shall be the numeric value in the underlying codeset
      > of the character following the single-quote or double-quote.
    (i.e. mbrtowc(&val, argv[n], ...))

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 src/dash.1 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index 310f34e..38cf020 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1552,9 +1552,7 @@ otherwise it is evaluated as a C constant, with the f=
ollowing additions:
 .It
 A leading plus or minus sign is allowed.
 .It
-If the leading character is a single or double quote, the value is the
-.Tn ASCII
-code of the next character.
+If the leading character is a single or double quote, the value of the nex=
t byte.
 .El
 .Pp
 The format string is reused as often as necessary until all
--=20
2.30.2

--zjihjifloub2pqef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmL5BFoACgkQvP0LAY0m
WPEn6g/+OfdqBHWC4560/EI63P4CBRut/EghLEJ9aMZ7EIw2fAoXYfXMHzXO0Bci
u/M0jreUNwkqF3R1jG4RUZX0jwO5TWz8f4/3Se1ZrbVKAn3Z8sbO69aRFmtwEZea
g/ijmPq4iLTO3BwpNxwY+CLDgIFxKOAlfCxs1HhVkAOi9ax0a+Cxu5bxyEjr6aVf
tD1rfE0XO9K14PiIkbjQITIbLsdPFVaEpCVmj2EdR8BqOV8Dxhm2yev/SrrlXHB9
43TYseOuZrGL/+4GY0wXVegLaCJ8qO3vZQSfPOXs26UgLxuks4G2f3Nr5YdlyAfx
sJ6jBOvQR0meY3AzLszoNJp0dT+gLVcGHRk49LKYNuWoflVZzaEMkGphi6DTECgH
HXYGNULNNoxXVEkyP0E+G9A0SYenfPNNGdcd+aMZTc+YVDLvcFF8KWsJICRkUbn6
4S9R6yTaoZTWRyoEmOs8wdxE7uyP9IpKtQjzjPhTHTXD+pYodP388YDnNH4S46SG
09WHq5cXu859s8D/AbBMcQ46YRUAj53pSoX1/pLPH9hgvstavias4t6yAbCoIwpB
iBZ+3elK0uzKru7ft5myu8/mlGTC+3M6XFNZMblp0UVG6SQQBOOJ1iWGnTXBrZuY
t37vlU/BF6jphaQ/iEeo2G0zfqze1pN4XqPNUWzxoUhKBkeOnFI=
=wblj
-----END PGP SIGNATURE-----

--zjihjifloub2pqef--
