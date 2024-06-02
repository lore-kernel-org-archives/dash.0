Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8815A5
	for <dash@vger.kernel.org>; Sun,  2 Jun 2024 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291738; cv=none; b=lcxkFRazk8Yu/lyIpXJUfbgC1qtDr8cWYUZw3dsJzrip7VIRdGOZgyZ2aNaAwaaWezILU2ggWu/hUTY/yirPZEu8dSHdy3c9g3jjCbv7Wo5kZmQY64WS6HyMBeY2wYQxGzkqWxVskxdU3FRTll4rxnRmle7JKaoa40aJkY5wLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291738; c=relaxed/simple;
	bh=8dvdbVjlB5zMfGYHFf1fmXACtNrDHff7IP+O6EIfJUQ=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=l9PFB6oXaTtcXJmTc60jBoVLtnWH72C91sJYLKBdjDItpxwDxuHpB12UuV6lCMt0nYD4lx51uabneLFuueTaq/l7tfWS0Jog8QAxZVA4X6BMSP4HUc1Eyx+H7fbkLbDvZ4I1I5O6Y3KK6ccAvJPSfqjPPKKHE0p/GgiFDaQHufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sDa1d-004iR0-2h;
	Sun, 02 Jun 2024 09:28:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Jun 2024 09:28:48 +0800
Date: Sun, 02 Jun 2024 09:28:48 +0800
Message-Id: <67a91cb8a0a6834d5f1efe6f582e73a400229963.1717291579.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1717291579.git.herbert@gondor.apana.org.au>
References: <cover.1717291579.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 02/13] shell: Use strcoll instead of strcmp where
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
index ce245e4..db46cf4 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1481,7 +1481,7 @@ msort(struct strlist *list, int len)
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

