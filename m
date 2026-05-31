Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197028C1F
	for <dash@vger.kernel.org>; Sun, 31 May 2026 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206668; cv=none; b=uMhszQH0JK9Q6+ZfQtc+y7C5bZJ8ZHnnzRIaBiHJTFCSOZPTpLAWUnF022XGmPDfon4b4NQHNiArhjABwdG+8902mTpi+djgYDxkJ/DUtzfhiVLj4Xd14sADWKOyEY+q/iwGA9TtA4QeeMdiilpGrUgR+J3hl+OErExM91m2mpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206668; c=relaxed/simple;
	bh=PmP/Vl+1UILwXgTTJp0Ii0rwTJz5JKz8Qf2J2xUC040=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NHWP4rsgRbGopr1GPR91LQG40cBVkEuOuNEP+ho9IQUypcFK+xUCOOx9mhDfAdnocqok7fWaYIy2WfnLxDP0uLMcr6lugtdSamkrcLrMEI7By46DNuJi3YL8mNqNe61r/b01Qwp8QlTUAmoHdd0rw/DorTuXfZ4a5UqhALruqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=IEYcV1sV; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="IEYcV1sV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	Cc:To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=swPUbhb68C7NIWfCIzLcoI6SVy6Gx0n0yJXNdweriCs=; b=IEYcV
	1sVp8TZjPYtXdV9Ko26AbAWN9vRLu2kUTS6NY1K0r3KyC8LijsX+sc9GuEF02Mij6ublWDHAtAblE
	U8dgbWrFJyTpEK04eRBMtdoJi/Z68rHhzX2uJvEGv+r0FFDGOdiWpvCMmnw6DWI16Zs2xZ/7OHesU
	vlj40Upx3xZB9z488pUYbz6SWUoQGVXPX6hTbxDso2hkdpYpAqdMEydfG2kwF+laevgHNavFxnhQR
	5IXk6B0Oty5l2V5OqEBnWvIeGBxU4b+oae94LnQXQQCeQFxbrZ+N3jWGqOpBsXMUK6ZAy6Ctzsx+F
	qiZR+5ehQKaNGAO2B5zczvkqp+qxA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wTZ4g-0016dT-27;
	Sun, 31 May 2026 13:51:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 31 May 2026 13:51:02 +0800
Date: Sun, 31 May 2026 13:51:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nathan Mills <the.true.nathan.mills@gmail.com>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] builtin: Fix unaligned access in conv_escape
Message-ID: <ahvMRjYgQu7oj0g3@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When writing out the unicode character in conv_escape, use memcpy
instead of direct assignment as the output buffer may not be aligned
sufficiently.

Reported-by: Nathan Mills <the.true.nathan.mills@gmail.com>
Fixes: 776424a8f915 ("parser: Add dollar single quote")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 106aecd..c2c3615 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -419,7 +429,7 @@ hex:
 			USTPUTC(CTLMBCHAR, out);
 			USTPUTC(len, out);
 			STADJUST(mboff, out);
-			*(uint32_t *)out = value;
+			memcpy(out, &value, 4);
 			STADJUST(len, out);
 			USTPUTC(len, out);
 			USTPUTC(CTLMBCHAR, out);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
