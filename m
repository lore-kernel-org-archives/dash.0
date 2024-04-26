Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB23EBE
	for <dash@vger.kernel.org>; Fri, 26 Apr 2024 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714099768; cv=none; b=OJzlTBwr1zHt2ykKPpfMY2Wc3NqYiAZDxUZcYujSh2fddjN3byjqheuQ0c5RYkBgrgrk42Hby6Ta8q2FYop5wAhsGuhmogcSL8lHWhuCMm3dN2ahoF7a6xCviNlt+uwnxBz/4/b1jv3xIeEKzojQ0Up/Na6+ZdrWU87mH9/IhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714099768; c=relaxed/simple;
	bh=P8Ko9ARKfaxfJbb39PXBvTGdd0fkBRxRsj5pkAHTv5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMn9m2rp4SEMKaSd/L3T13yz2IrtD3LnohK0CphvWtFDWEz2Uf1Eb+sXKsVBgHJfbyMswZBpB9mg/nX14AAqtbzmAzNgjjNcKZr9BehJSBpDXEsqjRytzqRAuFwKY6nXpjnLPp7hA15RktKqieSUqgXx3n+JJiBgUHQnGWky+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1s0BeE-006WtC-Vu; Fri, 26 Apr 2024 10:49:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Apr 2024 10:49:32 +0800
Date: Fri, 26 Apr 2024 10:49:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: DASH shell mailing list <dash@vger.kernel.org>
Subject: Re: [PATCH] Simplify alias storage.
Message-ID: <ZisWPO5Zc9DdQjgd@gondor.apana.org.au>
References: <c3903caf-06a7-e321-4fa9-5abe0a0f2ae9@gigawatt.nl>
 <ZhD3eVw1cXMZxZg6@gondor.apana.org.au>
 <b3609a6b-f47c-4aa6-a518-dac1be89fd01@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3609a6b-f47c-4aa6-a518-dac1be89fd01@gigawatt.nl>

On Thu, Apr 25, 2024 at 09:46:45PM +0100, Harald van Dijk wrote:
>
> You're quite right, thanks for spotting that. A test case that covers that
> is
> 
>   alias foo='
>   alias foo="echo Hello"
>   '
>   foo
>   foo
> 
> Here, the storage of the original 'foo' alias needs to be kept while the
> expansion is ongoing, even when the second 'alias' overwrites the original
> definition. This bug is fixed by below additional patch.

Could you please post a combined patch? Thanks!

> However, the patch conflicts with c8db655b because scanning 'name' will now
> find the '=' character and continue on from that to check the value. That
> should be relatively easy to avoid, but I am not sure it is worth it.

Don't worry about that one.  I can back it out if necessary.
In fact, I'll probably fix it in a different way as I'm adding
multi-byte support.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
