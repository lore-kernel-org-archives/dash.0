Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F54204C
	for <dash@vger.kernel.org>; Sat, 27 Apr 2024 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714220510; cv=none; b=dcqRmyhy0CwIhmKipCLxX0lT0zxwHC0macptByVMc6jNA0ME+JR3/46d2r2QtIcZUuzrVKJqPDxTW5gfR6bRuF3v42G1pw9RgyWf5KjwjKESblCYdYM5f277q6YFwfbpyVY2pbvttYiOro4UPts4Of0OSpZKwkL+zKG3Gq5Zs1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714220510; c=relaxed/simple;
	bh=n3tX7AtkexaOPpNSNdvwacsaLJ+R+kDyeaRT9SO3UHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esCzEeeq13JWXAiWqfw9eOr4Y7+UDcPnOMzWFvIBybrvjqsgg63AzLmoNF0z1sRYwmznu4/wWFa8ffEXcZxyiNqfXlaSJ/4+bFJXHabSXNDBjq4sttxJXh2IPoKqwMArZ02+QvrpsUFg/WXad5HpfQ3No8thZm+RxsA66FrF4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0h3m-007Asm-35;
	Sat, 27 Apr 2024 20:21:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 27 Apr 2024 20:22:01 +0800
Date: Sat, 27 Apr 2024 20:22:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: Re: [PATCH] expand: Fix naked backslah leakage
Message-ID: <Zizt6ZdJrdSFVBhT@gondor.apana.org.au>
References: <ZizbYRti9EydVOg4@gondor.apana.org.au>
 <000d8fe0-2898-49cc-a841-a78ae7292f6a@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000d8fe0-2898-49cc-a841-a78ae7292f6a@gigawatt.nl>

On Sat, Apr 27, 2024 at 01:12:19PM +0100, Harald van Dijk wrote:
>
> The correct result here, I believe, is <\*bc>. The backslash means the next
> character is taken as literal, even if that character is already also taken
> as literal because of the quoting. There is nothing to cause the backslash
> to be taken literally. The result should be that only a leading * is removed
> from $a.

While I do see the logic in your reasoning, no other shell implements
this behaviour:

*sh -c 'a="*bc"; b="\\"; c="*"; echo "<${a##$b"$c"}>"'

always produces <*bc> across all shells on my system.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
