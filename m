Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D682F2F
	for <dash@vger.kernel.org>; Fri,  2 May 2025 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746164063; cv=none; b=X5L0uFfH+KxSFkNNQ8K4NjRmDOVQGBpXGXv/fS5VqgcbW1qbBbT1q8z/lR5dIMKWmobK9bRRAT4FZ+VsZSY8cwcKf0ZdpmlbOvf/Xbx1t32ravt2Av+U0JRXy9z1bFPEE1OmvFgCUuY0NbhnSmlZx/cdUmta8SmcogXnimTwHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746164063; c=relaxed/simple;
	bh=6Xro/DwFFojl7jHgrQpG+E5toOplnWhiC655BEOWnC0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZG7Vs0ZO9K+goQK3sGhB8hRk6x2PagcYN7ZvqZdyQjx8AN7o/wh4jPTNey/KZTOWzV/RvwcGutw/Yj99mh7RvhNTmIcqrB0ez61ocT2v4NyVLpre3sbho2im+L0w6cNOv5zuG7B15D0tYqBy6pX0JtoB6xPFn/jBk9MfWrulbfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=LuHFfI03; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="LuHFfI03"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oLXZ48qMsaP+Gi8+d8xXrc8N146LICnfkS2OZO/0P3E=; b=LuHFfI039ssBDIuujRmCWxsLb0
	HtUNk887EG8Ig1vY9T+qcXN2SXDy6/3/QCU5CtlBXbap7/z+Gj5cRh1HjWaFLuuyVnPHAtcDHVRtI
	ftnD+c6SQshiOpiyY8qVbNY87R5URqY8WmCM/YbOTArFFELtW4wLfTBT3fW+iZKqW0oYu15nBv9nK
	AMzcFmC3ignjt18V0dH9e44fAkI9/hkXWuzQW0d+Dznu5UmpFgdEgOnmu4TDSR8rfPBP+0cEmz0ep
	veNYf0bQxgWrgNQYMjAki0H3c5BuDVCxmQELkEPWylhvqQ1jdadpkQLiF2sAf3CjXHyel2VhDGOJQ
	OS45aiAA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uAj2P-002lN9-2C;
	Fri, 02 May 2025 13:34:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 May 2025 13:34:17 +0800
Date: Fri, 2 May 2025 13:34:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zurab Kvachadze <zurabid2016@gmail.com>
Cc: dash@vger.kernel.org, zurabid2016@gmail.com
Subject: Re: [PATCH 1/2] expand: Fix negative size parameter to memmove in
 subevalvar()
Message-ID: <aBRZWR5fFMN1-u_i@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429214732.22390-2-zurabid2016@gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Zurab Kvachadze <zurabid2016@gmail.com> wrote:
> A bug was reported on the mailing list that causes dash to segfault on
> the following cmdline:
> 
>        dash -c 'echo test > "${1%.in}"' sh /tmp/META.in
> 
> This is caused by a memory corruption resulting from a bug in
> scanright(). The function returns a pointer to string A, but later in
> subevalvar() that pointer is subtracted from the base of string B (which
> address is less than the address of A's substring). This produces a
> negative integer which is later happily passed as a parameter to
> memmove. The correct behaviour for the function is to return a pointer
> to a substring of string B.
> 
> This erroneous behaviour is caused by the fact that under certain
> conditions (FNMATCH_IS_ENABLED being undefined) scanright() iterates
> over the pattern string (that the string A in the example above - startp
> in the function), when it is meant to iterate over the string with
> removed escapes (string B - rmesc in the function).
> 
> Due to the fact that if FNMATCH_IS_ENABLED is undefined, each for loop
> iteration sets loc2 (initially pointing to str. B's end - rmescend) to
> loc (initially pointing to str. A's end - endp), which is not the
> desired behaviour.
> 
> This commit slightly changes the for loop header to make its behaviour
> correct for any value of FNMATCH_IS_ENABLED, thus fixing the root issue.
> 
> Fixes: https://lore.kernel.org/dash/CWLP265MB4157446AD56C013BB88575CFBCA82@CWLP265MB4157.GBRP265.PROD.OUTLOOK.COM/
> Reported-by: Kate Deplaix
> Signed-off-by: Zurab Kvachadze <zurabid2016@gmail.com>
> ---
> src/expand.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)

Thanks, but I think this is already fixed by:

https://patchwork.kernel.org/project/dash/patch/Z81WqTBtj9TRqQzy@gondor.apana.org.au/

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
