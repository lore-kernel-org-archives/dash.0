From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [EVAL] Force fork if any trap is set, not just on EXIT.
Date: Thu, 27 May 2010 18:09:56 +1000
Message-ID: <20100527080956.GA7500@gondor.apana.org.au>
References: <20100514214429.GA66145@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:53212 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751636Ab0E0IJ7 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 27 May 2010 04:09:59 -0400
Content-Disposition: inline
In-Reply-To: <20100514214429.GA66145@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
> In some cases the shell executes a subshell or an external command in
> the current process. This is not done if a trap on EXIT has been set, so
> that that trap can execute after the subshell or external command has
> finished. Extend that check to all traps. (A trap is "set" if a
> non-empty command string has been attached to it.)
> 
> Improve encapsulation by exporting an accessor function for this and
> making the trap array static again.
> 
> This is much like FreeBSD SVN r194127, enhanced to apply to subshells
> also (see FreeBSD SVN r194774).
> 
> Example:
>  dash -c '{ trap "echo moo" TERM; sleep 3; }& sleep 1; kill $!;wait'
> This should print "moo" after 3 seconds.
> 
> Example:
>  dash -c '{ trap "echo moo" TERM; (sleep 3) }& sleep 1; kill $!;wait'
> The same.
> 
> Example:
>  dash -c '{ trap "echo moo" TERM; sleep 3; :; }& sleep 1; kill $!;wait'
> This works correctly even without this patch.
> 
> Signed-off-by: Jilles Tjoelker <jilles@stack.nl>

I've applied it with some changes.  In particuar, I've made the
have_traps code done using a count kept up-to-date by trapcmd
and clear_traps.  Let me know if you see any problems with this.

diff --git a/ChangeLog b/ChangeLog
index 650899a..969d6be 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-05-27  Jilles Tjoelker <jilles@stack.nl>
+
+	* Force fork if any trap is set, not just on EXIT.
+
 2010-05-27  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix poplocalvar on abnormal exit from function.
diff --git a/src/eval.c b/src/eval.c
index d5c1e6c..439f881 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -449,7 +449,7 @@ evalsubshell(union node *n, int flags)
 	int status;
 
 	expredir(n->nredir.redirect);
-	if (!backgnd && flags & EV_EXIT && !trap[0])
+	if (!backgnd && flags & EV_EXIT && !have_traps())
 		goto nofork;
 	INTOFF;
 	jp = makejob(n, 1);
@@ -836,7 +836,7 @@ bail:
 	switch (cmdentry.cmdtype) {
 	default:
 		/* Fork off a child process if necessary. */
-		if (!(flags & EV_EXIT) || trap[0]) {
+		if (!(flags & EV_EXIT) || have_traps()) {
 			INTOFF;
 			jp = makejob(cmd, 1);
 			if (forkshell(jp, cmd, FORK_FG) != 0) {
diff --git a/src/trap.c b/src/trap.c
index 3f93c46..ba32da6 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -69,7 +69,9 @@
 
 
 /* trap handler commands */
-char *trap[NSIG];
+static char *trap[NSIG];
+/* number of non-null traps */
+int trapcnt;
 /* current value of signal */
 char sigmode[NSIG - 1];
 /* indicates specified signal received */
@@ -125,11 +127,17 @@ trapcmd(int argc, char **argv)
 		if (action) {
 			if (action[0] == '-' && action[1] == '\0')
 				action = NULL;
-			else
+			else {
+				if (*action)
+					trapcnt++;
 				action = savestr(action);
+			}
 		}
-		if (trap[signo])
+		if (trap[signo]) {
+			if (*trap[signo])
+				trapcnt--;
 			ckfree(trap[signo]);
+		}
 		trap[signo] = action;
 		if (signo != 0)
 			setsignal(signo);
@@ -150,16 +158,17 @@ clear_traps(void)
 {
 	char **tp;
 
+	INTOFF;
 	for (tp = trap ; tp < &trap[NSIG] ; tp++) {
 		if (*tp && **tp) {	/* trap not NULL or SIG_IGN */
-			INTOFF;
 			ckfree(*tp);
 			*tp = NULL;
 			if (tp != &trap[0])
 				setsignal(tp - trap);
-			INTON;
 		}
 	}
+	trapcnt = 0;
+	INTON;
 }
 
 
diff --git a/src/trap.h b/src/trap.h
index f19a66b..50fc3ed 100644
--- a/src/trap.h
+++ b/src/trap.h
@@ -36,7 +36,7 @@
 
 #include <signal.h>
 
-extern char *trap[];
+extern int trapcnt;
 extern char sigmode[];
 extern volatile sig_atomic_t pendingsigs;
 
@@ -49,3 +49,8 @@ int dotrap(void);
 void setinteractive(int);
 void exitshell(void) __attribute__((__noreturn__));
 int decode_signal(const char *, int);
+
+static inline int have_traps(void)
+{
+	return trapcnt;
+}

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
