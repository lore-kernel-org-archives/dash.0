Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40ADC64981
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 13:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjAENmS (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 08:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjAENmK (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 08:42:10 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D676439F84
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 05:42:07 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DE50FBC0;
        Thu,  5 Jan 2023 14:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672926125;
        bh=KSFRVe1ldidMj5+KF7iddP8dFns5sQCxw6kiwnPVyCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWVb7tkeh7i8T6yfNpNj0cqyyBdtLDlTNty/nmZsU5T6tr0GIFw32L07PiahsUZgy
         QEpFJK++2bN0WQJLw29e4RcpJIEhFj6eaH9ttvxSIaaDCY/nyjyExNC6VCS71iXleY
         MzW7z5ToCANVPA2tXAWYxz7cymKzvMHpckwCjZHSwkuMGsC0BJ/Jlv34UTdeVHLbuw
         HiztERUbteQAqcA6oZuiXTCWBgyeo2m2J5yDj/LN7HhyRb90h/b8uDcTkK4Wn296iv
         mhCRM9tbyAmNI3dy7IEZZKXU8y5EStXpz7QKPKy9QEqtgpHXAHNwIWy4LKfYKjJoG9
         0JyIVkYSx92xA==
Date:   Thu, 5 Jan 2023 14:42:04 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: [PATCH v3] parser: don't keep alloca()ing in a loop for substitutions
Message-ID: <20230105134204.e7mczfzt2vbit3oc@tarta.nabijaczleweli.xyz>
References: <Y7aSMJlVi7fXD1DC@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ei7xasrnq3zr6zew"
Content-Disposition: inline
In-Reply-To: <Y7aSMJlVi7fXD1DC@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--ei7xasrnq3zr6zew
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
I think this means we also need to turn the USTPUTC() into STPUTC(),
since the previous code explicitly over-accounted for it in growstackto().

 src/parser.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/src/parser.c b/src/parser.c
index 8a06b9e..f5f76d5 100644
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
@@ -1445,12 +1442,8 @@ done:
 	/* Ignore any pushed back tokens left from the backquote parsing. */
 	if (oldstyle)
 		tokpushback =3D 0;
-	out =3D growstackto(savelen + 1);
-	if (str) {
-		memcpy(out, str, savelen);
-		STADJUST(savelen, out);
-	}
-	USTPUTC(CTLBACKQ, out);
+	out =3D stnputs(str, savelen, stackblock());
+	STPUTC(CTLBACKQ, out);
 	if (oldstyle)
 		goto parsebackq_oldreturn;
 	else
--=20
2.30.2

--ei7xasrnq3zr6zew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO206oACgkQvP0LAY0m
WPFtKBAApvIVmTi4sdJ+52W9gI0XBtzN/+18Ldj4n9LvCGpHw4OGc2rz7PvBfFae
9QeOx92T3TqFiIWpPxYAPLLiyiiota5cecFUXjWviQiBFKelOnj+SOzDSdtccU1c
SZH6KEjtxj7/xNmykDZQM+Yv/JWGJsGTIr8Y93T37PXOQgpHoriM88VerG9iafKB
iWv7rSJLtvaDrwQRIOSZUoQG9Hjyp/LMs/EGod5OH+yaP/UlbuHiti8+IvJTrVcs
FKTmfP5gI4lsNweqeKQv0Qx3PwshvScw9eH5Ifd+0Db2fX3c4jd1xuW6IaTKKwIY
1sHsklcPxQWj0wO1CmbmDz3UJsOweUHCejlqqc3BWNy2F12tbL6B82+CgXzhph/F
yrTp8H4BayBg9KCgfe1kx9NQcNQaa60p+Qon1+3BoMrCmXl/j1XaMsWoQBFhnAy9
4MQeL3mjCYvRC30RRn26NZc8PH6x+QB9ZeO/EMujHCSXiSuvxH+fBddK3gDFB7eP
xfdewCYlNcFpTX+exGGjdwbi5GFoNsglb6AFu0hOfQkyH7xrJIgM9hC0OPwYkHqz
IVTxlmNUB3r5+siRQvTqkVQhrvZhjlwzPWJCU+uPRck1fv62w2orCyY39uluV59o
jMn5tVNgzC0jpQKlwlV73HbVcWf2W8e2uZmHdImUIMsa/AwLfEk=
=6b1i
-----END PGP SIGNATURE-----

--ei7xasrnq3zr6zew--
