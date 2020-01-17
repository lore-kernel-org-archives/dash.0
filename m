From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] redir: Clear saved redirections in subshell
Date: Fri, 17 Jan 2020 17:57:55 +0800
Message-ID: <20200117095755.y6mwflmqqw7zeegh@gondor.apana.org.au>
References: <c1a9c062-0917-d3f3-8826-811b5a4fd802@gigawatt.nl>
 <20200117085124.ub53qala7c636owf@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:51698 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgAQJ56 (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 17 Jan 2020 04:57:58 -0500
Content-Disposition: inline
In-Reply-To: <20200117085124.ub53qala7c636owf@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: DASH shell mailing list <dash@vger.kernel.org>

On Fri, Jan 17, 2020 at 04:51:24PM +0800, Herbert Xu wrote:
> On Mon, Jan 06, 2020 at 09:57:20PM +0000, Harald van Dijk wrote:
> >
> > One way to fix this is to install an exception handler in evaltree(nr) to
> > prevent exceptions bubbling up too far. It can just call exitshell() from
> > there. It is not clear to me yet whether this is the best way.
> 
> Thanks for the report.  I think what we should do is drop the
> relevant state when we enter the subshell.

Something like this should fix the redir problem.  I'll address the
other issue in a subsequent patch.

---8<---
When we enter a subshell we need to drop the saved redirections
as otherwise a subsequent unwindredir could produce incorrect
results.

This patch does this by simply clearing redirlist.  While we
could actually free the memory underneath for subshells it isn't
really worth the trouble for now.

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 26a6248..69a511c 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -859,6 +859,7 @@ static void forkchild(struct job *jp, union node *n, int mode)
 
 		closescript();
 		clear_traps();
+		clearredir();
 
 #if JOBS
 		/* do job control only in root shell */
diff --git a/src/redir.c b/src/redir.c
index 6c81dd0..8242b9c 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -66,15 +66,7 @@
 # define PIPESIZE PIPE_BUF
 #endif
 
-
-MKINIT
-struct redirtab {
-	struct redirtab *next;
-	int renamed[10];
-};
-
-
-MKINIT struct redirtab *redirlist;
+struct redirtab *redirlist;
 
 /* Bit map of currently closed file descriptors. */
 static unsigned closed_redirs;
diff --git a/src/redir.h b/src/redir.h
index 8e56995..82c8ea8 100644
--- a/src/redir.h
+++ b/src/redir.h
@@ -41,13 +41,22 @@
 #endif
 #define REDIR_SAVEFD2 03	/* set preverrout */
 
-struct redirtab;
+struct redirtab {
+	struct redirtab *next;
+	int renamed[10];
+};
+
+extern struct redirtab *redirlist;
+
 union node;
 void redirect(union node *, int);
 void popredir(int);
-void clearredir(void);
 int savefd(int, int);
 int redirectsafe(union node *, int);
 void unwindredir(struct redirtab *stop);
 struct redirtab *pushredir(union node *redir);
 
+static inline void clearredir(void)
+{
+	redirlist = NULL;
+}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
