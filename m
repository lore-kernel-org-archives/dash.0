From: Julien Moutinho <julm+dash@autogeree.net>
Subject: dash 0.5.7-3 segfaults on eval then negative test
Date: Sat, 4 Jan 2014 08:24:07 +0100
Message-ID: <20140104072407.GB28159@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <dash-owner@vger.kernel.org>
Received: from chomsky.autogeree.net ([91.216.110.36]:36987 "EHLO
	chomsky.autogeree.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaADHbG (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 4 Jan 2014 02:31:06 -0500
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

% dash -c 'eval x=; test ! $x'
zsh: segmentation fault  dash -c 'eval x=; test ! $x'

% dash -c 'eval :; test !'
zsh: segmentation fault  dash -c 'eval :; test !'

cheers
--julm

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQKpBAEBCgCTBQJSx7cXMBSAAAAAABUAEnBrYS1hZGRyZXNzQGdudXBnLm9yZ2p1
bG1AYXV0b2dlcmVlLm5ldFsUgAAAAAAqAChpc3N1ZXItZnByQG5vdGF0aW9ucy5v
cGVucGdwLmF1dG9nZXJlZS5uZXRGQkU3MDQ4RjAwMDUxNzA2MEMzMDBGRkU1RTI3
MTlDRjcwRkU4QTlFAAoJEF4nGc9w/oqeVA4QAKaIbxolxr7OWGcGByUHcEkHLAKS
1IRjF94Hu1JsX3LhXHLuc3DOZaYg0KgJdXR9VCK35V47EiWs8a8r7R68JGfxtYL9
qklXGXkLezFwqqL6ifyTwmEz8vYGfO1RwqLqBfRqZB3i7+05im9f0OdjIi+CJ/My
pxfAgvsxgOzipiFJKfhS3yDLBgnjunt4C3DbhtTpgQ6mC7sxxnsfjkSPYS7CHoB1
vW0XAP6fpADUnadrlSh3XOfpmITKwxnCjwkXDWi7bKCM4WU3tSltux/xP6ZfXHXy
uv9dH3183eUBK8FwWJS7laQzz+sIyi79aH3XAq6TqQsLfGAZy2bWpEvVqt5pBwJM
LTMD2Mn4JxWo6GWem5EgyB+03ojhMzY+qPSVL6J/uLqQNH7PxamHbp3Y0QJWkMPV
7SSRs8w5S9gwX2w1UjSvgdGuHorYzVDqrGKKEQP6zLkjiGGAGrTtjsAidfZOrIEV
KlGpHIvSLh9XcCI6pUTQseCzJa2Ax2+ETvyg4/pV1YDCT8W31Kh02ua/Um3ujz6V
IlwCQRLJZoJkYlzXjzH7snGbeul/VaVeGjUSQeTbt/oDq3nopWIQW12ispSRnLAf
uTgAax7uHoxykQPqp+OJG/XaXiyYR0z/cDandXBY3yxdr8wDj+y9n3xnIi8+TWVc
FRGzIgbB9BPraqLW
=oVmR
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
