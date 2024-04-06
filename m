Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7977208D4
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712384578; cv=none; b=AUHWph8COAA9CktrQ+G53t81/oRZA920UNWSYHGZeJzKWJfV/NL5tqwpcqT9IFbau6meTAr/+wqkTEQTFCLdiSBGh9P8s8OyNLjCuznvrT8CIIGKBI3BUbY+6Zt/KE3K3ZkyOyxYLsTZbVPU2NmbzufN8y/ZIqLm8/Kg++p1rJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712384578; c=relaxed/simple;
	bh=duosC3iPwsPJm9ZNgocTnQH0OojDswfRliDfNolH3nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyFB8wR9+PL20hzxeU9GJrKsEEVbiwlr5T9MeQh+7/L102jYrGYhHKX5VwdsxkuwoHFhJGLO77UDWsda2NPJ4S0jJWCIiMyCttgTjcT9BJl5QoC6n9gQ/dasK/X4PqwqsFGyfIW6DdLfBY/T93+RNg2Kerjkx2OPlK2cL+6IPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rszRs-00FppB-71; Sat, 06 Apr 2024 14:22:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Apr 2024 14:23:01 +0800
Date: Sat, 6 Apr 2024 14:23:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Forest <forestix@sonic.net>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] man page: redirection operators: fix swapped stdin/stdout
Message-ID: <ZhDqRT0zVzK7Fur0@gondor.apana.org.au>
References: <hpl58htt4cqjtgkt4lvqus3fpc8jc5fdls@4ax.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hpl58htt4cqjtgkt4lvqus3fpc8jc5fdls@4ax.com>

On Mon, May 16, 2022 at 04:02:24PM -0700, Forest wrote:
> The Redirections section incorrectly claimed that <& replaces stdout
> and >& replaces stdin. Swapped them to make it read correctly.
> 
> Ref:
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07_05
> 
> Both errors were followed by extra text that looked like remains of a
> mostly-deleted sentence. Removed those.
> ---
>  src/dash.1 | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
