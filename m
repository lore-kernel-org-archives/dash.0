From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Dash Escape characters problem
Date: Sat, 27 Jun 2009 21:01:43 +0800
Message-ID: <20090627130143.GA23267@gondor.apana.org.au>
References: <4A1CF3A3.1080909@anduras.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:56256 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751919AbZF0NBn (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 27 Jun 2009 09:01:43 -0400
Content-Disposition: inline
In-Reply-To: <4A1CF3A3.1080909@anduras.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Sven Anders <anders@anduras.de>
Cc: dash@vger.kernel.org

On Wed, May 27, 2009 at 10:02:43AM +0200, Sven Anders wrote:
> Hello!
> 
> [ Sorry! I'm not sure, if the last messages reached you, so it resent it here... ]
> 
> 
> I upgraded from dash 0.5.4 to 0.5.5.1 and have to report a regression.
> 
> I want to color some output using escape sequences:
> 
> $./dash-0.5.4/src/dash
> >S="echo -n \\033[0;32mOK\\033[0;39m"; $S
> OK
> 
> ** The "OK" is displayed in green color
> 
> 
> 
> $./dash-0.5.5.1/src/dash
> > S="echo -n \\033[0;32mOK\\033[0;39m"; $S
> 033[0;32mOK033[0;39m
> 
> ** The dash does output the escape sequence itself

Thanks for the report.

I've just fixed it as follows:

commit 0d7d66039b614b642c775432fd64aa8c11f9a64d
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sat Jun 27 21:00:39 2009 +0800

    [EXPAND] Fix quoted pattern patch breakage
    
    The change
    
       [EXPAND] Do not quote back slashes in parameter expansions outside quotes
    
    broke quote removal after parameter expansion.  This is because
    its effecte extended beyond that of quoted patterns.
    
    This patch fixes this by limiting the change to just quoted
    patterns.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 2f52f75..e6a1d26 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2009-06-27  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix quoted pattern patch breakage.
+
 2009-05-23  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix incorrect savefd conversions.
diff --git a/src/expand.c b/src/expand.c
index e4c4c8b..7995d40 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -869,7 +869,9 @@ memtodest(const char *p, size_t len, const char *syntax, int quotes) {
 		int c = (signed char)*p++;
 		if (c) {
 			if ((quotes & QUOTES_ESC) &&
-			    (syntax[c] == CCTL || syntax[c] == CDBACK))
+			    ((syntax[c] == CCTL) ||
+			     (((quotes & EXP_FULL) || syntax != BASESYNTAX) &&
+			      syntax[c] == CBACK)))
 				USTPUTC(CTLESC, q);
 		} else if (!(quotes & QUOTES_KEEPNUL))
 			continue;
diff --git a/src/mksyntax.c b/src/mksyntax.c
index 9ecbb45..7a8a9ae 100644
--- a/src/mksyntax.c
+++ b/src/mksyntax.c
@@ -53,7 +53,6 @@ struct synclass synclass[] = {
 	{ "CWORD",	"character is nothing special" },
 	{ "CNL",	"newline character" },
 	{ "CBACK",	"a backslash character" },
-	{ "CDBACK",	"a backslash character in double quotes" },
 	{ "CSQUOTE",	"single quote" },
 	{ "CDQUOTE",	"double quote" },
 	{ "CENDQUOTE",	"a terminating quote" },
@@ -176,7 +175,7 @@ main(int argc, char **argv)
 	init();
 	fputs("\n/* syntax table used when in double quotes */\n", cfile);
 	add("\n", "CNL");
-	add("\\", "CDBACK");
+	add("\\", "CBACK");
 	add("\"", "CENDQUOTE");
 	add("`", "CBQUOTE");
 	add("$", "CVAR");
@@ -194,7 +193,7 @@ main(int argc, char **argv)
 	init();
 	fputs("\n/* syntax table used when in arithmetic */\n", cfile);
 	add("\n", "CNL");
-	add("\\", "CDBACK");
+	add("\\", "CBACK");
 	add("`", "CBQUOTE");
 	add("$", "CVAR");
 	add("}", "CENDVAR");
diff --git a/src/parser.c b/src/parser.c
index dad1037..28a46c0 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -901,7 +901,6 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 				break;
 			/* backslash */
 			case CBACK:
-			case CDBACK:
 				c = pgetc2();
 				if (c == PEOF) {
 					USTPUTC(CTLESC, out);

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
