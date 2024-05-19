Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729833D5
	for <dash@vger.kernel.org>; Sun, 19 May 2024 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716096017; cv=none; b=SOe/bEPuk9SPuTWknV/5/9TVCzeTPiokCxcpKEAmdVPn5u3s6xikJKoNcS6RuvzjUeSPYRngCYb/vTAQZ4tzH4dSb7NTySMDPCnjp6CHlod0zJKSmP7udXm27xSR6jw/Skrj4Zyaq1B+sMbfbA1AynfJWMyE7osnDAOJymCKyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716096017; c=relaxed/simple;
	bh=1refcKD/Z5qW8Czk7ev9Teg/iSBIjJQ7KrlUcn8DCq0=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=YssUZuKnAap0/Rg21R6yqyky7bcPtqsF62XQ6F79L9IzdKM7hYmoQXvGFLHPm3mcqUhEc/oTzz3r2HS9YxVooVBzA9L2WVLrq9Cq0GEIpOeVRiY2V+Bgk30DU6Bc8PlhpMDZAbBXufO9qUw81VqZ66zHAIkmMtw9JI2E4r8bPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Yxv-00HGAA-0O;
	Sun, 19 May 2024 13:20:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 13:20:12 +0800
Date: Sun, 19 May 2024 13:20:12 +0800
Message-Id: <57e08dd1fd32c616bf8cf60315edb6e1739efe6a.1716095868.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1716095868.git.herbert@gondor.apana.org.au>
References: <cover.1716095868.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 02/13] shell: Use strcoll instead of strcmp where
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
index d8b354c..38f8785 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1464,7 +1464,7 @@ msort(struct strlist *list, int len)
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

