Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD03C4332F
	for <linux-dash@archiver.kernel.org>; Tue, 13 Dec 2022 22:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiLMWRi (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 13 Dec 2022 17:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLMWRh (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Dec 2022 17:17:37 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CD1DDE4
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 14:17:36 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 1EF5AEE2
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 23:17:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1670969853;
        bh=/XHN6lnE9/k9i04p5Kh/g/2YZNYqjUK4jM2Gu9hN0Xc=;
        h=Date:From:To:Subject:From;
        b=WxLPs93R9Y5xHq7LDm5cMFmIHNlOwYZIFYmIOHe51RceBoDmwAhK3anVt3xyNX/fW
         JZkdPhxe4Ib6eHnWvTsAYGKKdbafbwI4258NnHMKxjzyrLNADHiqgW49pL1CGdEDvO
         4H4PQlIiGKPCY937J3P99VoQdHjda1HWw8/CGlrF+o6q8zgrRphZMU8fZXyT5X6APR
         xX47W6fKAV4NEdX9U07F9iSExB82aC1nZ6VUtzORCZnKSdtJQNlllzWG0AbEmxNUZU
         BEsxWfAx2cEP8JxvsnC0cfkzbZoN8yIkxQFJSFMclpzdxnBVRlFkuzt1s5fRZi9GbI
         k0Uj5zYas9vtw==
Date:   Tue, 13 Dec 2022 23:17:32 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] input: preadfd: read standard input byte-wise
Message-ID: <20221213221732.6mvv22u7ktdozrbx@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6lnckcwr74m5kzmk"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--6lnckcwr74m5kzmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

POSIX Issue 7, XCU, sh, STDIN says:
  When the shell is using standard input and it invokes a command that
  also uses standard input, the shell shall ensure that the standard
  input file pointer points directly after the command it has read when
  the command begins execution. It shall not read ahead in such a manner
  that any characters intended to be read by the invoked command are
  consumed by the shell (whether interpreted by the shell or not) or
  that characters that are not read by the invoked command are not seen
  by the shell.

I.e.
  sh <<EOF
  id
  cat
  good!
  EOF
must execute id, then execute cat, then the cat must copy "good!"
to the standard output stream, and similarly
  sh <<"EOF"
  id
  read Q
  good!
  echo Q$Q
  EOF
must execute id, then read "good!" into Q, then echo "Qgood!".

Heretofor the output was as such:
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  ./dash: 3: good!: not found
and as such (with -x):
  + id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  + read Q
  + good!
  sh: 3: good!: not found
  + echo Q
  Q
and a strace confirms:
  read(0, "id\ncat\ngood!\n", 8192)       =3D 13
  read(0, "id\nread Q\ngood!\necho Q$Q\n", 8192) =3D 25

Reading the standard input byte-by-byte is the obvious solution to this
issue, Just Works, and is how all other shells do it (we could,
theoretically, read regular files block-wise, then seek within them after
parsing, but the complexity out-weighs the rarity of running
sh < program; we could also do whole-line reads on teletypes in
icanon mode, but, again, the gain here is miniscule for an interactive
session, and the teletype mode can change at any time, so...).
Naturally, we keep reading block-wise for non-standard-input.

With this patch, we observe the correct
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  good!
and
  + id
  uid=3D1000(nabijaczleweli) gid=3D100(users) groups=3D100(users)
  + read Q
  + echo Qgood!
  Qgood!

Fixes: https://bugs.debian.org/862907
---
 src/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/input.c b/src/input.c
index ec075f5..6b6113e 100644
--- a/src/input.c
+++ b/src/input.c
@@ -195,7 +195,7 @@ retry:
=20
 	} else
 #endif
-		nr =3D read(parsefile->fd, buf, IBUFSIZ - 1);
+		nr =3D read(parsefile->fd, buf, parsefile->fd =3D=3D 0 ? 1 : IBUFSIZ - 1=
);
=20
=20
 	if (nr < 0) {
--=20
2.30.2

--6lnckcwr74m5kzmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOY+fsACgkQvP0LAY0m
WPH93Q//VIpTJ+fBntEHLvkUKIEW+CBh5WmNDEBtErl77vfkRSxfAH+xvGK6w4SB
c+HmhQ0Cik6SgWrP2N2FbJw6KdIOt2whr9uIOZGGsCQubE7ZSQFqspg2wLiRnX2w
PXaGqa1xEdRhGMeAED782VgqJbZbhoZ+PpcaZWigB+/9UbUsriW2w37Qmf2JIIkY
sWiDEfmoFNMS3DF3m4k48VWZRrgCSLPUqoQcIdGoK9Mib5/rVsObTtOzlFxlv7oc
vhG+8RSIuMBQ+yg2JzMoWWx4gLG9RB9Zx/CdEzO+1OwvPCc8Xchgtkg0xot+ZaE2
adR9EVW6uxv8xF2C3WOoVSjq5K/SbrhnWt4qkaUpCl2cWlHuZJLgt6FB+Uk/FqeC
+3XIkKEKTV4+Yt1m29EMRgn3FohKqrcomorfW2n8ne5pO2ZiGe3RRTm1dWe++B8R
kO2R6F4mCg3o386xW4H/ipP4MRWl89aqmkA2TreL2sX8xjCErWvnA9aRtJHN2cee
oB0XX3CVKvLLecux6KocJVbKky4qZqoUw+AjGQr/Lr0KJG2vKQbp3X1BwrNq40dd
yZTNxGGKYF2/P0xubFUlNYC0buYRIAo6eaHCXZs4OIQ5IrLx79XriVYj8Xto30No
WW4bv5aAI1+EHt1XydkjJvuBrxvqP0z5SlnhsZmzstTHpuIy5qo=
=mOSd
-----END PGP SIGNATURE-----

--6lnckcwr74m5kzmk--
