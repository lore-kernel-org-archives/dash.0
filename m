Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DFCC4167B
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 01:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbiLNBGO (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 13 Dec 2022 20:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbiLNBGN (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Dec 2022 20:06:13 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C98E720F74
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 17:06:11 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 2512D1422;
        Wed, 14 Dec 2022 02:06:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1670979971;
        bh=q9xUjh5EnLv9HcTDjy1D6ieekRuLfieCXp/n5xPLsvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCPN+d3k8RXnj3JTL6hzvRrR+CElAtrPFSNsoNtODh5kz04M67ZeRH8cc3lUuNcjN
         mzVme3s7c0tDWgEpvrS2g4y5MyRCeixtSNZHsDjEeHVKIMRzbDzZSg35wsW/JS9uJR
         UtK7S/PpfPBhW1TvyU02yxds0KG5zv8cJu9H864XBPcAl04yOGeydjT/nGgyVr9EOR
         y03zE5j+eI+ccqOlQKlHSuKUr1S6bWCXb9O8CmsfHX18mFJ5TqzUIgzYaU4QwdXZgZ
         +eXORUUZIam7aIp6VhH51XEFpHDUh3JO6I7M0Bave8CSvm74cQtzv5rZw9CKLRLECh
         Gbn679zyS5ljQ==
Date:   Wed, 14 Dec 2022 02:06:10 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Cc:     Harald van Dijk <harald@gigawatt.nl>
Subject: [PATCH v2 2/3] parser: synerror: explicitly consume the entire
 invalid line
Message-ID: <b62afca3e10b03c802276ace6e514f7ccb7a5134.1670979949.git.nabijaczleweli@nabijaczleweli.xyz>
References: <20221214010539.g3zy2jtzdrhsyrrz@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ktrewvoqlhkhgzk"
Content-Disposition: inline
In-Reply-To: <20221214010539.g3zy2jtzdrhsyrrz@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--7ktrewvoqlhkhgzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Interactively, sh_error() doesn't terminate, so
  echo "|$(printf %10000s)echo bug" | sh -i
would read the first 8KiB, see that it's invalid, then jump back to the
parser, which would then read and execute the rest of the line as-if
it were the next line.

The fix for this is to explicitly consume the rest of the invalid line,
so that the next line observed is /actually/ the next line.

This is difficult to trigger accidentally right now, since we consume
the entire icanon line buffer at once (provided it's <8k, which it
~always is interactively), so we always observe one line at a time,
but the next patch would make even "| echo bug" blow up.

Imported-from: https://github.com/hvdijk/gwsh/commit/d279523041c1c380d64b6d=
ec7760feba20bbf6b5
---
 src/parser.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/parser.c b/src/parser.c
index 8a06b9e..35fdbc3 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -761,6 +761,13 @@ static void nlnoprompt(void)
 	needprompt =3D doprompt;
 }
=20
+static void
+skipline(void)
+{
+	int c;
+	while ((c =3D pgetc()) !=3D '\n' && c !=3D PEOF);
+}
+
=20
 /*
  * Read the next input token.
@@ -798,7 +805,7 @@ xxreadtoken(void)
 		case ' ': case '\t':
 			continue;
 		case '#':
-			while ((c =3D pgetc()) !=3D '\n' && c !=3D PEOF);
+			skipline();
 			pungetc();
 			continue;
 		case '\n':
@@ -1526,6 +1533,12 @@ STATIC void
 synerror(const char *msg)
 {
 	errlinno =3D plinno;
+
+	/* If we see a syntax error in a command, read the rest of the
+	 * line now before reporting the error. This ensures we get error
+	 * reporting that does not depend on buffering details. */
+	skipline();
+
 	sh_error("Syntax error: %s", msg);
 	/* NOTREACHED */
 }
--=20
2.30.2


--7ktrewvoqlhkhgzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOZIYEACgkQvP0LAY0m
WPGm9g/+MkMBQhC1hRR3XPTAffHNieyzvnbe97CxbypL78cJhe8osXgbUZXvhsx2
TmDA2iZq2v3W+pk8p9W/tyyVOk7rDu62FXHdC0FiwKttfpvXBglOzoO39q7vU6Iu
7aP35RpGxty4irZK7ICZB3Kx6/6ZxNaReBjleOVFLPwhchnL/hnwUBRBAcQ5B3YO
sicdcoXsdDsGt9lHI52ncqMQsTCidvhbuGje0zrj5LL4AJ/t8T+oTkgIN1ytrxsA
hh2jsiN7xALuqnHeBHkteoPajgjjUCu1RQvfRuHe3F+/ejaK6tUV17jaibhVd0UF
yOnTVOehhpP3tGrhiHHXfVw9l3p0WTXCRBpJ6DtW+S2Hy8qF6YwgiIN7RO8iJJ10
Wwxp140YMjTArL3TyJSZmRP/ZWzS081FkLFVRuMz5FSRO2M76JP2rk9uLYDZyTMM
CwPLzctzoPtVTThTzs1yNP1poBdDNYQ/UmSiOe35Ii/VXvPff4U6PiV1DxGWoo9H
m0gMZ+/0/Uoz100fERyIUhZU3tr2gsAN8kFjVBadRDd4G6XOytydhJa48biPIHA4
Foc0zQjeNil1rMxWcDFVoys1tBpOqcFip7eWpzsks/+AQuJYmCSFa+vjjDG3jzwc
cSYREDsA+ZT7C3fVbNJUpV9HC8jOcmI3HDmergP84x1EpmYucb4=
=4ZrP
-----END PGP SIGNATURE-----

--7ktrewvoqlhkhgzk--
