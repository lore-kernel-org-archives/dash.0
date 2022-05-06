Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6131C433EF
	for <linux-dash@archiver.kernel.org>; Fri,  6 May 2022 19:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352000AbiEFTiY (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 6 May 2022 15:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343640AbiEFTiX (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 6 May 2022 15:38:23 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4B8033E07
        for <dash@vger.kernel.org>; Fri,  6 May 2022 12:34:38 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 12AFC117C
        for <dash@vger.kernel.org>; Fri,  6 May 2022 21:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1651865676;
        bh=Y692ralpRkhMkTBayN6EQoTdFE9+6yQkqZ2evL54XFI=;
        h=Date:From:To:Subject:From;
        b=pNf21cNH5ccV74NBBYuQt3TN6PpfiI6REtQQvwbEDdE0rZu77f7utZIh6IDPzhTDG
         q3ZZvgrEqh4U1TTPki1M//y2wraEya2xl1k/9wJF5yPFn6mOHVCOh0CmUmVLI9SKEJ
         JCfrW7cJ6xNw/j1oKyMaTMRtQ1ESjBXGS4AnLbNVl/LgveYEJA0rp/q4p6o83kJOcD
         AC+dc34QJNpRTmzXFiqV8xuuIpfLeKfVA4htlbKf+LyetlhFc/+mnlX+g/U4y+CPTd
         hwabHSmoR51hRR4+e87r19tI0EXNWMSSXqwCljmiuBZ+AadgQTWS63Z03gnUcuKm4a
         YggrQGgZBBO6w==
Date:   Fri, 6 May 2022 21:34:34 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] man: don't list unavailable built-ins and Command Line
 Editing section
Message-ID: <20220506193434.sza4mvudzuytauoj@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u2nz6mhtea7wug65"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--u2nz6mhtea7wug65
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
I went for a complete removal of the Command Line Editing sexion,
but it's possible doing something like "unavailable, configure with
--with-libedit" is better?

Please keep me in CC, as I'm not subscribed.

 src/.gitignore            | 2 ++
 src/Makefile.am           | 9 ++++++---
 src/{dash.1 =3D> dash.1.in} | 6 ++++++
 src/mkbuiltins            | 5 ++++-
 4 files changed, 18 insertions(+), 4 deletions(-)
 rename src/{dash.1 =3D> dash.1.in} (99%)
 mode change 100644 =3D> 100755 src/mkbuiltins

diff --git a/src/.gitignore b/src/.gitignore
index 644eccb..66cdfff 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,6 +1,7 @@
 *.o
 builtins.[ch]
 builtins.def
+builtins.roff
 dash
 init.c
 mkinit
@@ -11,3 +12,4 @@ nodes.[ch]
 signames.c
 syntax.[ch]
 token.h
+dash.1
diff --git a/src/Makefile.am b/src/Makefile.am
index 1732465..3c0d4da 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -35,7 +35,7 @@ HELPERS =3D mkinit mksyntax mknodes mksignames
 BUILT_SOURCES =3D builtins.h nodes.h syntax.h token.h token_vars.h
 CLEANFILES =3D \
 	$(BUILT_SOURCES) $(patsubst %.o,%.c,$(dash_LDADD)) \
-	$(HELPERS) builtins.def
+	$(HELPERS) builtins.def builtins.roff dash.1
=20
 man_MANS =3D dash.1
 EXTRA_DIST =3D \
@@ -49,8 +49,8 @@ token.h token_vars.h: mktokens
 builtins.def: builtins.def.in $(top_builddir)/config.h
 	$(AM_V_CC)$(COMPILE) -E -x c -o $@ $<
=20
-builtins.c builtins.h: mkbuiltins builtins.def
-	$(AM_V_GEN)$(SHELL) $^
+builtins.c builtins.roff builtins.h: mkbuiltins builtins.def
+	$(AM_V_GEN)./$^
=20
 init.c: mkinit $(dash_CFILES)
 	$(AM_V_GEN)./$^
@@ -66,5 +66,8 @@ signames.c: mksignames
=20
 mksyntax: token.h
=20
+dash.1: dash.1.in builtins.roff
+	$(AM_V_GEN)$(AWK) '{print}  /^\.Ss Builtins$$/ {while((getline < "builtin=
s.roff") > 0) print}' $< > $@
+
 $(HELPERS): %: %.c
 	$(AM_V_CC)$(COMPILE_FOR_BUILD) -o $@ $<
diff --git a/src/dash.1 b/src/dash.1.in
similarity index 99%
rename from src/dash.1
rename to src/dash.1.in
index 514fcfe..5084d79 100644
--- a/src/dash.1
+++ b/src/dash.1.in
@@ -1254,6 +1254,7 @@ With no arguments the export command lists the names =
of all exported variables.
 With the
 .Fl p
 option specified the output will be formatted suitably for non-interactive=
 use.
+.if !\n[BUILTIN_fc] .ig
 .It Xo fc Op Fl e Ar editor
 .Op Ar first Op Ar last
 .Xc
@@ -1340,6 +1341,7 @@ Name of the editor to use.
 .It Ev HISTSIZE
 The number of previous commands that are accessible.
 .El
+..
 .It fg Op Ar job
 Move the specified job or the current job to the foreground.
 .It getopts Ar optstring var
@@ -2160,6 +2162,7 @@ command, tracked alias and not found.
 For aliases the alias expansion is
 printed; for commands and tracked aliases the complete pathname of the
 command is printed.
+.if !\n[BUILTIN_ulimit] .ig
 .It ulimit Xo
 .Op Fl H \*(Ba Fl S
 .Op Fl a \*(Ba Fl tfdscmlpnv Op Ar value
@@ -2228,6 +2231,7 @@ Limits of an arbitrary process can be displayed or se=
t using the
 .Xr sysctl 8
 utility.
 .\".Pp
+..
 .It umask Op Ar mask
 Set the value of umask (see
 .Xr umask 2 )
@@ -2261,6 +2265,7 @@ last process in the job.
 If the argument is omitted, wait for all jobs to
 complete and return an exit status of zero.
 .El
+.if !\n[BUILTIN_fc] .ig
 .Ss Command Line Editing
 When
 .Nm
@@ -2283,6 +2288,7 @@ enters vi command mode.
 Hitting
 .Aq return
 while in command mode will pass the line to the shell.
+..
 .Sh EXIT STATUS
 Errors that are detected by the shell, such as a syntax error, will cause =
the
 shell to exit with a non-zero exit status.
diff --git a/src/mkbuiltins b/src/mkbuiltins
old mode 100644
new mode 100755
index f1f2593..70bb616
--- a/src/mkbuiltins
+++ b/src/mkbuiltins
@@ -41,7 +41,7 @@ if ! type tempfile > /dev/null 2>&1 && ! type mktemp > /d=
ev/null 2>&1; then
 	{
 		local index=3D0
 		while test -f "${TMPDIR:-/tmp}/builtin.$$.$index"; do
-			index=3D`expr $index + 1`
+			index=3D$(( index + 1 ))
 		done
=20
 		touch "${TMPDIR:-/tmp}/builtin.$$.$index"
@@ -118,3 +118,6 @@ struct builtincmd {
 };
=20
 extern const struct builtincmd builtincmd[];'
+
+exec > builtins.roff
+awk '{print ".nr BUILTIN_" $1 " 1"}' $temp2
--=20
2.30.2

--u2nz6mhtea7wug65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJ1eEoACgkQvP0LAY0m
WPHTLA/8C9EoGT/x+ujU6J5et175xfSMz0x6G/bmZ6PWR8JI0jM6h47JPcu1APoT
m6H8UNQNShLBYgT+3x3KeeXfphJcQCB2PzuBJvLtTmjKB+HT0Jo7VHU0+k/VSa1i
VZmWCf1B9KQICpE4AeMiNZ4jCYp52Ft83KpIZ5n8Dtk0F+/lB/fPAVPJ7HVmKMCK
SQ9IlNF1tL5Imn4jXWWtc5v7/eAQ9jGtiZ9UrVnF2Rzg07ydPsqil0F+hZSSSQBN
E1Pa0XNhm/ApxHNDHsbb3FzP2/XTSfdneYZ3J3ETIafnXQfK+TWP2OzZ+qo/tQl7
riQDtxta6rA7XJ2YzPzArf7eR04pRfOhPeo1Z1EJvSDhkPLtcvH32mFb1JaDJCjJ
7+mJAm+eeZ7zGmsa1aFSavkUCbDoGXgHhOt3nq0iAs0vHOfEl3+PuHW/Od9J9BbW
zLxxa+jIUFLx/b1m4Iw8tRMWOSs+SLPw8/jlUD09e7g3sG+eKbCSJmc0Zss5WTaD
fwnBb0IYeTV9Sn7c4EhIZGSMtSKeBl7l4zKvGQpVJr3N6ekfIN7rcwVCW9FX3SM4
VszEKEf4TfDVFu9rBP67Q0lSEqxZOGNedtZTuoN7MkdZyPrlU/57CNHkzxDpm/aB
kLnOnCpBJMz3Omm7KCRkQq6zcyrhXWtO4bD0r0AN2qjQIDcIl6Y=
=I09m
-----END PGP SIGNATURE-----

--u2nz6mhtea7wug65--
