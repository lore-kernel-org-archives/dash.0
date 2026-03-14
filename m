Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B2C14EC73
	for <dash@vger.kernel.org>; Sat, 14 Mar 2026 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480222; cv=none; b=fEqUXGdslzcv2Qgf5P0h147+rgfpOhJtZ06hKcwNLSz8S7Sp6NAukq0jn/syx04Jj63nmulTp2e/Cy32TuRMoVatczMQwIr2kX4EQ6xypTpirRUd4OV9Dt42+CEmmDX6t8s/oLNZBVky/xCxAeScRHzHB7v1m7AHosMd4I7UlCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480222; c=relaxed/simple;
	bh=44rldrFTyZDfHNMqmvYPZsNg4Ix9MPGvpqIutoqWJAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CmN8SKKnQ/m88P2HErO/3FaDef7jE3sxFNvRjAZ/3GRIb53Qk7pwtB3fB3/TQpE+Va6/hVC3c4tmjZvVt0LET8RP8l+fMhqPTj0SMc5Bdao31rz4/BEsuRvh/zo+I5yQfSuRL/99W3RN6KBlSHqzjgK22Dhe+oVzRXG/9lcj35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=FpQOr5Hc; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="FpQOr5Hc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=slE1fV9C15+ikLqVtiXZcmZKmkePlRCC+Mmxm8CPmBs=; b=FpQOr5HcNKnHSBfh1f43ZkVQYs
	efSfRiP4Yk8ODRl7z+/0pK5gRG0Yl+ABnesEL4t3BOe7oW1H/AKm8p25CEfXS9mjIdJYYAKiP+Co4
	Dighztyb/gRDG5W6GDJuHj5XvgiAzMGTNogKjrvh+7yn/RTsddpfVn2QMZdvL+5IopTeUhfvy82GN
	uhV6ueOR/dALloMihfZnNPnrI3QCR/uF5aDGU2yMiTmlMtIS/9KZMoMP87zaEY9axd8DP7CfnHHqB
	2JXiXpPP3s5fuwj5vLOBanVIAIsNGbcj6KXTwgCDF1Af5w2VudDRIIjDQhrD4/IqVttX0zSdcUx9P
	CcGFYrPQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1LDd-00EN7s-1C;
	Sat, 14 Mar 2026 17:23:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Mar 2026 18:23:37 +0900
Date: Sat, 14 Mar 2026 18:23:37 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tiago de Paula <tiagodepalves@gmail.com>
Cc: dash@vger.kernel.org, tiagodepalves@gmail.com
Subject: Re: [PATCH] input: Fix heap-buffer-overflow in preadbuffer on long
 lines
Message-ID: <abUpGUbMsSSM8mEF@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_NRt5mv7E-qkSA2hE+4HsQMzpczrF9ZAWL-jKbW0Li1F3U0A@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Tiago de Paula <tiagodepalves@gmail.com> wrote:
> Update lleft before calling preadfd so buffered data is preserved
> when refilling the buffer during long line scanning, preventing
> out-of-bounds reads.
> 
> Fixes: a065467315dc ("input: Move newline loop into preadbuffer")
> Signed-off-by: Tiago de Paula <tiagodepalves@gmail.com>
> ---
> I discovered this via perlbrew: config.sh contained a single
> 'cppsymbols=...' line that was 12502 characters long. The issue
> can be replicated with:
> 
>    python -c 'print("VAR=" + "a"*8300)' > repro.sh
>    dash repro.sh
> 
> AddressSanitizer reports a heap-buffer-overflow in preadbuffer(),
> which led to me this fix.
> 
> src/input.c | 1 +
> 1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
