Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D15723C4FF
	for <dash@vger.kernel.org>; Sat, 13 Jun 2026 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781326259; cv=none; b=r6VpKOcf2I/klAiLi5mX5NnCkjSCRvhb+0kBVY6cEr1DwkfvL1C5YS+dOAtsH4PXWiVhyMxXZ4Iuc9s3VPTU1Oh9osL8+CCMtm9S7pcg85qgG+g+56KRr3NAUi2shy0+iWXvzhGxgCf4iDY7f5KK1B62vV7jV5G75fNUJibSg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781326259; c=relaxed/simple;
	bh=3oLqdei+3uQs+dtSFxcei6YDFqQiAJtqmY6IlNRjeOg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uFg3LcF09MMDYnZ7YxBO0wYjFL8FiV1oMobrLjMD7McEwlzVFuBC62v9i05iHAiHi8rY3MaUjkOsJJTpkcCCxvtPJvzYU8xBXwxSNRT/pC3+oWLwizApInEdIy83PpgxYcgU3Fcu/CVavUS/1llOYJtUBM0Jq50+53mXrbEU8sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=cO+1DY1t; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="cO+1DY1t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=ZPj18nElfbXuycdBIARmNZILe/R7bstJEsRp4ELaHpw=; b=cO+1D
	Y1tC+fBm5UvIUFFoEzyjqdh4UD93HpKwVJtfx6X69DnsWw+hVqLP73BOm6P5NlZws450HTLxBKMPd
	iURuD/2Sdy9AWzux27B5Qe3vHGrgH6UHGS+XiVX9beVLU6RkUw1UtXL3wGf6yDuTTh048v4GQF+4T
	2cyLzZ2Y0RORZr6My/vpWDbpUXurjOaNUS/Bf+Tlz1H2tp73qm9lkOt5EXMiww65Z3cjzDiYISvjk
	LzA8JP9gelhEKY9PpcnCLS1UHjQQYiDnrprCyiMwPmklEmjXiiZLw8IZ+6LhMVmeHaJsgLgvQcFdS
	E76EjopKPTL3Yh5F3ePf5oDuot8pQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wYGKb-000000055ic-1ZvF;
	Sat, 13 Jun 2026 12:50:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Jun 2026 12:50:53 +0800
Date: Sat, 13 Jun 2026 12:50:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] var: Restore double NUL on unset variables
Message-ID: <aizhrUeyIg8TPg1k@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit 6d8a11f801b41b629d0ad3c71fc5298354ae99ef which
incorrectly removed the second NUL character for unset variables.

Without this NUL character the unset variables could become garbage
when used in dash internally (e.g., ps1val()).

Fixes: 6d8a11f801b4 ("Eliminate first null termination in setvar.")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/var.c b/src/var.c
index eb4075f..6e0671a 100644
--- a/src/var.c
+++ b/src/var.c
@@ -210,9 +210,9 @@ struct var *setvar(const char *name, const char *val, int flags)
 		vallen = strlen(val);
 	}
 	INTOFF;
-	p = mempcpy(nameeq = ckmalloc(namelen + vallen + 2), name, namelen);
+	p = mempcpy(nameeq = ckmalloc(namelen + vallen + 2), name, namelen + 1);
 	if (val) {
-		*p++ = '=';
+		p[-1] = '=';
 		p = mempcpy(p, val, vallen);
 	}
 	*p = '\0';
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
