Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9AFC636CC
	for <linux-dash@archiver.kernel.org>; Tue,  7 Feb 2023 19:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBGTd7 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjBGTdy (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 7 Feb 2023 14:33:54 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2CA43EFE4
        for <dash@vger.kernel.org>; Tue,  7 Feb 2023 11:33:44 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id EE40710CA;
        Tue,  7 Feb 2023 20:33:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1675798424;
        bh=B6q9ZevxjZFqj+JgoXImeHSf4CBX9uAxhRtszJMSlJw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=O5llsGvhg+GupuxjuvGGhjFwjHaanF16l2WBG9ksfXzUbgAU8bY9XeUHCrt69SVtn
         zYu14Gik6Tg4CJ2qX+JqRUDjgSGzu2wzYj5TazYq+JOY9jJu7HxE+JHpa/dLXA3W0X
         FWmDSK+fXevLiVagcmi++W6w4KMnXzW9pmmxyirNqVI/jmEEO63O6EEkBeLnR/speI
         dEOFurJPZu9uGDW1g6vacgb5DHQqxIqMkaAZkdlmTffsXp5gknPLYp7OOtRDBe56M5
         gyhypFH10NlXHzBgMjYQD1g5iQn+Blt6xtE/AjW2B8NwmO5j8TlQZkrmTRpw2lxAko
         zDFuo6/eYxcqg==
Date:   Tue, 7 Feb 2023 20:33:42 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: [PATCH 5/6] fc: fix "fc -3" extension on glibc
Message-ID: <0ea78f2dddbb59ce2c984c83ab45cd811191b499.1675798292.git.nabijaczleweli@nabijaczleweli.xyz>
References: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zdvw2swwaytqbmec"
Content-Disposition: inline
In-Reply-To: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--zdvw2swwaytqbmec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Before:
	$ echo a
	a
	$ echo b
	b
	$ fc -2 -1
	src/dash: 3: fc: unknown option: -2
	$ fc -- -2 -1
	16
	,p
	echo b
	fc -2 -1
After:
	$ echo a
	a
	$ echo b
	b
	$ fc -2 -1
	6
	,p
	echo a
	echo b

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Reported-in: https://marc.info/?l=3Ddash&m=3D154707728009743&w=3D2
---
 src/histedit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/histedit.c b/src/histedit.c
index f10e5ab..502ad40 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -217,7 +217,7 @@ histcmd(int argc, char **argv)
 #else
 	optreset =3D 1; optind =3D 1; /* initialize getopt */
 #endif
-	while (not_fcnumber(argv[optind]) &&
+	while (not_fcnumber(argv[optind ?: 1]) &&
 	      (ch =3D getopt(argc, argv, ":e:lnrs")) !=3D -1)
 		switch ((char)ch) {
 		case 'e':
@@ -243,6 +243,7 @@ histcmd(int argc, char **argv)
 			sh_error("unknown option: -%c", optopt);
 			/* NOTREACHED */
 		}
+	optind =3D optind ?: 1;
 	argc -=3D optind, argv +=3D optind;
=20
 	/*
--=20
2.30.2


--zdvw2swwaytqbmec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmPip5YACgkQvP0LAY0m
WPE0zw/8C94sQ2ILF9fcaAA/PNI1F8sjakqOl4sOHKgbCXL6ia+/FNmKiYRZknWy
w7k60N0HxUWYVCRbP2JvNPoqMf0wc5Zvd6X2OMR16W/cCo/GLVnT2rE+Fdn1JIPs
J5QPDz//kRIR0O1Ye1iSRAHnQ8m0UmshG3yKAOrX+9RjRIp1lNfEVeOe6PdCGqkH
ngTmg5McQhjkd9nRqOlGAY4wNGbRYLE4ASjIYgI3EF+ZrZOVcXH8zzLUy39E+3f3
F/dWsY4uempcL1Q25uthM+vB/jLCuyZmPmsXGaxjQ44yIYwfuXR93URRNeBnS3eo
pcpzJ6tHZgYnqlHXUUarpJsV0K7F5lbIERSS5lGRv6mlxFk+XgVG9S/vUH2/ESsN
2BX2bgZdWPxI5JCQkw73hNXXh6n+mOE/wFsv8KFOtagLEEQU0Qbcmh5hUedP8Vtt
LiQL11CYQf5rLIMCkBSW0PhpUAaQMi5e1//bHmnJIfzbxhKIQI6FLHiTbHTfO68H
dXxSDhMArduxSbCHZOohcBiDm/0/YAOKQKLyP15liiArOiTrukgppUIiV/jaVbJb
FAmMTqnZZ1To1n78QXGJvArwCE2Law6XYTmLkjOWGR1XRRUO0f2rFqfCs3UK+ou9
TA5OA8LVSx8E7pAZUMxGNIpwisTroiro6RqPx2IaVrHlxEVjL/g=
=+NKY
-----END PGP SIGNATURE-----

--zdvw2swwaytqbmec--
