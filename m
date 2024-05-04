Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4044A1C
	for <dash@vger.kernel.org>; Sat,  4 May 2024 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714800640; cv=none; b=CZe4afgTX9S9m3/znmm0K1a6FSDxjn30vF4h19B0Y1kdNXV/tIP/Zn7GXX3yiAHwob/5Vzn4DsrEsELzVEtnkENObJzmptUy1TutjIr/UpFNsTwo/hDqUO2z60i25tMuCMn/2my0uTNBkZEa9tW4Q9AUrVGkkzHp4+K4sXkN/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714800640; c=relaxed/simple;
	bh=Qe8l50HxerBCRHMmWbEEW2tkrkHtGlaj6UaxPV0pHtc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kgtzaNJ8S6WBUolstkskOtbJ7Kn0y4qlJ1TgM2VmXxJS0eeSOyppJkAwbjuNvmn8Xhj3fzotkdwB6H7fsslT/7sZ9oV7jS+r4yQSfYKL3ylLN7uiAuAmhS6uAb29ZipUi+/ll/6TJKkauHSjxYfB7yr+hrwyLac14b9TX4Js+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s37yj-00AF4w-1P;
	Sat, 04 May 2024 13:30:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 04 May 2024 13:30:33 +0800
Date: Sat, 4 May 2024 13:30:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] alias: Mark printalias as noinline
Message-ID: <ZjXH-bUn4MS-YwnA@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The function printalias is not any critical path and inlining it
makes no sense.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/alias.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/alias.c b/src/alias.c
index a443e05..1b9b979 100644
--- a/src/alias.c
+++ b/src/alias.c
@@ -202,8 +202,7 @@ freealias(struct alias *ap) {
 	return next;
 }
 
-void
-printalias(const struct alias *ap) {
+void __attribute__((noinline)) printalias(const struct alias *ap) {
 	out1fmt(snlfmt, single_quote(ap->name));
 }
 
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
