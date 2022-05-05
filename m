Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C6CC433F5
	for <linux-dash@archiver.kernel.org>; Thu,  5 May 2022 22:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiEEWSQ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 May 2022 18:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351287AbiEEWSP (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 May 2022 18:18:15 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 15:14:32 PDT
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D59F85EDDD
        for <dash@vger.kernel.org>; Thu,  5 May 2022 15:14:32 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C836C1B92
        for <dash@vger.kernel.org>; Fri,  6 May 2022 00:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1651788743;
        bh=brtJ09KtUjbwbkqZIpRG39TFsX50fSqRTIffHcn4nW8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Tx40hwyKpz9e7gN2Rq9WXRadSyN2rn6v/lanwwqNROX05dt5k6o+kNUbpMyFkcuys
         /zE/uTYrmt3CUxeLNzJ4AkDs6GWBccP31cpmaKH8ikuiaWssMxwcpCoGUPJqRlPv6c
         q5oGRCupTfzCs96TP62AC/KbynGy19aUNuQvcBiqJN/uVJQfxoSlA+wukmEC0O/86O
         oaIcO2UDYmj7z/p8qDKYyx3HKSwE/pB65kDUc0Yvl3pr9D5ase1XlXwRWNm/UjbuWv
         Nagt5nRLi1WUoOtWrmz9oMZQ3mOLrwOJX6pe9ZmaffODQtgbArU4X/LndKsEBRl3rk
         4iy+ktm6AIAzg==
Date:   Fri, 6 May 2022 00:12:22 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH 2/2] man: note chdir being the same builtin as cd
Message-ID: <1517fbdef919dd93b775a4c4278b98d4d626d071.1651788702.git.nabijaczleweli@nabijaczleweli.xyz>
References: <a54b9dea2b316ef9f5749cbde95417a2bad7a4d1.1651788702.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ztylkrwiqnc7eazb"
Content-Disposition: inline
In-Reply-To: <a54b9dea2b316ef9f5749cbde95417a2bad7a4d1.1651788702.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--ztylkrwiqnc7eazb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The manual now contains all built-ins

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
Please keep me in CC, as I'm not subscribed.

 src/dash.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index 969a883..dd2bd47 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1143,8 +1143,8 @@ Do not execute the command but
 search for the command and print the absolute pathname
 of utilities, the name for builtins or the expansion of aliases.
 .El
-.It cd Ar -
-.It Xo cd Op Fl LP
+.It cd|chdir Ar -
+.It Xo cd|chdir Op Fl LP
 .Op Ar directory
 .Xc
 Switch to the specified directory (default
--=20
2.30.2

--ztylkrwiqnc7eazb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJ0S8YACgkQvP0LAY0m
WPEppBAAq34+ABN8pV/ZN5z81eRYanu+a6p1dPZbXS3DlFF9CqoN7AbnqlLjt9mf
RSfAbBckkGLJfaMgcqwhVCTPN6DHRH5U4daaOziB5pCHhdCgcDY5tcpBGsibncMW
1KsEyGc8ei/tjpi2UGInFRF5FYCdLt4ik1Y0SkMVIedceqXEazzGWcTJiyFfJiid
VEcu5BOfRdkRFJHDyBcTAOcZAMUJYc4gOjvQFbpo7ms0qDNZT15di55zuI09z3MA
vRdyNOyy2gP1j29srblFyK03dHA0jg14OJmvGbnCWXGpnSclgeeYwSObJCxYRWFd
at8nnnPg7hMbH+NWW4sLGEby0ObNdI5CFo00ODb+roqwMxZEdZfIRQw3RMv9QXfV
WVPB8WU6JKpp34LU+2D+rwBPRrGwsE4seI4WJN1ZjbC7VJObZcZltBnmTHceWJmV
n6OAPw8KJv/PDWCthmsHESEHD1GVI3bjJTBUCZQjJmpRLIDNKbN0DAf4Wn+YjKUN
tchDl2Hin5/cCqHtQw6ciWsB+NRHH2msdzmgN9ImpGKWCewebNeBp1/9J41/noPy
WbzUNSeQs/QqXsfnD3N9m2ZDbIV1gZ/nwGKvKnyxdx7KpPRF/NVl1zGcI8UAVQ8l
bDVkjia0HYtdLZun6HJMpavYk6pYFshlaV9oYtnh3l4T/4qVye4=
=DnEz
-----END PGP SIGNATURE-----

--ztylkrwiqnc7eazb--
