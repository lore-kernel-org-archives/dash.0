From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: test incorrectly rejecting valid expression with confusing !
 placement
Date: Sun, 28 Sep 2014 18:42:51 +0800
Message-ID: <20140928104251.GA27782@gondor.apana.org.au>
References: <5218BCAD.2010107@gigawatt.nl>
 <20130904015629.GA19007@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:53192 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbaI1KnA (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Sep 2014 06:43:00 -0400
Content-Disposition: inline
In-Reply-To: <20130904015629.GA19007@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

On Wed, Sep 04, 2013 at 11:56:29AM +1000, Herbert Xu wrote:
> Harald van Dijk <harald@gigawatt.nl> wrote:
> > Hi,
> > 
> > Now that Herbert fixed the reported crash in test (in a far simpler
> > manner than I had suggested, which I like), I did some more testing, and
> > came across one case that does not currently work, and did not work in
> > the past, but is perfectly valid:
> > 
> > $ src/dash -c 'test ! ! = !'
> > src/dash: 1: test: =: unexpected operator
> 
> Agreed.

This case is now fixed by the following patch:

commit 4f7e4c8201e580b9d31c09d8a484741072033c01
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Sep 28 18:40:18 2014 +0800

    [BUILTIN] Correctly handle test ! ! = !
    
    This patch adds a special case in testcmd for the 4-argument
    expression beginning with a !.  Without this ! ! = ! is deemed
    a syntax error, which breaks POSIX.
    
    Note that this special case does not extend down into subexpressions
    so if ! ! = ! is used inside parentheses then a syntax error will
    still occur as before.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index a466a7f..7345144 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-09-28  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Correctly handle test ! ! = !.
+
 2014-09-26  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Small optimisation of command -pv change.
diff --git a/src/bltin/test.c b/src/bltin/test.c
index baa91a5..458e9f5 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -177,7 +177,7 @@ testcmd(int argc, char **argv)
 {
 	const struct t_op *op;
 	enum token n;
-	int res;
+	int res = 1;
 
 	if (*argv[0] == '[') {
 		if (*argv[--argc] != ']')
@@ -185,11 +185,12 @@ testcmd(int argc, char **argv)
 		argv[argc] = NULL;
 	}
 
+recheck:
 	argv++;
 	argc--;
 
 	if (argc < 1)
-		return 1;
+		return res;
 
 	/*
 	 * POSIX prescriptions: he who wrote this deserves the Nobel
@@ -209,6 +210,9 @@ testcmd(int argc, char **argv)
 			argv[--argc] = NULL;
 			argv++;
 			argc--;
+		} else if (!strcmp(argv[0], "!")) {
+			res = 0;
+			goto recheck;
 		}
 	}
 
@@ -216,7 +220,7 @@ testcmd(int argc, char **argv)
 
 eval:
 	t_wp = argv;
-	res = !oexpr(n);
+	res ^= oexpr(n);
 	argv = t_wp;
 
 	if (argv[0] != NULL && argv[1] != NULL)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
