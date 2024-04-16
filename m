Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D7481D0
	for <dash@vger.kernel.org>; Sat, 27 Apr 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216023; cv=none; b=JwA2GqH9HeNupnYs2vtMFdpaBN3oslyfgjZdnFZlY9d4Np0cHktzfHE6+HFHATr41Mbx8uTNjNjeNHEt5wTRSZ2u6EZLEku1LpeH5NDDZuQq/QEUb0gUw7GeqDALzrcNaKsaCQxc39Ry+VcKd8ubZEuoBzYMuQHgTIeM3H62WLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216023; c=relaxed/simple;
	bh=PTuY1FwaYoW0+ftpuGe503VHsrk4LYewOCTtoEdnLtQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To; b=G8x1dpZZFMyPMkaxwew0O9RZBsM0BGfxatnN/pyEuo6DwpMF4NvZKEIhYTs73jzG89276AJNN5SEAezcvIr4/1pYOEd53W5XOGPU7t2g5aZFbjYVRSAsEehdaImMfnNToWwGyCYbjogpn4dgLPoYo/d1P65EeChSKX+nU65gUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0ftS-0079lj-0k;
	Sat, 27 Apr 2024 19:06:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 27 Apr 2024 19:07:16 +0800
Message-Id: <696077d4f4bafbe3702ed01aa28bd97e17bbcf84.1714215826.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714215826.git.herbert@gondor.apana.org.au>
References: <cover.1714215826.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 16 Apr 2024 18:03:34 +0800
Subject: [PATCH 1/8] shell: Call setlocale
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

