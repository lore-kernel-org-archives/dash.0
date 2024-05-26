Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9D9454
	for <dash@vger.kernel.org>; Sun, 26 May 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716720240; cv=none; b=FdYc2ydhjapMKY1F2h+xKAyDRRz2R9eAO+uVI6I/KT80p/SxPwRLWuNGafIrfWCRsjuOiFcOt0HLDD/jH7i4a9LHwxPlJ6zj/xoT1jdAcnzVAB+NTNtY8pBMTP1N9rMBHS28r8bbzEuROFEByvzyiQGNSaXOqr9DQBu/PjYGeOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716720240; c=relaxed/simple;
	bh=9Kp+22iYcpieNDh8WHXDqeYR9boz1AYZPk10nUD4YKI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CWUTIgngPwsGD612kxyOy7SJTUJ1tkjGVIK1qZLAhS2qxwGdDUmJ7kZmzNZA8ciO4vRlmj9cZz9vQTlOMNHuuZxqQC4lORbmY8QqUuWRJce95Y/YIPYgeMrO1JSQMyqRsalhW5U9hXJSfhUJQgeOUf683QgQNnK1dZKCqhafyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sBBM1-002Dyt-2d;
	Sun, 26 May 2024 18:43:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 26 May 2024 18:43:55 +0800
Date: Sun, 26 May 2024 18:43:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] jobs: Fix resource leak in makejob
Message-ID: <ZlMSa5pG5S68WpOl@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If the ps ckmalloc call fails in makejob, the job will still be
marked as used and thus leaked.  Fix this by moving the ckmalloc
call earlier.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/jobs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/jobs.c b/src/jobs.c
index 4cf6b8c..02ec6f4 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -765,8 +765,9 @@ err:
 
 struct job *makejob(int nprocs)
 {
-	int i;
+	struct procstat *ps;
 	struct job *jp;
+	int i;
 
 	for (i = njobs, jp = jobtab ; ; jp++) {
 		if (--i < 0) {
@@ -783,6 +784,9 @@ struct job *makejob(int nprocs)
 		break;
 	}
 	memset(jp, 0, sizeof(*jp));
+	ps = &jp->ps0;
+	if (nprocs > 1)
+		ps = ckmalloc(nprocs * sizeof(*ps));
 #if JOBS
 	if (jobctl)
 		jp->jobctl = 1;
@@ -790,10 +794,7 @@ struct job *makejob(int nprocs)
 	jp->prev_job = curjob;
 	curjob = jp;
 	jp->used = 1;
-	jp->ps = &jp->ps0;
-	if (nprocs > 1) {
-		jp->ps = ckmalloc(nprocs * sizeof (struct procstat));
-	}
+	jp->ps = ps;
 	TRACE(("makejob(%d) returns %%%d\n", nprocs,
 	    jobno(jp)));
 	return jp;
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
