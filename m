From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Line continuation and variables
Date: Mon, 29 Sep 2014 22:57:27 +0800
Message-ID: <20140929145727.GA3723@gondor.apana.org.au>
References: <1554581409055304@web13g.yandex.ru>
 <53FC7EE2.7000309@redhat.com>
 <20140929145507.GA3670@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:51493 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbaI2O5d (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 29 Sep 2014 10:57:33 -0400
Content-Disposition: inline
In-Reply-To: <20140929145507.GA3670@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Oleg Bulatov <oleg@bulatov.me>, dash@vger.kernel.org

On Mon, Sep 29, 2014 at 10:55:07PM +0800, Herbert Xu wrote:
>
> I agree.  The following patch should fix this:
> 
> commit ef91d3d6a4c39421fd3a391e02cd82f9f3aee4a8
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Mon Sep 29 22:52:41 2014 +0800
> 
>     [PARSER] Handle backslash newlines properly after dollar sign

Here is a small clean-up on top of it:

commit 6df87cf1d4b7c0c490ab1803b863de10579df92e
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Sep 29 22:53:53 2014 +0800

    [PARSER] Add nlprompt/nlnoprompt helpers
    
    This patch adds the nlprompt/nlnoprompt helpers to isolate code
    dealing with newlines and prompting.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 398bd15..f161a13 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -2,6 +2,7 @@
 
 	* Kill pgetc_macro.
 	* Handle backslash newlines properly after dollar sign.
+	* Add nlprompt/nlnoprompt helpers.
 
 2014-09-28  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/parser.c b/src/parser.c
index 2b07437..f6c43be 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -743,6 +743,19 @@ out:
 	return (t);
 }
 
+static void nlprompt(void)
+{
+	plinno++;
+	if (doprompt)
+		setprompt(2);
+}
+
+static void nlnoprompt(void)
+{
+	plinno++;
+	needprompt = doprompt;
+}
+
 
 /*
  * Read the next input token.
@@ -786,16 +799,13 @@ xxreadtoken(void)
 			continue;
 		case '\\':
 			if (pgetc() == '\n') {
-				plinno++;
-				if (doprompt)
-					setprompt(2);
+				nlprompt();
 				continue;
 			}
 			pungetc();
 			goto breakloop;
 		case '\n':
-			plinno++;
-			needprompt = doprompt;
+			nlnoprompt();
 			RETURN(TNL);
 		case PEOF:
 			RETURN(TEOF);
@@ -837,9 +847,7 @@ static int pgetc_eatbnl(void)
 			break;
 		}
 
-		plinno++;
-		if (doprompt)
-			setprompt(2);
+		nlprompt();
 	}
 
 	return c;
@@ -913,9 +921,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 				if (syntax == BASESYNTAX)
 					goto endword;	/* exit outer loop */
 				USTPUTC(c, out);
-				plinno++;
-				if (doprompt)
-					setprompt(2);
+				nlprompt();
 				c = pgetc();
 				goto loop;		/* continue outer loop */
 			case CWORD:
@@ -934,9 +940,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 					USTPUTC('\\', out);
 					pungetc();
 				} else if (c == '\n') {
-					plinno++;
-					if (doprompt)
-						setprompt(2);
+					nlprompt();
 				} else {
 					if (
 						dblquote &&
@@ -1092,8 +1096,7 @@ checkend: {
 
 		if (c == '\n' || c == PEOF) {
 			c = PEOF;
-			plinno++;
-			needprompt = doprompt;
+			nlnoprompt();
 		} else {
 			int len;
 
@@ -1342,9 +1345,7 @@ parsebackq: {
 
 			case '\\':
                                 if ((pc = pgetc()) == '\n') {
-					plinno++;
-					if (doprompt)
-						setprompt(2);
+					nlprompt();
 					/*
 					 * If eating a newline, avoid putting
 					 * the newline into the new character
@@ -1366,8 +1367,7 @@ parsebackq: {
 				synerror("EOF in backquote substitution");
 
 			case '\n':
-				plinno++;
-				needprompt = doprompt;
+				nlnoprompt();
 				break;
 
 			default:

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
