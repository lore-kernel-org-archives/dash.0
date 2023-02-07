Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C335BC636D3
	for <linux-dash@archiver.kernel.org>; Tue,  7 Feb 2023 19:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjBGTdz (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjBGTdr (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 7 Feb 2023 14:33:47 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41DA03CE0C
        for <dash@vger.kernel.org>; Tue,  7 Feb 2023 11:33:29 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C232411C4;
        Tue,  7 Feb 2023 20:33:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1675798406;
        bh=+zPNgPih9bH/NvfdpusETLSd0TrgWTt+UCzMQH6RvzA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=QPXoyeHbl3ZT0pyC52AB/BOPXYxgIk3iJmuffQms2HSiN0u3Z6jHkX5ia2eaSil9J
         b7NmqKL9fopTlek/o7FOyv1aUVhKISaXOKLRf/2HQP177D4wQ7UeHstVWmsE5Z0dMY
         yI8tvc/B59MkAP/GtIVEBqVEi19aw64NxgvDYC4gpcv+7xNqBbDJJ8QMdOqsd4VRqI
         s7SAN/8Dn6wwzXt94pDNVVPmxApTdEOcEsokqaNUjHBbEFcMxDe4uq85KrroI8RM4F
         GsCJxGIr10elRAWGbfbaRuM+OTDzHhlu6ZPJpHjwEANINJExO8Fx7UP+PJCVhcQ6Mj
         rzUVDw3tZZHJA==
Date:   Tue, 7 Feb 2023 20:33:25 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: [PATCH 1/6] fc -s: refuse multiple events instead of ignoring
Message-ID: <96c003b30fc95cdf5aed3162901abaa9b89430e2.1675798292.git.nabijaczleweli@nabijaczleweli.xyz>
References: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xeykwizvkycnqul5"
Content-Disposition: inline
In-Reply-To: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--xeykwizvkycnqul5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The POSIX SYNOPSIS (and our manual which steals it verbatim) says:
  fc -s [old=3Dnew] [first]
and, indeed, we only use the first non-=3D argument
instead of enforcing the usage, which is confusing.

bash:
	2025     ls
	2026     id
	$ fc -s ls=3Dwho 2025 2026
	who
	nabijaczleweli pts/2 2023-02-07 17:36 (192.168.1.109)
	nabijaczleweli pts/3 2023-02-07 17:38 (192.168.1.109)
	nabijaczleweli pts/4 2023-02-07 16:58 (192.168.1.109)
	nabijaczleweli pts/5 2023-02-07 17:45 (192.168.1.109)
ksh93:
	240     id
	241     ls
	$ fc -s ls=3Dwho 241 240
	ksh: hist: -e - requires single argument
yash:
	2       ls
	3       id
	$ fc -s ls=3Dwho 2 3
	fc: too many operands are specified
zsh:
	    2  id
	    3  ls
	tarta% fc -s ls=3Dwho 3 2
	fc: bad option: -s
dash (before):
	    1 ls
	    2 id
	$ fc -s ls=3Dwho 1 2
	who
	nabijaczleweli pts/2 2023-02-07 17:36 (192.168.1.109)
	nabijaczleweli pts/3 2023-02-07 17:38 (192.168.1.109)
	nabijaczleweli pts/4 2023-02-07 16:58 (192.168.1.109)
	nabijaczleweli pts/5 2023-02-07 17:45 (192.168.1.109)
dash (after):
	    1 ls
	    2 id
	$ fc -s ls=3Dwho 1 2
	src/dash: 3: fc: -s takes one history argument

Adapted-from: NetBSD src bin/sh/histedit.c rev 1.38 by aymeric@
---
Here's a quick few that fix my report and a couple of the ones you list
at the end of that thread.

 src/histedit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/histedit.c b/src/histedit.c
index f5c90ab..fc87283 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -296,6 +296,13 @@ histcmd(int argc, char **argv)
 		*repl++ =3D '\0';
 		argc--, argv++;
 	}
+
+	/*
+	 * If -s is specified, accept only one operand
+	 */
+	if (sflg && argc >=3D 2)
+		sh_error("too many args");
+
 	/*
 	 * determine [first] and [last]
 	 */
--=20
2.30.2


--xeykwizvkycnqul5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmPip4UACgkQvP0LAY0m
WPFf9A/9H+AenI8q+dFJ+0LdjafJrP84qQMOJSJWir7oeZtmOc0J5xM9BLaGRBlN
pvjYHQyfhqCbjqIKqrIkcuQDmcD9zDCY4Nh5YCLc2MCa2kQ9max7uHLXe8D8D0y0
IgI9sa41PQY4oNfW919HYaQ6E5ZFRyUfx1/m7tXS9vOY+qeGkMQ0vE+hnXPUuLEJ
0/2FR8q6t45jnTGUcLjzVJUuU4CevT8GTzjq6OEJL/bY/eoCYDWjKG1+sAVOZh0b
DF5Lbo6MxnnN5KHl3SPgw7Nl+uWVobTz2NWwKKCMOqTRWMBMk0Ilc3JCtuSCCpii
y0ZzuPHX9I2hSN3OH3Fq4gnBrlXSs5q2iK6SS5sTi1EomzndFVsIBfITn5+sXUoN
DkaJuusKU4HSAANJB6yX8db3E+Im3H5iCJRffdKhhT9pMI6v5qqyLt0BpFCpqGUx
I8J8rlP21r5SnJOLP38VsdfrRGhLDYWCaog7KZe6pPyrTBt/UuGrED95NClqaLfJ
U9rhtYT54YUwwYap1SdJb2jCZse9/lhsuMAZtr4mcX/IAFP6zJlSlqlBlyNm4Jdv
YGqz6bVWal7pYasayPCxrDUPAWXOFNEo3eZc80igQY1Hk6qr9z4q4OHy9NtDKX4Z
nux+U32sYtXoYCRgDvc8TPEXthxKU20wHALdkyHj1wuVe+YLz6w=
=zo/q
-----END PGP SIGNATURE-----

--xeykwizvkycnqul5--
