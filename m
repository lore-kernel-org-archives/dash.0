Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E72BC3DA7D
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 12:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjAEMt5 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 07:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjAEMtu (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 07:49:50 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 007304C72E
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 04:49:48 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 48CFDA38;
        Thu,  5 Jan 2023 13:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672922988;
        bh=YF+9i+Z73DlD+ffREeD2ra8boNSdcbOJpzp7LZOqUJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1SLvQBnKD/gpCGD8zkxXKujRwCr+zYBZkW39ITR0f04MS/jJQWyswPKxEcq51u/o
         ITVwPHgpEDr0rKX3Draz84n124ZrUHixiiWBP0SdLyMJxN6yWoY/7gqiNzv156OEaf
         XcYVMj6YIfy5yj9vvgcFQ8KpggDmZYFattnoZfRTKug5ywpRNMAIEYF70BGETxezrh
         QdjSD+vyvXUKxrC7/tVMuuq3m0WGow1tVzDSiUrksmdEHj+AoNtswZvTABCtuayro3
         HPRdOPgAbK+99GBJshNsXD6jQ6PxxGiyX4SQsAGLrjq9VW6c0mgUw6z3XVh6QRcXqE
         9FN0I/hlpeaeQ==
Date:   Thu, 5 Jan 2023 13:49:47 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: [PATCH RESEND] alias: printalias: quote the name, too
Message-ID: <20230105124947.ewohzmmwddcpj4en@tarta.nabijaczleweli.xyz>
References: <Y7aTHHpWKPB2FfA7@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ayja34t3nuicopif"
Content-Disposition: inline
In-Reply-To: <Y7aTHHpWKPB2FfA7@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--ayja34t3nuicopif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This ensures even something like
  alias 'a|b|c=3Dd'
is output by alias as
  'a|b|c'=3D'd'
instead of
  a|b|c=3D'd'
which is both "suitable for reinput to the shell" per POSIX
and doesn't execute the aliases as code.
---
 src/alias.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/alias.c b/src/alias.c
index daeacbb..1375cdd 100644
--- a/src/alias.c
+++ b/src/alias.c
@@ -197,7 +197,7 @@ freealias(struct alias *ap) {
=20
 void
 printalias(const struct alias *ap) {
-	out1fmt("%s=3D%s\n", ap->name, single_quote(ap->val));
+	out1fmt("%s=3D%s\n", single_quote(ap->name), single_quote(ap->val));
 }
=20
 STATIC struct alias **
--=20
2.30.2

--ayja34t3nuicopif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO2x2oACgkQvP0LAY0m
WPHZKg//c0mUCW11uJ8taVU+uPMBAxJ1k2lnS+c22v50mrP8F3Kbj7UjZLVl4IrR
eA5CktixB91xj6nylbf43eR/A64/cpXa10JpL2gXcgb4O4WtFp2hkmxriwy1cilb
ErGxR4zQyn6Juin6Yta7Iw34ovBT4Q2JOlViS+2gP7/06hsMjxH8J+7Rqzmtrp8L
UfhT46DpgK0I0G4ElCiOTF3X+ui2PXj5ylolBksn9yyyGE2DiNbcHdlhC4rgxhj2
hdxfNMEyAXOipXrONnCoeZ1DzDbI9V8elu8qgh7Za+HLaJbsmaL4nQlqyKCbSHOy
0LQkWnbxguk9E2GoAHmtRrmcF2QeESIKGDE5FQLoNlUBTtMbE7B40WJnVQEyZraG
TFVPEnGtZMdafGK8TzSheQ5gVLUzf2pGKLsKeZH/PXZjnAlRoZmvXlkey67Cc50D
FnqJ8MYe4l3sExr+KxmaJTSDdzlO+EHzNC5rA9K5wO3FNCY0UksT0ftA4oyYG014
e2or0p5KG3tDTHb3XfwfMeIE1QflJMpaudyvDvBF0evfcF1cBnFgLmckO+c4mboV
FJ5GFZ3Mu6HEBdVxDB3zlofCTzY0V0zkca8u1KugeM82r6uutLyjh0IMzGi0WGRH
NiWEqO9U1EgDM/iKYtimi2IZRTJcii+ZeReR2bhTU4HW3UEm6vY=
=aRP4
-----END PGP SIGNATURE-----

--ayja34t3nuicopif--
