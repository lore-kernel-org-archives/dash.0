Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2621CD1F
	for <dash@vger.kernel.org>; Sun, 14 Apr 2024 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713081130; cv=none; b=X8FzqtQCfayrkNny+baHmJlaNI8Ic0dPbaeIMWQbt+XB+0IskTM9Lu3oSSUF53mGVRAerPkSmZQjwJF45z8DESTIbTj6Opnk75Gi/my7dnkuQ62r4be6FVm7rSJboP3JnWAG6s6wZRICScfVnk4SDguOHvKpCqp89GVj55OkT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713081130; c=relaxed/simple;
	bh=h4nCyb63dxVH2zO0t2pw3g37IYVWS0q8eODmdQ3FQMM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T1mUrfwcUjn/0JlGS+80XgHnj7gizHfiCiXuSN1/3F49aVfzbr1b0Pyu4xc1vHSY1zASXl9uOCyjm2yIcdU+QRPf8HlevEiFRGeSpFbeM4yjcmA0r6TXgZo4COtx8RFy9aAR2+kYhNrnf5wa6v4GPhiGnAp6n7PL29q3sKa5sDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvueg-001Qyd-Ha; Sun, 14 Apr 2024 15:52:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 14 Apr 2024 15:52:20 +0800
Date: Sun, 14 Apr 2024 15:52:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dash@vger.kernel.org
Subject: [PATCH] trap: Preserve parent shell traps for simple commands
Message-ID: <ZhuLNH4dCxqs0Ge1@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Traps are reset when subshell is started.  When a subshell is
started for a simple command, preserve the parent trap text so
that they can be printed.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/eval.c   |  4 ++--
 src/init.h   |  2 +-
 src/jobs.c   |  2 +-
 src/mkinit.c |  5 +++--
 src/trap.c   | 51 +++++++++++++++++++++++++++++++++++++--------------
 5 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index fce5314..a0f4df2 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -491,11 +491,11 @@ evalsubshell(union node *n, int flags)
 	expredir(n->nredir.redirect);
 	INTOFF;
 	if (!backgnd && flags & EV_EXIT && !have_traps()) {
-		forkreset();
+		forkreset(0);
 		goto nofork;
 	}
 	jp = makejob(1);
-	if (forkshell(jp, n, backgnd) == 0) {
+	if (forkshell(jp, n->nredir.n, backgnd) == 0) {
 		flags |= EV_EXIT;
 		if (backgnd)
 			flags &=~ EV_TESTED;
diff --git a/src/init.h b/src/init.h
index d56fb28..705ffd7 100644
--- a/src/init.h
+++ b/src/init.h
@@ -36,5 +36,5 @@
 
 void init(void);
 void exitreset(void);
-void forkreset(void);
+void forkreset(int);
 void reset(void);
diff --git a/src/jobs.c b/src/jobs.c
index 2a2fe22..0abdcaa 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -872,7 +872,7 @@ static void forkchild(struct job *jp, union node *n, int mode)
 	if (!lvforked) {
 		shlvl++;
 
-		forkreset();
+		forkreset(n && n->type == NCMD);
 
 #if JOBS
 		/* do job control only in root shell */
diff --git a/src/mkinit.c b/src/mkinit.c
index 9025862..f07e288 100644
--- a/src/mkinit.c
+++ b/src/mkinit.c
@@ -91,6 +91,7 @@ struct event {
 	char *name;		/* name of event (e.g. INIT) */
 	char *routine;		/* name of routine called on event */
 	char *comment;		/* comment describing routine */
+	char *args;		/* arguments to routine */
 	struct text code;	/* code for handling event */
 };
 
@@ -128,7 +129,7 @@ char reset[] = "\
 struct event event[] = {
 	{"INIT", "init", init},
 	{"EXITRESET", "exitreset", exitreset},
-	{"FORKRESET", "forkreset", forkreset},
+	{"FORKRESET", "forkreset", forkreset, "int simplecmd"},
 	{"RESET", "reset", reset},
 	{NULL, NULL}
 };
@@ -388,7 +389,7 @@ output(void)
 	for (ep = event ; ep->name ; ep++) {
 		fputs("\n\n\n", fp);
 		fputs(ep->comment, fp);
-		fprintf(fp, "\nvoid\n%s() {\n", ep->routine);
+		fprintf(fp, "\nvoid\n%s(%s) {\n", ep->routine, ep->args ?: "");
 		writetext(&ep->code, fp);
 		fprintf(fp, "}\n");
 	}
diff --git a/src/trap.c b/src/trap.c
index cd84814..4587144 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -66,7 +66,9 @@
 
 
 /* trap handler commands */
-MKINIT char *trap[NSIG];
+static char *trap[NSIG];
+/* traps have not been fully cleared */
+static int ptrap;
 /* number of non-null traps */
 int trapcnt;
 /* current value of signal */
@@ -81,6 +83,7 @@ volatile sig_atomic_t gotsigchld;
 extern char *signal_names[];
 
 static int decode_signum(const char *);
+MKINIT void clear_traps(int);
 
 #ifdef mkinit
 INCLUDE "memalloc.h"
@@ -92,19 +95,7 @@ INIT {
 }
 
 FORKRESET {
-	char **tp;
-
-	INTOFF;
-	for (tp = trap ; tp < &trap[NSIG] ; tp++) {
-		if (*tp && **tp) {	/* trap not NULL or SIG_IGN */
-			ckfree(*tp);
-			*tp = NULL;
-			if (tp != &trap[0])
-				setsignal(tp - trap);
-		}
-	}
-	trapcnt = 0;
-	INTON;
+	clear_traps(simplecmd);
 }
 #endif
 
@@ -133,6 +124,8 @@ trapcmd(int argc, char **argv)
 		}
 		return 0;
 	}
+	if (ptrap)
+		clear_traps(0);
 	if (!ap[1] || decode_signum(*ap) >= 0)
 		action = NULL;
 	else
@@ -168,6 +161,36 @@ trapcmd(int argc, char **argv)
 
 
 
+/*
+ * Clear traps on a fork.
+ */
+
+void clear_traps(int simplecmd)
+{
+	char **tp;
+
+	INTOFF;
+	for (tp = trap ; tp < &trap[NSIG] ; tp++) {
+		if (*tp && **tp) {	/* trap not NULL or SIG_IGN */
+			char *otp = *tp;
+
+			*tp = NULL;
+			if (tp != &trap[0])
+				setsignal(tp - trap);
+
+			if (simplecmd)
+				*tp = otp;
+			else
+				ckfree(*tp);
+		}
+	}
+	trapcnt = 0;
+	ptrap = simplecmd;
+	INTON;
+}
+
+
+
 /*
  * Set the signal handler for the specified signal.  The routine figures
  * out what it should be set to.
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
