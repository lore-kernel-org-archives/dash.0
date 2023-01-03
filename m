Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621E5C46467
	for <linux-dash@archiver.kernel.org>; Tue,  3 Jan 2023 12:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbjACM00 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Jan 2023 07:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjACM0Z (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Jan 2023 07:26:25 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFA78B49E
        for <dash@vger.kernel.org>; Tue,  3 Jan 2023 04:26:22 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5734C63A;
        Tue,  3 Jan 2023 13:26:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672748780;
        bh=jQAM7O+IXFC9JK7mpwAho9AYPS/7fN/nZ+vV3fSKJn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgBKVkqvrf7mPL7dgR6ZT5ab8C7jKZfZwHdYvFwKzafTQzk82FNDCC+NyIsEOru6+
         tfPRZVWs66wxtPRzpA+XNgNjGTdZM3ea6cENNQLVSjNkn0pMLRYHYsXxJ/uNiO6x1q
         m37irSHDp6jcPXe9CIpqssLipBXYr6Dqkidw4hoIr09gNDRa+9FCWM8vS1kQsTgbt2
         dfHyoFIWEo17lAi9gLd18eOHHs3xj+GryILTy4ks9XN7c1xbCQfiJqBQ2znaAiTsPa
         8wGOfD/5w8CpZszO9fWg6kPTZFYHOJRWeu5PpXGGRZZLkM8vh4HhGxvd1xp4fqNxE0
         f8XTyYOEG0t2A==
Date:   Tue, 3 Jan 2023 13:26:19 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] var: Do not add 1 to return value of strchrnul
Message-ID: <20230103122619.bhvn7lep5avoanji@tarta.nabijaczleweli.xyz>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sx24ycddlu4vcd2z"
Content-Disposition: inline
In-Reply-To: <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--sx24ycddlu4vcd2z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue, Jan 03, 2023 at 05:39:41PM +0800, Herbert Xu wrote:
> =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > --- a/src/var.c
> > +++ b/src/var.c
> > @@ -266,7 +266,7 @@ struct var *setvareq(char *s, int flags)
> >                        goto out;
> >=20
> >                if (vp->func && (flags & VNOFUNC) =3D=3D 0)
> > -                       (*vp->func)(strchrnul(s, '=3D') + 1);
> > +                       (*vp->func)(strchrnul(s, '=3D') + 1, flags);
> Yes this was definitely broken.  strchrnul returns a pointer to the
> final NUL character so adding one to it is just wrong.
That originally gave me pause but I assumed this is an intentional
muddling for a known memory lay-out or w/e,
but that explains the corruption I saw sometimes, yeah.

> However, I don't think we need to pass the flags to the action
> function since none of them care about whether it's unset.  We
> just need to pass a pointer to an empty string rather than some
> bogus pointer.
This, unsurprisingly, produces the same error, because getoptsreset()
needs a valid number for OPTIND:
  $ src/dash -c 'unset OPTIND'
  src/dash: 1: unset: Illegal number:
and the empty string isn't a valid number
(in the simple case of src/dash -c 'unset OPTIND' &a. the original
 broken approach also produced an empty string on accident
 in most cases for me).

We do need to at least to /some/how signal to getoptsreset() that we're
unsetting while preserving the requirement that OPTIND is an integer,
and passing a flag is the only sensible way, I think.

Scissor-patch rebased on top of your v2 below.

Best,
-- >8 --
Subject: [PATCH] options: don't error when unsetting OPTIND

unset OPTIND ends up calling getoptsreset("") which errors out with
  sh: 1: unset: Illegal number:

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
index b70d72c..13a946b 100644
--- a/src/var.c
+++ b/src/var.c
@@ -270,7 +270,7 @@ struct var *setvareq(char *s, int flags)
 			goto out;
=20
 		if (vp->func && (flags & VNOFUNC) =3D=3D 0)
-			(*vp->func)(varnull(s));
+			(*vp->func)(varnull(s), flags);
=20
 		if ((vp->flags & (VTEXTFIXED|VSTACK)) =3D=3D 0)
 			ckfree(vp->text);
@@ -535,7 +535,7 @@ poplocalvars(void)
 			unsetvar(vp->text);
 		} else {
 			if (vp->func)
-				(*vp->func)(varnull(lvp->text));
+				(*vp->func)(varnull(lvp->text), lvp->flags);
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

--sx24ycddlu4vcd2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO0HuoACgkQvP0LAY0m
WPGUTA/+LovXkNocdxlNAc1en4YeKD/AuwpHiM0TXbk4n3HzmULfJeM1d+Md2Btr
Za9Lk31G2awqKnZ6idhgPSueltiStSjTUGmth/EooUmFUQ5I2zeiZ4eYRRitSYmx
Q4KLk0nFImw37MPhgKh0vpN4VNL4aL2FpFsyhX4CBfUbMhMmBZFlY52TRn+g7CFw
ogZOn4fSUXSpeLCvKuJN+RTAmUOVLTFTb2U0l+QSsKGPgaXp7p1pSzkmAw7/8TNe
Emb20a4EZmm2K0hdLOfj5x1IXbfDc96BYJsKN+X0jXvM8FZZrHQKR2u0YM0DPR5o
7t+Hdclbgvjzt/Ixti0Jaivm8MFZS2vF4wsE378IMzXJ/qFzcfLhXIjmGtmAggZf
CpxhlQ6R7ZfOnzsQbEgTs/PLBBjQCHxUen1uCAK2Hl7pzhWhL4nd+7Hta4mQ6Jt1
mrDa4MY8G0rXMDEqDGM2stRl00xZOlOdm4xQP9EAwz2CIsYfNXZrrHveTqn6cZbq
cmWECzT5Brvp62l8R/n3iW5MD9PsaXxEvkyYakfwdNwDnbj3pRZRDRd9vwuhZ+mn
WScXltdQ0TB7AKJsdbRjQfWflvVKw9vbilwlI7NpFJI5B2YC02FMJOKC6urA9ieR
2iyQB9WJq3ao5C1zpgPfkpEtQ6MYwMz58a2dH3wBZHqXYpf5V4M=
=gwqj
-----END PGP SIGNATURE-----

--sx24ycddlu4vcd2z--
