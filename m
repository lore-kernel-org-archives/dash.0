Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C19454
	for <dash@vger.kernel.org>; Sun, 26 May 2024 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716720193; cv=none; b=Q1aMRyWBS9jbVc7jVNhMgP8rLyOQasmk7vSLQ+SNw8upD0LnHLZZ8+3czoplptMmZicPYIIeG9mk0l8c+U07dSRxHOIjGkV9ZcfleuOi3XI3XU624q/glEaTxaulCT5qdUem9q4ktJ41VJB5AvbpNGjyZuvebaskSzh22mmrorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716720193; c=relaxed/simple;
	bh=OVe5ze81uZz0MHmyKmz4goEatLIV3kiJy/6YiUCahCQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BWhi+YermKFOfJZBZBtVy0Ahf2YRTsAJI1w+EbqBeRN86mhjvB/3V/BOK5mJkd2l7P/F4AL5bZe0h2hnHfi3dVWVOZyBzaUElsXQHoTFleKu0+uoc99Zu00PIMvi4AZrLS/1U5VN+qahEHTDtAiYxtZWwlYs12Vg7KUNEYSzk3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sBBLG-002DyP-1n;
	Sun, 26 May 2024 18:43:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 26 May 2024 18:43:08 +0800
Date: Sun, 26 May 2024 18:43:08 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] eval: Fix pipe fd leakage in evalbackcmd
Message-ID: <ZlMSPD7YW_o_Fj9N@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If makejob or forkshell fails in evalbackcmd, the two pipe file
descriptors will be leaked.  Fix this by adding an EXITRESET
handler that frees them.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/eval.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/eval.c b/src/eval.c
index d169eb8..1839623 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -81,6 +81,7 @@ int savestatus = -1;		/* exit status of last command outside traps */
 /* Prevent PS4 nesting. */
 MKINIT int inps4;
 
+MKINIT int tpip[2] = { -1 };
 
 #if !defined(__alpha__) || (defined(__GNUC__) && __GNUC__ >= 3)
 STATIC
@@ -127,6 +128,11 @@ EXITRESET {
 	evalskip = 0;
 	loopnest = 0;
 	inps4 = 0;
+
+	if (tpip[0] >= 0) {
+		close(tpip[0]);
+		close(tpip[1]);
+	}
 }
 #endif
 
@@ -624,8 +630,9 @@ evalpipe(union node *n, int flags)
 void
 evalbackcmd(union node *n, struct backcmd *result)
 {
-	int pip[2];
 	struct job *jp;
+	int pip[2];
+	int pid;
 
 	result->fd = -1;
 	result->buf = NULL;
@@ -636,8 +643,12 @@ evalbackcmd(union node *n, struct backcmd *result)
 	}
 
 	sh_pipe(pip, 0);
+	tpip[0] = pip[0];
+	tpip[1] = pip[1];
 	jp = makejob(1);
-	if (forkshell(jp, n, FORK_NOJOB) == 0) {
+	pid = forkshell(jp, n, FORK_NOJOB);
+	tpip[0] = -1;
+	if (pid == 0) {
 		FORCEINTON;
 		close(pip[0]);
 		if (pip[1] != 1) {
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
