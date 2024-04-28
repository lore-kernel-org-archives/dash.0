Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292123BB
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714276607; cv=none; b=JIb4lM879Vw+bcGAU1xAxEK8U9yq+wNSjClVAQh3nvJXd7RyPa7jmxZRucSbZXN9hdpjY5MKU3cB5as7dHI6ZBk73Qb6Wh++QYmWQ96Ns+WsL2MBRYsi7P5Dl0YeJEJtbWRYurEleT0kCe9NYXr1ckHFJy8OFpXL4RQHeZaLygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714276607; c=relaxed/simple;
	bh=PTuY1FwaYoW0+ftpuGe503VHsrk4LYewOCTtoEdnLtQ=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=nWxixvcd53cWe3VgOsWEzD2ReHuNi8G5lhmh5YbVVzzn6Kw4wKSeFVV3RmBjULE0n2VA63bsL4eHj4EuO6ypk0zgROYZUDVn5CM9HcJeRC5PnEKGp+1AEvTf3PdWJ2xpredsLyTED8vyE+av3kicsxW2l0K2VzYtHozY2DDvYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0veZ-007PZ9-38;
	Sun, 28 Apr 2024 11:56:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Apr 2024 11:56:58 +0800
Date: Sun, 28 Apr 2024 11:56:58 +0800
Message-Id: <e798eb1ab0a6f3f22d6e31d845d8c8e3fc25f07d.1714276539.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714276539.git.herbert@gondor.apana.org.au>
References: <cover.1714276539.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 1/8] shell: Call setlocale
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

