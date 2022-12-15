Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CBAC4332F
	for <linux-dash@archiver.kernel.org>; Thu, 15 Dec 2022 00:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiLOA0D (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOA0C (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Dec 2022 19:26:02 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83903D92
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 16:26:01 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DB33010B6
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 01:26:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671063960;
        bh=InmYENqlveH5iqi6lE5OE1O97PhH6+Nd4rifHr0iTTk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=XhbBAmXwduVvgdc+FQ2yyMQqJJArqHRyM4+vnjXgVU2UWeYyvr2Pcfgl0vR+4Xhk7
         +dWRdgpw6iR8d7BGmlNxTR/eZEY74sBKmeupZw/xgOsma/RgJQANQEE9+J4SqN8fuP
         nQHiTC3g+dHwuZsqzCoE/SJSgzBZdp+PtRIPbms9gb3MLGPRuef8l3Pl0gxQmS29cB
         vT1vlOmxWiRupBol9zHRSab/4VUkSvGqH8PdDV+vVl9T9QNOZnbe5VqjUWVFczVxjo
         JKJsiFbFh+E20/PXvMmH8yFnsUe5efvaPVdiHKv5kmaiAllRJ27sMwV0rD+ZJyRD54
         DbAfFpwbHaAng==
Date:   Thu, 15 Dec 2022 01:25:59 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH v3 2/2] man: printf: in 'X, X is a byte under dash
Message-ID: <05324b17e76eef2401dbc3ee7d64366134a42d1d.1671063918.git.nabijaczleweli@nabijaczleweli.xyz>
References: <50b331b19b78fd56c5b2190f1f922a755e5f3270.1671063918.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ddjh6z5lkcleqfv"
Content-Disposition: inline
In-Reply-To: <50b331b19b78fd56c5b2190f1f922a755e5f3270.1671063918.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--6ddjh6z5lkcleqfv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Multiple issues:
  * the encoding is not always ASCII
  * what ASCII code is assigned to =D1=8F
  * dash isn't internationalised
    (this is nonconformant but out of scope),
    and uses the next /byte/; in a UTF-8 locale:
      $ printf %d\\n \'=C4=85
      196
      $ printf %d\\n \'=D1=8F
      196
    this is in contrast to POSIX (and bash), which says:
      > If the leading character is a single-quote or double-quote,
      > the value shall be the numeric value in the underlying codeset
      > of the character following the single-quote or double-quote.
    (i.e. mbrtowc(&val, argv[n], ...))
---
 src/dash.1 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index 310f34e..38cf020 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1552,9 +1552,7 @@ otherwise it is evaluated as a C constant, with the f=
ollowing additions:
 .It
 A leading plus or minus sign is allowed.
 .It
-If the leading character is a single or double quote, the value is the
-.Tn ASCII
-code of the next character.
+If the leading character is a single or double quote, the value of the nex=
t byte.
 .El
 .Pp
 The format string is reused as often as necessary until all
--=20
2.30.2

--6ddjh6z5lkcleqfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOaaZcACgkQvP0LAY0m
WPG/gw//cQHMKxVIN+viMKQ/whBDPWcF45nwWt6Ny/K3xLiBJwjMpLRZ56kL6wah
/fOS6LPtMxdogw+PmVzQX08sPFzT/uqFlAzBNGdehEAOe0M2xq0qN71eeuYVF9xD
dAeZMKbep2cFBUDcBiMmzFOHVha5wIcdWA81EEBZeMBHnazZgqvC2HaQQVqt/7sk
ys1m5bGpDrQ4V5MjRN2Sr6IL1lsi9R5Ve97IHbse3uawiXJQQI6D6behE8d3UhjL
q8CDg/RTJWRcmkjLmzepm8hq8GVSC91MdIbKL3oXPQ2fp+yBk5aM9VJh31NTmFHq
8DDnkEFUTo01BzTbI6sPZVAyIPqP/BaV7h7Pe7KHakBMwkJ7LUmZRjOfTgV/YrDy
LKHU5WMTbvWLSKtiKkYRQILXnznsR77GzlpN6WLKM09ZiCMbKEMd4FKNpbvucmPM
lhDu+aFfCAvIkTFjJyQ7R4PIDwjYOJC6LXnC5q1lo7ggE7HUaBYYgNdNHiw68njU
owZvqQLzxrLSHktDQfveKDDr7bjvQYfIGsGE7gAghvMVjzQ4jGpUM6N5o3lx0gZQ
eKC0+xtE9esErdMwIW66g2fI7uQRwEJDz6BxyoE0hmsBnDmZAQWM72aCpOL0siwj
0RAvmlDUTtY9GrxYX7UMNBH85X3HtRV6lybyUdUB+VPmTUJbU+M=
=Dr1b
-----END PGP SIGNATURE-----

--6ddjh6z5lkcleqfv--
