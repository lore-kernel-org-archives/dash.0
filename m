From: Vadim Zeitlin <vz-dash@zeitlins.org>
Subject: Possibly wrong handling of $_?
Date: Tue, 23 Dec 2014 23:34:59 +0100
Message-ID: <E1Y3Y2d-000276-SL@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="525889937-41-1419374099=:9020"
Return-path: <dash-owner@vger.kernel.org>
Received: from sunset.tt-solutions.com ([82.240.17.225]:46546 "EHLO
	smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068AbaLWWq4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Dec 2014 17:46:56 -0500
Received: from [192.168.17.86] (helo=Twilight)
	by smtp.tt-solutions.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <vz-dash@zeitlins.org>)
	id 1Y3Y2d-000276-SL
	for dash@vger.kernel.org; Tue, 23 Dec 2014 23:34:59 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

--525889937-41-1419374099=:9020
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

 Hello,

 I'm not exactly sure if this is a bug because I didn't find any
specification about how is this supposed to behave (to my surprise it
turned out that $_ was not in POSIX), but please consider this:

	% zsh -c 'echo -n foo && echo $_'
	foofoo
	% bash -c 'echo -n foo && echo $_'
	foofoo
	% dash -c 'echo -n foo && echo $_'
	foo/usr/bin/dash

I've tested several different versions of zsh (4 and 5) and bash (3 and 4)
and dash 0.5.5 and 0.5.7 from Debian and they all produced the results as
above.

 Shouldn't dash follow the other shells here?
VZ

--525889937-41-1419374099=:9020
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)

iEYEABECAAYFAlSZ7hMACgkQBupB3k9sHobtqwCfVHhTMgXAFnN3tPT6It7xU0HB
sSgAn0EcD65qTuzwB3R9W+JbeQbvbErl
=q+c4
-----END PGP SIGNATURE-----

--525889937-41-1419374099=:9020--
