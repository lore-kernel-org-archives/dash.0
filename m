Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51911C636D3
	for <linux-dash@archiver.kernel.org>; Tue,  7 Feb 2023 19:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjBGTd5 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjBGTdx (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 7 Feb 2023 14:33:53 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AF1C3B679
        for <dash@vger.kernel.org>; Tue,  7 Feb 2023 11:33:36 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8F9C4112A;
        Tue,  7 Feb 2023 20:33:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1675798415;
        bh=s9a5VEdd5M72aC5a/PehrFUxQ+XzrSa5PXh8d8pnvQo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=hLdQT38qw/l/cikbXBgFD8GFswoRBMRJU4Rq1Vysq2qYdNRq2EQjGtO6bkrFG9tbG
         6jro/wci1fUnGALCRW36ZznS/uXsaiiwl00p1MNDWXCm7o3Z9PGHAtly/Y1sFPSPFg
         DQFCN+iTsSKjuDLnwVIuNXK+Td7ZUf9/ZSqf4Vq87wPKYq3L/6zwf7MTZCB1QtMkjF
         6bkMkWhia0v38zL49YgA8Db+h7Fe24DVYF4RtR8j79cQwZ1suiDD0Cz4UVq5TlD5dn
         4eNE0uMCyQQ0mxtsn/g8g8+TG0K6yuNpX2SaUaJuDvERRTerSdlgsRKSgWQlfFgK0n
         6SNrXsdrX8ckA==
Date:   Tue, 7 Feb 2023 20:33:34 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: [PATCH 3/6] fc: only parse old=new if -s, per POSIX
Message-ID: <717f18e61d425cc96d2af5ac3f2c5f1de230f5d3.1675798292.git.nabijaczleweli@nabijaczleweli.xyz>
References: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxmlfm3lx2uopqzw"
Content-Disposition: inline
In-Reply-To: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--uxmlfm3lx2uopqzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Before (erroneously replaced):
	$ a=3Db set
	...
	$ fc a=3Db
	8
	,
	b=3Db set
After (used as search string):
	$ fc a=3Db
	8
	,
	a=3Db set

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Reported-in: https://marc.info/?l=3Ddash&m=3D154707728009743&w=3D2
---
 src/histedit.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/src/histedit.c b/src/histedit.c
index 28956ec..24631ca 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -288,21 +288,18 @@ histcmd(int argc, char **argv)
 	}
=20
 	/*
-	 * If executing, parse [old=3Dnew] now
+	 * If -s is specified, accept [old=3Dnew] first only
 	 */
-	if (lflg =3D=3D 0 && argc > 0 &&
-	     ((repl =3D strchr(argv[0], '=3D')) !=3D NULL)) {
-		pat =3D argv[0];
-		*repl++ =3D '\0';
-		argc--, argv++;
+	if (sflg) {
+		if (argc > 0 && ((repl =3D strchr(argv[0], '=3D')) !=3D NULL)) {
+			pat =3D argv[0];
+			*repl++ =3D '\0';
+			argc--, argv++;
+		}
+		if (argc >=3D 2)
+			sh_error("too many args");
 	}
=20
-	/*
-	 * If -s is specified, accept only one operand
-	 */
-	if (sflg && argc >=3D 2)
-		sh_error("too many args");
-
 	/*
 	 * determine [first] and [last]
 	 */
--=20
2.30.2


--uxmlfm3lx2uopqzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmPip44ACgkQvP0LAY0m
WPEr7g/9FmU5aZPDJiwK9R1wsjnCGIWRQ7ReUiLbX8a/bO8cBUi0NEdg2jYtzB9G
aAm18ZItnfw7kvgQSKOnBj679AaVCmhPCbqraanEwpiSoM12jQj1/7nSxCrp+aWX
G/ZLqHqxf+/XhuiEKAq+8k/g6w9C1JsZoU65c5+9dJr7tU5tOowe+bGDs1ltLWRw
ZmxnX9M9tKnDnnQZkomZ8LfbuMfkix1N/ld8+zHZk/buCgC5OaxLFxOz+5ovYii/
Exe2QJ16SWuMkKOVbnyRBXUCVjCJ+yepem1+V3/XKvLz6ur5XBosCWREZTvq2bbg
D4lT+NBNVA4Mf/iiLitI0+NZINoKuCwQHXvvteJ3H+FeNZGMLXAhAjMm6cj7AuxR
L/SWRooLk//moq9hOQ/kQ47UiaQp+gI2Q7pnh/b3eyitjvhQgr0Ryg6S/FqNY1ZH
0faxqxPE9tfP0rH8J8mnpdcWJlKerF4ViSqJDg8IUxmsTrJHkulhsXNsdwPWtQna
fdzGb6ZsC36Q/l4Uzm5DR/oGi6fJjXMiOjc5pzvPkqiCJwEj+aQMUtasyVs+/gCy
JxoKLruxZINTyhL0/vtv2nvFME9rAFCrMPuVrR7+4RUlA5XUZylB3fwDBUkox0/p
dSFwt0cnIClvMayECIYjNznJuiAyACh3Gspeo7J6vRA+J0W1WcU=
=GLXz
-----END PGP SIGNATURE-----

--uxmlfm3lx2uopqzw--
