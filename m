From: Stefan Potyra <stefan.potyra@informatik.uni-erlangen.de>
Subject: Re: Debian Bug#429251: [PATCH] honor tab as IFS whitespace when splitting fields
Date: Sun, 5 Jul 2009 00:45:49 +0200
Message-ID: <200907050045.54463.stefan.potyra@informatik.uni-erlangen.de>
References: <200905302233.05407.stefan.potyra@informatik.uni-erlangen.de> <200906100953.37597.stefan.potyra@informatik.uni-erlangen.de> <20090628041902.GA27613@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart46176420.ByFyssIlsM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:51975 "EHLO
	faui3es.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752704AbZGDWqG (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 4 Jul 2009 18:46:06 -0400
In-Reply-To: <20090628041902.GA27613@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, 429251@bugs.debian.org

--nextPart46176420.ByFyssIlsM
Content-Type: multipart/mixed;
  boundary="Boundary-01=_du9TKYHDk5KgjE+"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_du9TKYHDk5KgjE+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Sunday 28 June 2009 06:19:02 schrieb Herbert Xu:
> Awesome! The patch looks pretty good in general.  There are just
> a few minor issues that we need to fix.

Thanks for your thorough review! Revised patch is attached.=20

>
> > +static void
> > +readcmd_handle_line(char *line, char **ap)
> > +{
> > +	struct arglist arglist;
> > +	struct strlist *sl;
> > +	char *s, *backup;
> > +
> > +	/* ifsbreakup will fiddle stack region, need a copy */
> > +	s =3D savestr(line);
>
> savestr calls strdup so it cannot be used safely without disabling
> SIGINT in dash.  sstrdup is the safe alternative.  In fact, if
> you do a grabstackstr first then you only need to dup once.

thanks, should be fixed now (though I admit that I'm still not 100% confide=
nt=20
if I fully understood dash's memory management).

>
> > +	/* need yet another copy, so that delimiters aren't lost
> > +	 * in case there are more fields than variables */
> > +	backup =3D savestr(line);
> > +
> > +	arglist.lastp =3D &arglist.list;
> > +	recordregion(0, strlen(line), 0);
>
> You can avoid doing strlen if you save the stacknxt and use that
> to compute the length.

Done, thanks!

[..]
>
> > +		/* preceeding backslash */
> > +		if (backslash !=3D 0) {
> > +			backslash =3D 0;
> > +			if (c !=3D '\n') {
> > +				STPUTC(c, p);
>
> Need to output CTLESC for ifsbreakup and check for raw CTLESC
> and escape those.  Also need to rmescapes after ifsbreakup for
> each argument.

Thanks, that was a logic error from my side.
I hope I got this right with the patch, but I must admit that this is prett=
y=20
much a shot in the dark with the new patch, as I don't think I've completel=
y=20
understood the logic behind escape character processing in dash yet :/.

Cheers,
    Stefan.

--Boundary-01=_du9TKYHDk5KgjE+
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="dash.git.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dash.git.diff"

diff --git a/src/expand.c b/src/expand.c
index 7995d40..48c45e5 100644
=2D-- a/src/expand.c
+++ b/src/expand.c
@@ -117,9 +117,6 @@ STATIC char *evalvar(char *, int);
 STATIC size_t strtodest(const char *, const char *, int);
 STATIC void memtodest(const char *, size_t, const char *, int);
 STATIC ssize_t varvalue(char *, int, int);
=2DSTATIC void recordregion(int, int, int);
=2DSTATIC void removerecordregions(int);=20
=2DSTATIC void ifsbreakup(char *, struct arglist *);
 STATIC void ifsfree(void);
 STATIC void expandmeta(struct strlist *, int);
 #ifdef HAVE_GLOB
@@ -412,7 +409,7 @@ lose:
 }
=20
=20
=2DSTATIC void=20
+void=20
 removerecordregions(int endoff)
 {
 	if (ifslastp =3D=3D NULL)
@@ -1001,7 +998,7 @@ value:
  * string for IFS characters.
  */
=20
=2DSTATIC void
+void
 recordregion(int start, int end, int nulonly)
 {
 	struct ifsregion *ifsp;
@@ -1028,7 +1025,7 @@ recordregion(int start, int end, int nulonly)
  * strings to the argument list.  The regions of the string to be
  * searched for IFS characters have been stored by recordregion.
  */
=2DSTATIC void
+void
 ifsbreakup(char *string, struct arglist *arglist)
 {
 	struct ifsregion *ifsp;
diff --git a/src/expand.h b/src/expand.h
index 1862aea..405af0b 100644
=2D-- a/src/expand.h
+++ b/src/expand.h
@@ -67,6 +67,9 @@ void expari(int);
 #define rmescapes(p) _rmescapes((p), 0)
 char *_rmescapes(char *, int);
 int casematch(union node *, char *);
+void recordregion(int, int, int);
+void removerecordregions(int);=20
+void ifsbreakup(char *, struct arglist *);
=20
 /* From arith.y */
 intmax_t arith(const char *);
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 3f91bc3..8f2576b 100644
=2D-- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -55,18 +55,93 @@
 #include "miscbltin.h"
 #include "mystring.h"
 #include "main.h"
+#include "expand.h"
+#include "parser.h"
=20
 #undef rflag
=20
+/** handle one line of the read command.
+ *  more fields than variables -> remainder shall be part of last variable.
+ *  less fields than variables -> remaining variables unset.
+ *
+ *  @param line complete line of input
+ *  @param ap argument (variable) list
+ *  @param len length of line including trailing '\0'
+ */
+static void
+readcmd_handle_line(char *line, char **ap, size_t len)
+{
+	struct arglist arglist;
+	struct strlist *sl;
+	char *s, *backup;
+
+	/* ifsbreakup will fiddle with stack region... */
+	s =3D grabstackstr(line + len);
+	/* need a copy, so that delimiters aren't lost
+	 * in case there are more fields than variables */
+	if (len > 0) {
+		backup =3D sstrdup(line);
+	} else {
+		/* len=3D=3D0, so just nullify all arguments...
+		 * otherwise memcpy (from sstrdup) would be called=20
+		 * with equal memory regions.
+		 */
+		backup =3D NULL;
+		goto nullify;
+	}
+
+	arglist.lastp =3D &arglist.list;
+	recordregion(0, len, 0);
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
+			char *remainder;
+
+			/* FIXME little bit hacky, assuming that ifsbreakup=20
+			 * will not modify the length of the string */
+			offset =3D sl->text - s;
+			remainder =3D backup + offset;
+			rmescapes(remainder);
+			setvar(*ap, remainder, 0);
+
+			ungrabstackstr(backup, 0);
+			ungrabstackstr(s, 0);
+			return;
+		}
+	=09
+		/* set variable to field */
+		rmescapes(sl->text);
+		setvar(*ap, sl->text, 0);
+		ap++;
+	}
+
+nullify:
+	/* nullify remaining arguments */
+	for (; *ap !=3D NULL; ap++) {
+		setvar(*ap, nullstr, 0);
+	}
+
+	if (backup !=3D NULL) {
+		ungrabstackstr(backup, 0);
+	}
+	ungrabstackstr(s, 0);
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
@@ -75,14 +150,14 @@ readcmd(int argc, char **argv)
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
@@ -95,60 +170,54 @@ readcmd(int argc, char **argv)
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
=2D			continue;
=2D		}
=2D		if (!rflag && c =3D=3D '\\') {
=2D			backslash++;
 			continue;
 		}
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
+				STPUTC(CTLESC, p);
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
+	readcmd_handle_line(stackblock(), ap, p - (char *)stackblock());
 	return status;
 }
=20
=2D
=2D
 /*
  * umask builtin
  *

--Boundary-01=_du9TKYHDk5KgjE+--

--nextPart46176420.ByFyssIlsM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpP250ACgkQty49N44srvTOAgCfbO0pkAzmrna/wsDz0W+Xk7mW
kzsAoL2kiG0EyDqkIiiLj/+OpoY0ewoI
=DPH5
-----END PGP SIGNATURE-----

--nextPart46176420.ByFyssIlsM--
