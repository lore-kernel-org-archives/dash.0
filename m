From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [EVAL] Fix use-after-free in dotrap/evalstring
Date: Thu, 2 Oct 2014 08:27:57 +0800
Message-ID: <20141002002757.GA23733@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:60727 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbaJBA2C (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 1 Oct 2014 20:28:02 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

While going through trap code it occured to me that we have a
use-after-free bug.

commit 6c3f73bc536082fec38bd36e6c8a121033c68835
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu Oct 2 08:26:06 2014 +0800

    [EVAL] Fix use-after-free in dotrap/evalstring
    
    The function dotrap calls evalstring using the stored trap string.
    If evalstring then unsets that exact trap string then we will end
    up using freed memory.
    
    This patch fixes it by making evalstring always duplicate the string
    before using it.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index f161a13..a56fc5e 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-10-02  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix use-after-free in dotrap/evalstring.
+
 2014-09-29  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Kill pgetc_macro.
diff --git a/src/eval.c b/src/eval.c
index c7358a6..3cfa1e5 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -160,6 +160,7 @@ evalstring(char *s, int flags)
 	struct stackmark smark;
 	int status;
 
+	s = sstrdup(s);
 	setinputstring(s);
 	setstackmark(&smark);
 
@@ -171,7 +172,9 @@ evalstring(char *s, int flags)
 		if (evalskip)
 			break;
 	}
+	popstackmark(&smark);
 	popfile();
+	stunalloc(s);
 
 	return status;
 }
diff --git a/src/histedit.c b/src/histedit.c
index b27d629..94465d7 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -372,8 +372,7 @@ histcmd(int argc, char **argv)
 					out2str(s);
 				}
 
-				evalstring(strcpy(stalloc(strlen(s) + 1), s),
-					   0);
+				evalstring(s, 0);
 				if (displayhist && hist) {
 					/*
 					 *  XXX what about recursive and

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
