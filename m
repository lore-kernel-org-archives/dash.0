Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825CB1C8616
	for <dash@vger.kernel.org>; Sun, 24 Aug 2025 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756003346; cv=none; b=miMW/+bqn+wbI6A7O+IMG/QO/DDW3wavw4WcHnogHrjB4pCBy4VzwYK/zb23XeSWqO+fLDo/BhHTujlp9VxOzx6nkF2FxXwEC1xqdVqUbhsBplgZic25b9XQTvr0QxnLcrAfKY4DPPa/PFrGYiTp6v9QAkId9aac5EJtCU09ZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756003346; c=relaxed/simple;
	bh=2vpd5mHA8rD0T8w2sLRWww59jUYa4YEgKGOHXzLrF1c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mwwdzBPtT5ucR+6CDr1O6u7qLb4y1no1eZ3OB9eVdZ2JfQiiAfJNtuFaly2LzqdzVq+DJ56/pmuuGgA5LZM6eKKCApb3YO8xW+8UnoKW4qh1UowypYCsXIpUnSVAayJQuPSWiEiR7lWFckCHdwYPHdE5JzVNdkuJS3y3K7zLwKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=gIn1d3lI; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="gIn1d3lI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LQlglp6SRqUMnoAIXyOCrT2NHFx+EcsO9/ROO6fNFg8=; b=gIn1d3lIqAvUXuSux1ev99aHJi
	uWBya/V8HBs0hxt7v70nQFcg0aq3iiXx0UBjo4zsQMGTdRxhWf7Ij6RzrKB923o/y906pgSiB28hY
	aQmq025QQDhn2+w/gHqwjXoTW28+614J7Emh/sYtl+PJsiz0Dcf28ZmB4Vriu5A7PkyMoZHlJNR69
	j8uZieFfVkbgZIUBWuIG9UjcDybWg+5SH47G3CfYnrpTZJaAMiA/KUW94/nFtIo1DQpVYIwskrrfE
	JZjSGSd4pCp7boM2Nq+Va/VyJc1RhHzr9lNxvtx4I+bMnjtqZJGdUx0zEPYudzady/ZS8JE4EzLUM
	vAOq9g/w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uq0R5-00Gjqp-1f;
	Sun, 24 Aug 2025 10:42:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 24 Aug 2025 10:42:19 +0800
Date: Sun, 24 Aug 2025 10:42:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] jobs: Cache getpid
Message-ID: <aKp8C9gQullVJhRf@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As the vfork path now requires the use of getpid, cache the current
PID in a new global variable mypid.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 83d9694..d2fb30b 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -872,6 +872,7 @@ static void forkchild(struct job *jp, union node *n, int mode)
 	lvforked = vforked;
 
 	if (!lvforked) {
+		mypid = 0;
 		shlvl++;
 
 		forkreset(mode == FORK_NOJOB ? n : NULL);
@@ -887,7 +888,7 @@ static void forkchild(struct job *jp, union node *n, int mode)
 		pid_t pgrp;
 
 		if (jp->nprocs == 0)
-			pgrp = getpid();
+			mypid = pgrp = getpid();
 		else
 			pgrp = jp->ps[0].pid;
 		/* This can fail because we are doing it in the parent also */
@@ -991,7 +992,9 @@ struct job *vforkexec(union node *n, char **argv, const char *path, int idx)
 
 	jp = makejob(1);
 
-	vforked = getpid();
+	if (!mypid)
+		mypid = getpid();
+	vforked = mypid;
 
 	pid = vfork();
 
diff --git a/src/main.c b/src/main.c
index 1e192f8..dde9a36 100644
--- a/src/main.c
+++ b/src/main.c
@@ -64,6 +64,7 @@
 #define PROFILE 0
 
 int rootpid;
+int mypid;
 int shlvl;
 #ifdef __GLIBC__
 int *dash_errno;
@@ -146,7 +147,7 @@ main(int argc, char **argv)
 	opentrace();
 	trputs("Shell args:  ");  trargs(argv);
 #endif
-	rootpid = getpid();
+	mypid = rootpid = getpid();
 	init();
 	setstackmark(&smark);
 	login = procargs(argc, argv);
diff --git a/src/main.h b/src/main.h
index 19e4983..ef242a1 100644
--- a/src/main.h
+++ b/src/main.h
@@ -38,6 +38,8 @@
 
 /* pid of main shell */
 extern int rootpid;
+/* pid of current shell */
+extern int mypid;
 /* shell level: 0 for the main shell, 1 for its children, and so on */
 extern int shlvl;
 #define rootshell (!shlvl)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
