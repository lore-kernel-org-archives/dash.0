From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [BUG?] here documents, command substitution, and the { keyword
Date: Tue, 15 Mar 2011 17:42:36 +0800
Message-ID: <20110315094236.GA10637@gondor.apana.org.au>
References: <20101107022121.GA22719@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:54919 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab1COJmj (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 15 Mar 2011 05:42:39 -0400
Content-Disposition: inline
In-Reply-To: <20101107022121.GA22719@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org

On Sun, Nov 07, 2010 at 02:21:21AM +0000, Jonathan Nieder wrote:
> 
> Just ran into some strange behavior:

This patch should fix the problem.

commit ec2c84d3c4dba4b74440d72bdd1de416a9acd2a9
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue Mar 15 17:41:53 2011 +0800

    [PARSER] Fix clobbering of checkkwd
    
    On Sun, Nov 07, 2010 at 02:21:21AM +0000, Jonathan Nieder wrote:
    >
    > Just ran into some strange behavior:
    >
    > $ cat test.sh
    > #!/bin/sh
    > echo hello >greeting
    > cat <<EOF &&
    > $(cat greeting)
    > EOF
    > {
    > 	echo $?
    > 	cat greeting
    > } >/dev/null
    >
    >
    > $ sh test.sh
    > hello
    > test.sh: 7: {: not found
    > 127
    > hello
    > test.sh: 10: Syntax error: "}" unexpected
    >
    > bash, mksh, pdksh, and ksh93 all print hello as expected.  The problem
    > is reproducible with all versions of dash in the git repo.
    
    This is caused by the clobbering of checkkwd due to readtoken
    recursion while parsing a here document.
    
    This patch fixes it by saving the original value of checkkwd.
    
    Reported-by: Jonathan Nieder <jrnieder@gmail.com>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 5b6d53e..50a8044 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2011-03-15  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix clobbering of checkkwd.
+
 2011-03-15  Jonathan Nieder <jrnieder@gmail.com>
 
 	* Free IFS state after here document expansion.
diff --git a/src/parser.c b/src/parser.c
index 0bfd620..528d005 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -687,6 +687,7 @@ STATIC int
 readtoken(void)
 {
 	int t;
+	int kwd = checkkwd;
 #ifdef DEBUG
 	int alreadyseen = tokpushback;
 #endif
@@ -697,7 +698,7 @@ top:
 	/*
 	 * eat newlines
 	 */
-	if (checkkwd & CHKNL) {
+	if (kwd & CHKNL) {
 		while (t == TNL) {
 			parseheredoc();
 			t = xxreadtoken();
@@ -711,7 +712,7 @@ top:
 	/*
 	 * check for keywords
 	 */
-	if (checkkwd & CHKKWD) {
+	if (kwd & CHKKWD) {
 		const char *const *pp;
 
 		if ((pp = findkwd(wordtext))) {

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
