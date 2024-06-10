Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFE14277
	for <dash@vger.kernel.org>; Mon, 10 Jun 2024 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001912; cv=none; b=rXs18pbIY7XY1ngB58imKeR1DZaMEyLx9rFq+jEKjxYyahi30F+ui4HKid8Gv4ACd9733F/q6uXO08LirTSjOaSNgSwYQOkBxzwWSY+EeG2KyizBeWW9oCV3cmgFurjlAfto/qeHe+/SFgX5JfgtXXW0eScJIw1aNAhKckM4mc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001912; c=relaxed/simple;
	bh=EUxf2cvs2bOEihlreQcoWCb3RQjYoBDnwixC1w6Lr9o=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=P3prd5o1Iy2vtGsSdoj8R5OCHR9aVnPWZoAUZP4DJQiwRrXQTV/tsSiTP9E3Fy/6V4IYwXHYCpZbDuABz3/b4+nwTTTIb4Yc6DC63KaUKoKXroV0EXMx03iZ5qT+RXmKABQYRidzUsjWsDJ4WaiTv9Y844K6wx5HACX1XZuLs84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sGYm7-007V7V-2a;
	Mon, 10 Jun 2024 14:45:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 10 Jun 2024 14:45:06 +0800
Date: Mon, 10 Jun 2024 14:45:06 +0800
Message-Id: <99d0bd52d6f2c402b074c8ae995dfb2c8faeceea.1718001832.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1718001832.git.herbert@gondor.apana.org.au>
References: <cover.1718001832.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 1/3] parser: Move non-variable case in parsesub to end
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Move the rare case of a literal dollar sign to the end of the
parsesub block.  This eliminates a duplicate USTPUTC call.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/parser.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/src/parser.c b/src/parser.c
index 3d21894..b711d6c 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1298,15 +1298,9 @@ parsesub: {
 	char *p;
 	static const char types[] = "}-+?=";
 
-	c = pgetc_eatbnl();
-	if (c != '(' && c != '{' && !is_name(c) && !is_special(c)) {
-		USTPUTC('$', out);
-		pungetc();
-		goto parsesub_return;
-	}
-
 	USTPUTC('$', out);
 
+	c = pgetc_eatbnl();
 	if (c == '(') {		/* $(command) or $((arith)) */
 		USTPUTC(c, out);
 		if (pgetc_eatbnl() == '(') {
@@ -1315,7 +1309,7 @@ parsesub: {
 			pungetc();
 			PARSEBACKQNEW();
 		}
-	} else {
+	} else if (c == '{' || is_name(c) || is_special(c)) {
 		const char *newsyn = synstack->syntax;
 
 		typeloc = out - (char *)stackblock();
@@ -1441,7 +1435,9 @@ badsub:
 			*((char *)stackblock() + typeloc) = subtype | VSBIT;
 			STPUTC('=', out);
 		}
-	}
+	} else
+		pungetc();
+
 	goto parsesub_return;
 }
 
-- 
2.39.2

