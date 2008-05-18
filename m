From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Inconsistent parameter expansion
Date: Mon, 19 May 2008 01:01:04 +0800
Message-ID: <20080518170104.GA26635@gondor.apana.org.au>
References: <20080515142601.GA73886@healthgrid203d.healthgrid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:49943 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752603AbYERRBI (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 18 May 2008 13:01:08 -0400
Content-Disposition: inline
In-Reply-To: <20080515142601.GA73886@healthgrid203d.healthgrid.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Romain =?iso-8859-1?Q?Tarti=E8re?= <romain.tartiere@healthgrid.org>
Cc: dash@vger.kernel.org, Baptiste Grenier <baptiste.grenier@healthgrid.org>

On Thu, May 15, 2008 at 02:26:02PM +0000, Romain Tarti=E8re wrote:
>
> I can't figure out why '*/FILE' and '*"/FILE"' are not expanded the s=
ame
> way...

This is a bug in dash.  The following patch should fix the problem,
provided that Ubuntu hasn't built dash with glob(3) enabled because
glob(3) has a similar bug and that needs to be fixed in glibc.

Cheers,
--=20
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/ChangeLog b/ChangeLog
index 2f65e03..bf9dd4a 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2008-05-19  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fixed non-leading slash treatment in expmeta.
+
 2008-05-07  Gerrit Pape <pape@smarden.org>
=20
 	* Fixed lexical error in arithmetic expansion of & and |.
diff --git a/src/expand.c b/src/expand.c
index 2c52781..e4c4c8b 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1269,10 +1269,11 @@ expmeta(char *enddir, char *name)
 	struct dirent *dp;
 	int atend;
 	int matchdot;
+	int esc;
=20
 	metaflag =3D 0;
 	start =3D name;
-	for (p =3D name; *p; p++) {
+	for (p =3D name; esc =3D 0, *p; p +=3D esc + 1) {
 		if (*p =3D=3D '*' || *p =3D=3D '?')
 			metaflag =3D 1;
 		else if (*p =3D=3D '[') {
@@ -1291,11 +1292,11 @@ expmeta(char *enddir, char *name)
 			}
 		} else {
 			if (*p =3D=3D '\\')
-				p++;
-			if (*p =3D=3D '/') {
+				esc++;
+			if (p[esc] =3D=3D '/') {
 				if (metaflag)
 					break;
-				start =3D p + 1;
+				start =3D p + esc + 1;
 			}
 		}
 	}
@@ -1337,7 +1338,8 @@ expmeta(char *enddir, char *name)
 		atend =3D 1;
 	} else {
 		atend =3D 0;
-		*endname++ =3D '\0';
+		*endname =3D '\0';
+		endname +=3D esc + 1;
 	}
 	matchdot =3D 0;
 	p =3D start;
@@ -1363,7 +1365,7 @@ expmeta(char *enddir, char *name)
 	}
 	closedir(dirp);
 	if (! atend)
-		endname[-1] =3D '/';
+		endname[-esc - 1] =3D esc ? '\\' : '/';
 }
 #endif	/* HAVE_GLOB */
=20
