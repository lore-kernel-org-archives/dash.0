From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [BUILTIN] Return without arguments in a trap should use status
 outside traps
Date: Mon, 6 Oct 2014 21:53:35 +0800
Message-ID: <20141006135335.GA23072@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:37870 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbaJFNxi (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Oct 2014 09:53:38 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

commit 70c16dd30d4cf824aa895e9f6c095fec741c65a8
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Oct 6 21:51:26 2014 +0800

    [BUILTIN] Return without arguments in a trap should use status outside traps
    
    POSIX now requires that return without arguments in a trap should
    return the last command status prior to executing traps.  This
    patch implements this behaviour.
    
    Incidentally this also changes the behaviour of return without
    arguments in a loop conditional to use the last exit status in
    the body as opposed to the last command in the conditional when
    there is one.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 297b81a..aa230ab 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -4,6 +4,7 @@
 	* Do not allow break to break across function calls.
 	* Move common skipcount logic into skiploop.
 	* Allow return in loop conditional to set exit status.
+	* Return without arguments in a trap should use status outside traps.
 
 2014-10-03  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/eval.c b/src/eval.c
index 7b341f3..071fb1b 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -967,7 +967,7 @@ funcdone:
 	shellparam = saveparam;
 	handler = savehandler;
 	INTON;
-	evalskip &= ~SKIPFUNC;
+	evalskip &= ~(SKIPFUNC | SKIPFUNCDEF);
 	return e;
 }
 
@@ -1047,12 +1047,23 @@ breakcmd(int argc, char **argv)
 int
 returncmd(int argc, char **argv)
 {
+	int skip;
+	int status;
+
 	/*
 	 * If called outside a function, do what ksh does;
 	 * skip the rest of the file.
 	 */
-	evalskip = SKIPFUNC;
-	return argv[1] ? number(argv[1]) : exitstatus;
+	if (argv[1]) {
+		skip = SKIPFUNC;
+		status = number(argv[1]);
+	} else {
+		skip = SKIPFUNCDEF;
+		status = exitstatus;
+	}
+	evalskip = skip;
+
+	return status;
 }
 
 
diff --git a/src/eval.h b/src/eval.h
index 6e62137..6e8acda 100644
--- a/src/eval.h
+++ b/src/eval.h
@@ -62,3 +62,4 @@ extern int evalskip;
 #define SKIPBREAK	(1 << 0)
 #define SKIPCONT	(1 << 1)
 #define SKIPFUNC	(1 << 2)
+#define SKIPFUNCDEF	(1 << 3)
diff --git a/src/main.c b/src/main.c
index 29a258d..00c5e00 100644
--- a/src/main.c
+++ b/src/main.c
@@ -242,7 +242,7 @@ cmdloop(int top)
 
 		skip = evalskip;
 		if (skip) {
-			evalskip &= ~SKIPFUNC;
+			evalskip &= ~(SKIPFUNC | SKIPFUNCDEF);
 			break;
 		}
 	}
diff --git a/src/trap.c b/src/trap.c
index 15faeff..b924661 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -343,7 +343,8 @@ void dotrap(void)
 		if (!p)
 			continue;
 		evalstring(p, 0);
-		exitstatus = status;
+		if (evalskip != SKIPFUNC)
+			exitstatus = status;
 	}
 
 	savestatus = last_status;

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
