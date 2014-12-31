From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [EXPAND] Fixed "$@" expansion when EXP_FULL is false
Date: Thu, 1 Jan 2015 07:56:05 +1100
Message-ID: <20141231205605.GA32563@gondor.apana.org.au>
References: <20141231180330.GA32534@jue.netz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:55121 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbaLaU4J (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 31 Dec 2014 15:56:09 -0500
Content-Disposition: inline
In-Reply-To: <20141231180330.GA32534@jue.netz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Juergen Daubert <jue@jue.li>
Cc: dash@vger.kernel.org

On Wed, Dec 31, 2014 at 07:03:30PM +0100, Juergen Daubert wrote:
> Hi,
> 
> today I tried to use dash from git as /bin/sh and run in a lot of
> problem I don't see with stable version 0.5.8. 
> After some investigations I narrowed it down to commit 
> 
> 3c06acdac0b1ba0e0acdda513a57ee6e31385dce 
> [EXPAND] Split unquoted $@/$* correctly when IFS is set but empty
> 
> and related following to expand.c
> 
> 
> It seems that the changes to dash triggers, among others, some problem 
> with libtool.
> 
> As examples I've attached build logs for libpixman and kbd, there are a
> lot other builds that failed as well. If you need more, please let me 
> know.

Thanks for the report.  This patch should fix the problem.

-- >8 --
The commit 3c06acdac0b1ba0e0acdda513a57ee6e31385dce ([EXPAND]
Split unquoted $@/$* correctly when IFS is set but empty) broke
the case where $@ is in quotes and EXP_FULL is false.
    
In that case we should still emit IFS as field splitting is not
performed.
    
Reported-by: Juergen Daubert <jue@jue.li>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index dfb3f0e..b2d710d 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -901,6 +901,7 @@ varvalue(char *name, int varflags, int flags, int *quotedp)
 	int quotes = (discard ? 0 : (flags & QUOTES_ESC)) | QUOTES_KEEPNUL;
 	ssize_t len = 0;
 
+	sep = (flags & EXP_FULL) << CHAR_BIT;
 	syntax = quoted ? DQSYNTAX : BASESYNTAX;
 
 	switch (*name) {
@@ -931,16 +932,14 @@ numvar:
 		expdest = p;
 		break;
 	case '@':
-		sep = 0;
-		if (quoted)
+		if (quoted && sep)
 			goto param;
 		/* fall through */
 	case '*':
-		sep = ifsset() ? ifsval()[0] : ' ';
-		if (!quoted) {
+		if (quoted)
+			sep = 0;
+		sep |= ifsset() ? ifsval()[0] : ' ';
 param:
-			sep |= (flags & EXP_FULL) << CHAR_BIT;
-		}
 		sepc = sep;
 		*quotedp = !sepc;
 		if (!(ap = shellparam.p))

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
