Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C065C433F5
	for <linux-dash@archiver.kernel.org>; Thu,  5 May 2022 23:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381699AbiEEXL6 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 May 2022 19:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378983AbiEEXL5 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 May 2022 19:11:57 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 378825EDCA
        for <dash@vger.kernel.org>; Thu,  5 May 2022 16:08:15 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 315391AA6
        for <dash@vger.kernel.org>; Fri,  6 May 2022 01:08:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1651792093;
        bh=Pj9+oU/xccJ3EM+y9yYtptpw74MmJvAAfRcgIfiQK7s=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=dmiGRlcrPihU5NRaSiPMFePEroeuE7pF/zHxaSJY0/Z4xgWRYNnbTjvumOR2DanCb
         4XMmM4j0OmhYw0nay6c7xEPf2iCkjlEyHFF3ksbq2slmqJrPoKyAi4NvdkjClUWUhN
         59ZTewfAf3p7j+GU5/sLtgdZepPp5owWA01ukFdE+kZnAwfRv+rVdk4DR8NABbiQe/
         RchEMTq5GUbUXolRAj0VqX2X/Adk+oAXqIa5QUagW1AtEYY5ljPhPVx2uKX7ORF6Mh
         ok1V7kevlQ3IbazGaX4Ue9bwMPEJKjUayq1H1P9Yu0+tEp3vmt22Yms1sr3020ic93
         KEpkgwH1UAfvg==
Date:   Fri, 6 May 2022 01:08:12 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH 3/2] man: document kill builtin
Message-ID: <20220505230812.iarg3q4panxc4mnw@tarta.nabijaczleweli.xyz>
References: <a54b9dea2b316ef9f5749cbde95417a2bad7a4d1.1651788702.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hh376maxnvwxbhs"
Content-Disposition: inline
In-Reply-To: <a54b9dea2b316ef9f5749cbde95417a2bad7a4d1.1651788702.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--2hh376maxnvwxbhs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
I missed that kill wasn't documented;
it is now, and it should really be all.

Please keep me in CC, as I'm not subscribed.

 src/dash.1 | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/dash.1 b/src/dash.1
index dd2bd47..514fcfe 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1478,6 +1478,33 @@ of other members of the job.
 .It Fl p
 Display only leader PIDs, one per line.
 .El
+.It kill Oo Fl s Ar sigspec | Fl Ns Ar signum | Fl Ns Ar sigspec Oc Op Ar =
pid | job ...
+Equivalent to
+.Xr kill 1 ,
+but a
+.Ar job
+spec may also be specified.
+Signals can be either case-insensitive names without
+.Dv SIG
+prefixes or decimal numbers; the default is
+.Dv TERM .
+.It kill Fl l Op Ar signum | exitstatus
+List available signal names without the
+.Dv SIG
+prefix
+.Pq Ar sigspec Ns s .
+If
+.Ar signum
+specified, display just the
+.Ar sigspec
+for that signal.
+If
+.Ar exitstatus
+specified
+.Pq > Sy 128 ,
+display just the
+.Ar sigspec
+that caused it.
 .It pwd Op Fl LP
 builtin command remembers what the current directory
 is rather than recomputing it each time.
--=20
2.30.2

--2hh376maxnvwxbhs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJ0WNsACgkQvP0LAY0m
WPF1IxAAiOw/GWHZ+mg0PspQs6HjbjtU1QAm0vag99dlS5iWHuGVxyNosyuSmrSV
ID0QIUoJ02ABJiwZZiXgQu+wNDIvnVcjTtb94rx1Ox/x33hwAMJIH+dTUxDIGW66
wsDfcpODHoMuG+dcf9QWWfGm8ZiC4wcPqj+UieFbooKmy5vis3HTH8T2tTGMauIP
AGLtpiBwsDb6ji0uLy6GnQoPkMYi11v1dqy3um34WSM9EcAizfjiBlPdbcvxoZxP
meT5CyE7YR0p2cn1xMhF8lKwcRWmRsDnxLN72D2wIPgOldovhKvKMjM/IIYAducM
Fu9Aah8fzCK8AWO7BwLSaTNfqXyDSwEXLO0u/3noOeoLG+Jr5oJhBaRO69/nLhC0
STE5uJbEbo3sWkP3k+LOh5V1ctNhGC0ZDfLeynAXj/qyV2JolVUzp7rx14vg7Z16
jXcb60o5Tz6dNRT0kZANCZN/3KmZyRll9Dq4J67JM8/sHtksNJV5I0kGSlH9r63x
eIKlxMQw58gU0/8Iufd3cj7fVw9Nrox6LcJUdZy2VIjHKuyFK8oy1U3JGBb0iY0u
u4bDUxwirVFybKEks2FCnrlutqSlb02b9zELLpfkxE3Qe+P6um2fXIOQlsNiS0dV
1Flbnu5EtDkx70uREW5UITaD4uNgAwtxUf4UM4hFXwkbKwUUins=
=fSE9
-----END PGP SIGNATURE-----

--2hh376maxnvwxbhs--
