Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1091748F
	for <dash@vger.kernel.org>; Sun,  5 May 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714900478; cv=none; b=K7GLGGZ4Pgiv1KGQTR1N9DhpIfdRdMfNec2kPcUt8+M3qVRMTrWRMtpClEK5OspfOuWkImKKJKI5XSPCqFl676HoYFkeSRBA9Rv/QMgumtwoTCtTxukw/DI0vPQB3W3XR4rBPsmVV1xjqi9wvxCjrzO0xo360Lj2n6TSx6YX4wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714900478; c=relaxed/simple;
	bh=PTuY1FwaYoW0+ftpuGe503VHsrk4LYewOCTtoEdnLtQ=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=Nn1tm8TuTWsB7yK1Wc11d6Roc/nw0fJRxwUscdlJy54L1xqNZcfm5NuCZcRr6x8SPR6mq2bAY/uDeDItcL7WuEb+AAg7mFZEAySqSpdA25822sNdHNdPW8cpcAutTHnzwlTE8BLfIY4M2Sy4AX3uMFi/gFrHMOovAyE/pyvaM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s3Xwv-00AaVE-2k;
	Sun, 05 May 2024 17:14:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 May 2024 17:14:26 +0800
Date: Sun, 05 May 2024 17:14:26 +0800
Message-Id: <ae6898de815eb3fcf99cee110e7c0aade3406a6a.1714900377.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714900377.git.herbert@gondor.apana.org.au>
References: <cover.1714900377.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 01/13] shell: Call setlocale
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Call setlocale to initialise locale settings for libc.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/main.c b/src/main.c
index 7beb280..1e192f8 100644
--- a/src/main.c
+++ b/src/main.c
@@ -32,6 +32,7 @@
  * SUCH DAMAGE.
  */
 
+#include <locale.h>
 #include <stdio.h>
 #include <signal.h>
 #include <sys/stat.h>
@@ -101,6 +102,9 @@ main(int argc, char **argv)
 #if PROFILE
 	monitor(4, etext, profile_buf, sizeof profile_buf, 50);
 #endif
+
+	setlocale(LC_ALL, "");
+
 	state = 0;
 	if (unlikely(setjmp(main_handler.loc))) {
 		int e;
-- 
2.39.2

