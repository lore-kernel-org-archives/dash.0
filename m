From: Stefan Potyra <stefan.potyra@informatik.uni-erlangen.de>
Subject: Re: Debian Bug#429251: [PATCH] honor tab as IFS whitespace when splitting fields
Date: Wed, 10 Jun 2009 09:53:34 +0200
Message-ID: <200906100953.37597.stefan.potyra@informatik.uni-erlangen.de>
References: <200905302233.05407.stefan.potyra@informatik.uni-erlangen.de> <20090610054845.GA17111@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart138318107.OYSeyfeDVa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:47272 "EHLO
	faui3es.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752743AbZFJIC7 (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 10 Jun 2009 04:02:59 -0400
In-Reply-To: <20090610054845.GA17111@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

--nextPart138318107.OYSeyfeDVa
Content-Type: multipart/mixed;
  boundary="Boundary-01=_+Z2LK9OYcfrfgRx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_+Z2LK9OYcfrfgRx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Am Wednesday 10 June 2009 07:48:45 schrieben Sie:
> On Sat, May 30, 2009 at 10:33:00PM +0200, Stefan Potyra wrote:
> > Hi Herbert,
> >
> > thanks for your work wrt dash!
> >
> > forwarding the patch for debian bug 429251 to you, since I just found out
> > that I dropped the CC.
> >
> > Hope, that it's better this time.
>
> Thanks for the patch!
>
> Could you resend it and cc dash@vger.kernel.org?
>

Of course, here you are.

Cheers,
     Stefan.

--Boundary-01=_+Z2LK9OYcfrfgRx
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="dash_ifs_read.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dash_ifs_read.patch"

=2D-- dash-0.5.5.1.orig/src/expand.c
+++ dash-0.5.5.1/src/expand.c
@@ -117,9 +117,9 @@
 STATIC size_t strtodest(const char *, const char *, int);
 STATIC void memtodest(const char *, size_t, const char *, int);
 STATIC ssize_t varvalue(char *, int, int);
=2DSTATIC void recordregion(int, int, int);
=2DSTATIC void removerecordregions(int);=20
=2DSTATIC void ifsbreakup(char *, struct arglist *);
+void recordregion(int, int, int);
+void removerecordregions(int);=20
+void ifsbreakup(char *, struct arglist *);
 STATIC void ifsfree(void);
 STATIC void expandmeta(struct strlist *, int);
 #ifdef HAVE_GLOB
@@ -412,7 +412,7 @@
 }
=20
=20
=2DSTATIC void=20
+void=20
 removerecordregions(int endoff)
 {
 	if (ifslastp =3D=3D NULL)
@@ -999,7 +999,7 @@
  * string for IFS characters.
  */
=20
=2DSTATIC void
+void
 recordregion(int start, int end, int nulonly)
 {
 	struct ifsregion *ifsp;
@@ -1026,7 +1026,7 @@
  * strings to the argument list.  The regions of the string to be
  * searched for IFS characters have been stored by recordregion.
  */
=2DSTATIC void
+void
 ifsbreakup(char *string, struct arglist *arglist)
 {
 	struct ifsregion *ifsp;
only in patch2:
unchanged:
=2D-- dash-0.5.5.1.orig/src/miscbltin.c
+++ dash-0.5.5.1/src/miscbltin.c
@@ -55,18 +55,77 @@
 #include "miscbltin.h"
 #include "mystring.h"
 #include "main.h"
+#include "expand.h"
=20
 #undef rflag
=20
+/** handle one line of the read command.
+ *  more fields than variables -> remainder shall be part of last variable.
+ *  less fields than variables -> remaining variables unset.
+ *
+ *  @param line complete line of input
+ *  @param ap argument (variable) list
+ */
+static void
+readcmd_handle_line(char *line, char **ap)
+{
+	struct arglist arglist;
+	struct strlist *sl;
+	char *s, *backup;
+
+	/* ifsbreakup will fiddle stack region, need a copy */
+	s =3D savestr(line);
+	/* need yet another copy, so that delimiters aren't lost
+	 * in case there are more fields than variables */
+	backup =3D savestr(line);
+
+	arglist.lastp =3D &arglist.list;
+	recordregion(0, strlen(line), 0);
+=09
+	ifsbreakup(s, &arglist);
+	*arglist.lastp =3D NULL;
+	removerecordregions(0);
+
+	for (sl =3D arglist.list; sl !=3D NULL; sl =3D sl->next) {
+
+		/* remaining fields present, but no variables left. */
+		if ((*(ap + 1) =3D=3D NULL) && (sl->next !=3D NULL)) {
+			size_t offset;
+			const char *remainder;
+
+			/* FIXME little bit hacky, assuming that ifsbreakup=20
+			 * will not modify the length of the string */
+			offset =3D sl->text - s;
+			remainder =3D backup + offset;
+			setvar(*ap, remainder, 0);
+
+			free(s);
+			free(backup);
+			return;
+		}
+	=09
+		/* set variable to field */
+		setvar(*ap, sl->text, 0);
+		ap++;
+	}
+
+	/* nullify remaining arguments */
+	for (; *ap !=3D NULL; ap++) {
+		setvar(*ap, nullstr, 0);
+	}
+
+	free(s);
+	free(backup);
+}
=20
=20
 /*
  * The read builtin.  The -e option causes backslashes to escape the
=2D * following character.
+ * following character. The -p option followed by an argument prompts
+ * with the argument.
  *
  * This uses unbuffered input, which may be avoidable in some cases.
  */
=2D
 int
 readcmd(int argc, char **argv)
 {
@@ -75,14 +134,14 @@
 	char c;
 	int rflag;
 	char *prompt;
=2D	const char *ifs;
 	char *p;
=2D	int startword;
=2D	int status;
 	int i;
+	int res;
+	int status;
=20
 	rflag =3D 0;
 	prompt =3D NULL;
+	status =3D 0;
 	while ((i =3D nextopt("p:r")) !=3D '\0') {
 		if (i =3D=3D 'p')
 			prompt =3D optionarg;
@@ -95,60 +154,53 @@
 		flushall();
 #endif
 	}
=2D	if (*(ap =3D argptr) =3D=3D NULL)
+	if (*(ap =3D argptr) =3D=3D NULL) {
 		sh_error("arg count");
=2D	if ((ifs =3D bltinlookup("IFS")) =3D=3D NULL)
=2D		ifs =3D defifs;
=2D	status =3D 0;
=2D	startword =3D 1;
+	}
+
 	backslash =3D 0;
 	STARTSTACKSTR(p);
 	for (;;) {
=2D		if (read(0, &c, 1) !=3D 1) {
+		/* read character by character until eol */
+		res =3D read(0, &c, 1);
+		if (res !=3D 1) {
 			status =3D 1;
 			break;
 		}
=2D		if (c =3D=3D '\0')
=2D			continue;
=2D		if (backslash) {
+
+		if (c =3D=3D '\0') {
 			backslash =3D 0;
=2D			if (c !=3D '\n')
=2D				goto put;
 			continue;
 		}
=2D		if (!rflag && c =3D=3D '\\') {
=2D			backslash++;
=2D			continue;
=2D		}
=2D		if (c =3D=3D '\n')
+=09
+		/* eol reached, end loop */
+		if ((backslash =3D=3D 0) && (c =3D=3D '\n')) {
 			break;
=2D		if (startword && *ifs =3D=3D ' ' && strchr(ifs, c)) {
+		}
+
+		/* preceeding backslash */
+		if (backslash !=3D 0) {
+			backslash =3D 0;
+			if (c !=3D '\n') {
+				STPUTC(c, p);
+			}
 			continue;
 		}
=2D		startword =3D 0;
=2D		if (ap[1] !=3D NULL && strchr(ifs, c) !=3D NULL) {
=2D			STACKSTRNUL(p);
=2D			setvar(*ap, stackblock(), 0);
=2D			ap++;
=2D			startword =3D 1;
=2D			STARTSTACKSTR(p);
=2D		} else {
=2Dput:
=2D			STPUTC(c, p);
+
+		if ((! rflag) && (c =3D=3D '\\')) {
+			backslash++;
+			continue;
 		}
+
+		backslash =3D 0;
+		STPUTC(c, p);
 	}
+
 	STACKSTRNUL(p);
=2D	/* Remove trailing blanks */
=2D	while ((char *)stackblock() <=3D --p && strchr(ifs, *p) !=3D NULL)
=2D		*p =3D '\0';
=2D	setvar(*ap, stackblock(), 0);
=2D	while (*++ap !=3D NULL)
=2D		setvar(*ap, nullstr, 0);
+	readcmd_handle_line(stackblock(), ap);
 	return status;
 }
=20
=2D
=2D
 /*
  * umask builtin
  *

--Boundary-01=_+Z2LK9OYcfrfgRx--

--nextPart138318107.OYSeyfeDVa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkovZn4ACgkQty49N44srvRfWgCgh48Ms+qKGwv604eUbC9niCKE
TGUAoLWQXfZKkFqEQcEHlA+Z986Xnqzg
=8Bne
-----END PGP SIGNATURE-----

--nextPart138318107.OYSeyfeDVa--
