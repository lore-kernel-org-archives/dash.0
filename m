From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Bug in man page
Date: Fri, 26 Sep 2014 22:17:21 +0800
Message-ID: <20140926141720.GD14940@gondor.apana.org.au>
References: <B9BC530A-2542-409D-AA48-2B9E3B7906A1@vandijke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:57898 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbaIZORY (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 26 Sep 2014 10:17:24 -0400
Content-Disposition: inline
In-Reply-To: <B9BC530A-2542-409D-AA48-2B9E3B7906A1@vandijke.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jeroen van Dijke <jeroen@vandijke.net>
Cc: dash@vger.kernel.org

commit 63ab7ea86d12ff87f311e9a59dffdc4f1d47ff33
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri Sep 26 22:16:26 2014 +0800

    [MAN] Change characters for printf precision to bytes
   =20
    On Sun, Mar 09, 2014 at 11:11:43AM +0000, Jeroen van Dijke wrote:
    >
    > There seems to be a bug in the dash man page, at least in 0.5.7. =
It reads:
    >
    >             Precision:
    >                     An optional period, `.', followed by an optio=
nal digit string giving a precision which specifies the number of digit=
s to appear after the decimal point, for e and f formats, or the maximu=
m number of *characters* to be printed from a string (b and s for-
    >                     mats); if the digit string is missing, the pr=
ecision is treated as zero;
    >
    > dash behaves cuts to the number of bytes
    >
    > $ length=3D10; printf "%.${length}s\n" "eeeeeeeeeeeeeeeeeeeeeeeee=
"
    > eeeeeeeeee
    > $ length=3D10; printf "%.${length}s\n" "=C3=AB=C3=AB=C3=AB=C3=AB=C3=
=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=
=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=C3=AB=E2=80=9D
    > =C3=AB=C3=AB=C3=AB=C3=AB=C3=AB
    >
    >
    > The  POSIX specification (2008) says:
    >
    > precision Gives the minimum number of digits to appear for the d,=
 o, i, u, x, or X conversion specifiers (the field is padded with leadi=
ng zeros), the number of digits to appear after the radix character for=
 the e and f conversion specifiers, the maximum number of significant d=
igits for the g conversion specifier; or the maximum number of *bytes* =
to be written from a string in the s conversion specifier. The precisio=
n shall take the form of a ( '.' ) followed by a decimal digit string; =
a null digit string is treated as zero.
    >
    > So it seems to me that =E2=80=9Ccharacters=E2=80=9D should be cha=
nged to =E2=80=9Cbytes=E2=80=9D.
   =20
    Indeed and this patch makes that change.
   =20
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 7b67c0c..6f27fd7 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -2,6 +2,7 @@
=20
 	* Small optimisation of command -pv change.
 	* Set command -p path to /usr/sbin:/usr/bin:/sbin:/bin.
+	* Change "characters" for printf precision to "bytes".
=20
 2014-09-26  Harald van Dijk <harald@gigawatt.nl>
=20
diff --git a/src/dash.1 b/src/dash.1
index 6241a61..6ceb16a 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1670,7 +1670,7 @@ for
 .Cm e
 and
 .Cm f
-formats, or the maximum number of characters to be printed
+formats, or the maximum number of bytes to be printed
 from a string
 .Sm off
 .Pf ( Cm b
@@ -1758,7 +1758,7 @@ is printed.
 .It Cm s
 Characters from the string
 .Ar argument
-are printed until the end is reached or until the number of characters
+are printed until the end is reached or until the number of bytes
 indicated by the precision specification is reached; if the
 precision is omitted, all characters in the string are printed.
 .It Cm \&%

Thanks,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
