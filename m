Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393C5C46467
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 16:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjADQFt (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbjADQFd (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 11:05:33 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00FFBE60
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 08:05:29 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8C944654;
        Wed,  4 Jan 2023 17:05:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672848327;
        bh=53p+ElD5pP0OJk5UcJNhSllcveNj4Licvyrhyuxj+Ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrSIDOoVroWiQ6gWJyUWPHYpPLf0D0Wn/esNZiwRfB7SQ4FW8QKRdvnPYzes+a/72
         6J+iytdZxYmK0p+mhaHx2wTz1AfYNp/95ZaKNEcVGSnkP1leuL8WA3IOIgSTNWBRdG
         nvV5OeW8UmBvDyJZ4Fbh4EzP8Y335T63hEXyZY3mJIV4qHRgpzBfk9rmy2DfLO8SDC
         nBy3Rbrhk+pt1nAWBXPhJVJv6RiKL0XaOjnLT6bFlNZ+15TMx3v/X0JfoJU1AV4szG
         UQc4WFI6PepfZ2Rc9Fije4lhkV/0mlZMXe1IARvhwfz8eiEWBROlo1mgN+TElKxQFl
         CGVQHM0gY+Afw==
Date:   Wed, 4 Jan 2023 17:05:26 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] var: Do not add 1 to return value of strchrnul
Message-ID: <20230104160526.7vuq3s2ivqaaot4l@tarta.nabijaczleweli.xyz>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
 <20230103122619.bhvn7lep5avoanji@tarta.nabijaczleweli.xyz>
 <Y7VOEx/cE4vQZ0zE@gondor.apana.org.au>
 <20230104125421.rmjbjzme7a6qbxhx@tarta.nabijaczleweli.xyz>
 <Y7WJVBPWsNhTvRuJ@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xmx42ht2az7axcw2"
Content-Disposition: inline
In-Reply-To: <Y7WJVBPWsNhTvRuJ@gondor.apana.org.au>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--xmx42ht2az7axcw2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Jan 04, 2023 at 10:12:36PM +0800, Herbert Xu wrote:
> On Wed, Jan 04, 2023 at 01:54:21PM +0100, =D0=BD=D0=B0=D0=B1 wrote:
> > AFAICT, after trawling through the Issue 8 Draft 2.1,
> > there are no special provisions for unset/OPTIND,
> Well it says this regarding OPTIND:
>=20
> : If the application sets OPTIND to the value 1, a new set of parameters
> : can be used: either the current positional parameters or new arg
> : values. Any other attempt to invoke getopts multiple times in a single
> : shell execution environment with parameters (positional parameters
> : or arg operands) that are not the same in all invocations, or with an
> : OPTIND value modified to be a value other than 1, produces unspecified
> : results.
>=20
> Unsetting OPTIND ought to do the same thing as setting it to "",
On the basis of? Those are fundamentally unrelated operations,
and when they are to do the same thing, this is explicitly noted.

Additionally, this is a description of /getopts/, and therefore only
applies if you do "OPTIND=3Ddupa; getopts ..." =E2=80=92 the getopts call is
unspecified.

/Any/ operation on OPTIND is legal, and the current behaviour is wrong
(but it seems that no-one has actually cared) =E2=80=92 POSIX defines this =
in
terms of getopts inspecting OPTIND when it's run.

"OPTIND=3Dwhatever" is legal and must result in OPTIND becoming whatever.
bash, ksh, and zsh all reduce it to OPTIND=3D0, so it appears that no-one
actually cares about this so erroring out is fine, I guess.
(mksh does the same but folds to 1; posh refuses the assignment),

"unset OPTIND" is legal, and subsequent getopts calls are well-defined
(it's unclear to me what it oughta do /per se/, but it's not "been set",
 so it's unclear what it's well-defined /to/, but since "the index of
 the next argument to be processed in the shell variable OPTIND" and
 that value doesn't exist, erroring out is fine I guess),
and all the above shells agree
(as does mksh; posh ignores the unset).
and this fell out of a debbug where someone used it
(and additionally cites a few more shells),
so people actually care about this behaviour.

In testing the poster's shells,
I found that yash behaves close to correct here:
-- >8 --
nabijaczleweli@tarta dash 2$ OPTIND=3Ddupa
nabijaczleweli@tarta dash 2$ getopts a a a
getopts: $OPTIND has an invalid value
nabijaczleweli@tarta dash 1 2$ OPTIND=3D300
nabijaczleweli@tarta dash 2$ getopts a a a
nabijaczleweli@tarta dash 1 2$ unset OPTIND
nabijaczleweli@tarta dash 2$ set | grep -i optind
nabijaczleweli@tarta dash 1 2$ getopts a a a
getopts: $OPTIND has an invalid value
-- >8 --

As does busybox ash:
-- >8 --
~/code/dash $ OPTIND=3Ddupa
~/code/dash $ set | grep -i optind
OPTIND=3D'dupa'
~/code/dash $ getopts a a a
~/code/dash $ set | grep -i optind
OPTIND=3D'1'
~/code/dash $ unset OPTIND
~/code/dash $ set | grep -i optind
_=3D'OPTIND'
~/code/dash $ getopts a a a
~/code/dash $ set | grep -i optind
OPTIND=3D'1'
-- >8 --

The minimal change required to achieve compatibility is my patch,
or some equivalent variant of it, like passing NULL instead of flags.
The minimal change required to achieve conformance would be
to get parse OPTIND in getopts like yash.

There's code in the wild that uses "unset OPTIND; getopts ..."
instead of "OPTIND=3D1; getopts ...":
  https://codesearch.debian.net/search?q=3Dunset+OPTIND&literal=3D1&perpkg=
=3D1
but those are all bash programs, so it's up to you whether they should
receive explicit provisions for this.

I'm including a PoC scissor-patch below; in particular the ternary
should either be turned into an equivalent of ': "1"' if you want to
support "unset OPTIND; getopts ..." or produce a better error than
"./dash: 1: getopts: Illegal number: unset", but you get the idea
(and shellparam should get fully boolified
 and dash.1 wants to have an explicit note that reset is OPTIND=3D1,
 but I can follow up with that if we're in agreement here).

Best,
-- >8 --
Subject: [PATCH] options: lazy-parse OPTIND in getopts, per POSIX

This allows "unset OPTIND" and "OPTIND=3Ddupa" to execute as-written
(and as required by POSIX), and catches them as an error in getopts,
which exits 2 ("An error occurred.").

Fixes: https://bugs.debian.org/985478
---
 src/options.c | 30 +++++++++++++++++-------------
 src/options.h |  5 ++++-
 src/var.h     |  1 +
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/src/options.c b/src/options.c
index a46c23b..578a13f 100644
--- a/src/options.c
+++ b/src/options.c
@@ -164,7 +164,7 @@ setarg0:
 	shellparam.p =3D xargv;
 	shellparam.optind =3D 1;
 	shellparam.optoff =3D -1;
-	/* assert(shellparam.malloc =3D=3D 0 && shellparam.nparam =3D=3D 0); */
+	/* assert(!shellparam.malloc && !shellparam.optreparse && shellparam.npar=
am =3D=3D 0); */
 	while (*xargv) {
 		shellparam.nparam++;
 		xargv++;
@@ -390,11 +390,9 @@ setcmd(int argc, char **argv)
=20
=20
 void
-getoptsreset(value)
-	const char *value;
+getoptsreset(const char *value)
 {
-	shellparam.optind =3D number(value) ?: 1;
-	shellparam.optoff =3D -1;
+	shellparam.optreparse =3D true;
 }
=20
 /*
@@ -408,22 +406,28 @@ int
 getoptscmd(int argc, char **argv)
 {
 	char **optbase;
+	unsigned max;
=20
 	if (argc < 3)
 		sh_error("Usage: getopts optstring var [arg]");
 	else if (argc =3D=3D 3) {
 		optbase =3D shellparam.p;
-		if ((unsigned)shellparam.optind > shellparam.nparam + 1) {
-			shellparam.optind =3D 1;
-			shellparam.optoff =3D -1;
-		}
+		max =3D shellparam.nparam + 1;
 	}
 	else {
 		optbase =3D &argv[3];
-		if ((unsigned)shellparam.optind > argc - 2) {
-			shellparam.optind =3D 1;
-			shellparam.optoff =3D -1;
-		}
+		max =3D argc - 2;
+	}
+
+	if (shellparam.optreparse) {
+		shellparam.optind =3D number(optindset() ? optindval() : "unset") ?: 1;
+		shellparam.optoff =3D -1;
+		shellparam.optreparse =3D false;
+	}
+
+	if ((unsigned)shellparam.optind > max) {
+		shellparam.optind =3D 1;
+		shellparam.optoff =3D -1;
 	}
=20
 	return getopts(argv[1], argv[2], optbase);
diff --git a/src/options.h b/src/options.h
index 975fe33..8aebf9f 100644
--- a/src/options.h
+++ b/src/options.h
@@ -34,9 +34,12 @@
  *	@(#)options.h	8.2 (Berkeley) 5/4/95
  */
=20
+#include <stdbool.h>
+
 struct shparam {
 	int nparam;		/* # of positional parameters (without $0) */
-	unsigned char malloc;	/* if parameter list dynamically allocated */
+	bool malloc;		/* if parameter list dynamically allocated */
+	bool optreparse;	/* re-parse optind/optoff from $OPTIND */
 	char **p;		/* parameter list */
 	int optind;		/* next parameter to be processed by getopts */
 	int optoff;		/* used by getopts */
diff --git a/src/var.h b/src/var.h
index aa7575a..ca90a68 100644
--- a/src/var.h
+++ b/src/var.h
@@ -133,6 +133,7 @@ extern char linenovar[];
 #define attyset()	((vatty.flags & VUNSET) =3D=3D 0)
 #endif
 #define mpathset()	((vmpath.flags & VUNSET) =3D=3D 0)
+#define optindset()	((voptind.flags & VUNSET) =3D=3D 0)
=20
 void initvar(void);
 struct var *setvar(const char *name, const char *val, int flags);
--=20
2.30.2

--xmx42ht2az7axcw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmO1o8YACgkQvP0LAY0m
WPHXWRAAkoKA0Hjo/dUGgezpXdDJkn4e+LCcUJWAHVRJIfIimmWqsZOs9ssHp4vO
g0TL1UFAvCNxVJ0x2lPMTjWTKq05NcUPmdQ+Ag6B5DU8I6v6BsLHYOOl18FCk2nU
kd/caoNwI/6C/SWOrPxEvSlY0RPlyOcV939DW7I5+zadO0IWMDxJIotF77RPQil1
gShmgeGq2s/Bk+5hzSetaG0E3qukzmanu4qt9DueqCL4fGVTWZQvkYqjQsd6mqp3
/C1e56iSDf+SZd7+tPcLEX9WvHqT5Lhr8/Eay3YZazT6Ml8q1piJCK2ay4odbQhS
tR2NDWB9JK1NHLRDQEVsaBk8AljDAqeUra3nZOhyTg8ukKfrhUlAyqErvdEWvKqY
4nij/0AtYDiVfPWAX8LjvCv9Ey+vbtgMbnUso4V4GT/wbh7Yw+7ZaIWb/sZIevoA
GmKC3sQNRI6Bq2lQK829Ngg5E1AyINKJh2+GQTEBspb9o12YhQye489zSCtd0maI
56h7YuRQwP8rvmbyORxE21yLVFae8Y+HtnlZgewL9Ws2tOZcqWw4wTp4CbfiiAmT
+bLOpDCeyw7qk8o0xSEUbfHKiF5pXs8J00EGHzA5khovoj/ctEfuzhiCQU4kRHRB
/plYH+CRCyOMIjd/bOCmeBEz/w61qWBJzU900oOA0eOaO7nJJeg=
=3/jl
-----END PGP SIGNATURE-----

--xmx42ht2az7axcw2--
