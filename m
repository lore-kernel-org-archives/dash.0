Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D0C4332F
	for <linux-dash@archiver.kernel.org>; Fri, 16 Dec 2022 17:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiLPRU3 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 16 Dec 2022 12:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiLPRU1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 16 Dec 2022 12:20:27 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC3FA70B8B
        for <dash@vger.kernel.org>; Fri, 16 Dec 2022 09:20:24 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 88D661250
        for <dash@vger.kernel.org>; Fri, 16 Dec 2022 18:20:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671211220;
        bh=/Gsgr4drAJKy8VWXcfvAgiHG6+nSqm408hdPlBQVS/4=;
        h=Date:From:To:Subject:From;
        b=fxx8LlPO1C6aSxZ9a5rHi8M6rmBT8agEjGMcagb7zEXsrrLoQfu1v9X1JXJIU7k6+
         qd8RoM+SWKZZtkUXjIOrERgG86xHGw3u5CQBIpsOlk9CrmAkSfBkkqOdm3OuXJjbot
         zF2aLeboWvjw4WyEtJHdQTFlt0gFDTK8dPWBPe7TVwqc7pXActCxe0m/NJQg5Bz1SZ
         240HdKOPyov7zQHKo7N3GWf/WHKwLDM9uPF/FscSBRO+wWHsk7Ys0Lu6DB935rkOyZ
         yMHlW/SkoUkB54XS5Eu9WvqNE2tk6hWq+0v0VZDF2yTdpx2mpZA/A+eymrGeJ2nNf2
         SEYF7JsMsbWIQ==
Date:   Fri, 16 Dec 2022 18:20:19 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] miscbltin: ulimitcmd: actually accept -r
Message-ID: <20221216172019.upb425kmpx75epml@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="44p2mm3mkroquvhq"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--44p2mm3mkroquvhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Vincent Lefevre <vincent@vinc17.net>

The original commit that added it supposes this works, but it only adds
it to the ulimit -a listing and the manual, but doesn't allow it as an
option.

Fixes: commit 46abc8c6d8a5e9a5712bdc1312c0b6960eec65a4 ("[BUILTIN] Add
 support for ulimit -r")
Fixes: https://bugs.debian.org/975326
---
 src/miscbltin.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/miscbltin.c b/src/miscbltin.c
index 5ccbbcb..e553f9e 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -440,6 +440,9 @@ ulimitcmd(int argc, char **argv)
 #endif
 #ifdef RLIMIT_LOCKS
 			       "w"
+#endif
+#ifdef RLIMIT_RTPRIO
+			       "r"
 #endif
 	)) !=3D '\0')
 		switch (optc) {
--=20
2.30.2

--44p2mm3mkroquvhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOcqNMACgkQvP0LAY0m
WPGhcg//UzRbZK2SE9MAmmfVwYEsUXHbCze0XlZBAarRGctFMOK6pyAwRXaXH4YU
I+RK5zUeCWCyKrlRkr2k2ImIxWOrw3Pa4t2vtQeEm/YDmgqr33h4YlbK/Ls+/a24
U8QN9ORTAEiPTuOI26QkqmmakE4YWHS6rraBybkV4FAoLVjS3wKpDwN7yOMkAFVc
ubcu4weOoFuFefEBB5YUfUtrU0wP+g7gyO2pUoFL1BGQY7rRRCuEClz7i1YE8eg3
vP72Ut+/r6/p/knl7A9cTMlJTxXn6LCxILiG/tnq6v9PDGbC2uQ0jkZ8r6EDPmo7
3QAWI4zi+eLtVU9145E5zkW76yHiLgFZFYoAxR+yFORAUdoUmc8yvc4Z8DIEvtuG
dSueJptgGQillTsDyXOtnPOWnObjtmicpC6J7lnTigTiFj5fFHwY1q341M17D3mM
6jecQ3DLnaOGpF1O/m+iBLJ2KpInJ6TcnNJ27mwX8FT3fqhIcyJshyxSKgbLuiEy
SFFx6sp0+jW2Gq+Szl+MT4wZOE5K/uxDvbRqIs5KQGbMV/mED97cGY+LM949zG9Z
54hL3xA6kr8AXG/kgCLrc8BagC5kFhZ6oI6GdQlMiJlsaKuk0efavf/HZ8+5W51T
AkxR4D6NreOdCPi5LmUQoafPJHAnLJ0dt1E1NpMh2t8G8QYQ/So=
=wMHZ
-----END PGP SIGNATURE-----

--44p2mm3mkroquvhq--
