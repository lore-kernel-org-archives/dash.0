Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76D223707
	for <dash@vger.kernel.org>; Tue, 23 Sep 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639642; cv=none; b=GenYlNbcRMHQLwapporfMppoLPFuZQXHsGVOj+yb0DJeojx/Ic6RMM3KG9lzaBqFVeVL/3VIjbDAYymkWKN8oyJZ8frHQffqnNctJpmUtlZ+l76OJnEILSLWLTS3OV3Eqd3YwZRHK2fVOoR7hw53XSRzBodBMWi4ungPMwr5D5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639642; c=relaxed/simple;
	bh=AlbqVFVyx/4YBb/NzF+zafq1+5xgPOHj9/5X6VVFlQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDK+WetAVVI///wo89MUDH4v+uGFVUMUo1LKYHHyk8DHYpplWUZr5W789SjENn6HZHnv+z8FTHdqsDJzbln+fcrtsiNcQY8R0SnAtMg7difbxu9PBJN7lz0T+j9nDbBT/vXNuUVZnMzOK2ArB+ke20UMuv2yJZxxwpB0DZmDbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=MB//vTuM; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="MB//vTuM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:cc:to:subject:message-id:date:from:reply-to;
	bh=FdEeONtrXonSnTAlW0doDL6faM+YhoTLYej1TzDYUMA=; b=MB//vTuMVaP5gJfHAqE4oOUcMF
	EHYGfyTZD6M8WFsP0iUjpWg+h957oM/EijMVkhit4FUkzQFC+3L2Hjw5Sb3xVSPc3PdxbEIn2Cf01
	MElrU1wBbP8M1/aJXdz0NQfhxT6hsYUpr5sERMKvedtbDzyoT2bmv6KXbPgFlk0fyXo1IcgK/FmGs
	qxKf6BSKuzrkUT7isLuGFC6DIBDvtT5CvVYBpr0b7vzG5an1+rIONng+/jeReGuaoK6DPFCxhewuG
	+nqJZCspPGEequ3npQy8gccx7It+sSHnl8aXUetrKwveGFY53MKIH5ZfdGrx7TFSsTuDI8q7cp6FA
	CxYr9rag==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v14VK-007iJr-2w;
	Tue, 23 Sep 2025 23:00:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 23 Sep 2025 23:00:30 +0800
Date: Tue, 23 Sep 2025 23:00:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Reilly Brogan <reilly@reillybrogan.com>, dash@vger.kernel.org
Subject: [PATCH] expand: Fix typo in pmatch for wildcard search
Message-ID: <aNK2DgpH6Bs0XCQm@gondor.apana.org.au>
References: <aNI-RCggOzN-tyHy@gondor.apana.org.au>
 <77d15ae4-e9e9-44f5-9eda-f287a4815411@gigawatt.nl>
 <aNJ3dYOcNX_lrTbr@gondor.apana.org.au>
 <aNJ4Nd-lE1rIjhH3@gondor.apana.org.au>
 <6f017266-fc35-4864-9f10-3ead8af4e9f4@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f017266-fc35-4864-9f10-3ead8af4e9f4@gigawatt.nl>

On Tue, Sep 23, 2025 at 12:03:20PM +0100, Harald van Dijk wrote:
>
> configure did/does prefer bash but can run with dash, either on systems
> where bash is not available or when CONFIG_SHELL is set to bypass the
> automatic switch to bash. This has been working for years, and I very much
> suspect that if you run with a slightly older version of dash, you will see
> that it also works for you.

Thanks, you're right.

And Reilly had already isolated the buggy commit through bisection:

---8<---
Skip the optimisation for * for only if the next character is
? and [, rather than ? and anything but [.

Reported-by: Reilly Brogan <reilly@reillybrogan.com>
Fixes: e878137f63e6 ("expand: Move stop array closer to strpbrk call")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index 992cbe8..1fab394 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1911,7 +1911,7 @@ static int pmatch(char *pattern, const char *string)
 				c = *++p;
 			if (!c)
 				return 1;
-			if (c == '?' || c != '[')
+			if (c == '?' || c == '[')
 				c = CTLESC;
 			for (;;) {
 				if (c != CTLESC) {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
