Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57759C4332F
	for <linux-dash@archiver.kernel.org>; Thu, 15 Dec 2022 17:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiLORCp (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 15 Dec 2022 12:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiLORCV (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 15 Dec 2022 12:02:21 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E89E27B16
        for <dash@vger.kernel.org>; Thu, 15 Dec 2022 09:02:19 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 59857160C;
        Thu, 15 Dec 2022 18:02:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671123737;
        bh=MGpScLVf9ipd13IlaJ7GQlKp7jEJmZtgNxrL6cWLLuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3VpRiC6Y3ZDEPOb7ChmOjBEo96/rjibA1O/RE5s4rhxnnW79NZoZCPsfYtABChvn
         Dz7Gs/zSXpgBqzoP4J8vkhnGmCmOU+B0VVDUiA1dliwSx2quY//jWdTAd8ESGigToa
         Vb7+TyApsTtc0fM5rDaAtge7gk8XT7Rvpx0C+9oLaGndpE5xqgV50WOEN1u9skJloO
         wUir/HR1lCfYx99hse7LL1Q9YBIXNANhdbxHAnA9+fV999FxIMjAPmFGFpzOTve/3a
         LBr/YwzkXrynXS8WGCPI9blRmJnY03VKG+sGDbLKGGEHGgw/5tfNZVKxe0jHG1NVan
         vPYuhSpcFKiDw==
Date:   Thu, 15 Dec 2022 18:02:16 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: [PATCH v2] parser: don't keep alloca()ing in a loop for substitutions
Message-ID: <20221215170216.hm6i5akmxbz6u62j@tarta.nabijaczleweli.xyz>
References: <Y5r2oJdWI6CfwwHR@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kbpnmmzmkcctqoyo"
Content-Disposition: inline
In-Reply-To: <Y5r2oJdWI6CfwwHR@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--kbpnmmzmkcctqoyo
Content-Type: text/plain; charset=utf-8
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
destroy the stack. Instead of squirreling the out block away, then
letting subsequent allocations override the original, mark it used,
and just re-copy it to the top of the dash stack. This increases peak
memory usage somewhat
(in the most pathological case =E2=80=92 the above but with three nines =E2=
=80=92
 from 23.26 to 173.7KiB according to massif,
 in parsing a regular program (ratrun from ratrun 0c)
 from 28.68 to 29.19;
 a simpler program (ibid., rat) stays at 5.422;
 parsing libtoolize, debootstrap, and dkms
 (the biggest shell programs in my /[s]bin by size + by `/$( count)
 likewise stay the same at 12.02, 41.48, and 6.438)
but it's barely measurable outside of truly pathological conditions
that were a step away from a segfault previously.

Fixes: https://bugs.debian.org/966156
---
Naturally, I hadn't considered that.

This version I've run through valgrind in a good few configurations and
am happy to conclude there are no leaks (and the memory usage bump is
imperceptible unless you were almost-crashing anyway).

 src/parser.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/src/parser.c b/src/parser.c
index a552c47..89698cb 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1360,12 +1360,9 @@ parsebackq: {
 	struct heredoc *saveheredoclist;
 	int uninitialized_var(saveprompt);
=20
-	str =3D NULL;
+	str =3D stackblock();
 	savelen =3D out - (char *)stackblock();
-	if (savelen > 0) {
-		str =3D alloca(savelen);
-		memcpy(str, stackblock(), savelen);
-	}
+	grabstackblock(savelen);
         if (oldstyle) {
                 /* We must read until the closing backquote, giving special
                    treatment to some slashes, and then push the string and
@@ -1446,10 +1443,8 @@ done:
 	if (oldstyle)
 		tokpushback =3D 0;
 	out =3D growstackto(savelen + 1);
-	if (str) {
-		memcpy(out, str, savelen);
-		STADJUST(savelen, out);
-	}
+	memcpy(out, str, savelen);
+	STADJUST(savelen, out);
 	USTPUTC(CTLBACKQ, out);
 	if (oldstyle)
 		goto parsebackq_oldreturn;
--=20
2.30.2

--kbpnmmzmkcctqoyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmObUxcACgkQvP0LAY0m
WPHEbg/+N3X9ch8e6pkOFJsDO4RjfsqRVlUnDe5AhvQrgEp9uCCc+hzla0e09TXe
FK8/fMAtXCw+u/fIhTMbweQvUxundQDltowK9Y2fhtI91XtIsvflkTQdqAvRc/En
qe+almdsjpfP3k/48xdyFM+LJBRH0pewqp3nFotEBl4F37jQ0MWgVkWBeMYRh40b
WljFQWNr7HBia1pBfH9tGbr+SrTSXcZ4QpPjIXnC5wCVQIrYCK0PoSv2SYFKAcWm
ezSeckfeFXDl3bdX9LrSpPK5c4KTokm0gfDbvhcTPKO/G6d2SOI9wy7PjZCgwxC1
etrXa+D3YpL/hlTaiFYhvhJqWG3/BfyZ/H+C6DM7BmODjEZgjTTA/4Xz1fjA2zBC
JqTpykSg7dufLEPuSfjZuRwLxLiBrG3Ch5p/u1fJpLVZftE/y9kazjKn6t1oYGJr
MbzKexsQGVWnwAIoy85qvHrcXYq4fcX914ANRsSbY0jbz5ADVbv/Th4iIFiNQF3V
VPz7YvUb6AaPOkZ3hFTrYX+X3rsOD5K9q5ew2XVR0FFs/+EU00T/Vc3cRsBJYIgu
ysBMEKDGDYrSm47kSRRwTFXmCucD0suoYNayjtypcM4lM1Hy2F9uQOx+B2dtqONh
EBMDyjSt/K13TcTNrnHlF/co9eJtAdA+1COv0LNytzVeHmgCaok=
=7OJc
-----END PGP SIGNATURE-----

--kbpnmmzmkcctqoyo--
