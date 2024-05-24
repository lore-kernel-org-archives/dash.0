Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D7942AB7
	for <dash@vger.kernel.org>; Fri, 24 May 2024 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561674; cv=none; b=qkt0QeveWgBHig1CgjImn/DQ7HX48w2azKwBsBmjFhVlFEt3MV5VHo7YQe3bdbvVl9v9JVr6Jn8qUaseQ44TY5M+FBTZcLjErEaCYTqD8Gia1LtS560oQXJsHirL38p4T0aiOJdjAoM2INPM26HfR0VsF+jiTI41f69izDCk2VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561674; c=relaxed/simple;
	bh=RApUdpOqbT970UQEehb/MDNkCVQTYwvkh9P3mdKbbic=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dhATR5/3IhijdhmCHsHypjeyxKX2rtxp9GwTot0j+07x/EFZnWjhE5cKPxU4gPXAwENtLDCJcAQ55zXTBU/rWMNvq7BjWHZhEWPk2T0o6jJcNe3KvJDUnKxG2+JQ9lE2tvNBzTKBOnNXOHYpcrYNdfPjHj+6Gg3Jlje/ovF11Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sAW6M-001o7T-25;
	Fri, 24 May 2024 22:40:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 May 2024 22:41:00 +0800
Date: Fri, 24 May 2024 22:41:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] parser: Fix here-doc EOF marker bug with negative chars
Message-ID: <ZlCm_BeRZ3POGHSR@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The here-document EOF marker parsing code incorrectly treats all
negative bytes as EOF instead of just PEOF.  Fix this by testing
against PEOF.

Fixes: 81daadfce8d5 ("[PARSER] Removed noexpand/length check on eofmark")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/parser.c b/src/parser.c
index 27611f0..09b1cb8 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1127,7 +1127,7 @@ more_heredoc:
 			len = out - p;
 
 			if (len) {
-				len -= c < 0;
+				len -= c <= PEOF;
 				c = p[-1];
 
 				if (len) {
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
