Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F108C4332F
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 01:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiLNBGJ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 13 Dec 2022 20:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbiLNBGH (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Dec 2022 20:06:07 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ECDC1FCFE
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 17:06:07 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5D0CE1420;
        Wed, 14 Dec 2022 02:06:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1670979966;
        bh=WYphJDsAiwrtHaq2L27c0S7jMvUZ+oLXrAjgTK9Gv8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxEHUzNc5oNyru68snMZV/IZXrM5msWBcDbIAlbBMUbqQxHaCsRFzthZik/aX582u
         azpRJiDc8u2A+n9LvcstvT2jGpAxsVZ5TQcQ1rmaCIjbJk/au0ankjbXUCd5iJPTpu
         PTJMyWuGK1/uZVVAJpa3V3VOMoz4t+ND1XftBzm8ENM9swx8BKg/qVUM1HZk39tIfc
         QWcdnuB9OGnlkZLhkR5dgLcxwGEEAol4KMETYeR4AAE6WHngepnvxzlxBlCnh7dCBW
         bX0UtVHTcewPr4gnYdFK0ZIsHhIQz6C7luHxFe+zuPNsrrnRWeVcoDpAf7nJYSJ6lF
         nVgN8PAQT8hGg==
Date:   Wed, 14 Dec 2022 02:06:05 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Cc:     Harald van Dijk <harald@gigawatt.nl>
Subject: [PATCH v2 1/3] parser: fixredir: invalid redirections are run-time,
 not syntax
Message-ID: <3a7ba3fa786e34cde8ab158cb8578f0d39cf655e.1670979949.git.nabijaczleweli@nabijaczleweli.xyz>
References: <20221214010539.g3zy2jtzdrhsyrrz@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ffxsluguwebp2e4k"
Content-Disposition: inline
In-Reply-To: <20221214010539.g3zy2jtzdrhsyrrz@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--ffxsluguwebp2e4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This fixes a long-standing bug where
  echo 'echo >&a' | sh
errors out with
  sh: 2: Syntax error: Bad fd number
despite the error being on line 1

This patch makes the error
  sh: 1: Bad fd number: a
as expected

Adapted-from: https://github.com/hvdijk/gwsh/commit/d279523041c1c380d64b6de=
c7760feba20bbf6b5
---
 src/parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/parser.c b/src/parser.c
index a552c47..8a06b9e 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -615,7 +615,7 @@ void fixredir(union node *n, const char *text, int err)
 	else {
=20
 		if (err)
-			synerror("Bad fd number");
+			sh_error("Bad fd number: %s", text);
 		else
 			n->ndup.vname =3D makename();
 	}
--=20
2.30.2


--ffxsluguwebp2e4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOZIXwACgkQvP0LAY0m
WPFTQg//e/7qhWed1h2OIqZLLyWVBzbceCXmu/XBjAExRkvYPbAWorniMKdCyqJE
qZDiKpE8/ysfibeo4b9OCXkaHKmOkUJYEzNyMB6vGCw+Y/uYthrM4IZSFge5JdYF
ILOUPWDeuN2axsk7cNnD/42E/XgIqWPfGLEPigEMfOG1gEHUpba4yBQQxBkoK+ku
ATH6uxo2LN1TeWX7Xq2oGKU26ivRLj8iKBHv5dHmXFAnilwNjsZbnzsCv+BqfogN
J/Pdh/iF2Bn6N/ZX3kgQ6pCpw0uTt7Gh+4hH3LZLIZFNdL9wg1mq9FKE7H4A8+8q
l1i8QScdYcvO/ygzF/oC+hP81jONh2LS0OsVOdHmLB6R9bBYpqJSdLxGu2vtHC7f
fq27QAbTOFbBNFDg+3tlBIzQb0TmT2j0JCigQTSkYjqshgitkB4h0BnOqCy8XW6Y
edpR/TMitA5XdW+y9bTeAswe4VwTivyZOXFHDatF3aKShMJbho7iFT8lcK5XoUUB
DID7NuC2Q8TdP11sVugWRisBZPnq/+U1LppWmvtl23D9ZwUxvh0QL92P7OVOn8i3
BZZftFWuLHbY7Enmt3Dg3d1vXWDh3wRMtCY6IwozJt+M9IlaHJap2at17JkJW0QN
IbPCTXA2ubtMKC/veXGFANBusUgTZSLzXPjulrEGpxplvnQCQoU=
=BHLi
-----END PGP SIGNATURE-----

--ffxsluguwebp2e4k--
