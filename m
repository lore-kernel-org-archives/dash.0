Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EBD26A
	for <dash@vger.kernel.org>; Sun,  9 Jun 2024 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921154; cv=none; b=SLtRzyJdbnbesaVY3icnAY//m05myavaZmzlD8NiCy1Vmu0/Rms/g78uJlR7MrnlM+y1jwBi0AY0/w0f4AqPeppunbbwo7ig/fa75Ze45x0I3yMWIwATtCrBwetHB2qPPSnTWw8MwpaXnhkEF7EoiwhJZmnpE94YMkMJz3LU908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921154; c=relaxed/simple;
	bh=pH1XkBH7esAqKBr5ptSks5E6pM3NK04paG4olG1rjqE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m8yZaCKiXGE2yyt74gHQs+A4WonjTb29RuBKPHmuQ7g+OgOcgI8InuTGvoGSq0dcqUX1C6vIOhXzhskVDUmq5Fy7K76q39escncbW+u+Q9+wV0i0PSDvo01WbnbzTPxwTZVBwBDQmy2tUzZfWqOF5diNYsDOcdQPLYZHqsl3Uwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sGDlZ-007IKv-38;
	Sun, 09 Jun 2024 16:19:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Jun 2024 16:19:08 +0800
Date: Sun, 9 Jun 2024 16:19:08 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] parser: Fix PEOF infinite loop in getmbc
Message-ID: <ZmVlfDqLvvfdw51t@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bail out of getmbc if the first character is PEOF.

Fixes: 6c44f4ee0c2b ("parser: Add support for multi-byte characters")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/parser.c b/src/parser.c
index a4d3291..3d21894 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -892,7 +892,7 @@ unsigned getmbc(int c, char *out, int mode)
 	wchar_t wc;
 	char *mbc;
 
-	if (likely(c >= 0))
+	if (likely(c >= 0 || c <= PEOF))
 		return 0;
 
 	mbc = (mode & 3) < 2 ? out + 2 + (mode == 1) : out;
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
