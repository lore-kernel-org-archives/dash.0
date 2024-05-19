Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6046C125
	for <dash@vger.kernel.org>; Sun, 19 May 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716110222; cv=none; b=OVSLnMk2qh5gtOrBtoR/ktgl1sB5qTyG9lo0CSRi1+ccuVPrOVcQUkpeiCtuZMA0Bc/m/4Jz/m3xOEwNUAy/aZtTGRHeHnMphzgZByWoDrqDdmyj6hbzOjhyWrIlbm/IcPbfp0YCnQ+26XbJfCr/RasNqrXqzJTxsuGrBnmzNLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716110222; c=relaxed/simple;
	bh=Edn8E9fyHBsxsSl4y1+PplMfDjbNQQ0txyyW7+dMSf4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rIE4w+ZiQJaJ6wJsVTqTRBD6EdLwma2kS3YZLI14/lRO72b1zXVt4r2CbTFVQGhGLzmsuw6nyD70pEc9otCNBxuAZ6Zk9XvJHo3YhLkTq75FEdJTojOvkNjJpQr7fxIvdJSegBqt7iqb2Mz1mUOutjXYMNBJ+b048YVSP5YXUVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8cez-00HIN0-3C;
	Sun, 19 May 2024 17:16:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 17:16:55 +0800
Date: Sun, 19 May 2024 17:16:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] man: Remove reference to PS expansion
Message-ID: <ZknDh75GDTkQMYx7@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The variables PS1/PS2/PS4 have been expanded since 2004.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/dash.1 b/src/dash.1
index ff02237..3e0455b 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -2361,6 +2361,3 @@ in 2002.
 .Sh BUGS
 Setuid shell scripts should be avoided at all costs, as they are a
 significant security risk.
-.Pp
-PS1, PS2, and PS4 should be subject to parameter expansion before
-being displayed.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
