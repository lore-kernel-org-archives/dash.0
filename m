Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D94C4332F
	for <linux-dash@archiver.kernel.org>; Tue, 13 Dec 2022 21:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiLMVNk (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 13 Dec 2022 16:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiLMVNk (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Dec 2022 16:13:40 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9840B13E12
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 13:13:37 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id CC8C913AE
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 22:13:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1670966014;
        bh=5lKuos6I/pVpfCRluZjl/jZOs5ePv5uNU0TPYnQ7n8M=;
        h=Date:From:To:Subject:From;
        b=SvKgfluXxeQv72vQh8iNq6jXdzmx1vbZIXSVDAqdXP2cJaNy0gwAEL1sDy1g6YfX1
         lEkhDg8uOT1zUaXJxFL+HUds0jSWTBrHXIXYRFB2MLbAhs/FF6eXBXTo+10tWVEbK1
         9SPJ/HZ7EYug4SsoC58RYEl7QCFrT4dmFGbmK8aB2R5LgWzr2RF6XYD2rXeUbbKfdm
         y03CR4Kth+l5hRLeHNPdTd8sxTFKj8SQhTbHbmWaI702C0PJNOu2RZZ5panisXXob+
         PRRIHuaZdPczyW2BDyTT6pTIqKaOT8/1gJP1lbUDVYZuowaNmHlR+dah/qF/987lGL
         oslIyvTBiEC2A==
Date:   Tue, 13 Dec 2022 22:13:33 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH 1/2] exec: type: ignore first --, per POSIX
Message-ID: <b9085f1a9812a436d37bc6f8d96d17bdba4433c5.1670966008.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ynpgph2zxkwvna72"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--ynpgph2zxkwvna72
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Issue 7, XCU, type, OPTIONS reads "None.",
and type isn't a special built-in listed in sexion 2.14 =E2=80=92
this means that XCU, 1. Introduction, 1.4 Utility Description Defaults,
OPTIONS, Default Behavior applies:
  Default Behavior: When this section is listed as "None.", it means
  that the implementation need not support any options. Standard
  utilities that do not accept options, but that do accept operands,
  shall recognize "--" as a first argument to be discarded.

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


--ynpgph2zxkwvna72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOY6v0ACgkQvP0LAY0m
WPGX3hAAq2F1gLTV25K2Zg3oLW2RQjSJfbd3Z+O0MCMoC3o9WjGiXaY5k9OMrV8+
vFvUOJEyyrbqo9nloHQHCDkyvBgWQuomEvs2dRlWjiE9X4FBm+8Jxiq0K9u8qfGn
BCl0u1i9cDnHPuhPu80QTHIgzi97L6vJM+gLT3hQBkFfKJTVCMHII/9xcVC0Wmgh
8Knc3+r0JDo7OqSbhcLxUKrhXPKpKqlRgiW1vpvzZtii5Bq8FNEEjOoL0cW7I34o
Gcs1jSbY/S6bzNac6SmnyjZQJxhfIScB2NcZeLFYiHvvPewEfFxx4obB/BHrCulE
MeFPv6GnqY2hs3QXijWhVKejWaf3kjX3Ami/4wEJrSZTf28Vsxs6EdSY5pjjhXVO
ul5JPGLS4YpIXicg4FgcTorTrgXVjVRGU9a5fI/PanRYkx1a1J03e0tkcp5qMojO
alJxfVYybinSXGpjlePt+SH/q+5HmWgTo7c9co/wAcSPMbFX4y71A619Tf7qxUKX
AVpI0nAl+3SJ0izkEPpkUUHr1IGFOw2FOOM7u2XH0u8/3qLHUpaaA8oOpub8+AoW
+UD21nEsHQm/wqDln3heBBj+v2Na6fixFds+hO8fGnm+Bsjvo2y15PAOf8npoFjA
+EJ7f1sZWSRs+Q5eVprLxcz+3XWTNhSOZslxG8jbt6eejS1oqeM=
=a1NB
-----END PGP SIGNATURE-----

--ynpgph2zxkwvna72--
