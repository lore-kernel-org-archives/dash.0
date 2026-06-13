Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4122F3A5452
	for <dash@vger.kernel.org>; Sat, 13 Jun 2026 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781327718; cv=none; b=Uiz2gOT33OG5krvtkl1xMWqRCEgmVJ4xk0FmYZTBxRu8qjaCbgiK2n9nOUAGeXTasdub/R3+qPtYaHTEgbRUaWz6Rn251EZpKhRnIz+jlDAwc9MT5SoTlZQJDgYW7I1fqqUApZxzUKpRkpee3gB3zWAeu0ON7v/RE+E+2qzdkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781327718; c=relaxed/simple;
	bh=ncXEj07dVk4Q8QzbyGs+l2+6Y+xYdCfhdPwxYUHebiE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tsFrY6ucd0Tx0R23NUZj+M9dNIR7K2xU6XH850lVQQ5mNJvgJ0iEMrocmGU+kPbqrvaL4DNhHHzUwfAeG4Mm3poCbZzqiRsVWRDkaEf1OQ5lQpDStJZrLnTgDEMwW0/pYYvyp3opwxaB0LaysrbxGXulv/ZG0NB7nQkfTpKQdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=iN6AWNac; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="iN6AWNac"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=CiuexPC356bU3Ftq2tkIkKySw3bs6DTKffnxwoiKhU0=; b=iN6AW
	Nacsd9L+OtWgPqcg1/ijCcZHFU3wGDrVdM7bZxSGIvbhlUN0JNhoHtuUEHBXHOMEFN4U0Cv1nijSZ
	rRpCV16hAyiTNxy09N4RrqOKdZxiWVFKKx4fNVLPB1/qGF8QV6QpVHRLuASrSjrv5iOzxs230WSnb
	xf+L2LLEfrq0Xu0w0UlrCNpGf1JVaqyCiDEFRG15un7HPL9l037PF5kdtD23oyeUV/XGy3ltKqNRT
	Vx2IHXd45Fc0u+MBbM0g4EYjLJcVtn0gyiG+P4NtRpdzGlLhmJ/LvGMzwsv+LRkCYAYTb++MYeWNz
	ZnYc6XyYKHyFfiHY0/OlkvKuz9ROQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wYGi1-000000055r0-33rp;
	Sat, 13 Jun 2026 13:15:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Jun 2026 13:15:05 +0800
Date: Sat, 13 Jun 2026 13:15:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] var: Remove unset check in varnull
Message-ID: <aiznWbJC12AWyVXe@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Unset variables always carry two NUL characters at the end so it's
safe to call strchrnul in varnull uncondtionally and step past the
first NUL character.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/var.c b/src/var.c
index 6e0671a..90fc896 100644
--- a/src/var.c
+++ b/src/var.c
@@ -156,7 +156,8 @@ RESET {
 
 static char *varnull(const char *s)
 {
-	return (strchr(s, '=') ?: nullstr - 1) + 1;
+	/* Unset variables always end with two NUL chars. */
+	return strchrnul(s, '=') + 1;
 }
 
 /*
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
