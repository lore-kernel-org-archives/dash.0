Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58E4C433EF
	for <linux-dash@archiver.kernel.org>; Wed, 19 Jan 2022 05:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349769AbiASFiG (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 19 Jan 2022 00:38:06 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59664 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231512AbiASFiF (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 19 Jan 2022 00:38:05 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nA3fP-0007bD-0h; Wed, 19 Jan 2022 16:37:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 19 Jan 2022 16:37:54 +1100
Date:   Wed, 19 Jan 2022 16:37:54 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     calestyo@scientia.org, dash@vger.kernel.org
Subject: [v2 PATCH] expand: Always quote caret when using fnmatch
Message-ID: <YeejsuVQaGCkQ97t@gondor.apana.org.au>
References: <YeZadfOkUDdN7JqS@gondor.apana.org.au>
 <c31fb498-0f82-dcdc-b1c6-212b8c919c07@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c31fb498-0f82-dcdc-b1c6-212b8c919c07@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Jan 18, 2022 at 08:44:05AM +0000, Harald van Dijk wrote:
>
> The loop that is modified by this patch is only taken after any qchars are
> seen, so for e.g.
> 
>   var=abc
>   echo ${var#[^a]}
> 
> it has no effect. More importantly though, _rmescapes is used to modify

Good catch.  I have modified qchars accordingly.

> strings in place. This patch causes _rmescapes to try and grow strings,
> which cannot ever work. A test case for this is
> 
>   case aa in \a[^a]) echo match ;; esac
> 
> which fails with a segfault after this patch is applied.

Indeed.  I have modified the RMESCAPE_ALLOC to allow growth.

Thanks,

---8<---
This patch forces ^ to be a literal when we use fnmatch.

In order to allow for the extra space to quote the caret, the
function _rmescapes will allocate up to twice the memory if the
flag RMESCAPE_GLOB is set.

Fixes: 7638476c18f2 ("shell: Enable fnmatch/glob by default")
Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Suggested-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index aea5cc4..9906d8a 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -135,8 +135,6 @@ STATIC int pmatch(const char *, const char *);
 #endif
 static size_t cvtnum(intmax_t num, int flags);
 STATIC size_t esclen(const char *, const char *);
-STATIC char *scanleft(char *, char *, char *, char *, int, int);
-STATIC char *scanright(char *, char *, char *, char *, int, int);
 STATIC void varunset(const char *, const char *, const char *, int)
 	__attribute__((__noreturn__));
 
@@ -541,10 +539,8 @@ out:
 }
 
 
-STATIC char *
-scanleft(
-	char *startp, char *rmesc, char *rmescend, char *str, int quotes,
-	int zero
+static char *scanleft(char *startp, char *endp, char *rmesc, char *rmescend,
+		      char *str, int quotes, int zero
 ) {
 	char *loc;
 	char *loc2;
@@ -573,16 +569,14 @@ scanleft(
 }
 
 
-STATIC char *
-scanright(
-	char *startp, char *rmesc, char *rmescend, char *str, int quotes,
-	int zero
+static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
+		       char *str, int quotes, int zero
 ) {
 	int esc = 0;
 	char *loc;
 	char *loc2;
 
-	for (loc = str - 1, loc2 = rmescend; loc >= startp; loc2--) {
+	for (loc = endp, loc2 = rmescend; loc >= startp; loc2--) {
 		int match;
 		char c = *loc2;
 		const char *s = loc2;
@@ -618,7 +612,9 @@ static char *subevalvar(char *start, char *str, int strloc, int startloc,
 	long amount;
 	char *rmesc, *rmescend;
 	int zero;
-	char *(*scan)(char *, char *, char *, char *, int , int);
+	char *(*scan)(char *, char *, char *, char *, char *, int , int);
+	int nstrloc = strloc;
+	char *endp;
 	char *p;
 
 	p = argstr(start, (flag & EXP_DISCARD) | EXP_TILDE |
@@ -646,33 +642,40 @@ static char *subevalvar(char *start, char *str, int strloc, int startloc,
 		abort();
 #endif
 
-	rmesc = startp;
 	rmescend = stackblock() + strloc;
+	str = preglob(rmescend, FNMATCH_IS_ENABLED ?
+				RMESCAPE_ALLOC | RMESCAPE_GROW : 0);
+	if (FNMATCH_IS_ENABLED) {
+		startp = stackblock() + startloc;
+		rmescend = stackblock() + strloc;
+		nstrloc = str - (char *)stackblock();
+	}
+
+	rmesc = startp;
 	if (quotes) {
 		rmesc = _rmescapes(startp, RMESCAPE_ALLOC | RMESCAPE_GROW);
-		if (rmesc != startp) {
+		if (rmesc != startp)
 			rmescend = expdest;
-			startp = stackblock() + startloc;
-		}
+		startp = stackblock() + startloc;
+		str = stackblock() + nstrloc;
 	}
 	rmescend--;
-	str = stackblock() + strloc;
-	preglob(str, 0);
 
 	/* zero = subtype == VSTRIMLEFT || subtype == VSTRIMLEFTMAX */
 	zero = subtype >> 1;
 	/* VSTRIMLEFT/VSTRIMRIGHTMAX -> scanleft */
 	scan = (subtype & 1) ^ zero ? scanleft : scanright;
 
-	loc = scan(startp, rmesc, rmescend, str, quotes, zero);
+	endp = stackblock() + strloc - 1;
+	loc = scan(startp, endp, rmesc, rmescend, str, quotes, zero);
 	if (loc) {
 		if (zero) {
-			memmove(startp, loc, str - loc);
-			loc = startp + (str - loc) - 1;
+			memmove(startp, loc, endp - loc);
+			loc = startp + (endp - loc);
 		}
 		*loc = '\0';
 	} else
-		loc = str - 1;
+		loc = endp;
 
 out:
 	amount = loc - expdest;
@@ -1501,7 +1504,9 @@ msort(struct strlist *list, int len)
 STATIC inline int
 patmatch(char *pattern, const char *string)
 {
-	return pmatch(preglob(pattern, 0), string);
+	return pmatch(preglob(pattern, FNMATCH_IS_ENABLED ?
+				       RMESCAPE_ALLOC | RMESCAPE_GROW : 0),
+		      string);
 }
 
 
@@ -1654,15 +1659,22 @@ _rmescapes(char *str, int flag)
 	int notescaped;
 	int globbing;
 
-	p = strpbrk(str, qchars);
+	p = strpbrk(str, cqchars);
 	if (!p) {
 		return str;
 	}
 	q = p;
 	r = str;
+	globbing = flag & RMESCAPE_GLOB;
+
 	if (flag & RMESCAPE_ALLOC) {
 		size_t len = p - str;
-		size_t fulllen = len + strlen(p) + 1;
+		size_t fulllen = strlen(p);
+
+		if (FNMATCH_IS_ENABLED && globbing)
+			fulllen *= 2;
+
+		fulllen += len + 1;
 
 		if (flag & RMESCAPE_GROW) {
 			int strloc = str - (char *)stackblock();
@@ -1680,7 +1692,6 @@ _rmescapes(char *str, int flag)
 			q = mempcpy(q, str, len);
 		}
 	}
-	globbing = flag & RMESCAPE_GLOB;
 	notescaped = globbing;
 	while (*p) {
 		if (*p == (char)CTLQUOTEMARK) {
@@ -1693,8 +1704,11 @@ _rmescapes(char *str, int flag)
 			notescaped = 0;
 			goto copy;
 		}
+		if (FNMATCH_IS_ENABLED && *p == '^')
+			goto add_escape;
 		if (*p == (char)CTLESC) {
 			p++;
+add_escape:
 			if (notescaped)
 				*q++ = '\\';
 		}
diff --git a/src/mystring.c b/src/mystring.c
index de624b8..ed3c8f6 100644
--- a/src/mystring.c
+++ b/src/mystring.c
@@ -62,7 +62,12 @@ const char spcstr[] = " ";
 const char snlfmt[] = "%s\n";
 const char dolatstr[] = { CTLQUOTEMARK, CTLVAR, VSNORMAL, '@', '=',
 			  CTLQUOTEMARK, '\0' };
-const char qchars[] = { CTLESC, CTLQUOTEMARK, 0 };
+const char cqchars[] = {
+#ifdef HAVE_FNMATCH
+	'^',
+#endif
+	CTLESC, CTLQUOTEMARK, 0
+};
 const char illnum[] = "Illegal number: %s";
 const char homestr[] = "HOME";
 
diff --git a/src/mystring.h b/src/mystring.h
index 083ea98..564b911 100644
--- a/src/mystring.h
+++ b/src/mystring.h
@@ -37,11 +37,18 @@
 #include <inttypes.h>
 #include <string.h>
 
+#ifdef HAVE_FNMATCH
+#define FNMATCH_IS_ENABLED 1
+#else
+#define FNMATCH_IS_ENABLED 0
+#endif
+
 extern const char snlfmt[];
 extern const char spcstr[];
 extern const char dolatstr[];
 #define DOLATSTRLEN 6
-extern const char qchars[];
+extern const char cqchars[];
+#define qchars (cqchars + FNMATCH_IS_ENABLED)
 extern const char illnum[];
 extern const char homestr[];
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
