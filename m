From: Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH v2] jobs: Handle string-based job descriptors
Date: Tue, 7 Jun 2016 16:43:07 +0200
Message-ID: <20160607164307.650db975@heffalump.sk2.org>
References: <1464940471-9819-1-git-send-email-steve@sk2.org>
	<20160606144527.GA23630@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/vpEknVY7tBUqYimZS/8Xc2O"; protocol="application/pgp-signature"
Return-path: <dash-owner@vger.kernel.org>
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:57397 "EHLO
	4.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161418AbcFGPWE (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 7 Jun 2016 11:22:04 -0400
Received: from player730.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 479E8101411B
	for <dash@vger.kernel.org>; Tue,  7 Jun 2016 16:43:17 +0200 (CEST)
In-Reply-To: <20160606144527.GA23630@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

--Sig_/vpEknVY7tBUqYimZS/8Xc2O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jun 2016 22:45:27 +0800, Herbert Xu <herbert@gondor.apana.org.au>
wrote:
> On Fri, Jun 03, 2016 at 09:54:31AM +0200, Stephen Kitt wrote:
> > When looking for a job using a string descriptor, e.g.
> >=20
> > 	fg %man
> >=20
> > the relevant loop in src/jobs.c only ever exits to the err label. With
> > this patch, when the end condition is reached, we check whether a job
> > was found, and if so, set things up to exit correctly via gotit.
> > Multiple matches are already caught using the test in the match block.
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org> =20
>=20
> Thanks for the patch.  I'd prefer to move that logic out of the
> loop, like this:
[...]

> -	while (1) {
> -		if (!jp)
> -			goto err;
> +	while (jp) {
[...]

That is indeed much better, thanks!

Regards,

Stephen

--Sig_/vpEknVY7tBUqYimZS/8Xc2O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXVt17AAoJEIDTAvWIbYOci5gP/0ic874rbx+k8DMvAywOWIBY
Gerzkjx6PuqFT4Qjlv1IVgHimshotA0xXq0AYzhEd+j7LGG6q62qNEY0ye5eQk9h
7k2AHeG2zUzym3G617R4YFKnuv+gbv2OffFsb6CiXbF7P4UyBeuNt0Y302fMwgwG
b90kPs7v+0bNRIpcZ93RtQPpQRSoG0UdXMXI8+WtXkpD84dZhmBZ3f7Ywmu8b49d
9a6HBe/4O7r/JjoUVPIoHeqMJXM+qHKPEXHMNuHlBHmolJ3YEfV0uINZoMTbVptt
WgbbXSO7MbO4nid/RK8TpM2eQgYH/lkSjwoqT6DyQboYpgjSRn2dLnEdKll8yNQt
23GJu3Kw2oinAV5DOUbg0lxI7Wrk7J0jSekKTyAPdjHpImlgN19oh0DqY8y1M6Tr
+eaYLWwIdvhsqBK2OZBx0IdMolqdIAfhO+53YExh9r+XYQ7AFcpEUt2GQDh/EY2g
L+/330N0xTbvdV/5cM1f+rOFOiz4fNFHlbnRWjZdkUKDT/4c+PNcW1waWh9KOMW4
kZQ2jKg0aWkdixfFS6gTDCc+6NrDB1B3knU93Ni4UIXwe1eiHfXyyENfW+c5JGUs
A9EGlG202oEeuRHSWOds+19Uzy0zF03W47c/dTumKnGV/OUHk9rQ/j8bN+x6eikm
U9XLR4a67rDkx3n10nNh
=Mz68
-----END PGP SIGNATURE-----

--Sig_/vpEknVY7tBUqYimZS/8Xc2O--
