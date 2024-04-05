Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768915FA9B
	for <dash@vger.kernel.org>; Fri,  5 Apr 2024 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308685; cv=none; b=i0OvcYx8+6Sbp+UP8e1t5s1VnDEYin6FXtlToQ6KpSytN7W067+lBFfoj2O6j+A9KNnpfxgbJ8UvMgYV5dZmeYZuKuczINF1TB8dFsO704GeRC2hXAJCbc9HM41OpyO4lPRMge9sO6FZ8Bux8xcM241NDeucpFzFUPxDQDX0yRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308685; c=relaxed/simple;
	bh=Ei4uNWqq9OrDVu5wAu1Myc+fHHFFP5v/WX94SY29ioM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkGw6eNRsS+3aYNqQvVLgllrSqUd5jj2Esc+QWJEaky/SShcDD4rP+tr2UJpuVrMJkh0+vOOu0NNFnBTy0HeUOx0nwr2Lr80DuxEW0+U7ab3HGqloTig5hdfcw3mrRW1rbdkX5wqiQSsXRvog+CAqswuC387ZLFPdqCLPkyMRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsfhu-00FW2m-T6; Fri, 05 Apr 2024 17:17:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 17:18:15 +0800
Date: Fri, 5 Apr 2024 17:18:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "C. McEnroe" <june@causal.agency>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Fix chkmail loop break condition
Message-ID: <Zg/B1+kFFuEQp24+@gondor.apana.org.au>
References: <20211002203732.6175-1-june@causal.agency>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211002203732.6175-1-june@causal.agency>

On Sat, Oct 02, 2021 at 04:37:32PM -0400, C. McEnroe wrote:
> padvance_magic() returns -1 when there are no more paths left, not
> zero.
> ---
>  src/mail.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied with a change to check len < 0 instead.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
