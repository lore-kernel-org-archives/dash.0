Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1FB4437
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096016; cv=none; b=LxCaFHnPaGlNJ86vCnQaV0doPW3m+YB99au48CxBVl0Jall1pkFBHT6PuLnkL2RgN2/AOS39ReEpEDWqUfh7u1Bb5q/G5Jzh694BhLl9dGgxF3J/SPbImkLQyXTdHSdNh2yzefi38aB+2XFxltdCJmtDmAisNMTMz+ospiTfUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096016; c=relaxed/simple;
	bh=PTuY1FwaYoW0+ftpuGe503VHsrk4LYewOCTtoEdnLtQ=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=k3IDFT/O5LEwiaRqHV5X1LunonvyjEoa7x9VrdtDO2xX1SRhdcGzPs9YSveLz+XuwnexgKfcO2clykS388OdiTEBtv4+ZeWnWh8Cl7WSYGQ/M1MFYzRUd+DUsKJa1ca0Qu0Wx74hXuOwL5FauLBgeOEmtEieS0Ezxk3dvfYkoSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Yxs-00HGA0-2d;
	Sun, 19 May 2024 13:20:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:20:10 +0800
Date: Sun, 19 May 2024 13:20:10 +0800
Message-Id: <e309ecd02d9ff940f021c275821fe1d834a1d5ba.1716095868.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1716095868.git.herbert@gondor.apana.org.au>
References: <cover.1716095868.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 01/13] shell: Call setlocale
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

