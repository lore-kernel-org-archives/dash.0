Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE9EBE
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291737; cv=none; b=MAnxeX708MPi+InD/8+pRaoit8GkHztX/TBwjms2fHbcpVN1+/bmMiNjyXMeKNTvMWgzdDRozmbTq4PfacwDC+O8TZBOLmnGV0Jyk6t0Y4eqaUDeiZXWazwF5D1xj4LzOpSAzETxILJpncOVVtcY/wUmpsfkWJb76Lf7GXhsgHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291737; c=relaxed/simple;
	bh=PTuY1FwaYoW0+ftpuGe503VHsrk4LYewOCTtoEdnLtQ=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=YMFYy9RHm7Gng3KaUYSRXCqm3FyN+MxTYQyhlLoVrNzoJXrFPzOZuJfLg+UXVSIASZAWDMgDk8Dh1i4FJBCzVmDQIgY/1vuW1i6Rkektdgpe9cB9DgcO3PLxEZnAzY4KEVZ1zI1KLF7vV1Q7VEOmJfgDQJJiLAESkOkGzo6s2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa1b-004iQq-1g;
	Sun, 02 Jun 2024 09:28:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:28:45 +0800
Date: Sun, 02 Jun 2024 09:28:45 +0800
Message-Id: <ca29c44ba7e8194c178bffc872f636f9053dd356.1717291579.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1717291579.git.herbert@gondor.apana.org.au>
References: <cover.1717291579.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 01/13] shell: Call setlocale
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

