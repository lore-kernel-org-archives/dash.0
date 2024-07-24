Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECA1C6A3
	for <dash@vger.kernel.org>; Wed, 24 Jul 2024 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817244; cv=none; b=ih2NNJJOX5OMRSVm8xlNPMnehYXHQHV42uC3fRMNqv3pAQwhhwl4k40sbHu48XpaMBA1n9V4CVgHBVDh9vZETaWbZn45xsjKg+X4+3H+1E1rc0uiNcjP6r9u5UEe23d6J0L/ilE30fLSO3kelIZU0csW8iPuPXl11AL6gFXK6Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817244; c=relaxed/simple;
	bh=dG4C5cdnEKCox6Ai6gk6xrHtbRl1Pt0W0qEdVLYqo/Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bw5mdYKhAgMKuBuU43+a950uYxZxnHMz8PXJb+CIBOrbddh6oYKUzphNjP5PvCMfHx4dl8cssL+buZuFgFlNgjxhqKPi5Xar6CNbejojRi0D7fGTWn9XfIYdGgiURppzYfL8joCKrCNufUW13gwUtmNT+8N49/Fiz81mTOIEU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sWZCe-000dkT-2g;
	Wed, 24 Jul 2024 18:33:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 Jul 2024 18:26:39 +0800
Date: Wed, 24 Jul 2024 18:26:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] jobs: Add comment about reset_input in forkchild
Message-ID: <ZqDW3_Tu63sO2umG@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For background jobs where the stdin is redirected to /dev/null,
a reset_input may be needed in future.  For the time being there
is no reason to do this as all possible states for stdin will work
correctly with /dev/null.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/jobs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/jobs.c b/src/jobs.c
index 247fab5..51e6fa1 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -904,6 +904,9 @@ static void forkchild(struct job *jp, union node *n, int mode)
 		if (jp->nprocs == 0) {
 			close(0);
 			sh_open(_PATH_DEVNULL, O_RDONLY, 0);
+			/* Should call reset_input here, but it's harmless
+			 * for now.
+			 */
 		}
 	}
 	if (!oldlvl && iflag) {
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
