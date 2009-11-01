From: Mike Frysinger <vapier@gentoo.org>
Subject: export + default value parameter expansion -> broken dash parser
Date: Sun, 1 Nov 2009 16:20:37 -0400
Message-ID: <200911011520.38362.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12237683.ZMxPIkcAQZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:58504 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255AbZKAUTn (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 1 Nov 2009 15:19:43 -0500
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id CCCBE66D1A
	for <dash@vger.kernel.org>; Sun,  1 Nov 2009 20:19:46 +0000 (UTC)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

--nextPart12237683.ZMxPIkcAQZ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

dash is unable to parse:
unset A; export ${A- -E}

results in:
export: 1: -E: bad variable name
-mike

--nextPart12237683.ZMxPIkcAQZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK7e2WAAoJEEFjO5/oN/WBq+cQAIMzDltQDnjVNBDd/Wi/9W3j
c7BKIGmF8DA9JH524usPGVvDHKYFBqDc2jv7f79MWsyzpIE2M8PsLHxffyqg3ws7
CSOie6I7daEtSCJC1Avi2GNLurkPvLyCPmcvMuig6Ok81s9NSVuQY5Is99CsJUFA
RaYC0U9eC+pLy1pWuqcMwyke/MCSMMeEREvH8dU2lvWZ8kdtzY/PN/vm17Bl4X7k
XzfgGsAI6ozuO9APzMMkTWdg5wG98E2S+PeC+wCa5e3lUrKGR9iwqiES9c8j0ZyA
ivU4WuIPEiEhlUs8Ply7HHaCkwZjAKoKryjsJMNsEgRqdTk3ShNt1+CxuX5b4Ym/
ep3d+rsYf+/VpuAeo0ZbPlpGJU1XTo4T49usnU8ezTxG9Iyt0KPbpctaGO2wwXBH
PUENHIPxATeYrc8j3hBc/a7kV8Cf3oQX8bqMjAXGP/8kixcYuq+tzH+OlCHP/63R
DXbGM2CYftaSAH1dimswTTSwo4U53/yN2JpkOGbICnujxMAJRV435G2DU8A+Xg8m
2CbWYS8a+gJG8qtac32zvngzzqvvu2V0Q2CdzbsFIXdd8TNH872ElOjRuNzLDlW3
THSUoJapQlF+D551UPfOKN1IZEgh8m4jM558DxvP3svcqF4jAjDIiRlxq4aKKIrx
BqIzN1/17gc+a1mm32Ru
=D47s
-----END PGP SIGNATURE-----

--nextPart12237683.ZMxPIkcAQZ--
