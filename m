From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [EXPAND] Do not split the result of tilde expansion
Date: Thu, 10 Mar 2011 17:17:09 +0800
Message-ID: <20110310091709.GB10824@gondor.apana.org.au>
References: <20101205173159.GA90217@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:36722 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab1CJJRM (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 04:17:12 -0500
Content-Disposition: inline
In-Reply-To: <20101205173159.GA90217@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

On Sun, Dec 05, 2010 at 05:31:59PM +0000, Jilles Tjoelker wrote:
> A tilde expansion generates a valid pathname. Splitting it using IFS
> either leaves it unchanged or changes it to something unintended.
>=20
> This fixes FreeBSD sh test expansion/tilde1.0 and does not change the
> outcome of the other tests.
>=20
> This fixes Debian bug #601096.
>=20
> Example:
>   IFS=3Dm HOME=3D/tmp; printf "%s\n" ~

Thanks for the patch! I also removed startloc which is now unused.

commit 834629283f6c629a4da05ef60bae9445c954a19a
Author: Jilles Tjoelker <jilles@stack.nl>
Date:   Thu Mar 10 17:16:13 2011 +0800

    [EXPAND] Do not split the result of tilde expansion
   =20
    A tilde expansion generates a valid pathname. Splitting it using IF=
S
    either leaves it unchanged or changes it to something unintended.
   =20
    This fixes FreeBSD sh test expansion/tilde1.0 and does not change t=
he
    outcome of the other tests.
   =20
    This fixes Debian bug #601096.
   =20
    Example:
      IFS=3Dm HOME=3D/tmp; printf "%s\n" ~
   =20
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index c94dff8..a64e030 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2011-03-10  Jilles Tjoelker <jilles@stack.nl>
=20
 	* Replace GPL noclobberopen code with the FreeBSD version.
+	* Do not split the result of tilde expansion.
=20
 2010-11-28  Maciej =C5=BBenczykowski <zenczykowski@gmail.com>
=20
diff --git a/src/expand.c b/src/expand.c
index 1b77b7c..6bee5c5 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -364,7 +364,6 @@ exptilde(char *startp, char *p, int flag)
 	char *name;
 	const char *home;
 	int quotes =3D flag & QUOTES_ESC;
-	int startloc;
=20
 	name =3D p + 1;
=20
@@ -393,9 +392,7 @@ done:
 	if (!home || !*home)
 		goto lose;
 	*p =3D c;
-	startloc =3D expdest - (char *)stackblock();
 	strtodest(home, SQSYNTAX, quotes);
-	recordregion(startloc, expdest - (char *)stackblock(), 0);
 	return (p);
 lose:
 	*p =3D c;

Cheers,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
