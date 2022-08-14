Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB520C19F2D
	for <linux-dash@archiver.kernel.org>; Sun, 14 Aug 2022 00:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiHNA2N (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 13 Aug 2022 20:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiHNA2M (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 13 Aug 2022 20:28:12 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEFED76445
        for <dash@vger.kernel.org>; Sat, 13 Aug 2022 17:28:09 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 71C1E1886
        for <dash@vger.kernel.org>; Sun, 14 Aug 2022 02:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1660436403;
        bh=R4HAme1jmeJma7kdnMMKOC4Dlo/ERPPcElsh8QH8zC8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=MjD27z160/1L6tTPMMU3GnObTwv5a2IbT5e2SFT7V8vhQEmL5GPCjqYIVhKOB6Do/
         fLVvqw8MMQ+VHN4QhqWP4guT2T3fno+BdRaQY6nPKMoTG/tKQDAt5DjIoZfy44Rt99
         VuQDDzVonxEow5y9trq/JhkztsMmXWyxUHUI/0QnEJWpUVPnqzUGpaFAhmEgxs1yJY
         vg0SebckHgYieSBZCOQoJj+9Bvv7jyso5KIFEHdKk7hniMugiwb+KDWntdCxW4u3hb
         MUAe/hmwTErg8RLvd0nmGAAEuvU9uLrDpTjLB5x55LWNDXEkZvY5g58q1JzdDVTLe2
         YrYG9l1MybQU+0XDg1AVSM7a0aPXD1o0zluwhrOAzSAAav8mu164Iv4HQL8JwkOYqP
         pIwTDJzI2mOjhFbsODlR2JG7mUQrbcXBJOelG0tA68g2iPaqckXh3/WBmJNrcszMhB
         Zzkc+aWHXvmn95b/jHpzKmKZCu4spSGw33olTyYnsvxYgo8u37Xi77XXliYqNqg1aQ
         HJOgz60X8cCUr4shIrC2WYMgjLWj2rWp07JdMnL50daIrzHoizuZKxH/05btPD25XG
         kXbB6NEISHeUWPV6k+q0z9MWC4sHK7aMWf3SGpb7S8qBgi64vmk4C3yAfD0wNJXPkA
         /V4WpZ/JrA1MvSaQHwZHtjfc=
Date:   Sun, 14 Aug 2022 02:20:02 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH 2/2] man: printf: in 'X, X is a byte under dash
Message-ID: <d4a95c9b5772db68b6ae7a00f2f2c3d0535ca1ca.1660436383.git.nabijaczleweli@nabijaczleweli.xyz>
References: <ba1440bf05e22d3cae38521a25cb3ca90b30680d.1660436383.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76ptj3ipchfuebib"
Content-Disposition: inline
In-Reply-To: <ba1440bf05e22d3cae38521a25cb3ca90b30680d.1660436383.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--76ptj3ipchfuebib
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

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 src/dash.1 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index bd5c311..19d4d3b 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1556,9 +1556,7 @@ otherwise it is evaluated as a C constant, with the f=
ollowing extensions:
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
 The format string is reused as often as necessary to satisfy the
--=20
2.30.2

--76ptj3ipchfuebib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmL4P7EACgkQvP0LAY0m
WPFnRxAAjgiDemev/8gs9YbvVpCnR9psLYIJkJySv2NG/hEG7eUy8VWUpByNvFr1
ZJHpB+vsxylPRocIvbhR3Fb0/Z1085Os36avT0wWd5VtvkQAHUNTT2qcaBke55go
5xrEFVCCKy6NfwALLSuBgn8Uyrf56OqMQGHrSZj2zb7UMgDGqLwmEAbeW+yIifCO
hj+PWJ5LbzledWSpeNXKeuHFMsP3Bv2PHldjVi4Ac48cVf+MRq+qCp0wknq+x1lT
7/+XXzOo1C1qtPxmz2mX/hOBTf/02ZJrS+JtjxZIlJj+qdPKQAu9BVrdfMmHuo9k
fQtjXpMAlQxcBRizIAQu4TrI3Jk+EoQH+eiBblMcF/ELfCYjPUkhF/tbjh1i6Mom
lu38eTJ/h11Y16cnu/uaIyqneachWUU94xv5rOLoygQoNusxNwAbjEYDN9Rj63Dq
bAurAYepWq7/p2TYVlO/RpDAv0v9pzZhr60zXFMplUjE/v6IchgC+EP78/E98HHg
hfpmx878daHfiueFBnZ3dgRfaqHXuhq/sNiX/QoIp6SAAQ23FgzJeFGsV/woXKPX
+gMUrc2JDwV0+jeTHqI/yS1YSMNd4YyQQJZ0G+ql9GOmlSqKERGM48sM2Pq4a1MZ
yNjbxFt5YR043ke5uXrOUIIwqC/VxA1OFZ8uxPglHK/CMEej+XI=
=FL5r
-----END PGP SIGNATURE-----

--76ptj3ipchfuebib--
