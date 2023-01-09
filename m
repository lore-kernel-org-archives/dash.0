Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28285C54EBD
	for <linux-dash@archiver.kernel.org>; Mon,  9 Jan 2023 00:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjAIAMi (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 19:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjAIAMd (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 19:12:33 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EE7B1144A
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 16:12:23 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D88981126;
        Mon,  9 Jan 2023 01:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1673223140;
        bh=dEvsxRGwxtTaf1tRKPXRt2rH+AYzQH2luGS+/ohQTcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AnwIeZNw9t6AWWKi7N2MupvRfJry/wqVr0lAg/kYxeB14km8u6RkZTpphoPnFxHKU
         ike9KvbUjY1RsWqNq8JsZa9ngxB/FKcJyPYn89JACbikWD8pOPQOmrRlj9U3EQqMD4
         yNjtgALtOkbyPcIguO+8M+wFmlkZc5qczunTdRpNqFTBTLgjptVjhsihdcP7JLu5bG
         VPeAym6XN5EeCJFQ+gVQ+27pvrijyflEYTeMhKP/ACr8RMffMoYgUJHSktZDlOFSSm
         SG5In/QeaMUEKP9l4qmK3heRJTigulYi4PeHY/9QEolvbKbgNwiWS/HOolb1mrfaFL
         3O+GGsZYyuMGA==
Date:   Mon, 9 Jan 2023 01:12:19 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Subject: [PATCH] alias: fix name quoting in printalias
Message-ID: <20230109001219.2ylktzb7uckoeti5@tarta.nabijaczleweli.xyz>
References: <ae838562-3d6d-aad8-f3ae-8d7d23e25c4d@gigawatt.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xeci533rptxhhaud"
Content-Disposition: inline
In-Reply-To: <ae838562-3d6d-aad8-f3ae-8d7d23e25c4d@gigawatt.nl>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--xeci533rptxhhaud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

single_quote() over-writes the stack string, so just output the name
separately first.

Fixes: commit 4ec545e8dc98a3f461cf56bed03adafa81c64aec ("alias: Quote
 name in printalias")
---
I coulda swore I tested it and that's where I got my commit message from;
I try to always use my history verbatim for the messages,
for this exact reason.
That said, I can reproduce the bug on trunk and my clean original branch,
so dunno how that got there. my b.

On trunk:
  $ src/dash -c 'alias foo=3Dbar "a|b|c"=3Dd; alias'
  'bar'=3D'bar'
  'd'=3D'd'
With patch:
  $ src/dash -c 'alias foo=3Dbar "a|b|c"=3Dd; alias'
  'foo'=3D'bar'
  'a|b|c'=3D'd'

 src/alias.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/alias.c b/src/alias.c
index 1375cdd..3cd589c 100644
--- a/src/alias.c
+++ b/src/alias.c
@@ -197,7 +197,8 @@ freealias(struct alias *ap) {
=20
 void
 printalias(const struct alias *ap) {
-	out1fmt("%s=3D%s\n", single_quote(ap->name), single_quote(ap->val));
+	out1str(single_quote(ap->name));
+	out1fmt("=3D%s\n", single_quote(ap->name), single_quote(ap->val));
 }
=20
 STATIC struct alias **
--=20
2.30.2

--xeci533rptxhhaud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO7W+MACgkQvP0LAY0m
WPGsfA//bQQIq560Fnd0VDZmxmOZoMZN57Q6HmgKCCBu0SZEV47dr39HwN1p3fQy
8SUoxKB+fnUQygkSRtuwGmeHiwovI9iFdO8PuTBphCbX6yMJC7vtOb71o1maW1Si
2pVd4Mj6YW/lct8mqjqJ/wK/KzXzcLhzROooQ6nokbxw6AVbGgodQ9cFG+L/J47s
+tTHcT7REmLBBprSY6EoV2Jp0mZW8J+LfxIKTtKUQZpTBe+1e/B+oOzPVk1B8NUB
FQUDa/PIUUddFFooHQXmaLDhS3ezJlIBCZ9vPl3zTuF4XuGCeQ1kF2Wf3rxiRkyZ
3NsIJzJAnFcPT+VwwyyyOXxOZp5huB+q/Gs2eBh3EXuppUp/+4pd51tdm3nIbYLj
OTnVtSvQPDAx5LSM10NSWbsptkBbDb3ZkubX4e4MdKl3eGmxI7JAs9vAIWBMyw7U
yUo4If3gj5byMb0qoM9MKXjq17YcNeRsbsiXSGR7Nqm49vUTDBQo0CT6xCySS07D
+Vw8rFPPnp4KBHTBH9SYRKtvbWmOkmSQakQepj9ZztYiVfjbEbHZAYJ2/wCDTl79
7OaGX9ZQAka2if7iyjSaHR6FAi5rRk1t0e/QvtTZGiiyxnyy/0ij0XnVAYQwb6qK
kONuREyjHkKmgQ8ZlOm958yUdMri/JfFXiKIw1Zoh8K0w5wdeTA=
=h4LD
-----END PGP SIGNATURE-----

--xeci533rptxhhaud--
