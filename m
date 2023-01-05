Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DEAC3DA7D
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 12:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjAEMpg (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 07:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjAEMpf (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 07:45:35 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99A003FC9E
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 04:45:34 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DD3384D2;
        Thu,  5 Jan 2023 13:45:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672922733;
        bh=QVMddsYEVkuFmmINVL6n85mEZbt1Xcrt0//jwwctDlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jS9ss/myGDwTGKrEWfgKcMrFPM5kNitOOSMhquFTxnZ28eV+fBGXzgO6Geqc1Z02Q
         PW3iWYdrW/T0DkjjWcY4p+1+KjAGjuXj6n6zlEMPUgZLnBuM/a7ERw2W0EAU0pktvo
         9OyyrIZ7lBo/7yQj9o/3jsoURwFfcSEtkV606kLVXMAxr07p//s8Xxc67Og1OmJk/0
         zBhR0Z3lMqXvWNE+U97akhLD+L5X4m2rq0u3u6Pna9g4fRWRvGqF7uPd/EawAru6RE
         ldywt1vptBAHy8Xh6YMFy3eYo/3MDNXk32ZXJkp+Zyob1NdXdGEOcgDq3h9ltFvhzs
         M3PwJWZrHDbHQ==
Date:   Thu, 5 Jan 2023 13:45:32 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     jilles@stack.nl, dash@vger.kernel.org
Subject: Re: [PATCH v2] redir: savefd: use F_DUPFD_CLOEXEC instead of
 F_DUPFD+F_SETFD, if available
Message-ID: <20230105124532.wfmshkzgn6xujama@tarta.nabijaczleweli.xyz>
References: <Y7aVs5pglzAvbnfn@gondor.apana.org.au>
 <20230105124321.gsmk7h7xpuss75hw@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nr6ohocinbfwjnq2"
Content-Disposition: inline
In-Reply-To: <20230105124321.gsmk7h7xpuss75hw@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--nr6ohocinbfwjnq2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(this is v3 with your comments applied, naturally; my finger slipped)

=D0=BD=D0=B0=D0=B1

--nr6ohocinbfwjnq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO2xmwACgkQvP0LAY0m
WPFmYxAAqfDH1AggKuVWxtOZcA3j/gfUfOwxYF6Vzj5vHSWl4S/3bp4jieb7wFvh
jmzS49Tk0lpZBWLdJHLtEzJuvhLWtksCv0ZjDEFZUSA8NiCxY7eAa7/P2tvJ7B9r
yt0jweWw3J57Q0zrzNONX6ruLT5PiqNqCuLmfKeCkT1e/4w0Ims5N/HR3Sm7QKBi
I+hw+Ln0gXyfNfFUxRr7bjgS2q5HIIepd3Dl7/U+kF2SZO6w0oRaNN9MEPDXyGfZ
0Z/4oLrgY6qpAbNhjmtGGHhhvVsZUcBciorzeQn+20v7zCj6oCXODKCcMs49oWeM
d1nBBqe1kAZcNd980I5U322I/Og+jejPrax9eZr/om1CM4qrB0CdlgCf3hL8pvDh
m1BmLUC3MnssPhZdq2T2W2lLjRHRIkoF3tk+oS8d/vpqLFJCmdeB/ihGxyidenfA
2uP4K5B/+TxgVRcU8M0FskEGf65Ck+rzYnHVw/7RIVykvH5mRoC6kygZIa7pRRDy
fKg8vCdkJesopOWqXYdhibcxuq6Rzp4O98+hUMuCRCKxJbkm7+ktzEr4rGDP+DlC
PQx3ix5uEcBDd/TPPh/8Yk3pmFwp61o0zNfXOYrs/eGB0ss0S91OlJ2t1PIeEO7j
pLaZ5kuD9OSsZrRwH9AZGabh3hSFxFgqW/NIcq2lxvknj67kUVk=
=vsWy
-----END PGP SIGNATURE-----

--nr6ohocinbfwjnq2--
