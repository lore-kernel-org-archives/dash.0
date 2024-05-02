Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4356B73
	for <dash@vger.kernel.org>; Thu,  2 May 2024 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645359; cv=none; b=ryiYFWLDB94svEaPPhTDB3L5cqQ0U2JDRE2hT1Y4QFTtGgO8CWhfwfa04UajfqlTN9PFqEeQ4Gs9aEuvfc1YclwPYyYX7cDDFr4MXKbLJZD9/et4/w/UlmDlcS0uY01pp5qTo+9vvlbh8lBMYeIxaaaJbdqUFRbBQY3VGmPY16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645359; c=relaxed/simple;
	bh=OkhsAYi429+I+24B5hyNotLDedjdgfH6nxT+JPoMK9A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CZrPI/9p/w0ZG+T0SWtFItg9n3vcVVMF7F1XZjdslIZtAJ7rUeiPXvhdGNiRW97gKzVI7bNY4eqlfeEL9jkBWLKQ365sE4O63FCF4Z1vb+SJqSnveYzfw5JQYskPcNYuU5L1XDsVFqAYs5/AzjyJLBkx0GOX82Vk2GNarWq+KF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s2Ta0-009SKn-1G;
	Thu, 02 May 2024 18:22:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 02 May 2024 18:22:20 +0800
Date: Thu, 2 May 2024 18:22:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] input: Fix potential out-of-bounds read in popstring
Message-ID: <ZjNpXKnES43hHImN@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For an empty alias, the check on the last character of the alias in
popstring may read a bogus byte.  Fix this by checking whether the
alias is empty or not before reading the last byte.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/input.c b/src/input.c
index fb9858f..e56ab5f 100644
--- a/src/input.c
+++ b/src/input.c
@@ -401,7 +401,7 @@ static void popstring(void)
 	struct strpush *sp = parsefile->strpush;
 
 	INTOFF;
-	if (sp->ap) {
+	if (sp->ap && parsefile->nextc > sp->string) {
 		if (parsefile->nextc[-1] == ' ' ||
 		    parsefile->nextc[-1] == '\t') {
 			checkkwd |= CHKALIAS;
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
