From: Philipp Weis <pweis@pweis.com>
Subject: [PATCH] [MAN] Document optional open parenthesis for case patterns.
Date: Tue, 7 Sep 2010 22:42:19 -0400
Message-ID: <20100908024219.GA3283@zaphod.pweis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Return-path: <dash-owner@vger.kernel.org>
Received: from arthur.pweis.com ([87.106.5.233]:34631 "EHLO arthur.pweis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143Ab0IHDBl (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 7 Sep 2010 23:01:41 -0400
Received: from zaphod (authenticated)
	by arthur.pweis.com with esmtps (Exim 4.63 #1 (Debian))
	id 1OtAcA-0001QM-BN
	for <dash@vger.kernel.org>; Wed, 08 Sep 2010 02:42:22 +0000
Received: from pweis by zaphod with local (Exim 4.72 #1 (Debian))
	id 1OtAc8-0005NK-1i
	for <dash@vger.kernel.org>; Tue, 07 Sep 2010 22:42:20 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

while inspecting some dash scripts on my system, I was surprised to
see that some of them use an open parenthesis at the beginning of case
patterns while that's not mentioned in the manpage. Dash currently is
fine with and without that parenthesis (parser.c:413). The attached
patch documents this feature.

Philipp



--gBBFr7Ir9EOA20Yy
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="dash-case-parenthesis.patch"

diff --git a/src/dash.1 b/src/dash.1
index c7771d0..ddeb52b 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -663,7 +663,7 @@ These are implemented as builtin commands.
 The syntax of the case command is
 .Bd -literal -offset indent
 case word in
-pattern) list ;;
+[(]pattern) list ;;
 \&...
 esac
 .Ed
@@ -673,6 +673,11 @@ The pattern can actually be one or more patterns (see
 described later), separated by
 .Dq \*(Ba
 characters.
+The
+.Do
+(
+.Dc
+character before the pattern is optional.
 .Ss Grouping Commands Together
 Commands may be grouped by writing either
 .Pp

--gBBFr7Ir9EOA20Yy--

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyG+AYACgkQzxf2HvbDMkk/zwCfZ+4x1xXVuzoRHt+WgVabgvF5
3jkAn3FIduUbXFRl3FnCXKtcHH8G8vvn
=aOmA
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
