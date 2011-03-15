From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH dash] [EXPAND] Free IFS state after here document
	expansion
Date: Tue, 15 Mar 2011 16:02:14 +0800
Message-ID: <20110315080214.GC8898@gondor.apana.org.au>
References: <20110313144103.30026.48296.reportbug@volta.aurel32.net> <20110313184858.GA6687@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:53764 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429Ab1COICS (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 15 Mar 2011 04:02:18 -0400
Content-Disposition: inline
In-Reply-To: <20110313184858.GA6687@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, Aurelien Jarno <aurel32@debian.org>

On Sun, Mar 13, 2011 at 01:48:58PM -0500, Jonathan Nieder wrote:
> Here's another bug bisecting to f42e443bb ([EXPAND] Fix
> ifsfirst/ifslastp leak, 2010-09-08).  It was found with the following
> test case, based on the configure script for Tracker:
>=20
> 	dash -x -c '
> 		<<-_ACEOF
> 		$@
> 		_ACEOF
> 		exec
> 	' - abcdefgh
> 	+
> 	+ exec   =EF=BF=BDa
> 	exec: 1: : Permission denied
>=20
> The missing ifsfree call is in expandarg when it returns to openhere
> during here document expansion.
>=20
> Reported-by: Aurelien Jarno <aurel32@debian.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Applied with minor rearrangement.  Thanks!
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
commit a58d301405d96fb8ff87cffa3cabe3b110214a31
Author: Jonathan Nieder <jrnieder@gmail.com>
Date:   Tue Mar 15 16:01:34 2011 +0800

    [EXPAND] Free IFS state after here document expansion
   =20
    Here's another bug bisecting to f42e443bb ([EXPAND] Fix
    ifsfirst/ifslastp leak, 2010-09-08).  It was found with the followi=
ng
    test case, based on the configure script for Tracker:
   =20
    	dash -x -c '
    		<<-_ACEOF
    		$@
    		_ACEOF
    		exec
    	' - abcdefgh
    	+
    	+ exec   =EF=BF=BDa
    	exec: 1: : Permission denied
   =20
    The missing ifsfree call is in expandarg when it returns to openher=
e
    during here document expansion.
   =20
    Reported-by: Aurelien Jarno <aurel32@debian.org>
    Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 44e5bdf..5163479 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2011-03-15  Jonathan Nieder <jrnieder@gmail.com>
+
+	* Free IFS state after here document expansion.
+
 2011-03-15  Harald van Dijk <harald@gigawatt.nl>
=20
 	* Let funcnode refer to a function definition, not its first command.
diff --git a/src/expand.c b/src/expand.c
index f155ea0..ce60fe9 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -194,7 +194,8 @@ expandarg(union node *arg, struct arglist *arglist,=
 int flag)
 	p =3D _STPUTC('\0', expdest);
 	expdest =3D p - 1;
 	if (arglist =3D=3D NULL) {
-		return;			/* here document expanded */
+		/* here document expanded */
+		goto out;
 	}
 	p =3D grabstackstr(p);
 	exparg.lastp =3D &exparg.list;
@@ -212,12 +213,14 @@ expandarg(union node *arg, struct arglist *arglis=
t, int flag)
 		*exparg.lastp =3D sp;
 		exparg.lastp =3D &sp->next;
 	}
-	ifsfree();
 	*exparg.lastp =3D NULL;
 	if (exparg.list) {
 		*arglist->lastp =3D exparg.list;
 		arglist->lastp =3D exparg.lastp;
 	}
+
+out:
+	ifsfree();
 }
=20
=20
