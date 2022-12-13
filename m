Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDB9C10F1B
	for <linux-dash@archiver.kernel.org>; Tue, 13 Dec 2022 21:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiLMVNm (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 13 Dec 2022 16:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiLMVNl (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Dec 2022 16:13:41 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A6112189D
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 13:13:40 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9077013B0
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 22:13:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1670966019;
        bh=H8X/NWq1wHSLLBAC5kYtVMs2VRbpJA6RlHz69DtL3DQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=pehX6+ondWrHuucyH5/ZSqc729VyuMtPYh0F6EosQ0KNPIHeCvqyy5RpcIDzPMpyG
         6Lw3FXEBDx/2P+1Jln0OCstJoxJyZanlBdhfs7PCwgAsR3/450a9j3QqvnKkk8n/e9
         Ptjbgu4Z9LXsyvNtcq690e0a2sznrHII+tz0kN3y076dOQ1Q0ZJ8EKWBxCk6tZpE6k
         QY7pmYbdisOdEajjI5Wg71wEKEYcJlbNTFP7SztSOxrPmNFfRK9EvVmpcbJg0E+OQG
         MRrmORoiPWAYYB1XSs+OVt6WsONpRNsgjjpFICMZNuQCRFofJ46+IeUlP59w5PXEpA
         fvJXLdSGa5SfQ==
Date:   Tue, 13 Dec 2022 22:13:38 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH 2/2] options: getopts: ignore first --, per POSIX
Message-ID: <d7d04bbcf75c97c52726bf65e9ed4d9310ebdd51.1670966008.git.nabijaczleweli@nabijaczleweli.xyz>
References: <b9085f1a9812a436d37bc6f8d96d17bdba4433c5.1670966008.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q2mla3gnexac6du6"
Content-Disposition: inline
In-Reply-To: <b9085f1a9812a436d37bc6f8d96d17bdba4433c5.1670966008.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--q2mla3gnexac6du6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Issue 7, XCU, getopts, OPTIONS reads "None.",
and getopts isn't a special built-in listed in sexion 2.14 =E2=80=92
this means that XCU, 1. Introduction, 1.4 Utility Description Defaults,
OPTIONS, Default Behavior applies:
  Default Behavior: When this section is listed as "None.", it means
  that the implementation need not support any options. Standard
  utilities that do not accept options, but that do accept operands,
  shall recognize "--" as a first argument to be discarded.

Test with: getopts -- d: a
Correct output is no output, exit 1
Wrong output errors out with d: being an invalid argument name
---
 src/options.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/options.c b/src/options.c
index a46c23b..337a8ee 100644
--- a/src/options.c
+++ b/src/options.c
@@ -409,6 +409,9 @@ getoptscmd(int argc, char **argv)
 {
 	char **optbase;
=20
+	nextopt(nullstr);
+	argc -=3D argptr - argv - 1;
+	argv =3D argptr - 1;
 	if (argc < 3)
 		sh_error("Usage: getopts optstring var [arg]");
 	else if (argc =3D=3D 3) {
--=20
2.30.2

--q2mla3gnexac6du6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOY6wIACgkQvP0LAY0m
WPHnMg/+MzDmqz3aVSiT6VQPSPmKEhgYL4MYcj9CoiKUQNgFPFZVq/oMDoYv5Ykw
oA+HgotkD/B99/azA4kGKnrYET80apEEl9CMnABN3oUgP7Ivy5gc0nZoyk25ORNY
mwABTKDzCQsf0MsJBT91OhtlTUbpzUHo5XfuXOVSYIxJ46/fyWer5Hsbn0DzO+VW
7soiuGoCb7iUDrU6/kpZQMtIPLhIYe7E5zLs+/QDFLApAzVeKjcTdFCRPh3laT7f
dv7w8sCyinSTZbSBwk1r7en2wvTjZCeG8ljdG0ORcFo4TCBY+40+S0Qhpq3UipjP
WiulBJcGAaWyXLbBIUq/LySnQmfFWp1kXcmv6+tLJWxHbOhirqbRO9pT80g1lwuM
L0Re1BSHo0Z2y1iWKWQdiuXUK0JxwLiICKvaUv9d6+LLKkmvgywsD14/bP8TU7ID
0SNlxZvwQrN3LOi0RkeIOyG9DFxrXv9Rz6LKMX3oBSG9HGNfJY7tQK8XMI71Ptk/
gSBseVuhVL0WH79O50kpSHlQXD2vR2EBUOlAIwCfBHMZP3wOC4Ky1th4Xl1EVBjr
jiCtMSIlVaLQtxv5L2qP5LpilszHToVaZfxh7+qKHcoRsJrqLQMySSjMVDp7bjxA
uEvCluCdyB6XPdnVyMVwDo5AHJCN2Rh1hqsdgHO1+nfKauLJUeo=
=1cTt
-----END PGP SIGNATURE-----

--q2mla3gnexac6du6--
