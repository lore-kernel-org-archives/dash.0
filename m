Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CA6101CA
	for <dash@vger.kernel.org>; Mon, 10 Jun 2024 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001913; cv=none; b=oNmLpEHAz1xZ/jhzubPZczB8MOQc7JZitM1bE7mncStIRS+tiKXj6itGS1XaeeNduxodFZl8eXBt48PRgPapx7WdA8GUJYn/IIh3UpwLZoMPohRm6K64jsvny/ivB6loqO9KiDtkP4DWhAgC6POCz08nnjYY5Rfjjo+04NST1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001913; c=relaxed/simple;
	bh=dVKkhDsZNKJTpocyKl/l+5PLI2o1CqeoKUqNXWLw+pY=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=VTkac9752WjVNz0jEjniLAtCimyRAO0yzfVLkrE/56mnlpF/5PybpaFf6HbCQnjP8ZncwFMc5hO3DMrDURIJ4OqL91HAunjA/IYPLcUkgkCVuomStAkMRgvYK+dMOiYkic2k5+OpXI368QdxITsH3LyG/HR/T5oWD5sWApIher0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sGYmA-007V7f-0D;
	Mon, 10 Jun 2024 14:45:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 10 Jun 2024 14:45:08 +0800
Date: Mon, 10 Jun 2024 14:45:08 +0800
Message-Id: <6687ab4e862db7a356c9fa11d019f29a46f97fda.1718001832.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1718001832.git.herbert@gondor.apana.org.au>
References: <cover.1718001832.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 2/3] parser: Merge first and last chkeofmark branches in
 parsesub
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Elminate the first chkeofmark branch by moving the CTLVAR to the
end of the parsesub block and always doing STADJUST.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/parser.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/src/parser.c b/src/parser.c
index b711d6c..2517721 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1293,10 +1293,9 @@ parseredir: {
  */
 
 parsesub: {
-	int subtype;
-	int typeloc;
-	char *p;
 	static const char types[] = "}-+?=";
+	int subtype;
+	char *p;
 
 	USTPUTC('$', out);
 
@@ -1310,13 +1309,10 @@ parsesub: {
 			PARSEBACKQNEW();
 		}
 	} else if (c == '{' || is_name(c) || is_special(c)) {
+		int typeloc = out - (char *)stackblock();
 		const char *newsyn = synstack->syntax;
 
-		typeloc = out - (char *)stackblock();
-		if (!chkeofmark) {
-			out[-1] = CTLVAR;
-			STADJUST(1, out);
-		}
+		STADJUST(!chkeofmark, out);
 		subtype = VSNORMAL;
 		if (likely(c == '{')) {
 			if (chkeofmark)
@@ -1432,7 +1428,10 @@ badsub:
 				synstack->dqvarnest++;
 		}
 		if (!chkeofmark) {
-			*((char *)stackblock() + typeloc) = subtype | VSBIT;
+			char *p = stackblock();
+
+			p[typeloc - 1] = CTLVAR;
+			p[typeloc] = subtype | VSBIT;
 			STPUTC('=', out);
 		}
 	} else
-- 
2.39.2

