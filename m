Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3664A
	for <dash@vger.kernel.org>; Sun, 28 Apr 2024 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714265366; cv=none; b=WGK6OOd/dwOD70b6v+XDvyToRReVlKWusqZi52HLLjsQrs8eN39moDLSQ5m/h9kFq3Ex0dxccatvks2+0WVzguum2RAgbu+XIdVCb1SSAQcVhVjOzwKqJVqhp89aAKqLysgi7Be3eFBnfCblfYKKLEwFAcX6hDBIxg0PmJLcAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714265366; c=relaxed/simple;
	bh=xxn1XmB+AiO3d4WeWNrU/5jWlqtMlshmp0akZ3Tyaz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhxRmUVLR3b/XoknLc4WK+Z48hDL8bcv1BpK356Q4woE6bGImdnNeQ77ZwnGB6I8WE6wWkYQy4l146xJQluYlNh7k71RHajncRFqGzh9FVQyvHkyqLidAuzdbHQQ07FE2EJd/tJsBCoGbP4RCSm1V/kmGN0/n1NYvK8HdDhPaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s0sjF-007MCM-3A;
	Sun, 28 Apr 2024 08:49:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Apr 2024 08:49:36 +0800
Date: Sun, 28 Apr 2024 08:49:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: Re: [PATCH 0/8] Add multi-byte support
Message-ID: <Zi2dIJQcNVwJgxuN@gondor.apana.org.au>
References: <cover.1714215826.git.herbert@gondor.apana.org.au>
 <eb927eeff3d1da7406c998d0ce816d3b6a061fc7.camel@scientia.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb927eeff3d1da7406c998d0ce816d3b6a061fc7.camel@scientia.org>

On Sat, Apr 27, 2024 at 11:31:43PM +0200, Christoph Anton Mitterer wrote:
>
> Long story short:
> The recommended way was to add a sentinel character '.' at the end of
> the output within the command substitution and strip that off later
> with parameter expansion.
> But despite of the very special properties[0] of '.', it's apparently
> still required to set LC_ALL=C when stripping the sentinel, because the
> pattern matching notation in ${foo%.} is defined only on strings of
> characters, not on strings of bytes.

Are you talking about a theoretical undefined condition, or an
actual one?  Which shell doesn't deal with ${foo%.} correctly?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
