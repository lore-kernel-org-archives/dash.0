From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6/9] [BUILTIN] Remove getintmax in printf
Date: Mon, 27 Oct 2014 16:26:58 +0800
Message-ID: <E1Xifdi-0001i9-EH@gondolin.me.apana.org.au>
References: <20141027082546.GA6447@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:42897 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbaJ0I1B (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Oct 2014 04:27:01 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
	id 1Xifdj-0006JF-2E
	for <dash@vger.kernel.org>; Mon, 27 Oct 2014 19:26:59 +1100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This patch removes getintmax and moves its functionality into
getuintmax in order to reduce code duplication.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog          |    1 +
 src/bltin/printf.c |   45 +++++++++++----------------------------------
 2 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 026b47c..5b9b03a 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -6,6 +6,7 @@
 	* Add likely tag in outmem.
 	* Add ifdefs around MEM_OUT handling in outmem.
 	* Remove unnecessary restoration of format string in printf.
+	* Remove getintmax in printf.
 
 2014-10-13  Eric Blake <eblake@redhat.com>
 
diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index d1181e3..ebc74ae 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -44,8 +44,7 @@ static int	 conv_escape_str(char *, char **);
 static char	*conv_escape(char *, int *);
 static int	 getchr(void);
 static double	 getdouble(void);
-static intmax_t	 getintmax(void);
-static uintmax_t getuintmax(void);
+static uintmax_t getuintmax(int);
 static char	*getstr(void);
 static char	*mklong(const char *, const char *);
 static void      check_conversion(const char *, const char *);
@@ -179,14 +178,14 @@ pc:
 			/* skip to field width */
 			fmt += strspn(fmt, SKIP1);
 			if (*fmt == '*')
-				*param++ = getintmax();
+				*param++ = getuintmax(1);
 
 			/* skip to possible '.', get following precision */
 			fmt += strspn(fmt, SKIP2);
 			if (*fmt == '.')
 				++fmt;
 			if (*fmt == '*')
-				*param++ = getintmax();
+				*param++ = getuintmax(1);
 
 			fmt += strspn(fmt, SKIP2);
 
@@ -220,18 +219,18 @@ pc:
 			}
 			case 'd':
 			case 'i': {
-				intmax_t p = getintmax();
-				char *f = mklong(start, fmt);
-				PF(f, p);
+				uintmax_t p = getuintmax(1);
+				start = mklong(start, fmt);
+				PF(start, p);
 				break;
 			}
 			case 'o':
 			case 'u':
 			case 'x':
 			case 'X': {
-				uintmax_t p = getuintmax();
-				char *f = mklong(start, fmt);
-				PF(f, p);
+				uintmax_t p = getuintmax(0);
+				start = mklong(start, fmt);
+				PF(start, p);
 				break;
 			}
 			case 'a':
@@ -404,30 +403,8 @@ getstr(void)
 	return val;
 }
 
-static intmax_t
-getintmax(void)
-{
-	intmax_t val = 0;
-	char *cp, *ep;
-
-	cp = *gargv;
-	if (cp == NULL)
-		goto out;
-	gargv++;
-
-	val = (unsigned char) cp[1];
-	if (*cp == '\"' || *cp == '\'')
-		goto out;
-
-	errno = 0;
-	val = strtoimax(cp, &ep, 0);
-	check_conversion(cp, ep);
-out:
-	return val;
-}
