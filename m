From: Mike Frysinger <vapier@gentoo.org>
Subject: fail to expand/assigned subshell output into a local variable
Date: Thu, 8 Nov 2007 18:07:17 -0400
Message-ID: <200711081707.17944.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2327687.IDurtdFves";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:52185 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759203AbXKHWHT (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 8 Nov 2007 17:07:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 625AD652EA
	for <dash@vger.kernel.org>; Thu,  8 Nov 2007 22:07:18 +0000 (UTC)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

--nextPart2327687.IDurtdFves
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

this code snippet incorrectly fails under dash:
$ { local f=$(date); }
local: 5: 8: bad variable name
-mike

--nextPart2327687.IDurtdFves
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQIVAwUARzOIlUFjO5/oN/WBAQLVdhAAlEB3U8xm4fE5w418Rn5XF20mpQuua6Bv
Oo7Q7bqJPjk/9W/a+uCjakIj9vGL40iYxxDVsVWbAamVrewevKfSQKii1AE6aIBY
mDMBJyKOL1tyS5EfEUyYwfA6eqVnJUs/tpvym8vUfsDALEha59VWxCzJTSgybGop
8yCB+uCHFLVzy+7NMfLj52tg7LrdaN3EWBGQmqQmJqsgEgvwVQF1KDkzg9l7W6rQ
Xo3KWs9cwy1X1FdirsE4f54uET6FN17C16j0tkgszvphMaRmGHO1aJLjehATegMU
ACCTRUNvJJ7AmDiw1dBfDvyoF3WThe9oNlbTNwmljedLoJb1buTLk4Kv8LSkkZrB
pirfj5ndjYiB6raCJcW+8oTfvTMpmiB9ppRypu8r+d3MDE5HeJvcfstj9hQaWWEe
rGbiSJxYmrZ6uoEfYewleir12OyRUHM07wvjO5c2Vc4W7OIZmZh7151BWwkuMKnW
o/gsryFOWkqbBZDPWp5KCx3f07E4/V2uIhzADT2r/D1CquuiUzfugCNlBKFk1kHc
j/Wg/gOM2L9Nro8DNH5gpXGd1zvkgNOloYfpGoNgfcCxP5XA2D6vyiyavYsW1BSD
Jl9PNrL48O5iEV0fznqxQmpbpfUpQvbe2Cpl4ZZmb7fH2sXiJjWQjf8biJw6kJVd
ApjZg7H7TtM=
=sXgm
-----END PGP SIGNATURE-----

--nextPart2327687.IDurtdFves--
