Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA545C4332F
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 02:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiLNCvT (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 13 Dec 2022 21:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLNCvS (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Dec 2022 21:51:18 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07E0417400
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 18:51:16 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0D6CDEE6
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 03:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1670986275;
        bh=JFBygdBTOrMWXWnRgBA8pvhkWTW00C6tQiBrynCB6J8=;
        h=Date:From:To:Subject:From;
        b=EX0NwumQh4ghyPHbLIHsm74n3W6Q90vGR8FwOBdFlDmj6uKhFl5dRwcJ1PqWfbsAN
         t4jkkG0iZkmFs++EOCaHoayAb/oJDvqg0+4ETSlDwdt5gIHa7nlIfa0RN16hx5muoh
         oLJW1pYazyR1ffv2CPEdsy53gWxJAzDoDygL6DkKVw0lEA4cokzcMgwMLWTnxcPwmd
         00V4hVMRqyZUyfVjXqC6cl65eJ/xztJW0TQ5Mukv18ZOVjMoz89jCu9PavTVzPb1nQ
         l+61iHmFj547gH6Oc9dec6w9dZFGYA2JIL+aFO/YBTdSVrOU1uphs7I74JpLqd9pty
         LhVbZ6aFOeDDA==
Date:   Wed, 14 Dec 2022 03:51:13 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] exec: hashcmd: don't early-exit when first -r is found
Message-ID: <20221214025113.c6lxog5v3wp4vzbt@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xpnup6pasyjpgns6"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--xpnup6pasyjpgns6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This fixes incorrectly-accepted "hash -rv" being equivalent to hash -r
(well, hash -r[literally anything] being equivalent to hash -r)

Also remove -v from the manual, it doesn't appear to have ever existed

Fixes: https://bugs.debian.org/819829
---
 src/dash.1 | 6 ++----
 src/exec.c | 8 +++++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index ff02237..3e09090 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1441,7 +1441,8 @@ cmd \-a \-c arg file file
 cmd \-carg -a file file
 cmd \-a \-carg \-\- file file
 .Ed
-.It hash Fl rv Ar command ...
+.It hash Op Ar command ...
+.It hash Fl r
 The shell maintains a hash table which remembers the
 locations of commands.
 With no arguments whatsoever,
@@ -1457,9 +1458,6 @@ With arguments, the
 .Ic hash
 command removes the specified commands from the hash table (unless
 they are functions) and then locates them.
-With the
-.Fl v
-option, hash prints the locations of the commands as it finds them.
 The
 .Fl r
 option causes the hash command to delete all the entries in the hash table
diff --git a/src/exec.c b/src/exec.c
index 87354d4..d7a1f53 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -36,6 +36,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #ifdef HAVE_PATHS_H
 #include <paths.h>
@@ -271,11 +272,16 @@ hashcmd(int argc, char **argv)
 	int c;
 	struct cmdentry entry;
 	char *name;
+	bool clear;
=20
-	while ((c =3D nextopt("r")) !=3D '\0') {
+	clear =3D false;
+	while ((c =3D nextopt("r")) !=3D '\0')
+		clear =3D true;
+	if(clear) {
 		clearcmdentry();
 		return 0;
 	}
+
 	if (*argptr =3D=3D NULL) {
 		for (pp =3D cmdtable ; pp < &cmdtable[CMDTABLESIZE] ; pp++) {
 			for (cmdp =3D *pp ; cmdp ; cmdp =3D cmdp->next) {
--=20
2.30.2

--xpnup6pasyjpgns6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOZOiEACgkQvP0LAY0m
WPGwiA/+MBStsk3IeCqmVFbJAcge1tyaVSTzSvbDtrNfs4OyVDVOYm2MiAByaREc
YEwIj4D8ul6XDz+q/HniIXDT8gueRglC+flfQTK/2WUWXab6S5irUqdpuTCc6YfA
47fqUVQfojKMn1wnaSdAAIM8eS7I3Nb8BOLAY3tPWzWZf7d3ljYizrbi6nlyrn8b
/HCaHJE7ZH34mJwuQYC8dVTeFrmRdDcDb1Tt8L5N6pACHthWJB8kkHEiZib2NklH
Wk3Dk3MblNy6H0Ly38GFPzqeoNyi8HZZMd9YluObLte2x/8UxyJ2LfxYhC6+sMq6
wynRMwOO9sPvppM8KHmzAxcXpmaSFxXeRNbP+/rKVGbDmmjuvfnBrwDl9xw1zgOw
o2uVBVVI9619Xa2ZgjxdbYJlLasxL75ZNSbG9vrZa9jPAMreceSb+I+R1v9XpAqC
jg0mekrexnlskPfFnsmXQ36KAvBYnuaxWZgkxiiKhRx1OKAz5bWWJgc38a2LJrkY
aiKkfiTYjdq4vY5Xivsj8dCLcFRqVl8JD3EJALnHBdElBkvaZyt/PZN9e1rAEE32
RXFUlat8Pgv8q327wSkuI0H/x0Ju4NiGZWUhuhWI0qBgvWnYy1N1lgmxVwfnvUGe
r4Jyd5d0kMnSjOIoUWjNCAiiFcUW0b6WQCjX1aXdOjusPj9KKmg=
=62oj
-----END PGP SIGNATURE-----

--xpnup6pasyjpgns6--
