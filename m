Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC938F
	for <dash@vger.kernel.org>; Sat, 20 Apr 2024 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713573360; cv=none; b=IerWvRCl0AF/RvA/7NssQeq5Iz8RglstICN6I3jqzgxWMJF0h9aqbCTTyyeOrlVyqoNEJp4hPGHr4VZCfiLdSG29sUlz32tBaZuGQQAJmT6FZgpzWl89hIsaTRRIrmVQkKh1kvQ52r6KioxOGI7O3udp6PErrYUxSZm/Q/TRp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713573360; c=relaxed/simple;
	bh=YKtsSfhfHOsSzITa408RAnS4vm5Ywt8t2M/+qD1Hkvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsL4D1xx4RQB2f6vM1y0rgPZAAbdEmaRvbKRdKDfj9gmll4EaBUL4qF+/7E1061bAVvRkOAiQ8mnrXQ2cNHQ2vEW8DXws7Gi60xzMBkR7ovEs22i/tCbMrzxAI5JFOpLUo3sGSrI/vTX4N4F/picyfUk1h+l1yO9LLDLZEpcbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rxyhm-0047k3-MA; Sat, 20 Apr 2024 08:35:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 20 Apr 2024 08:36:04 +0800
Date: Sat, 20 Apr 2024 08:36:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org
Subject: [v3 PATCH] trap: Preserve parent traps for trap-only command
 substitution
Message-ID: <ZiMN9FzMvg+IhjNJ@gondor.apana.org.au>
References: <ZhuLNH4dCxqs0Ge1@gondor.apana.org.au>
 <Zhz+wALFljSAqnDU@gondor.apana.org.au>
 <20240419214425.GB24704@stack.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419214425.GB24704@stack.nl>

On Fri, Apr 19, 2024 at 11:44:25PM +0200, Jilles Tjoelker wrote:
>
> It looks like this will execute the EXIT trap in a subshell $(trap).

Good catch!

> I think the intent of https://austingroupbugs.net/view.php?id=53 is that
> things like $('trap') and $(\trap) should also work (although an
> expansion that expands to trap need not work).

I don't agree with that.  Unless the wording becomes much more
explicit, I'm not going to support something silly like $('trap').

Thanks,

---8<---
Traps are reset when a subshell is started.  When a subshell is
started for command substitution with a simple command whose first
word is "trap", preserve the parent trap text so that they can be
printed.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/eval.c   |  4 ++--
 src/init.h   |  4 +++-
 src/jobs.c   |  2 +-
 src/mkinit.c |  5 +++--
 src/trap.c   | 57 +++++++++++++++++++++++++++++++++++++++-------------
 5 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index fce5314..d169eb8 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -491,11 +491,11 @@ evalsubshell(union node *n, int flags)
 	expredir(n->nredir.redirect);
 	INTOFF;
 	if (!backgnd && flags & EV_EXIT && !have_traps()) {
-		forkreset();
+		forkreset(NULL);
 		goto nofork;
 	}
 	jp = makejob(1);
-	if (forkshell(jp, n, backgnd) == 0) {
+	if (forkshell(jp, n->nredir.n, backgnd) == 0) {
 		flags |= EV_EXIT;
 		if (backgnd)
 			flags &=~ EV_TESTED;
diff --git a/src/init.h b/src/init.h
index d56fb28..4f98b5d 100644
--- a/src/init.h
+++ b/src/init.h
@@ -34,7 +34,9 @@
  *	@(#)init.h	8.2 (Berkeley) 5/4/95
  */
 
+union node;
+
 void init(void);
 void exitreset(void);
-void forkreset(void);
+void forkreset(union node *);
 void reset(void);
diff --git a/src/jobs.c b/src/jobs.c
index 2a2fe22..dce8e22 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -872,7 +872,7 @@ static void forkchild(struct job *jp, union node *n, int mode)
 	if (!lvforked) {
 		shlvl++;
 
-		forkreset();
+		forkreset(mode == FORK_NOJOB ? n : NULL);
 
 #if JOBS
 		/* do job control only in root shell */
diff --git a/src/mkinit.c b/src/mkinit.c
index 9025862..870b64d 100644
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
+	{"FORKRESET", "forkreset", forkreset, "union node *n"},
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
index cd84814..75501d7 100644
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
+MKINIT void clear_traps(union node *);
 
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
+	clear_traps(n);
 }
 #endif
 
@@ -133,6 +124,8 @@ trapcmd(int argc, char **argv)
 		}
 		return 0;
 	}
+	if (ptrap)
+		clear_traps(NULL);
 	if (!ap[1] || decode_signum(*ap) >= 0)
 		action = NULL;
 	else
@@ -168,6 +161,40 @@ trapcmd(int argc, char **argv)
 
 
 
+/*
+ * Clear traps on a fork.
+ */
+
+void clear_traps(union node *n)
+{
+	int simplecmd;
+	char **tp;
+
+	simplecmd = n && n->type == NCMD && n->ncmd.args &&
+		    equal(n->ncmd.args->narg.text, "trap");
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
@@ -390,6 +417,8 @@ exitshell(void)
 	handler = &loc;
 	if ((p = trap[0])) {
 		trap[0] = NULL;
+		if (ptrap)
+			goto out;
 		evalskip = 0;
 		evalstring(p, 0);
 		evalskip = SKIPFUNCDEF;
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
