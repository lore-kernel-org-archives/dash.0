Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEADC4332F
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 02:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLNCbg (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 13 Dec 2022 21:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLNCbf (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 13 Dec 2022 21:31:35 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C563D1E3F7
        for <dash@vger.kernel.org>; Tue, 13 Dec 2022 18:31:33 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8655FE66
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 03:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1670985091;
        bh=V5ybB/D+/KqQiBMNlJVXsEIMIycAgfneIt9WRKhi3sg=;
        h=Date:From:To:Subject:From;
        b=lDABUUL8AbY9VTyQ0xvI5tiC8csoZh+DljiqVlGYbw/QvRLBsgUP+0kmo6mpeK/8F
         cKEy2jfEedpvmzYpVDyi2D2fX2FLsgK1aUNiTvnEqDzQFYdKrAjON/Ek2SKrUajYdc
         MYvlSYICFDGIP2KsFEKlxNNLSpD50Hc/owVdghtdnVEowFBapc2LKq2l/Q3LkoeHYV
         U0udHitEPA8q3/mnfYO3yg0u+BbPB9EZTRtNyew7MsOZvVtsXracHRo8hVOceYtbXW
         4jZBxlr0aQ7c9Kpo73X4FIYkHJ1Hwl3DOVpsfb4Im+5CWOVhJVGCe4dkaxztjFVeTI
         1fxNaT+RdLc2A==
Date:   Wed, 14 Dec 2022 03:31:30 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] options: don't error when unsetting OPTIND
Message-ID: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ykddvgchsbybmnpt"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--ykddvgchsbybmnpt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

unset OPTIND ends up calling getoptsreset("") which errors out with
  sh: 1: unset: Illegal number:
or even
  sh: 1: unset: Illegal number: leweli/bin:/usr/l=EF=BF=BD=EF=BF=BD

Pass the current flags to struct var->func, set the getopts optind to 1
and continue with allowing the unset.

We still forbid OPTIND=3D, OPTIND=3D-1, OPTIND=3Dabc, &c.

Fixes: https://bugs.debian.org/985478
---
 src/exec.c    | 2 +-
 src/exec.h    | 2 +-
 src/mail.c    | 2 +-
 src/mail.h    | 2 +-
 src/options.c | 5 ++---
 src/options.h | 2 +-
 src/var.c     | 4 ++--
 src/var.h     | 2 +-
 8 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/src/exec.c b/src/exec.c
index 87354d4..68fa8ab 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -565,7 +565,7 @@ hashcd(void)
  */
=20
 void
-changepath(const char *newval)
+changepath(const char *newval, int unused)
 {
 	const char *new;
 	int idx;
diff --git a/src/exec.h b/src/exec.h
index 423b07e..0f74be4 100644
--- a/src/exec.h
+++ b/src/exec.h
@@ -69,7 +69,7 @@ int hashcmd(int, char **);
 void find_command(char *, struct cmdentry *, int, const char *);
 struct builtincmd *find_builtin(const char *);
 void hashcd(void);
-void changepath(const char *);
+void changepath(const char *, int);
 #ifdef notdef
 void getcmdentry(char *, struct cmdentry *);
 #endif
diff --git a/src/mail.c b/src/mail.c
index 8eacb2d..e81d2b4 100644
--- a/src/mail.c
+++ b/src/mail.c
@@ -109,7 +109,7 @@ chkmail(void)
=20
=20
 void
-changemail(const char *val)
+changemail(const char *val, int unused)
 {
 	changed++;
 }
diff --git a/src/mail.h b/src/mail.h
index 3c6b21d..70b54a4 100644
--- a/src/mail.h
+++ b/src/mail.h
@@ -35,4 +35,4 @@
  */
=20
 void chkmail(void);
-void changemail(const char *);
+void changemail(const char *, int);
diff --git a/src/options.c b/src/options.c
index a46c23b..81f2c4b 100644
--- a/src/options.c
+++ b/src/options.c
@@ -390,10 +390,9 @@ setcmd(int argc, char **argv)
=20
=20
 void
-getoptsreset(value)
-	const char *value;
+getoptsreset(const char *value, int flags)
 {
-	shellparam.optind =3D number(value) ?: 1;
+	shellparam.optind =3D (flags & VUNSET) ? 1 : number(value) ?: 1;
 	shellparam.optoff =3D -1;
 }
=20
diff --git a/src/options.h b/src/options.h
index 975fe33..10bcb88 100644
--- a/src/options.h
+++ b/src/options.h
@@ -83,4 +83,4 @@ int shiftcmd(int, char **);
 int setcmd(int, char **);
 int getoptscmd(int, char **);
 int nextopt(const char *);
-void getoptsreset(const char *);
+void getoptsreset(const char *, int);
diff --git a/src/var.c b/src/var.c
index ef9c2bd..a7d4a92 100644
--- a/src/var.c
+++ b/src/var.c
@@ -266,7 +266,7 @@ struct var *setvareq(char *s, int flags)
 			goto out;
=20
 		if (vp->func && (flags & VNOFUNC) =3D=3D 0)
-			(*vp->func)(strchrnul(s, '=3D') + 1);
+			(*vp->func)(strchrnul(s, '=3D') + 1, flags);
=20
 		if ((vp->flags & (VTEXTFIXED|VSTACK)) =3D=3D 0)
 			ckfree(vp->text);
@@ -531,7 +531,7 @@ poplocalvars(void)
 			unsetvar(vp->text);
 		} else {
 			if (vp->func)
-				(*vp->func)(strchrnul(lvp->text, '=3D') + 1);
+				(*vp->func)(strchrnul(lvp->text, '=3D') + 1, lvp->flags);
 			if ((vp->flags & (VTEXTFIXED|VSTACK)) =3D=3D 0)
 				ckfree(vp->text);
 			vp->flags =3D lvp->flags;
diff --git a/src/var.h b/src/var.h
index aa7575a..4329e22 100644
--- a/src/var.h
+++ b/src/var.h
@@ -56,7 +56,7 @@ struct var {
 	struct var *next;		/* next entry in hash list */
 	int flags;			/* flags are defined above */
 	const char *text;		/* name=3Dvalue */
-	void (*func)(const char *);
+	void (*func)(const char *, int flags);
 					/* function to be called when  */
 					/* the variable gets set/unset */
 };
--=20
2.30.2

--ykddvgchsbybmnpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOZNYIACgkQvP0LAY0m
WPFIqA/+IZxINxxC+DC+oh8I8bUQ2HEQEsvu32yOnp3KPbL+Cl/rK1HTWr8n4tQY
rl+t5l4YkEnhk++Z/jmVfApQQ8Q+KxynELeUSpHSHfzLRXvBSuQ3/Rh/8NF/HNHE
FcQ8PdbYvEglyeYFI/rZALzWzON6Jz/r/nGh4g2oa76dgOj0wLL2hDK35BUmcuMe
nElvegQozXDhY3zgk63ECIPgaenk3w6oXU4rrKBTLpx6aGy2nw8PM2sOq2AeuFUj
4Ehno6v4PkNsFeP8zeRIO83u3Y3vl19/6+aUPkIkNZs+6kuTVP93g8ZdqR8sCukY
VgF5PW/UedmxWoHGQc+aqD0+4EIlfqkBGsswpFworMYqCByVmSR6gzuMzu64/BMg
scEWRiTFuXsy54oFmroSWIWTLtrk65brGgGiO2uKz1kOML/NHcKrjQrnUG2uy23i
zKg9FFt7NHG3k7aSpu09ZAAiukwAr5g4ESerPTVy+TaV8P8ZFep/U0+VQKCVr+F8
xNmC0xidtzBG1PZA8HJGGc2eK+99gIn5wq5dZr/8YQHL6gXIqnu0ohlHJ3dbRS3a
Dp8fTmmflTTwlbcBms7LMNidwwnGjTfq59FWVSJAoHDMVS4q6FqIRQkf2PlPR/vd
upC/HbZscWUrI3dFGT4rG5B6vEy3UHJzK60P1quBANwgpadAny4=
=cmHG
-----END PGP SIGNATURE-----

--ykddvgchsbybmnpt--
