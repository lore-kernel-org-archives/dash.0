Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7C567F
	for <dash@vger.kernel.org>; Sun,  5 May 2024 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714900480; cv=none; b=r9NMnGvi4wR+52i9ARfRhxJx3Z+CtEGk4pXWNh7pHKNAOsqYyeXMzsXGfe9ZEMk5O11GYlEgmX2gC5fRym89eB3eSH5Irg+dsOTopJAa5TT/1AfytMK87SX0rpxYENbt8yf+7Fz7e8uNLbZdyYYF0n3BWTtrxTmRJz+siIBPgIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714900480; c=relaxed/simple;
	bh=QSNOuGchN7VIKs3Dii5wq9S5Z13unfd2KegrKIUOKMs=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=oLe8Ml/skSOnutda4KW48wlZQUiI5RJ2jtLhZKbi1J/oo4fXSEMMZirDzzgtmSHIPje2qR/hl4bv7t6QXlCnXId4fACWBnq6+/UzrY6IbSGmwL+3wyCM0xQWzVMkPH0PzPRn8D7oxmYGMM5v/+piYPmpMSrGi7+5WpHnAUO7khI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s3Xwy-00AaVl-0h;
	Sun, 05 May 2024 17:14:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 May 2024 17:14:28 +0800
Date: Sun, 05 May 2024 17:14:28 +0800
Message-Id: <3455da09a3e822b0ac3e29e644dffa1c78a8cbef.1714900377.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714900377.git.herbert@gondor.apana.org.au>
References: <cover.1714900377.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 02/13] shell: Use strcoll instead of strcmp where
 applicable
To: DASH Mailing List <dash@vger.kernel.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Use strcoll instead of strcmp so that the locale is taken into
account when sorting strings during pathname expansion, and for
the built-in test(1) string comparison operators.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/bltin/test.c | 8 ++++----
 src/expand.c     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/bltin/test.c b/src/bltin/test.c
index fd8a43b..2db4d0f 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -353,13 +353,13 @@ binop(void)
 		/* NOTREACHED */
 #endif
 	case STREQ:
-		return strcmp(opnd1, opnd2) == 0;
+		return strcoll(opnd1, opnd2) == 0;
 	case STRNE:
-		return strcmp(opnd1, opnd2) != 0;
+		return strcoll(opnd1, opnd2) != 0;
 	case STRLT:
-		return strcmp(opnd1, opnd2) < 0;
+		return strcoll(opnd1, opnd2) < 0;
 	case STRGT:
-		return strcmp(opnd1, opnd2) > 0;
+		return strcoll(opnd1, opnd2) > 0;
 	case INTEQ:
 		return getn(opnd1) == getn(opnd2);
 	case INTNE:
diff --git a/src/expand.c b/src/expand.c
index 0db2b29..9ac981e 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1476,7 +1476,7 @@ msort(struct strlist *list, int len)
 	p = msort(p, len - half);		/* sort second half */
 	lpp = &list;
 	for (;;) {
-		if (strcmp(p->text, q->text) < 0) {
+		if (strcoll(p->text, q->text) < 0) {
 			*lpp = p;
 			lpp = &p->next;
 			if ((p = *lpp) == NULL) {
-- 
2.39.2

