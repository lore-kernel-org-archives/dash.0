Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840BC84A2B
	for <dash@vger.kernel.org>; Thu, 28 Aug 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373237; cv=none; b=uCMMs5gm4Ny/tRuVkHCfxYH172Eg/FztqvW0auCJ16Py8HenmWaEydsVbz/+O6YmSWwmVs/BqKIFD8jIuzgHepiv98Hk8VQ5zhag95EvlCrPaWoLdaf0p1S3MuFodxZ1qEGnZme9vFGgpDEYBY7JwJX8Xu2oYu5MHyBfMt1z8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373237; c=relaxed/simple;
	bh=RoLOlBku8axvAjwgya5q1bNCLoXzn/Mr9jBmYUMXNNU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KRCk6+l+vD5ZB3xQtwFEuRaqUV9xFpZYveOAS6aWCiJZdzUy3RXP/pRud2FUJIoJB2x8nyU0yn0HgLqkSSCaAR60RNVqV95eYPetqBTpi1/slUs66H1QQ737SqGQjdHd3SuAlzd63UnGMKEPNheYNcz+KBt/rmFsVPNErXCaF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=EhVgBYO3; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="EhVgBYO3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cuuCHqRwalylGRTTWzyvTubwGVHDwswu4M1hB2RcJhY=; b=EhVgBYO3G8U3g/wu9d2RQ4Vksl
	bQ68p5qhAqQVDNahA4V+sSqrU1z7qT72BU5PUTHUV9pTlHd3VwBjBBJMrSp/zK4VlnSSvbp7HC8ff
	R1zpnLMcEDcaHjDhnMrkK09q8Wt3gYMzbbe0MVQC/rlEQITev4ts0N9uiIgSKSN5iBYyhQql2XXQ6
	bJabGw6lg5hyFA1kbFf0FZvHr8YFX+PvilJX+OOCFG5SctewrJeI3c6tcsHHRjUijaQBb4dKyYnl1
	BQZmxJ0wTBTmH0ormbG43XH+Aze3RKatVI/zd7Q0U65qp5uf6d7txRmka7NxqRxVBsoFGlv5wKHJR
	OEZNdj5Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1urYf3-000SZ8-0H;
	Thu, 28 Aug 2025 17:27:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Aug 2025 17:27:09 +0800
Date: Thu, 28 Aug 2025 17:27:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aleksander Ushakov <aushakov@astralinux.ru>
Cc: dash@vger.kernel.org
Subject: [PATCH] expand: Do not call rmescapes in expari
Message-ID: <aLAg7Zi5moktmY8k@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc8ed5da-3024-4d22-b6da-83dccabafe99@astralinux.ru>
X-Newsgroups: apana.lists.os.linux.dash

Aleksander Ushakov <aushakov@astralinux.ru> wrote:
> 
> ==19757==ERROR: AddressSanitizer: heap-buffer-overflow on address 
> 0x515000000500 at pc 0x6187826bab84 bp 0x7ffff71dca90 sp 0x7ffff71dca88
> READ of size 1 at 0x515000000500 thread T0
>     #0 0x6187826bab83 in _rmescapes /upstream/dash/src/expand.c:2088:9
>     #1 0x6187826bc389 in expari /upstream/dash/src/expand.c:517:3

Thanks for the report!

Indeed this rmescapes is completely unnecessary, which is why it
leads to the buffer overrun.  At this point characters are not
escaped at all.  The rmescapes call is a remnant from times when
argstr wasn't used by expari to generate the string.

---8<---
Remove the rmescapes call from expari as the string produced by
the recursive argstr call is not escaped.

Link: https://lore.kernel.org/dash/fc8ed5da-3024-4d22-b6da-83dccabafe99@astralinux.ru/
Fixes: 3cd538634f71 ("expand: Do not reprocess data when expanding words")
Reported-by: Aleksander Ushakov <aushakov@astralinux.ru>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index 25df03c..35481d6 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -513,9 +513,6 @@ static char *expari(char *start, int flag)
 
 	removerecordregions(begoff);
 
-	if (likely(flag & QUOTES_ESC))
-		rmescapes(start);
-
 	pushstackmark(&sm, endoff);
 	result = arith(start);
 	popstackmark(&sm);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
