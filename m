From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 2/2] [REDIR] Fix popredir on abnormal exit from built-in
Date: Thu, 27 May 2010 17:16:18 +1000
Message-ID: <E1OHXKE-0001oo-64@gondolin.me.apana.org.au>
References: <20100527033437.GA5323@gondor.apana.org.au>
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:47300 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754971Ab0E0HQV (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 27 May 2010 03:16:21 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org, pape@smarden.org

[REDIR] Fix popredir on abnormal exit from built-in

Just like the poplocalvar problem recently fixed, redirections
can also be leaked in case of an abnormal exit.  This patch fixes
it using the same method as poplocalvar, by storing the previous
redirection state and restoring to that point.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 ChangeLog   |    1 +
 src/eval.c  |    4 ++++
 src/redir.c |   45 ++++++++++++++++++++++++++++++++-------------
 src/redir.h |    3 +++
 4 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 1fd184b..650899a 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -3,6 +3,7 @@
 	* Fix poplocalvar on abnormal exit from function.
 	* Do not poplocalvars prematurely on regular utilities.
 	* Move null redirect checks into caller.
+	* Fix popredir on abnormal exit from built-in.
 
 2010-05-26  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/eval.c b/src/eval.c
index 59bded9..d5c1e6c 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -219,6 +219,7 @@ evaltree(union node *n, int flags)
 		goto setstatus;
 	case NREDIR:
 		expredir(n->nredir.redirect);
+		pushredir(n->nredir.redirect);
 		status = redirectsafe(n->nredir.redirect, REDIR_PUSH);
 		if (!status) {
 			evaltree(n->nredir.n, flags & EV_TESTED);
@@ -683,6 +684,7 @@ evalcommand(union node *cmd, int flags)
 #endif
 {
 	struct localvar_list *localvar_stop;
+	struct redirtab *redir_stop;
 	struct stackmark smark;
 	union node *argp;
 	struct arglist arglist;
@@ -740,6 +742,7 @@ evalcommand(union node *cmd, int flags)
 
 	preverrout.fd = 2;
 	expredir(cmd->ncmd.redirect);
+	redir_stop = pushredir(cmd->ncmd.redirect);
 	status = redirectsafe(cmd->ncmd.redirect, REDIR_PUSH|REDIR_SAVEFD2);
 
 	path = vpath.text;
@@ -882,6 +885,7 @@ raise:
 out:
 	if (cmd->ncmd.redirect)
 		popredir(execcmd);
+	unwindredir(redir_stop);
 	unwindlocalvars(localvar_stop);
 	if (lastarg)
 		/* dsl: I think this is intended to be used to support
diff --git a/src/redir.c b/src/redir.c
index 16decfc..b4e49c0 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -111,20 +111,12 @@ redirect(union node *redir, int flags)
 		memory[i] = 0;
 	memory[1] = flags & REDIR_BACKQ;
 #endif
-	if (!redir) {
+	if (!redir)
 		return;
-	}
 	sv = NULL;
 	INTOFF;
-	if (likely(flags & REDIR_PUSH)) {
-		struct redirtab *q;
-		q = ckmalloc(sizeof (struct redirtab));
-		q->next = redirlist;
-		redirlist = q;
-		for (i = 0 ; i < 10 ; i++)
-			q->renamed[i] = EMPTY;
-		sv = q;
-	}
+	if (likely(flags & REDIR_PUSH))
+		sv = redirlist;
 	n = redir;
 	do {
 		newfd = openredirect(n);
@@ -373,8 +365,7 @@ RESET {
 	/*
 	 * Discard all saved file descriptors.
 	 */
-	while (redirlist)
-		popredir(0);
+	unwindredir(0);
 }
 
 #endif
@@ -485,3 +476,31 @@ redirectsafe(union node *redir, int flags)
 	RESTOREINT(saveint);
 	return err;
 }
+
+
+void unwindredir(struct redirtab *stop)
+{
+	while (redirlist != stop)
+		popredir(0);
+}
+
+
+struct redirtab *pushredir(union node *redir)
+{
+	struct redirtab *sv;
+	struct redirtab *q;
+	int i;
+
+	q = redirlist;
+	if (!redir)
+		goto out;
+
+	sv = ckmalloc(sizeof (struct redirtab));
+	sv->next = q;
+	redirlist = sv;
+	for (i = 0; i < 10; i++)
+		sv->renamed[i] = EMPTY;
+
+out:
+	return q;
+}
diff --git a/src/redir.h b/src/redir.h
index d1d160e..8e56995 100644
--- a/src/redir.h
+++ b/src/redir.h
@@ -41,10 +41,13 @@
 #endif
 #define REDIR_SAVEFD2 03	/* set preverrout */
 
+struct redirtab;
 union node;
 void redirect(union node *, int);
 void popredir(int);
 void clearredir(void);
 int savefd(int, int);
 int redirectsafe(union node *, int);
+void unwindredir(struct redirtab *stop);
+struct redirtab *pushredir(union node *redir);
 
