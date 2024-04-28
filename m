Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C21876
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 03:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714276608; cv=none; b=p0KoKSXWuBcKtyXUaSUi1envf6xRIm6vhAo05TJYZ7OrDFFIEAG4yuX2Jt2t5UijnK45RmhjuzSY1gzYCcbaylylNX3LZU3lQxPAyMdI/jcY6G/4AMj0cKjUexsfQFz3xLMvNO/XmX+KwCdTEshjS1atqVurFwK3IiQ8xIHfZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714276608; c=relaxed/simple;
	bh=QSNOuGchN7VIKs3Dii5wq9S5Z13unfd2KegrKIUOKMs=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=syFM0n40g4TEF+76QIdiLECBsf1mtt5FK+8VJLRs/DgOaHwW5IECI4/O+D5gvYEwl+r1g10a8yOpF3dkVfar76oL5IZaed845u6Eyqmn+2wLQ8Iqv38vG0x9bEMBxf7cxxHU9C3W5SxeQCyEWDjR4O1VlXn8y754/clpJorc+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0vec-007PZL-0x;
	Sun, 28 Apr 2024 11:56:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Apr 2024 11:57:00 +0800
Date: Sun, 28 Apr 2024 11:57:00 +0800
Message-Id: <6bb4ba1fe8c3bf97b993aa037dda946ff6947d86.1714276539.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1714276539.git.herbert@gondor.apana.org.au>
References: <cover.1714276539.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 2/8] shell: Use strcoll instead of strcmp where applicable
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

