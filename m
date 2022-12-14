Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8105FC4332F
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 23:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiLNXjk (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLNXj0 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Dec 2022 18:39:26 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2352945ECE
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 15:39:24 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 53E7D11CE
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 00:39:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671061162;
        bh=V0fmCYd5hkH1lJ/FQEM82C+izDClEDfEej2OgVWDYyY=;
        h=Date:From:To:Subject:From;
        b=MZgdrDSYMTnVCgYdFu+CenJ8JN2cdhkYr27ph1Nyx0yb+FytjMycJBWhSMdgGl8h9
         4CIM5LOT/T2doVSTxf3YJTwbqxzFSAXBNLNPZAkEiKhWjY/4f/JAgMjW55OaTX2on7
         UvlWgi+UnSDB66yxjhZTCRUUZ+r4vY9LLQB8D7HzzYJGn/yDJ+uKOboYQAie5ieEXq
         gbDGhtsUE2btspcyFQV9V7X99FQLX7OJk+4c86jV4J57JdE2uH6jx9YQ2NoPa1KAew
         8wZdOMX+LsJeIpGXTtDVXtn1pPuc9LqeBxlJyX+82LdFTL1AOpdWuWQYONXy+vYqDE
         VJPBSp4YcldDA==
Date:   Thu, 15 Dec 2022 00:39:21 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] parser: don't keep alloca()ing in a loop for substitutions
Message-ID: <20221214233921.m6hpt5a6kb3wgyjl@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pkcwtjcn3mxuqizz"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--pkcwtjcn3mxuqizz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When encountering
  printf %010000d | tr 0 \` | sh -n
  printf %09999d  | tr 0 \` | sh -n
you want no output and "Syntax error: EOF in backquote substitution",
respectively; instead, current dash segfaults.

This is because the alloca for the save buffer is run, naturally,
in the same function, so first it allocates one byte, then two,
then ..., then appx. 4000 (for me, depends on the binary),
then it segfaults on the memcpy (it's even worse, since due to
alignment, it usually allocates much more for the early stuff).

Nevertheless, the stack frame grows unboundedly, until we completely
destroy the stack. Instead, alloca a 1KiB buffer on first use and
fall back to ckmalloc for bigger save buffers. In practice this means
that we'll alloca nothing in a good amount of cases, then just about
always use the alloca buffer except for truly pathological input.

Fixes: https://bugs.debian.org/966156
---
 src/parser.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/parser.c b/src/parser.c
index a552c47..3f7e50a 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -898,6 +898,7 @@ readtoken1(int firstc, char const *syntax, char *eofmar=
k, int striptabs)
 	struct nodelist *bqlist;
 	int quotef;
 	int oldstyle;
+	char *parsebackq_save;
 	/* syntax stack */
 	struct synstack synbase =3D { .syntax =3D syntax };
 	struct synstack *synstack =3D &synbase;
@@ -906,6 +907,7 @@ readtoken1(int firstc, char const *syntax, char *eofmar=
k, int striptabs)
 		synstack->dblquote =3D 1;
 	quotef =3D 0;
 	bqlist =3D NULL;
+	parsebackq_save =3D NULL;
=20
 	STARTSTACKSTR(out);
 	loop: {	/* for each line, until end of word */
@@ -1355,15 +1357,18 @@ badsub:
 parsebackq: {
 	struct nodelist **nlpp;
 	union node *n;
-	char *str;
+	char *str, *mstr;
 	size_t savelen;
 	struct heredoc *saveheredoclist;
 	int uninitialized_var(saveprompt);
=20
-	str =3D NULL;
+	str =3D mstr =3D NULL;
 	savelen =3D out - (char *)stackblock();
 	if (savelen > 0) {
-		str =3D alloca(savelen);
+		if (savelen > 1024)
+			str =3D mstr =3D ckmalloc(savelen);
+		else
+			str =3D parsebackq_save ?: (parsebackq_save =3D alloca(1024));
 		memcpy(str, stackblock(), savelen);
 	}
         if (oldstyle) {
@@ -1449,6 +1454,7 @@ done:
 	if (str) {
 		memcpy(out, str, savelen);
 		STADJUST(savelen, out);
+		free(mstr);
 	}
 	USTPUTC(CTLBACKQ, out);
 	if (oldstyle)
--=20
2.30.2

--pkcwtjcn3mxuqizz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOaXqgACgkQvP0LAY0m
WPExuxAAtx6TkTYyoXFq/NZ0j/vDuJkxhYkjrZJ2jOwMfYyItsbmah/vI+abcSm0
oHpbdfiNlhOSFe16zBxsb8M/0EKbQyhAr5zeOiGKAi0I7aXTXkeBhGq8a2S0GcLp
Z4jamUjMmOOQExzOQbjBvtNcYZmUtomBIXjoWmVnqWdwxui/gfsiV1JhJqlydUdF
x4Di6X5AIzYXNHQWEGACWMfNTK/ml7LvpdhaVWNcI0V56BQNLVY5mIgophNp7LZ/
XqfrXhrN1uGtdIqbruDgoS8z3JxtvQN6ppCUi1+G1Cpm6tm6b1T77/hOfsGnKx+f
n6excFEjeV5+Uyatz0tlNriGsA+qf7qKebWHMTJS1kbMiYmdeNQ+z/0YV5gRUMj9
XGffnPbHFoOMhtUPcOplNh+pW7OVSs8qZ3p4co3NvR9nSy4SLbZD5y6/a6KqP/7/
VzfJdLhiSOLCax07aFDM3AJkyyufSXylqjsilK2rzJCNq4ecl8CMerYO5/FYevbm
UdMB/r5fjfdoBCj8FLCMSL5C/cIp9tv+1fLGH1IkHo2AMR2H765O/HYIqa4T8tM1
ujqTX/4BCLj7sr0M3FjrpyCuQZeyzvw5DNKVBGJ5iSwphee7LZ2TqbVXg4xWLWDW
ZG2BcF1QU/52ih0N6FsAkeQB9mGwZkfpj40cG2ztn32wuVgL/r0=
=DON3
-----END PGP SIGNATURE-----

--pkcwtjcn3mxuqizz--
