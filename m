Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BF9C4708D
	for <linux-dash@archiver.kernel.org>; Fri,  6 Jan 2023 11:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjAFLtk (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjAFLti (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 6 Jan 2023 06:49:38 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71AC17288E
        for <dash@vger.kernel.org>; Fri,  6 Jan 2023 03:49:37 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 4C96FE20;
        Fri,  6 Jan 2023 12:49:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1673005774;
        bh=20vnoeCTlASz+i3W9LfmiEqwvlAEUpW1fhnewJUL4EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B27u9g5vr2sfWy8ZCdx436Ea5LFko4GjaKVpOdAJjpFP2r7KD26L/zN8I7X2Pq+KC
         ezP+uO/wKO52GLSuNsxh6ECd1sY1ah+9lC+3mLx77XxStAAdlpLSjHBDCpleafMKTO
         677D9MjpxpfWzcqHJFgRSPGiHZJulDcK3rS7pGJnBjaudj46pEXACZgxspaV8HoVwl
         xhnF7EwrQWxdRuSj8uzG3GZ5xQJtUMFT6m7xT4qeilrCYrsxoloAzxtC7C17OnoSdp
         12CcrYD9aEGX3Me3nhiRK59S0uWTSfH+bpyxHYTWsFkA5HAO70z5WHMIXOjGmFTm/T
         kziQ2THKfQjeQ==
Date:   Fri, 6 Jan 2023 12:49:33 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] parser: Print CTLBACKQ early in parsesub
Message-ID: <20230106114933.eeki2uzg6rmo7thh@tarta.nabijaczleweli.xyz>
References: <Y7aSMJlVi7fXD1DC@gondor.apana.org.au>
 <20230105134204.e7mczfzt2vbit3oc@tarta.nabijaczleweli.xyz>
 <Y7eSaxWkgoiFl8Lx@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tw34ref4ptellc5r"
Content-Disposition: inline
In-Reply-To: <Y7eSaxWkgoiFl8Lx@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--tw34ref4ptellc5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri, Jan 06, 2023 at 11:15:55AM +0800, Herbert Xu wrote:
> On Thu, Jan 05, 2023 at 02:42:04PM +0100, =D0=BD=D0=B0=D0=B1 wrote:
> > I think this means we also need to turn the USTPUTC() into STPUTC(),
> > since the previous code explicitly over-accounted for it in growstackto=
().
> Good catch.  However, we can easily get rid of it by moving the
> USTPUTC to the top:

Yep, patch works for me and appears sound; that's the first USTPUTC()
for the new path and the second for the old path.

=D0=BD=D0=B0=D0=B1

--tw34ref4ptellc5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO4CskACgkQvP0LAY0m
WPEiuRAAkUbueAF2EGTdU5Fl+WNotmXgd3cNncp0hr/HV9atKEop5V387MHTkKa1
RIzPCuXN28A+jeHvnrNjLnkoRi0813qzl4Fd7afyHTRTEpoeMoTDzYEi1D5ZtWs5
8LNfWhnRoq6Q9I3KorwU8Yq4d/07guNFe3/NUGenzhCJ+aMfomnnD8BQPUTOTz1a
5L8LZ3ZtV98nj+9gTwLbgOlmTi4WEMzTkz0RJ7ePuwZ9Ht8HsC9bxdskcL+yDdNm
RnaKAqCClCRTJjoACwl4k9XKAYM8x38O3TUe73qX34PocZPvwf2Qpt0OG4e2/wtg
gtzz4/hOEG47/OwXDYASDlajZj6gdWVDucfqDtGcrW3RESFCMFNykBYcS2lOG9hn
9caEM+2vn1kj7raEyq2lUehRY7k1G5FuKsgpw2s2Lpc3AHAyCXplJ1ykszhUiHOn
e97d9n+P6zg8G4Eon9cPbtHQcRZi0sJmv0MRDw6eOMtmxlnwZj6M2xJsJbs8fDOE
70hcxY4DfbQ7HgFM/uSCDRHAgTCnF+lEg5IoOzWRwAszpajiIlQE1KXPBqS8U3pJ
CTT4giwVwPOzE9nNrMFTDhomH0zELy7xxGBEK285UdRa/K6crzAeeRYPuik31hYA
FZNdqFSBY0wN7dcHg1ctxGMfnGS5dS88QB6unRS+kgmreAEaWyo=
=UvaL
-----END PGP SIGNATURE-----

--tw34ref4ptellc5r--
