Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30209C433F5
	for <linux-dash@archiver.kernel.org>; Fri,  6 May 2022 14:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442452AbiEFOxK (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 6 May 2022 10:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442451AbiEFOxJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 6 May 2022 10:53:09 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2E536AA61
        for <dash@vger.kernel.org>; Fri,  6 May 2022 07:49:22 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id CF3831728
        for <dash@vger.kernel.org>; Fri,  6 May 2022 16:49:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202006; t=1651848560;
        bh=OayhS9Zo7XyG7RV2qUp4GGpmz858Fco6d/1ly2z3+Ow=;
        h=Date:From:To:Subject:From;
        b=tABwCRARH1IXvWRX6fD+uOylFjJWkug6YQX630GPA/jhAiPgA19Y/mtDph81N7Ja3
         LbRum0QBCEfxBSl7UfXDPgu27Yyv6YOWnWW+us0IlodXPCBYy09d+lBOd3AzeFGAwT
         oxbUPTPMFTVkONgUmUj+0c7wEdvp2wrK+VcksNWt/mNLxq/V5KZWJ6CU89KeLIGI7w
         sh2t2obs+27zJXgeB1efAZPsZIZvImxtac5tyWSpdN5XvSyEwro59XCSNCpCPQc85e
         E2+6mlOmehHkz/xZDGSu9o/QPxjFOr2VvVRb7buit6hF6PvHsunP5RT8lpZQnzLLK2
         PCw1KmbYOL96g==
Date:   Fri, 6 May 2022 16:49:19 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] shell: correctly prototype all functions
Message-ID: <20220506144919.6rpwoq5edahq7s3z@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="afmnnhbgi6i6dl4o"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--afmnnhbgi6i6dl4o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This fixes all warnings with -Wall -Wextra on Clang trunk

Also fix a missing const

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
Please keep me in CC, as I'm not subscribed

 src/eval.c       |  5 +++--
 src/eval.h       |  2 +-
 src/exec.c       | 10 ++--------
 src/jobs.c       |  4 +---
 src/mksignames.c |  5 ++---
 src/nodes.c.pat  | 15 +++++----------
 src/options.c    |  3 +--
 src/redir.c      | 13 ++++---------
 8 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index 3337f71..ea4804d 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -167,13 +167,14 @@ static int evalcmd(int argc, char **argv, int flags)
  */
=20
 int
-evalstring(char *s, int flags)
+evalstring(const char *sc, int flags)
 {
 	union node *n;
+	char *s;
 	struct stackmark smark;
 	int status;
=20
-	s =3D sstrdup(s);
+	s =3D sstrdup(sc);
 	setinputstring(s);
 	setstackmark(&smark);
=20
diff --git a/src/eval.h b/src/eval.h
index 63e7d86..fb35a41 100644
--- a/src/eval.h
+++ b/src/eval.h
@@ -51,7 +51,7 @@ struct backcmd {		/* result of evalbackcmd */
 #define EV_EXIT 01		/* exit after evaluating tree */
 #define EV_TESTED 02		/* exit status is checked; ignore -e flag */
=20
-int evalstring(char *, int);
+int evalstring(const char *, int);
 union node;	/* BLETCH for ansi C */
 int evaltree(union node *, int);
 void evalbackcmd(union node *, struct backcmd *);
diff --git a/src/exec.c b/src/exec.c
index 87354d4..535a8a1 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -770,11 +770,7 @@ typecmd(int argc, char **argv)
 }
=20
 STATIC int
-describe_command(out, command, path, verbose)
-	struct output *out;
-	char *command;
-	const char *path;
-	int verbose;
+describe_command(struct output *out, char *command, const char *path, int =
verbose)
 {
 	struct cmdentry entry;
 	struct tblentry *cmdp;
@@ -876,9 +872,7 @@ out:
 }
=20
 int
-commandcmd(argc, argv)
-	int argc;
-	char **argv;
+commandcmd(int argc, char **argv)
 {
 	char *cmd;
 	int c;
diff --git a/src/jobs.c b/src/jobs.c
index f3b9ffc..6176d0c 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -244,9 +244,7 @@ close:
=20
=20
 int
-killcmd(argc, argv)
-	int argc;
-	char **argv;
+killcmd(int argc, char **argv)
 {
 	extern char *signal_names[];
 	int signo =3D -1;
diff --git a/src/mksignames.c b/src/mksignames.c
index a832eab..8fe2171 100644
--- a/src/mksignames.c
+++ b/src/mksignames.c
@@ -55,7 +55,7 @@ char *progname;
 #endif
=20
 void
-initialize_signames ()
+initialize_signames (void)
 {
   register int i;
 #if defined (SIGRTMAX) || defined (SIGRTMIN)
@@ -361,8 +361,7 @@ initialize_signames ()
 }
=20
 void
-write_signames (stream)
-     FILE *stream;
+write_signames (FILE *stream)
 {
   register int i;
=20
diff --git a/src/nodes.c.pat b/src/nodes.c.pat
index 9125bc7..463f7f5 100644
--- a/src/nodes.c.pat
+++ b/src/nodes.c.pat
@@ -88,8 +88,7 @@ copyfunc(union node *n)
=20
=20
 STATIC void
-calcsize(n)
-	union node *n;
+calcsize(union node *n)
 {
 	%CALCSIZE
 }
@@ -97,8 +96,7 @@ calcsize(n)
=20
=20
 STATIC void
-sizenodelist(lp)
-	struct nodelist *lp;
+sizenodelist(struct nodelist *lp)
 {
 	while (lp) {
 		funcblocksize +=3D SHELL_ALIGN(sizeof(struct nodelist));
@@ -110,8 +108,7 @@ sizenodelist(lp)
=20
=20
 STATIC union node *
-copynode(n)
-	union node *n;
+copynode(union node *n)
 {
 	union node *new;
=20
@@ -121,8 +118,7 @@ copynode(n)
=20
=20
 STATIC struct nodelist *
-copynodelist(lp)
-	struct nodelist *lp;
+copynodelist(struct nodelist *lp)
 {
 	struct nodelist *start;
 	struct nodelist **lpp;
@@ -143,8 +139,7 @@ copynodelist(lp)
=20
=20
 STATIC char *
-nodesavestr(s)
-	char   *s;
+nodesavestr(char *s)
 {
 	char   *rtn =3D funcstring;
=20
diff --git a/src/options.c b/src/options.c
index a46c23b..db64111 100644
--- a/src/options.c
+++ b/src/options.c
@@ -390,8 +390,7 @@ setcmd(int argc, char **argv)
=20
=20
 void
-getoptsreset(value)
-	const char *value;
+getoptsreset(const char *value)
 {
 	shellparam.optind =3D number(value) ?: 1;
 	shellparam.optoff =3D -1;
diff --git a/src/redir.c b/src/redir.c
index 93abba3..1bbb214 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -282,17 +282,12 @@ ecreate:
=20
=20
 STATIC void
+dupredirect(union node *redir, int f
 #ifdef notyet
-dupredirect(redir, f, memory)
-#else
-dupredirect(redir, f)
+    , char memory[10]
 #endif
-	union node *redir;
-	int f;
-#ifdef notyet
-	char memory[10];
-#endif
-	{
+)
+{
 	int fd =3D redir->nfile.fd;
 	int err =3D 0;
=20
--=20
2.30.2

--afmnnhbgi6i6dl4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmJ1NW8ACgkQvP0LAY0m
WPGNeQ//eZQLuGhBbBXffb1wtyMYYhmJqmPTtMU1SPZM58Y1Px4EoYdN53dVbfAb
eNcTfN8mruqDLFvXaW9twe+omgdY2PN/IfQ5dylu6xtLuxOOLxpKnUpamVCQe4tU
BA861ouiawlXUvrcjqTcQnn41eN9IS3O8CZUSo+N0l7ccl9V2r3YNqDLnQ28Mp5Z
6FFYljuiKJxyNOfnu4rShOcfQ0X1OQ8zNGoBAil3aiwJIVON5A++yn/oKOGVlhge
S7xrOMTXqvMpCUUnAbfrOmwMmOTZ5SKBOR+qJkIrt2fLoIO2jYWNLqGNh0NmN8HQ
1halrBbhXVHGuyqloB/ZaddGfILb/Vv/l9DCPv28gAPQhqaTv91phyf/7lzyrLA7
hbyxRv29wxVRKV/5DPZcwZz6Q8bRnIVcs3MU9RdbcU6uwz3nT0P2B1qbu6KwV+pT
t0gGeOOxwpu4iUIRCliOvQVo18dNxH0Pwq+j0pNYxnUMiW6wySnjcnT/AQqbZ91/
qLr7dJI8a8uL9Cgq5RrV5udYPEZroaAL5ZqLvTcKhCOwh1sIHCrZMmrxjJhLoLW+
hvuoc8OhFz7dZr6EQAcTjSQqm3Ke9H3YHy4kX/2PQNog99O3Lba9u2DaOHfqxGs9
d1069FQkgsJanCiWUY3cw2hUgAKZF4KyGKAZp31IBncKB6JSdpg=
=KRWZ
-----END PGP SIGNATURE-----

--afmnnhbgi6i6dl4o--
