Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33C7C54EBC
	for <linux-dash@archiver.kernel.org>; Mon,  9 Jan 2023 00:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjAIAPr (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 19:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjAIAPq (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 19:15:46 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94C2AEE
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 16:15:45 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DFDDF1048;
        Mon,  9 Jan 2023 01:15:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1673223344;
        bh=WFHUqTpNWxTbB2UEuJwbBuUVa7wOWmEAT+Qln0r+DT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=teeuVMG8/o+SOvqPs98bpvYsXJ/suDQSyx/fkO9zdTFQDiE+zqreXFsCpE5LTdInp
         ybj7qwacwVd0IEv1kUCF81F3llDD7Lw/wH0S66uaeKk2LxiFez26kIjYWmhfGWiOWH
         AVy8DwrcCrAkEq78Z6/03nYbQolWG8Y7giJjjO68NJpOjYLvnj9NXfp5/n+fn8iZt2
         KR6FPsAwpoxHAWNcdFPlZlKC2f3uNwIpMRJXwLwEUepj5Qkm4mlk8lgSDKGicM/4p5
         PjVzT1zvxu0S+JUoCl95XbE9l3ypHDsQAbXhgOZMd48HOCqy86FGWXcvsIMUwrg0vU
         pu+5P+Hr/3A/w==
Date:   Mon, 9 Jan 2023 01:15:43 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Subject: [PATCH v2] alias: fix name quoting in printalias
Message-ID: <20230109001543.vpk6khjtqkjtrjox@tarta.nabijaczleweli.xyz>
References: <20230109001219.2ylktzb7uckoeti5@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7hb2riuxrznjm2he"
Content-Disposition: inline
In-Reply-To: <20230109001219.2ylktzb7uckoeti5@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--7hb2riuxrznjm2he
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

single_quote() over-writes the stack string, so just output the name
separately first.

Fixes: commit 4ec545e8dc98a3f461cf56bed03adafa81c64aec ("alias: Quote
 name in printalias")
---
really not my year sorry

 src/alias.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/alias.c b/src/alias.c
index 1375cdd..fcad43b 100644
--- a/src/alias.c
+++ b/src/alias.c
@@ -197,7 +197,8 @@ freealias(struct alias *ap) {
=20
 void
 printalias(const struct alias *ap) {
-	out1fmt("%s=3D%s\n", single_quote(ap->name), single_quote(ap->val));
+	out1str(single_quote(ap->name));
+	out1fmt("=3D%s\n", single_quote(ap->val));
 }
=20
 STATIC struct alias **
--=20
2.30.2

--7hb2riuxrznjm2he
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO7XK8ACgkQvP0LAY0m
WPGsfBAAlKeskumYUTiXHUr6CgAMVRuFNKGPipTkhX41/c3a/7mBgXcgUSm0ukE9
JEXgshiv5PPDQyvlmb6KJ0WwqMpfCvhpk2zQR1TEO5BSF2O/+sNk2/JYNTKx+DR5
BTaKD72TPFKY7W6kEhqGdPeLxLsMUGxhVC4p5xpG4lu8O94dIn7xo5Bks8q0OLGg
aEBpVzBFJ4kMzjfe3a9sceXlZUxzyNxk9UHJhJcq21g+IamB/T+NBstm89VTpBYH
f67aTGGWuNRXA2dXeuzSQ4VFoNi4JJok8F5Sx5Zf3JZY4O+hDdzURhLTjloN+Lh+
5E3tP2emdjjL+Vd8Ws8zzSszbUM38fDVF+hhuig4zsfYUCHoEtr0yE/5B6AjWYT/
jD2QVkQJqQizEq6quSekogkhozksa9fm7QkS7kAgVTmzO5UUluq5rejug9jNQbUc
NNBqkwG/LcffXwJ9YAvD0DggWos3heSSwLbUzqj+EVx79zjQKDlqhnYGooqy7oce
8MS/RB8el3IQI3DjhO9RDiPVP8FG+Je6x/vB7AMumAE48rof4/iLV1W6+vSEC8MO
rQcK29agozy9b3t8kyXXB1VE1SGCMl6GT+s0kSpGZj+JROxV4v22nDAgPEpV9YLG
Xsbyw+36z345Zn3y8dDxP9UlnYmn48rRciLiBH5zh3Mh2hbIdQY=
=Hxzv
-----END PGP SIGNATURE-----

--7hb2riuxrznjm2he--
