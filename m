Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6013C38
	for <dash@vger.kernel.org>; Sun, 28 Sep 2025 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759021151; cv=none; b=qnrKnp4WY+eZfArnPu3ZmYXv6mExChrfhQH9zyzHEnKEm/VcNOmftILKoVd6SOv8Sv6mIz3N0PVvDJfsdoMk/WEJCX2FzzfDxY7thvagvRbYzc2a6X9OjnLFBaSLTNqpvM11vkOjlEIa7L0UXHdfKGIyTIdAMrpBTjQR+jS5yck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759021151; c=relaxed/simple;
	bh=jJ3pkNKoFVSHwhOS1wSagUUwwLcUZYv71FcqwRGDI64=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ar7do2xlDBeNHsBe9qGIIeLYuXlgK08qA4I+xLRpeTn3LZqhTvlaePYj2yZvGcz81Sta8NeL19NI8u4qz6PQA3CQrFkGhOV1jhBr/Kl+CNB9ZEErh9Gydk1WUBX36DOn/XxnyuYJsseXvVEoq4wto2hBTM91KuqvR7Klpc+MY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Z24tgMrU; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Z24tgMrU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:cc:
	to:subject:message-id:date:from:references:reply-to;
	bh=6et6DkPIoragzAQH/8e2IiNUodpQZYtLypNXuAHE5U8=; b=Z24tgMrUqYYI1mZVe59Y97NXWX
	1pkzZSjjKtSyeqWfne+ki/P3ceFzZiA/Nt8dKFS1DohqWwkhUiH0JR3fb4terVYvXynVot1FIL1ZC
	LYtYvHfpIwPDxgVawRUHQvqInf6FqNtQa51H6QIzTLh2K8+0E7gQzwm4mXwYYSetkt8ohJYm3OPz2
	P4uvMnC6Q0kuXks2Dw01NkINwuTTSeT8UVO8XpX33X3g9C4NM4KNwz8o/Bbc1nUNC2cP0OR9/4V+/
	Vq1sxniNesrcTTdBfRuJxx7LGgM9a3rGIPxGmJYVdXrsZmufrENVDMtBBS8yhEHRUxcbl47mi9Bor
	6Ta1OAlg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v2fkf-008pDe-1s;
	Sun, 28 Sep 2025 08:58:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Sep 2025 08:58:57 +0800
Date: Sun, 28 Sep 2025 08:58:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Reilly Brogan <reilly@reillybrogan.com>
Cc: dash@vger.kernel.org
Subject: Re: bug: 0.5.13 regression (bisected)
Message-ID: <aNiIUVH2-NFBAS3E@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3a79537-be6a-4e5d-afe6-8b8d9dd57955@reillybrogan.com>
X-Newsgroups: apana.lists.os.linux.dash

Reilly Brogan <reilly@reillybrogan.com> wrote:
> Hi! I've gotten a new build failure with gcc 15 (using git source) with 
> dash 0.5.13. This is unrelated to the previously reported regression as 
> our 0.5.13 has the patch that was provided to fix that one.

Thanks for the report.

> ../configure: 9961: .: cannot open ../gcc/cp/config-lang.in���M�U: No 
> such file
> ```

Yes I can reproduce this.

> I've bisected this failure to a9012f4078be32012f240c6208c3df53db3b6086, 
> but unfortunately I'm not able to test 0.5.13 with that reverted as it 
> has non-trivial merge conflicts (well, non-trivial to me at least).

Thanks for bisecting! I'll look into it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
