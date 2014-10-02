From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [TRAP] Make sure evalskip is zero before running traps
Date: Thu, 2 Oct 2014 19:54:53 +0800
Message-ID: <20141002115453.GA27786@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:48172 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbaJBLy6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 2 Oct 2014 07:54:58 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

While reviewing the trap code I found the following anomaly:

dash -c 'trap ":; echo trap" USR1; while continue; do continue; done'&
while :; do
	kill -USR1 $!
done

One would expect to see a stream of traps but in fact nothing
is printed.  This is because evalskip is non-zero when entering
dotrap so only the first command in the first trap is executed.
tested seem to be fine.

Interestingly this bug also seems to affect bash.  The real ksh
also doesn't print trap, but it seems to not execute the trap at
all as even if you remove the first colon it still prints nothing.

commit d28c13e7119a605ef152a4310e9415dc7ae9b8f3
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu Oct 2 19:49:48 2014 +0800

    [TRAP] Make sure evalskip is zero before running traps
    
    As it is if dotrap is called with evalskip set to a nonzero value,
    it'll try to execute any set traps.  The result is that the first
    command in the first set trap will be executed while the rest of
    the trap will be silently ignored due to evalskip.  This is highly
    counterintuitive, even though both bash and ksh exhibit a similar
    behaviour.
    
    This patch fixes it by skipping trap processing if evalskip is set
    on entry.  It also adds a dotrap call to the top of evaltree to
    ensure that
    
    	while continue; do
    		continue;
    	done
    
    has a chance of running traps.
    
    Finally the pendingsigs check is moved into dotrap for compactness.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index a56fc5e..81aba60 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2014-10-02  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix use-after-free in dotrap/evalstring.
+	* Make sure evalskip is zero before running traps.
 
 2014-09-29  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/eval.c b/src/eval.c
index 3cfa1e5..7f06931 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -197,6 +197,9 @@ evaltree(union node *n, int flags)
 		TRACE(("evaltree(NULL) called\n"));
 		goto out;
 	}
+
+	dotrap();
+
 #ifndef SMALL
 	displayhist = 1;	/* show history substitutions done with fc */
 #endif
@@ -308,8 +311,7 @@ out:
 	if (checkexit & exitstatus)
 		goto exexit;
 
-	if (pendingsigs)
-		dotrap();
+	dotrap();
 
 	if (flags & EV_EXIT) {
 exexit:
diff --git a/src/trap.c b/src/trap.c
index 17316c9..e34e0f8 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -316,6 +316,9 @@ void dotrap(void)
 	int i;
 	int savestatus;
 
+	if (!pendingsigs)
+		return;
+
 	savestatus = exitstatus;
 	pendingsigs = 0;
 	barrier();
@@ -323,6 +326,12 @@ void dotrap(void)
 	for (i = 0, q = gotsig; i < NSIG - 1; i++, q++) {
 		if (!*q)
 			continue;
+
+		if (evalskip) {
+			pendingsigs = i + 1;
+			break;
+		}
+
 		*q = 0;
 
 		p = trap[i + 1];
@@ -330,8 +339,6 @@ void dotrap(void)
 			continue;
 		evalstring(p, 0);
 		exitstatus = savestatus;
-		if (evalskip)
-			break;
 	}
 }

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
