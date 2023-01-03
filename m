Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B1AC3DA7D
	for <linux-dash@archiver.kernel.org>; Tue,  3 Jan 2023 12:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjACMlI (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Jan 2023 07:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjACMk6 (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Jan 2023 07:40:58 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30DDF10070
        for <dash@vger.kernel.org>; Tue,  3 Jan 2023 04:40:54 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 410784B2;
        Tue,  3 Jan 2023 13:40:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672749653;
        bh=EZckXI1TVOMNWGqk7VT8LkglbozkcHWO8g3JBWn2HVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dx7h5NkBUt5U6d4uCYnq7MFvo7i10AJ6Zrn488+p8wwJxd3Abj+F+2bbk5m6IcMtL
         dz7+aJ5T77SVvNskFdIX/Vz7NX4Oyf7t0BvcAmyn95ZZ1DJj5ViVp+SED5CmsITmZ4
         ppX3VOpbZaUEAaD9mNkBQZfyBhF0Gg7CT5eyEYnz4uDTcJlisPdck7j+trZlZFu6Ym
         0FIfPBuhcUZIkFVZdfetABL3ehSaRQLid5jvUlrABi7Gof+XaD+O4VZY9HDku4t2L3
         UPWzH80lGOK9PwrBDIfQJQyHwjiSE3JUwJbDqKNhKNVAEYxegXLI9QBceDRNsxmzph
         nWkV/WdQlxOHg==
Date:   Tue, 3 Jan 2023 13:40:52 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: type: ignore first --, per POSIX
Message-ID: <20230103124052.wwnf3c5pync2lqk7@tarta.nabijaczleweli.xyz>
References: <b9085f1a9812a436d37bc6f8d96d17bdba4433c5.1670966008.git.nabijaczleweli@nabijaczleweli.xyz>
 <Y7KhlatS/XnFn3VP@gondor.apana.org.au>
 <20230102124628.w6mtevhvnuthco4j@tarta.nabijaczleweli.xyz>
 <Y7OHRV9Mf1agWIMC@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="somy4s5wkdp4d2ks"
Content-Disposition: inline
In-Reply-To: <Y7OHRV9Mf1agWIMC@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--somy4s5wkdp4d2ks
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue, Jan 03, 2023 at 09:39:17AM +0800, Herbert Xu wrote:
> On Mon, Jan 02, 2023 at 01:46:28PM +0100, =D0=BD=D0=B0=D0=B1 wrote:
> > On Mon, Jan 02, 2023 at 05:19:17PM +0800, Herbert Xu wrote:
> > > =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > > > Issue 7, XCU, type, OPTIONS reads "None.",
> > > type is marked XSI.  dash does claim conformance with respect
> > > to XSI.
> > Which means it ought to abide by "None." in the OPTIONS sexion,
> > as out-lined in the subsequent lines, i.e. discard an initial --, yes.
> > Good to see we agree, I guess?
> Sorry, I meant that dash does not claim conformance.

If I can't convince you to apply this with the consistency argument of
"all built-ins that could, would parse their arguments with nextopt()",
then do consider the 2/2 that does the same for getopts,
which isn't shaded XSI and therefore must support this.

Best,
=D0=BD=D0=B0=D0=B1

--somy4s5wkdp4d2ks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO0IlEACgkQvP0LAY0m
WPEuFxAAoK3CFJNrtaZtwOov3SMq/J/m963ObkxRRNi632ZrTGZRzFGgtEHBR650
Oyn17fDr9FzFqJFZGeO62ArXL71gYFUt3Mwi6B7pKhD2wW3G2r6tYIjTiu+h1Yvv
vQ6XEfJeVrnEYbbpqwV4BNjz6WzT6UJSJiNN9neQMELreEfPQcKa661wSp0BVLf1
/v96j6eLfWGiVpg44ewDeAiygaj847pvOoNHMrfzHtmK7tzV+jhXbZAEgkndkhe+
HXKxKiyFvRFLlK5S/uskh1KbPSXSAv0X/j+OocAb/uUazRTxnHzT1LSud6kJGltZ
Qv17pfphTo9nqliAP+rbQHSFFXTX+ATWkyRTziK/tDO8E8k6wAkIzr8YEMfn3USE
p1gn1DywUGWHSrf8zwxkilmZps/gfwyAOD4qKGzK/TsH3UnYdsWTQHinzD3PYcYR
4jZ8xq2QR5Vrf1rr92nJsOs2F6caQ+EudWBjsoKK4jtfqTjdMD+PV72sCqzy44BN
MBTT+1BK2M4givEPlxCNWNQhgbam0fBAV/p9jhPf4D8PHD/H/rMiLO/eVG3zbQH6
FKoh8TYBsVWYKg1LpZ1oqKRQj6iyx3eYTkiLov4OTNwROzK9Bd9XRHHsdpSCRf4K
DLXqdBd8niQMV1H2iJQ0QBE2i+QTgXEULeghiEYAlEb8N7JR1DI=
=uCUE
-----END PGP SIGNATURE-----

--somy4s5wkdp4d2ks--
