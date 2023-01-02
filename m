Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6CBC3DA7A
	for <linux-dash@archiver.kernel.org>; Mon,  2 Jan 2023 12:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjABMqf (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 2 Jan 2023 07:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjABMqe (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 2 Jan 2023 07:46:34 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 535393B3
        for <dash@vger.kernel.org>; Mon,  2 Jan 2023 04:46:32 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 36CBC4A8;
        Mon,  2 Jan 2023 13:46:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672663589;
        bh=4+F7qxkZx5aSKDPMBe7urZgT1z5d62vBSne0EOenUeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glV5DHyYq5h8z8VKZfSnqHa7cUi3T9J7wxslVJY1nnTHTWTPuJV3Wktwah5bcw9Y5
         PYn5PaKm+0c+15dtgq1w9bCLZJTbjxk8oixTlf8Pa17/Rln7uKBYu7Ob/OBjF/cgu8
         K30go9gEDEMoESLGJ4uRKDOwpSJ5KX12Fa1hc+PANvVrulpB7BrNVt2nVKFGvH0j5s
         6BA1zb5we3AKJ7bFKHLPEiJBcMyUw6LJ/G0oSmhSPvNRlWMIsbFkokPXXXWvKPTlkI
         KH6glW0z/1L6LCGtrBmgnqPlIP3+tXjDOBTq4/BAz5xql1Aoc327YHWc09ey6ZXKSZ
         LrPkqireo1qEQ==
Date:   Mon, 2 Jan 2023 13:46:28 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: type: ignore first --, per POSIX
Message-ID: <20230102124628.w6mtevhvnuthco4j@tarta.nabijaczleweli.xyz>
References: <b9085f1a9812a436d37bc6f8d96d17bdba4433c5.1670966008.git.nabijaczleweli@nabijaczleweli.xyz>
 <Y7KhlatS/XnFn3VP@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zwqy7f5oglnzf3sf"
Content-Disposition: inline
In-Reply-To: <Y7KhlatS/XnFn3VP@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--zwqy7f5oglnzf3sf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2023 at 05:19:17PM +0800, Herbert Xu wrote:
> =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > Issue 7, XCU, type, OPTIONS reads "None.",
> type is marked XSI.  dash does claim conformance with respect
> to XSI.
Which means it ought to abide by "None." in the OPTIONS sexion,
as out-lined in the subsequent lines, i.e. discard an initial --, yes.

Good to see we agree, I guess?
=D0=BD=D0=B0=D0=B1

--zwqy7f5oglnzf3sf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOy0h8ACgkQvP0LAY0m
WPFvdxAAiG0hJUpoYq8JvrsO3lHoMx+zWpJE9VMW/lj7klM+wqr2KZ+0Vjrv9oHv
vKMeHy4vMj28XyvUhEU2MXhOscc1SJQveliaDop/ABvZd/v5IQ3sHeMb568/23/G
yKu3QSDHEdlIJLhW51l8u62CFmAduItN0hrTCzZzYRScpOPQzSMB8D4VS+avgy7a
FYCgwlQW+82oP5BvJv2DIu/3lIuX4bw4JP3g5jgewistotTTWAj2mA1aPJlzjQso
SnmBX8OlTn6jjiBkXh2Wy8jrZFvPQASoxoh6J1rRrlh1Ag719+wpSwreS+HE6cwX
zUdW0mj/iRI+SLcYFS6kUBbi2UQkO6qav0NRxPkxVBZcUbpg/khz9P6389y3tzZx
JPLf8JCJDYeSmnP5IGg9XZ17ZzWDi3vp31fkSAUZ4tEdGm/YTy5br4MoqKS1cEbd
pRXoazFdtzfghgIM9uVh0MvTBlKOWezskOklKZSCLWZV5SSF5gnUQ1Uqjs8i/jev
a+NB6jyCyMSIZb0UNqT8/LJoAgZ3Sp8d2NBmM6TeFzLI5DjoUhP3vDYhVds1fQ9d
RjE779oRCM7Qas3gUevC2I2kOHAyXguB+btXxzYOzsMQZXnRJzEjlhvXuRVB9zO9
Vx5qZ/GFwwD2Skb2k2ZuK+I9aNcHu+ZgRogfiUghAes6nbzuYFA=
=HpuN
-----END PGP SIGNATURE-----

--zwqy7f5oglnzf3sf--
