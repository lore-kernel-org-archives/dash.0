From: Joachim Breitner <mail@joachim-breitner.de>
Subject: dash drops exported bash functions
Date: Wed, 10 Feb 2016 16:18:53 +0100
Message-ID: <1455117533.18345.59.camel@joachim-breitner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-WMEfBOvpbsHeYQ9aED6u"
Return-path: <dash-owner@vger.kernel.org>
Received: from hermes.serverama.de ([176.9.213.133]:56408 "EHLO
	hermes.serverama.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbcBJPqG (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Feb 2016 10:46:06 -0500
Received: from [10.254.1.12] (helo=kirk)
	by hermes.serverama.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84)
	(envelope-from <mail@joachim-breitner.de>)
	id 1aTWXg-0004TG-Fm
	for dash@vger.kernel.org; Wed, 10 Feb 2016 16:18:57 +0100
Received: from jojo by kirk with local (Exim 4.86)
	(envelope-from <mail@joachim-breitner.de>)
	id 1aTWXg-0003t0-A6
	for dash@vger.kernel.org; Wed, 10 Feb 2016 16:18:56 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


--=-WMEfBOvpbsHeYQ9aED6u
Content-Type: multipart/mixed; boundary="=-tw5r7gO0aUlLcRsWfY+l"


--=-tw5r7gO0aUlLcRsWfY+l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear dash developers,

a change in 0.5.8, very likely this one
http://git.kernel.org/cgit/utils/dash/dash.git/commit/?id=3D46d3c1a614f11f0=
d40a7e73376359618ff07abcd
broke the exporting of bash shell functions via the environment.

The attached script shows the breakage, as it outputs

$ ./exporttest.sh=C2=A0
exportest called ()
Setting up environment
Calling myself
exportest called (1)
function foo successfully called
Calling myself directly
exportest called (2)
function foo successfully called
Calling myself via dash
exportest called (3)
/tmp/exporttest.sh: Zeile 33: foo: Kommando nicht gefunden.
Done

Exporting bash functions via the environment might be a rarely used
feature, but it is used in practice, unfortunately (otherwise I
wouldn=E2=80=99t have noticed this).

Thanks,
Joachim

--=20
Joachim =E2=80=9Cnomeata=E2=80=9D Breitner
=C2=A0 mail@joachim-breitner.de =E2=80=A2 https://www.joachim-breitner.de/
=C2=A0 XMPP: nomeata@joachim-breitner.de=C2=A0=E2=80=A2 OpenPGP-Key: 0xF0FB=
F51F
=C2=A0 Debian Developer: nomeata@debian.org


--=-tw5r7gO0aUlLcRsWfY+l
Content-Type: application/x-shellscript; name="exporttest.sh"
Content-Disposition: attachment; filename="exporttest.sh"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9lbnYgYmFzaAoKCmVjaG8gImV4cG9ydGVzdCBjYWxsZWQgKCRJVEVSQVRJT04p
IgoKaWYgWyAteiAiJElURVJBVElPTiIgXQp0aGVuCgogIGVjaG8gIlNldHRpbmcgdXAgZW52aXJv
bm1lbnQiCiAgc2V0IC1vIGFsbGV4cG9ydAogIGZ1bmN0aW9uIGZvbyB7CiAgICBlY2hvICJmdW5j
dGlvbiBmb28gc3VjY2Vzc2Z1bGx5IGNhbGxlZCIKICB9CiAgSVRFUkFUSU9OPTEKICBzZXQgK28g
YWxsZXhwb3J0CgogIGVjaG8gQ2FsbGluZyBteXNlbGYKICBleGVjICIkMCIKZWxpZiBbICIkSVRF
UkFUSU9OIiA9IDEgXQp0aGVuCiAgZm9vCiAgSVRFUkFUSU9OPTIKICBlY2hvICJDYWxsaW5nIG15
c2VsZiBkaXJlY3RseSIKICBleGVjICIkMCIKZWxpZiBbICIkSVRFUkFUSU9OIiA9IDIgXQp0aGVu
CiAgZm9vCiAgSVRFUkFUSU9OPTMKICBlY2hvIENhbGxpbmcgbXlzZWxmIHZpYSBkYXNoCiAgZXhl
YyBkYXNoIC1jICIkMCIKZWxpZiBbICIkSVRFUkFUSU9OIiA9IDMgXQp0aGVuCiAgZm9vCiAgZWNo
byBEb25lCmZpCg==


--=-tw5r7gO0aUlLcRsWfY+l--

--=-WMEfBOvpbsHeYQ9aED6u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABCAAGBQJWu1TdAAoJED2QirPw+/Ufp20QAJbxxLFkgkqpllzdsUGfjQxS
6I9q96iq8sFy65PPWqMHd8DAdxIpA5CWCeEtqiFmege64bxgNO06MzrNtO9Kz9E7
/6A/ppqJKVuVr8ZHIPJzLEG9Dixi3Vh1EytPZnsXCqCaevCFIYjg+CMO8Ma6j3Ir
Uy2wKDlZFB/WwbDt08KrosJO4Ss6L/eo1fda8jGVR5DyULlozvLjHonjA+Jm7H5B
1QaF8nx+B78wCTI6yvCZ12uDGst/QHoGMZZAUVz6vRZ3iJhGagfhpa3GoOlyEKdk
SrWNPoiTNnXR8bx7RmL/9U+uEJ7V2Vq2c8j4MD6NgdwJJDvUuN4ELTnsx1bJdwVc
mEWHpe5mzMZ4TfqLlDI86Sd14vWKEXNLviCuHUffUO9w0kUo192fACEwYXYDZm2S
bVDKeU1wppU+Ac/SgnqdGKJDKzPZcD1zvFkyN0AzvDm5ZmmTXRTJ04rjsG7OxPsQ
573ZWBU08ZO84paJxMBatd7lvSNGzVIHUi7rWgrEm+AgOc/Ux0fMKKAdQQ5Pd6fo
AsUNf6z54JTZzHYN6sKPq9xxzpocwZZDpYI6Bif6aU+/fKO+yYtXqY/3zAg5YVLu
J/l3bJ3OKupEvnDtz0auhbVg7hPYgdM2Ph/k0FzXw1U3nVDs/n8jJEyhFJB1coUD
j3F++/166ZNSZ149GXFP
=0uNk
-----END PGP SIGNATURE-----

--=-WMEfBOvpbsHeYQ9aED6u--
