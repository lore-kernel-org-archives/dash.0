From: Tim Ruehsen <tim.ruehsen@gmx.de>
Subject: ':' noop results in ':: not found'
Date: Fri, 28 Oct 2016 12:54:55 +0200
Message-ID: <56849947.Cgj98o2q7x@blitz-lx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2632488.HYRlRvZqDJ"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Return-path: <dash-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.181]:24791 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbcJ1LBA (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 28 Oct 2016 07:01:00 -0400
Received: from blitz-lx.localnet (p50846E32.dip0.t-ipconnect.de [80.132.110.50])
        by smtp.strato.de (RZmta 39.7 DYNA|AUTH)
        with ESMTPSA id I097c1s9SAstPuG
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate)
        for <dash@vger.kernel.org>;
        Fri, 28 Oct 2016 12:54:55 +0200 (CEST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

--nextPart2632488.HYRlRvZqDJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

maybe you can enlighten me :-)

I try to use dash (0.5.8-2.3) on Debian unstable for executing ./configure 
scripts. Since Debian builds with --disable-lineno, all ./configure scripts 
silently fall back to bash (I created bug report #842242 to get this fixed).

Next I rebuilt the package from the (Debian) sources without --disable-lineno 
and installed it. Now I see error messages from dash when it comes to the do 
nothing operator :.

$ dash -c 'test -n "a" && :'
dash: 1: :: not found
$ echo $?
127

$ bash -c 'test -n "a" && :'
$ echo $?
0

Since this : construct is wildly used and I know that dash on other systems 
work with it, I wonder what is wrong here.

Is there a known bug, maybe fixed on recent dash versions ?
Or has this some simple reason my stupidity doesn't see ?

Regards, Tim

--nextPart2632488.HYRlRvZqDJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYEy5/AAoJEAgwLbaiZwQoUvgP/jg5orgfwmfWFV9tg7bzklj6
6fNhJWGq8lofbnxaF2GZ1f3Ivfo2hFtSDJTiojjSD1qV7zrFTa5bd9N+82FXoz21
BigS8X6v5n/iJMnsKoufH/1LtsoVMKxBneV3fyaIUHKvlobHl+V0yHoF7KhGa4to
ay/zVtoYU7FJacdUvjZVM/tXCWOg8WxF2+Fl4oF4hJWJexNzhC4vKuajAxujzer0
VW7SVHdtb13u9PAn71O5hTQpvpQl6L8OUAJaiKtkGRupZyegC6s4MJ8/FwxqvFlL
Qxio9w1H72TCo9As1K60+IeRQRRsYxgBsYdkXJvl/N9KZfcu1mAcYAbYmvCoZvU7
ISzUmIclPPEi5aLyd0DTXhJSd9qYXRTygVR0A28CsP4Lx0uI+NMDkSDZ2osDYXGn
3212h13i7XMTBGdiYjQu513Ahsx7KPxTo1X4t8vdqD+nsOh9mSw/WoX8c3+zZuo1
R3UZ1XVAH4ZXxOxGyI7W+xTYvsnlYv+81B/uFp8kzOp1eYX/ygxKDiczxkALYzxA
viOA7IiRreRCjVQ3mc5Y/0IHtx+XSvOgVJ2NSzmFtgOLLD74WKZL5kjJFCyt2zOR
/as+YvkXc69VTRHi4xlWu+Y42PL4cCPCKwttLVWYwQ/18SkP9N8K/qDNrcp1khmS
5Z3oe2k0W+LfKVaRqGnZ
=hDsV
-----END PGP SIGNATURE-----

--nextPart2632488.HYRlRvZqDJ--

