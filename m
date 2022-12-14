Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5AC4332F
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 16:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbiLNQwg (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiLNQwL (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Dec 2022 11:52:11 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9537C18B2F
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 08:52:07 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id A6B3365A
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 17:52:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1671036725;
        bh=AsNsxFv8IgJXev6p9OZBxrtM/3MKLXD8sTS0tMqgBzU=;
        h=Date:From:To:Subject:From;
        b=gtV2ILENk2Igdmi1jP4/bmAVtmaot3a+K8CbGZWvtIPlaHPs9VOG5dKg+nL036two
         iF0EOtVKadCK+yQLHVNqvAdqkc+iy6Gdnk3hz7Eh52jgFPhgVo8jbh2ca0Z2mmuhnp
         BjfUbkXYHa6rlnOMgnRb6mwKja8mfD4dEJY4EqXK0Xb0izEO6VyIqESutE1JooqRI5
         L01iNt/Fae5P22042A3kl+QNz4KkUgONt7FqcttkDjakkd+Nc18L98ICeO58hcnfar
         To4vWj3udjgkFDqVAX8ghdZhVt1RZ2Zr+Vit+qDlyeUPBHxT+jkWgUjSsXGP3I49mB
         SVRaYNhPubbog==
Date:   Wed, 14 Dec 2022 17:52:04 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     dash@vger.kernel.org
Subject: [PATCH] man: fix getopts documentation
Message-ID: <20221214165204.diohpccu6cx7nrdx@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pc6iopug7cizicsd"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org


--pc6iopug7cizicsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The explicit arguments were missing, also exchange expr subst for
arithmetic and fix the spacing around Bell Labs
---
 src/dash.1    | 13 +++++++++----
 src/options.c |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index ff02237..46efd01 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1342,13 +1342,12 @@ The number of previous commands that are accessible.
 .El
 .It fg Op Ar job
 Move the specified job or the current job to the foreground.
-.It getopts Ar optstring var
+.It getopts Ar optstring var Op Ar arg ...
 The
 .Tn POSIX
 .Ic getopts
 command, not to be confused with the
-.Em Bell Labs
--derived
+.Em Bell Labs Ns -derived
 .Xr getopt 1 .
 .Pp
 The first argument should be a series of letters, each of which may be
@@ -1386,6 +1385,12 @@ then
 .Ev OPTARG
 will be unset.
 .Pp
+By default, the variables
+.Va $1 , ... , $n
+are inspected; if
+.Ar arg Ns s
+are specified, they'll be parsed instead.
+.Pp
 .Va optstring
 is a string of recognized option letters (see
 .Xr getopt 3 ) .
@@ -1430,7 +1435,7 @@ do
 	\\?)	echo $USAGE; exit 1;;
 	esac
 done
-shift `expr $OPTIND - 1`
+shift $((OPTIND - 1))
 .Ed
 .Pp
 This code will accept any of the following as equivalent:
diff --git a/src/options.c b/src/options.c
index a46c23b..3158498 100644
--- a/src/options.c
+++ b/src/options.c
@@ -410,7 +410,7 @@ getoptscmd(int argc, char **argv)
 	char **optbase;
=20
 	if (argc < 3)
-		sh_error("Usage: getopts optstring var [arg]");
+		sh_error("Usage: getopts optstring var [arg...]");
 	else if (argc =3D=3D 3) {
 		optbase =3D shellparam.p;
 		if ((unsigned)shellparam.optind > shellparam.nparam + 1) {
--=20
2.30.2

--pc6iopug7cizicsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOZ/zQACgkQvP0LAY0m
WPFwrA//fpBE5ZicaITuc9kdN6P9kD4ogvV+39zwQfkr34M4YOG1p//O7itvR+0/
bAw7dhRW0C4R0STXEDjzfeTGLLWld6A+oaV5il3flEBAW8Zb2Ubs4J6mPTS4zFtS
qzhqOIGgWCKcIj7vtNYN51WDg6tpUOHqe1pkc62P411hiA1lFZCwJlxjII4v71FP
MgicGtV+kWNAuf554bzu7ef7/2V+tfMk2AB6bbiVayPBnwEZGOH+OP/yDWRBiPh4
IRnJS7MEGP5uoIoBpsdve/StDHKix7n9LaUX7BX8HUZdTRAn1gqPqcr259pejceX
qXNjQz+gbwoplVnNpjL83AeU+LF2cXEhJ3C4zN0gKnXPkwAGbrF6IaUtpkJKU3AK
AJdC211OWo7Jhw7/aJgrIsjq0GJ/CeN5mMOwfrx9HX8qMmB65sBQnjstTqlJSVT8
NQROzp9bIXQKlVekizw6Ehg8Vs6eMkNUgO0PY7D6gRzG58ghnrbMuX2eIQK6xqPa
ULMCiXX99/4/IdPSu67WPSGhc6rqdCSphWOjgy540UKG1Dm3/I7SHVwFkeA6FiF9
ec95pEEW75Rc4ArtEh4LKd3gn9jJhzUl82DqV/McwWmQSTUw8k9qOc2IclICQA31
Eksjen8lxzGZk+LvyETfNhbtfuINK+b+5J1WWseeRUeBpbOdbT0=
=gEy3
-----END PGP SIGNATURE-----

--pc6iopug7cizicsd--
