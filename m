Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045ADC4332F
	for <linux-dash@archiver.kernel.org>; Sat, 17 Dec 2022 15:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLQPRZ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 17 Dec 2022 10:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLQPRY (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 17 Dec 2022 10:17:24 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A70E12758
        for <dash@vger.kernel.org>; Sat, 17 Dec 2022 07:17:21 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0A08BA7C
        for <dash@vger.kernel.org>; Sat, 17 Dec 2022 16:17:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671290239;
        bh=NuUGY4K3ehATo6NkjQ8Zz+MeNIp7o7WUpzluoyyLfUE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=KEflYoWiuyLupL44irIeRIWhOlVC3XOFyarqRgf94JHzfriS6YmgzukkOe7QAUjyQ
         fGn7XX55C6bzqxLjeDzsX/VZDTlk4Ehp2xR+km8EnKAn2dyTjVklc2Nz4UP5IXL2Jo
         NR3qGUCmN7h7f+gU1foGdmuJe0GLJDxyvQGHCgqm2YqHFSLhg9iD+YiSdlRxGMdc2V
         46naBAupZ892joLQBsRyZxQiU0CB4/YSMVVdugYmLi6b0a76qavAvT0PyDQoZjumJh
         dlocYlNl+GjYNAGss2Ps7wKf+DVNXGk+OK0DeJQDdQZWRf7FpHWgGxn2PjeoyUDyEw
         k14FRkVdTcsLQ==
Date:   Sat, 17 Dec 2022 16:17:17 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH 2/1] man: document ulimit -w
Message-ID: <20221217151717.tiupxl7jrgwvwjsr@tarta.nabijaczleweli.xyz>
References: <20221216172019.upb425kmpx75epml@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w4imawgd3gdp24m3"
Content-Disposition: inline
In-Reply-To: <20221216172019.upb425kmpx75epml@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--w4imawgd3gdp24m3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And fix the synopsis.

Fixes: commit 05c1076ba2d1a68fe7f3a5ae618f786b8898d327 ("Initial
 import.)"
Fixes: https://bugs.debian.org/850202
---
 src/dash.1 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/dash.1 b/src/dash.1
index ff02237..c9eace4 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -2121,7 +2121,7 @@ printed; for commands and tracked aliases the complet=
e pathname of the
 command is printed.
 .It ulimit Xo
 .Op Fl H \*(Ba Fl S
-.Op Fl a \*(Ba Fl tfdscmlpnv Op Ar value
+.Op Fl a \*(Ba Fl tfdscmlpnvwr Op Ar value
 .Xc
 Inquire about or set the hard or soft limits on processes or set new
 limits.
@@ -2174,6 +2174,8 @@ show or set the limit on the number files a process c=
an have open at once
 .It Fl v
 show or set the limit on the total virtual memory that can be
 in use by a process (in kilobytes)
+.It Fl w
+show or set the limit on the total number of locks held by a process
 .It Fl r
 show or set the limit on the real-time scheduling priority of a process
 .El
--=20
2.30.2

--w4imawgd3gdp24m3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOd3X0ACgkQvP0LAY0m
WPGDnQ/9Favwmr8FKBZUM47l7Jd4jhGPoYGYiXNu9CCMtCjJt7ESrKLY05z7z7Ta
95GZQqwXtIs1pR1qmv2o4Q3jrHka4F537Jx8s3BeipbDxupPOZkNJcrH13lmDKPS
MaWJPu82/8AfypvFsxkaPtVCjE0JM20GgrCpDCmpkreGn5l9DDpo5WTA6uwXO5zP
HAPm/+bcGp4/k1XR/URnAs9QPXshrkfrJqA8SF4fsnA2jcm8pZlKFRO5bJUojSvB
ALnybX/KoRKZLutl8b04uv9htH/qimhJq59dTUEm7EH+FfYOGIahaImlWyM9rxVY
decaf5KCXWWIv03HPBNyBgd5VOyZ5gCcPc81UOjl3UlsdiITeJX1Q+wgwQs5C3FA
8+VJ3FXNv0LXpWCcRCYTUQCXG/+mLkBdeDnaREd10FnfXggD+tnO7QF23L5pXqis
bn05S2bybbfkaytewOnsL6YdgQ0ynfEgXI8ER8Ao273JpPXDzVCyCPZD3NNhcmpc
exBwmoAH9UBaY4kRrk8tuTZIx/Uhz1qkEYqhYzRLtroZAxaFCyE65HcadM72ejw6
fBN55GemdsYiLAErW+fdJG83GQer1Mvp8GcwAPfnzDyPMIwiVii86sy32G4/7h9B
azXLvRWetoS0DZZPfm82OjyBeAXWetV2Jte91eylT0Ayy8ER3sQ=
=ZIkt
-----END PGP SIGNATURE-----

--w4imawgd3gdp24m3--
