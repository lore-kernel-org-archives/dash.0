Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137D3C636D4
	for <linux-dash@archiver.kernel.org>; Tue,  7 Feb 2023 19:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjBGTeD (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjBGTdy (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 7 Feb 2023 14:33:54 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E00E3B670
        for <dash@vger.kernel.org>; Tue,  7 Feb 2023 11:33:40 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id B426A942;
        Tue,  7 Feb 2023 20:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1675798419;
        bh=LFLA99HyYUBNUwoTrehEu2zy8RwDT7JJG6bmJkWYQmk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Vdq6uwNpj095FXg/1ZQNyvbD9fwBRapdeX5/MVfR+QSHO0V/M6XMuwZkgIRnXYdtf
         17P1iUl7GG08tNdq8IicgYNdX94eojI3lgMH3+sx97B0zoeFbpmPf8K85lmeEerW0W
         KgIiPICPtiXjpskAbQUuABumcmWecJqXFKzwlyWWjBpUIG/00Jpm17cL+wnjxFw05G
         CtdgEy6m++lV/PECgi1r6h+Pr3DBa8g/Iu889w58saC4Z0K0JyD4AvnYRi4Bzdo3m6
         aJ6R7Cd6mHcyiAPzbyKbm+LPV2N6wD6KSMD1ELEepn6LXqsJZmmSBu2x4bv2aHlt8b
         zCAHSjFxEInsQ==
Date:   Tue, 7 Feb 2023 20:33:38 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: [PATCH 4/6] fc: don't require an argument
Message-ID: <ba7012f7f2cf644c79160b6f1361486d46d9cf9d.1675798292.git.nabijaczleweli@nabijaczleweli.xyz>
References: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w7boaumakpr4mvwu"
Content-Disposition: inline
In-Reply-To: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--w7boaumakpr4mvwu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is already handled correctly (per POSIX) below:
  When the synopsis form with -s is used:
    If first is omitted, the previous command shall be used.
  For the synopsis forms without -s:
    If first and last are both omitted, the previous 16 commands
    shall be listed or the previous single command shall be edited
    (based on the -l option).

Test log:
  $ ls
  autogen.sh  ChangeLog  ...
  $ id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  $ who
  nabijaczleweli pts/2 2023-02-07 18:36 (192.168.1.109)
  $ fc
  4
  ,
  who
  q
  nabijaczleweli pts/2 2023-02-07 18:36 (192.168.1.109)
  $ fc -l
      1 ls
      2 id
      3 who
      4 fc
  $ fc -s
  fc -l
      1 ls
      2 id
      3 who
      4 fc
      5 fc -l

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Reported-in: https://marc.info/?l=3Ddash&m=3D154707728009743&w=3D2
---
 src/histedit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/histedit.c b/src/histedit.c
index 24631ca..f10e5ab 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -212,9 +212,6 @@ histcmd(int argc, char **argv)
 	if (hist =3D=3D NULL)
 		sh_error("history not active");
=20
-	if (argc =3D=3D 1)
-		sh_error("missing history argument");
-
 #ifdef __GLIBC__
 	optind =3D 0;
 #else
--=20
2.30.2


--w7boaumakpr4mvwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmPip5IACgkQvP0LAY0m
WPG8gQ//RQaF4ka55nnId9otiJ/qv0wzYRhxHsD2sDhw8K2AGB5SxMjLGwA+NQwO
G7FE7GiEVeRkge1u5zOBE/m9E0tDIG3s7O+IUe+OmyiL6TbkGgQj9yhHjL0YfH9P
RpFzY6VI6oyUx1x/DMGVR4vqR73Wd+rNKOgBOn+nOvbAKNH1RzD/oT0sbnBHM5ol
x1SL4F17pFZl93qPsQkFXkKZLgB9b+v2emiG8JF9tmP2uHlve3Onjh6yoqlLVD/V
KWCvUZHZ1gS2Gik9As9a/z6E+5hz4lHN37MnrBxp57jvnlVRKSDc78XAU/Jw1eS6
gT7JnxBaa8l9WwF84W4cSyhoGoVq7NHDMbFu22xiEyxYTAn533XgdaN39QRJriD+
zUZE5BBD468JgB3uDFVYZNphJJAZQmluqL/+ehmZfTnE/F68eGilEByAr2JfklVu
dAuCu4DX/Bb3gK6aubh5TxBGNAaRl5sJVmIr1I3pzZNeNnS8PvWc4LNShn1R3wPd
rgBXXHiV2xX1sEpZ3cIpS5Jxt6Ly39ha4gBq2jb7sztpnEkchUB/MysdTS/lZ0b/
innjrRLc723YCn1YFxF0punJUxmwsfyyz9Yvpy7tmOT2YChth43a3vD0bF6X+T0f
6kRsYngyUmkQH0AwGz0aGnYkM6e3K252KOL50C0vp1SrNnbnbp4=
=9h1g
-----END PGP SIGNATURE-----

--w7boaumakpr4mvwu--
