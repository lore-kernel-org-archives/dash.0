Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AB6C433FE
	for <linux-dash@archiver.kernel.org>; Thu,  5 May 2022 22:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351287AbiEEWSQ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 May 2022 18:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245603AbiEEWSP (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 May 2022 18:18:15 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 473C85EDE1
        for <dash@vger.kernel.org>; Thu,  5 May 2022 15:14:32 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3C0FF1B8E
        for <dash@vger.kernel.org>; Fri,  6 May 2022 00:12:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1651788734;
        bh=v3Ld0PLF+MKzHVVmQtFMacw2PyiPkcYLYIUDsFvMUpw=;
        h=Date:From:To:Subject:From;
        b=NwdYi1D2MHlwxCOI2wMT4Gl/8Su/90piV+G4fZQcBfCh0ZUUzMnArAaD6Vx/OiaiW
         wBzAcRgcY/A9nOT9AnJYcW7gvGWO8D/iMv6LYYOxU9UAVcDWF5uWxnmi7mIK9L3Wat
         Ophnx4OwQMYXJLYAJdpoSCNfE9w1jQ3hjkAASeVjqfHggBztRjCnoA2Uw0xSDHPgUN
         CjpWaTfY+7mZkscivsVKoWq5wUJqL29jyIxraRKSmAkiJq5cAJA2u5BW7ddWgODF5+
         9dFmE8u+QXSK/tB0ZOmqlzETXH7xNlygxNyELQF4hA7u9F3lUKDCRsHUhk1HRXxz+2
         rGK/ETeLCOWhA==
Date:   Fri, 6 May 2022 00:12:13 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH 1/2] man: document jobs builtin
Message-ID: <a54b9dea2b316ef9f5749cbde95417a2bad7a4d1.1651788702.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w5lkyq52ttibviwi"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--w5lkyq52ttibviwi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fixes: Debian #558607
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
Please keep me in CC, as I'm not subscribed.

 src/dash.1 | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/dash.1 b/src/dash.1
index ff02237..969a883 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1464,6 +1464,20 @@ The
 .Fl r
 option causes the hash command to delete all the entries in the hash table
 except for functions.
+.It jobs Oo Fl lp Oc Op Ar job ...
+Display the status of all, or just the specified,
+.Ar job Ns s :
+.Bl -tag -compact -offset 5n -width "By default"
+.It By default
+display the job number, currency
+.Pq Sy +-
+status, if any, the job state, and its shell command.
+.It Fl l
+also output the PID of the group leader, and just the PID and shell comman=
ds
+of other members of the job.
+.It Fl p
+Display only leader PIDs, one per line.
+.El
 .It pwd Op Fl LP
 builtin command remembers what the current directory
 is rather than recomputing it each time.
--=20
2.30.2


--w5lkyq52ttibviwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJ0S7oACgkQvP0LAY0m
WPHvYg//dBMe3ytLjZubaRQbU2cgh6YF8eBV0C0WWvIC372Zt74Os0OvG+pO0wkr
mxd68QiyD2QEwJRi4v4uJwwguakqr1zIpfwa6KQkm9e60su97aeOB3jY2JAWkWln
3/7BEEKUi7eDlPEb1sGvj0Tm5XGJXsCNFX0mVXcy3lXJOsWJxQ3B9mfoPk7qEO1x
Yt5XG+5w/aUlCbWnd0nqzVaVQXn7bdbbZEMm7Ow38Ftq+hr7yywq5rU5XTwmkB6I
gzVRG3clAXij7Y2VEQ9ihDucfDxfgjdNxXdw3rfIfUWYGAWt5mpFQqSfRDfAtqHL
ufKUY7GysSlwjKMOx/UznRml6DcA3egV3adCWAkvAeBptHR5KVtmPxKhKzvtFCMt
+dKmsutoy3jNGIrqDgwLqXKaDGTfDgHZsCuwuK/ncQ7s5/ltBvn/w48Xf9RgmpvU
nxf8T5ks13724mtIwNz7Blr12HzK8F7h+DmThe/dz8fPBGWENWh8+Oal5eB/d0A3
6SyfLrLv0VulEE/jPNQl9aUXdtw8nY/B4mdWyA94AnnFRQxcEYPJj9aLjlhZ985Z
SKUH0ouaENjkWOvnST+bXLNowElpNddX+V2Kq6umu4hjchMWvWKbt6cGk9TYD/oO
xJ23cg4vnFi7K9L6UE8+gKiClu6Tywt6qQtbgZdrltpGMrHaT/A=
=kDf6
-----END PGP SIGNATURE-----

--w5lkyq52ttibviwi--
