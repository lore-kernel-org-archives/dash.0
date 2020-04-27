From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH] parser: Fix handling of empty aliases
Date: Tue, 28 Apr 2020 01:15:26 +1000
Message-ID: <20200427151526.GA26444@gondor.apana.org.au>
References: <m2y33ftyu7.fsf@pomona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:40712 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgD0PPa (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 27 Apr 2020 11:15:30 -0400
Content-Disposition: inline
In-Reply-To: <m2y33ftyu7.fsf@pomona.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Michael Greenberg <Michael.Greenberg@pomona.edu>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On Thu, May 09, 2019 at 03:46:43PM +0000, Michael Greenberg wrote:
> Dash was incorrectly handling empty aliases. When attempting to use an
> empty alias with nothing else, I'm (incorrectly) prompted for more
> input:
> 
> ```
> $ alias empty=''
> $ empty
> >
> ```
> 
> Other shells (e.g., bash, yash) correctly handle the lone, empty alias as an
> empty command:
> 
> ```
> $ alias empty=''
> $ empty
> $
> ```
> 
> This patch fixes the parser to handle the case where an alias is empty,
> i.e., produces no token.
> 
> Signed-off-by: Michael Greenberg <michael.greenberg@pomona.edu>

Thanks for the patch! I think your patch doesn't fix all the cases
though as it's also possible to encounter the problem if the alias
consists entirely of space characters.  Here is my attempt at the
problem.

---8<---
Dash was incorrectly handling empty aliases. When attempting to use an
empty alias with nothing else, I'm (incorrectly) prompted for more
input:

```
$ alias empty=''
$ empty
>
```

Other shells (e.g., bash, yash) correctly handle the lone, empty alias as an
empty command:

```
$ alias empty=''
$ empty
$
```

The problem here is that we incorrectly enter the loop eating TNLs
in readtoken().  This patch fixes it by setting checkkwd correctly.

Reported-by: Michael Greenberg <michael.greenberg@pomona.edu>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index b318b08..5c9e9a0 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -115,7 +115,6 @@ STATIC union node *simplecmd(void);
 STATIC union node *makename(void);
 STATIC void parsefname(void);
 STATIC void parseheredoc(void);
-STATIC int peektoken(void);
 STATIC int readtoken(void);
 STATIC int xxreadtoken(void);
 STATIC int pgetc_eatbnl();
@@ -161,21 +160,23 @@ parsecmd(int interact)
 STATIC union node *
 list(int nlflag)
 {
+	int chknl = nlflag & 1 ? 0 : CHKNL;
 	union node *n1, *n2, *n3;
 	int tok;
 
 	n1 = NULL;
 	for (;;) {
-		switch (readtoken()) {
+		checkkwd = chknl | CHKKWD | CHKALIAS;
+		tok = readtoken();
+		switch (tok) {
 		case TNL:
-			if (!(nlflag & 1))
-				break;
 			parseheredoc();
 			return n1;
 
 		case TEOF:
-			if (!n1 && (nlflag & 1))
+			if (!n1 && !chknl)
 				n1 = NEOF;
+out_eof:
 			parseheredoc();
 			tokpushback++;
 			lasttoken = TEOF;
@@ -183,8 +184,7 @@ list(int nlflag)
 		}
 
 		tokpushback++;
-		checkkwd = CHKNL | CHKKWD | CHKALIAS;
-		if (nlflag == 2 && tokendlist[peektoken()])
+		if (nlflag == 2 && tokendlist[tok])
 			return n1;
 		nlflag |= 2;
 
@@ -214,15 +214,16 @@ list(int nlflag)
 			n1 = n3;
 		}
 		switch (tok) {
-		case TNL:
 		case TEOF:
+			goto out_eof;
+		case TNL:
 			tokpushback++;
 			/* fall through */
 		case TBACKGND:
 		case TSEMI:
 			break;
 		default:
-			if ((nlflag & 1))
+			if (!chknl)
 				synexpect(-1);
 			tokpushback++;
 			return n1;
@@ -685,16 +686,6 @@ parseheredoc(void)
 	}
 }
 
-STATIC int
-peektoken(void)
-{
-	int t;
-
-	t = readtoken();
-	tokpushback++;
-	return (t);
-}
-
 STATIC int
 readtoken(void)
 {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
