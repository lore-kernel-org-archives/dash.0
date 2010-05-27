From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 1/2] [REDIR] Move null redirect checks into caller
Date: Thu, 27 May 2010 17:16:17 +1000
Message-ID: <E1OHXKD-0001oM-0f@gondolin.me.apana.org.au>
References: <20100527033437.GA5323@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:47298 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754752Ab0E0HQV (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 27 May 2010 03:16:21 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org, pape@smarden.org

[REDIR] Move null redirect checks into caller

The null redirect checks were added as an optimisation to avoid
unnecessary memory allocations.  However, we could avoid this
completely by simply making the caller avoid making a redirection
unless it is not null.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog   |    1 +
 src/eval.c  |    6 ++++--
 src/redir.c |   14 +-------------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 4fc35a6..1fd184b 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -2,6 +2,7 @@
 
 	* Fix poplocalvar on abnormal exit from function.
 	* Do not poplocalvars prematurely on regular utilities.
+	* Move null redirect checks into caller.
 
 2010-05-26  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/eval.c b/src/eval.c
index 337667f..59bded9 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -224,7 +224,8 @@ evaltree(union node *n, int flags)
 			evaltree(n->nredir.n, flags & EV_TESTED);
 			status = exitstatus;
 		}
-		popredir(0);
+		if (n->nredir.redirect)
+			popredir(0);
 		goto setstatus;
 	case NCMD:
 #ifdef notyet
@@ -879,7 +880,8 @@ raise:
 	}
 
 out:
-	popredir(execcmd);
+	if (cmd->ncmd.redirect)
+		popredir(execcmd);
 	unwindlocalvars(localvar_stop);
 	if (lastarg)
 		/* dsl: I think this is intended to be used to support
diff --git a/src/redir.c b/src/redir.c
index 54af96b..16decfc 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -72,12 +72,10 @@ MKINIT
 struct redirtab {
 	struct redirtab *next;
 	int renamed[10];
-	int nullredirs;
 };
 
 
 MKINIT struct redirtab *redirlist;
-MKINIT int nullredirs;
 
 STATIC int openredirect(union node *);
 #ifdef notyet
@@ -113,7 +111,6 @@ redirect(union node *redir, int flags)
 		memory[i] = 0;
 	memory[1] = flags & REDIR_BACKQ;
 #endif
-	nullredirs++;
 	if (!redir) {
 		return;
 	}
@@ -124,10 +121,8 @@ redirect(union node *redir, int flags)
 		q = ckmalloc(sizeof (struct redirtab));
 		q->next = redirlist;
 		redirlist = q;
-		q->nullredirs = nullredirs - 1;
 		for (i = 0 ; i < 10 ; i++)
 			q->renamed[i] = EMPTY;
-		nullredirs = 0;
 		sv = q;
 	}
 	n = redir;
@@ -343,8 +338,6 @@ popredir(int drop)
 	struct redirtab *rp;
 	int i;
 
-	if (--nullredirs >= 0)
-		return;
 	INTOFF;
 	rp = redirlist;
 	for (i = 0 ; i < 10 ; i++) {
@@ -364,7 +357,6 @@ popredir(int drop)
 		}
 	}
 	redirlist = rp->next;
-	nullredirs = rp->nullredirs;
 	ckfree(rp);
 	INTON;
 }
@@ -381,12 +373,8 @@ RESET {
 	/*
 	 * Discard all saved file descriptors.
 	 */
-	for (;;) {
-		nullredirs = 0;
-		if (!redirlist)
-			break;
+	while (redirlist)
 		popredir(0);
-	}
 }
 
 #endif
