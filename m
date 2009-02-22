From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash, ash for loop oddity
Date: Sun, 22 Feb 2009 19:48:39 +0800
Message-ID: <20090222114839.GA3038@gondor.apana.org.au>
References: <87myi1r2js.fsf@ID-132527.user.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:33096 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753649AbZBVLsp (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 22 Feb 2009 06:48:45 -0500
Content-Disposition: inline
In-Reply-To: <87myi1r2js.fsf@ID-132527.user.dfncis.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Maximilian =?iso-8859-1?Q?Bern=F6cker?= <maximilian.bernoecker@lrz.tum.de>
Cc: dash@vger.kernel.org

On Sun, Sep 21, 2008 at 02:33:59PM +0000, Maximilian Bern=F6cker wrote:
> Hi,
>=20
> according to the grammar
> <http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.h=
tml#tag_02_10_02>
>=20
> | for_clause       : For name linebreak                            do=
_group
> |                  | For name linebreak in          sequential_sep do=
_group
> |                  | For name linebreak in wordlist sequential_sep do=
_group
> | [...]
> | linebreak        : newline_list
> |                  | /* empty */
>=20
> the following script should be legal:

Thanks.  Fixed with this patch.

commit 22e8fb41be2bfd0e6757c80d6365af9080a3b4a1
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Feb 22 19:47:52 2009 +0800

    [PARSER] Allow newlines after var name in for statements
   =20
    POSIX allows newlines before the "in" keyword in for statements
    so we should too.
   =20
    Thanks to Maximilian Bern=F6cker for reporting this.
   =20
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index dcb7182..d7e0f79 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -3,6 +3,7 @@
 	* Fix dowait signal race.
 	* Remove EXSIG.
 	* Do not close stderr when /dev/tty fails to open.
+	* Allow newlines after var name in for statements.
=20
 2009-01-14  Herbert Xu <herbert@gondor.apana.org.au>
=20
diff --git a/src/parser.c b/src/parser.c
index ab66f30..425c457 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -357,7 +357,7 @@ TRACE(("expecting DO got %s %s\n", tokname[got], go=
t =3D=3D TWORD ? wordtext : ""));
 		n1 =3D (union node *)stalloc(sizeof (struct nfor));
 		n1->type =3D NFOR;
 		n1->nfor.var =3D wordtext;
-		checkkwd =3D CHKKWD | CHKALIAS;
+		checkkwd =3D CHKNL | CHKKWD | CHKALIAS;
 		if (readtoken() =3D=3D TIN) {
 			app =3D &ap;
 			while (readtoken() =3D=3D TWORD) {
@@ -383,7 +383,7 @@ TRACE(("expecting DO got %s %s\n", tokname[got], go=
t =3D=3D TWORD ? wordtext : ""));
 			 * Newline or semicolon here is optional (but note
 			 * that the original Bourne shell only allowed NL).
 			 */
-			if (lasttoken !=3D TNL && lasttoken !=3D TSEMI)
+			if (lasttoken !=3D TSEMI)
 				tokpushback++;
 		}
 		checkkwd =3D CHKNL | CHKKWD | CHKALIAS;

Cheers,
--=20
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
