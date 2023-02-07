Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526FFC636D4
	for <linux-dash@archiver.kernel.org>; Tue,  7 Feb 2023 16:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjBGQet (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjBGQes (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 7 Feb 2023 11:34:48 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51B3538EAB
        for <dash@vger.kernel.org>; Tue,  7 Feb 2023 08:34:46 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 32D99F6
        for <dash@vger.kernel.org>; Tue,  7 Feb 2023 17:34:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1675787680;
        bh=G3HZ4em4JD8HpxBGYVxirYmr9G+jLB3AyuD2bxwcbYU=;
        h=Date:From:To:Subject:From;
        b=PNslh0Yx4nI2NrDFt7nTgE3h9iyUQdhPDRwZhgxGpGjRBkDz6qAgUD1fvUXHRC0xt
         0kN4i3o/nLDMOCO0/8Fd/sVyA6fV9em/6iTlabC43N+WWTkWh5SGgOsv4p4bdFm0Ja
         G2Ofo+R6wCu6njKxZcy7CEUP8bmdU9RCoIV6Fz99Uy0w3E2V2N+UZZ4etZO7jeTXhW
         wQIsJ77n+alxtjasWWxAOXnyxnTwRML+NkAd7HkGWHiOpRqJduGLRfvn1JnQMU8H+s
         fHFRw4o0jMWdsRZoryJ5BUNC8sGQDcZ5AmGCKOyyXTix2HuA1lVrS2nFXzgso22mwg
         T7QR/JYnJgL1Q==
Date:   Tue, 7 Feb 2023 17:34:39 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] Prototype all function definitions for C23 compat
Message-ID: <20230207163439.d3fqmpyh6ak3wyhw@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5jjo4sfyqmbukd2t"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--5jjo4sfyqmbukd2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Current compilers just produce warnings about unprototyped definitions,
noting that they've been deprecated for decades now, but in C23 mode
they're rejected, because they got removed, cf. draft and paper:
  https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf
  https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2841.htm

In short, int whatever(a, b, c) is illegal, and int whatever() is now
finally equivalent to int whatever(void); or, to put it another way,
when building in C23 mode (which is not /yet/ the default), you get
-- >8 --
$ make -j25
make  all-recursive
make[1]: Entering directory '/home/nabijaczleweli/code/dash'
Making all in src
make[2]: Entering directory '/home/nabijaczleweli/code/dash/src'
  CC       builtins.def
  CC       mknodes
  GEN      token.h
  GEN      token_vars.h
  CC       mksyntax
  GEN      builtins.h
  GEN      syntax.h
  GEN      nodes.h
make  all-am
make[3]: Entering directory '/home/nabijaczleweli/code/dash/src'
  CC       alias.o
  CC       arith_yacc.o
  CC       arith_yylex.o
  CC       cd.o
  CC       error.o
  CC       eval.o
  CC       exec.o
  CC       expand.o
  CC       histedit.o
  CC       input.o
  CC       jobs.o
  CC       mail.o
  CC       main.o
  CC       memalloc.o
  CC       miscbltin.o
  CC       mystring.o
  CC       options.o
  CC       parser.o
  CC       redir.o
  CC       show.o
  CC       trap.o
  CC       output.o
  CC       system.o
  CC       bltin/printf.o
  CC       bltin/test.o
  CC       bltin/times.o
  CC       var.o
  CC       builtins.o
histedit.c:376:16: warning: passing 'const char *' to parameter of type 'ch=
ar *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
                                evalstring(s, 0);
                                           ^
=2E/eval.h:54:22: note: passing argument to parameter here
int evalstring(char *, int);
                     ^
  CC       mkinit
exec.c:779:18: error: unknown type name 'out'
describe_command(out, command, path, verbose)
                 ^
exec.c:779:23: error: unknown type name 'command'
describe_command(out, command, path, verbose)
                      ^
exec.c:779:32: error: unknown type name 'path'
describe_command(out, command, path, verbose)
                               ^
exec.c:779:38: error: unknown type name 'verbose'
describe_command(out, command, path, verbose)
                                     ^
exec.c:779:46: error: expected ';' after top level declarator
describe_command(out, command, path, verbose)
                                             ^
                                             ;
exec.c:784:1: error: expected identifier or '('
{
^
exec.c:885:12: error: unknown type name 'argc'
commandcmd(argc, argv)
           ^
exec.c:885:18:options.c error: :unknown type name 'argv'393
:commandcmd(argc, argv)14:
                 ^
error: unknown type name 'value'
getoptsreset(value)
             ^
exec.c:885:23: error: expected ';' after top level declarator
commandcmd(argc, argv)
                      ^
                      ;
options.c:393:20: exec.c:888:1: error: error: expected identifier or '('
{expected ';' after top level declarator

^
getoptsreset(value)
                   ^
                   ;
options.c:395:1: error: expected identifier or '('
{
^
10 errors generated.
  CC       nodes.o
make[3]: *** [Makefile:478: exec.o] Error 1
make[3]: *** Waiting for unfinished jobs....
3 errors generated.
jobs.c:247:9: error: unknown type name 'argc'
killcmd(argc, argv)
        ^
jobs.c:247:15: error: unknown type name 'argv'
killcmd(argc, argv)
              ^
jobs.c:247:20: error: expected ';' after top level declarator
killcmd(argc, argv)
                   ^
                   ;
jobs.c:250:1: error: expected identifier or '('
{
^
make[3]: *** [Makefile:478: options.o] Error 1
redir.c:288:13: error: unknown type name 'redir'
dupredirect(redir, f)
            ^
redir.c:288:20: error: unknown type name 'f'
dupredirect(redir, f)
                   ^
redir.c:288:22: error: expected ';' after top level declarator
dupredirect(redir, f)
                     ^
                     ;
redir.c:295:2: error: expected identifier or '('
        {
        ^
4 errors generated.
make[3]: *** [Makefile:478: redir.o] Error 1
4 errors generated.
make[3]: *** [Makefile:478: jobs.o] Error 1
nodes.c:122:10: error: unknown type name 'n'
calcsize(n)
         ^
nodes.c:122:12: error: expected ';' after top level declarator
calcsize(n)
           ^
           ;
nodes.c:124:1: error: expected identifier or '('
{
^
nodes.c:206:14: error: unknown type name 'lp'
sizenodelist(lp)
             ^
nodes.c:206:17: error: expected ';' after top level declarator
sizenodelist(lp)
                ^
                ;
nodes.c:208:1: error: expected identifier or '('
{
^
nodes.c:219:10: error: unknown type name 'n'
copynode(n)
         ^
nodes.c:219:12: error: expected ';' after top level declarator
copynode(n)
           ^
           ;
nodes.c:221:1: error: expected identifier or '('
{
^
nodes.c:317:14: error: unknown type name 'lp'
copynodelist(lp)
             ^
nodes.c:317:17: error: expected ';' after top level declarator
copynodelist(lp)
                ^
                ;
nodes.c:319:1: error: expected identifier or '('
{
^
nodes.c:339:13: error: unknown type name 's'
nodesavestr(s)
            ^
nodes.c:339:15: error: expected ';' after top level declarator
nodesavestr(s)
              ^
              ;
nodes.c:341:1: error: expected identifier or '('
{
^
15 errors generated.
make[3]: *** [Makefile:478: nodes.o] Error 1
1 warning generated.
make[3]: Leaving directory '/home/nabijaczleweli/code/dash/src'
-- >8 --

With this patch, you're just left with the histedit.c warning.
---
 src/exec.c       | 10 ++--------
 src/jobs.c       |  4 +---
 src/mksignames.c |  3 +--
 src/nodes.c.pat  | 15 +++++----------
 src/options.c    |  3 +--
 src/redir.c      | 11 +++--------
 6 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/src/exec.c b/src/exec.c
index 83cba94..2ce0605 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -776,11 +776,7 @@ typecmd(int argc, char **argv)
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
@@ -882,9 +878,7 @@ out:
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
index a832eab..8ccdf38 100644
--- a/src/mksignames.c
+++ b/src/mksignames.c
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
index 2d4bd3b..2cf40b4 100644
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
index 631ddc9..a3c6baa 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -283,16 +283,11 @@ ecreate:
=20
 STATIC void
 #ifdef notyet
-dupredirect(redir, f, memory)
+dupredirect(union node *redir, int f, char memory[10])
 #else
-dupredirect(redir, f)
+dupredirect(union node *redir, int f)
 #endif
-	union node *redir;
-	int f;
-#ifdef notyet
-	char memory[10];
-#endif
-	{
+{
 	int fd =3D redir->nfile.fd;
 	int err =3D 0;
=20
--=20
2.30.2

--5jjo4sfyqmbukd2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmPifZ4ACgkQvP0LAY0m
WPEVag/+NsnPKMx2vdqgZM+lp2cuxMYqPf8w8nmN8c5ZrySQJjTg1o3Dq++PQWdi
8XfcD8J0VBt08snOdibaZhNOaJgVIro8S312zKcx9Vyg7SG8tbsXwG5/DBCy+u6H
XxQb+/9CTeGPROcIEpdCoEgIt2m8/zf2qsSKSHnen+mW01zV6/z5iHlxSpre2mDd
c5npjjtFmuzRNSL91aUBRUWG0XwOSLJTr/Ar86UyxumRimTUfIDqeD+mylensmZY
sYAxS8Nu/hW6x8fBpxZuBNQa9oLVxMzD4F7l29aWlli1K7tDOmteFUD4jHYMDm4t
8bPs8Jc/SF9254uXSrGo3wjVQcHgukbxY8JTwI4DgOJfPGuXmZBLompoflbkA1Wd
CPmZcntR7HpikBFb9AjD6ko94xRBSxt5MUvQUuTzE0y+byYOmo0AW10Ir6+ytxKd
beXcW3gjV7TS8amHmdGB+xn6/suSVAOWv1XL2StP2yotQJrTu8Hzk9kwN8rxYp0f
1GtJEt5BnDRdwFPebEqI2SrWnVZpQpFqpSwurs6YlyTRbIgEi096M0pDGI/T28ok
beSSV6+AyHnMduWrcOETT+SCtopTMF2Iksgxbx3+qm7QGtlRGILuFBcvSNaDA8fJ
ddGIQxObnj46bvFWXd1cZ7ea3Z8dNj/pEcQzC5fPZyoScGvD1Go=
=VKEO
-----END PGP SIGNATURE-----

--5jjo4sfyqmbukd2t--
