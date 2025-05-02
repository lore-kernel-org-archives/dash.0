Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3DBA3F
	for <dash@vger.kernel.org>; Fri,  2 May 2025 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746164750; cv=none; b=mSclFrQh5pDTdNCHqFLO8uQcP18z8JBxTzSLTTa5qRK/C+t69aLyKpX7gpLF7Ei8SsSzl5FuhTiO3HvKJGudUz7LtgxYd9rCmsgpK3mJthMb+lMD8mssDKSs7R3+1mtPZzeHRn5Q7GymKFIuq/q0ADJko4HC3DwNvqsM3SHmgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746164750; c=relaxed/simple;
	bh=7Sh8lnyJ+3YtwPuxA1mSSToI8wY0yELKJRyFLs5wkgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLb3Q/iUXZkzWpg3CeBi5+ek3ael7FyVxqQqIQ7gp617ZDyRN4SKRKMJ8sweXNbh8gYU4DwtGEI7dTXhPeqdhc3mGyZxH2x6kxyE2T8O1NKuqGcIJMOcqWhilog2SHGTrR5y9mLKORfHEBbPmAM4aTK/fuZ0QVszLN2J0eUS/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=l7NVkYh7; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="l7NVkYh7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oAOMkDwd5YyxvQz8dmD/8NsLxtSTXC9Fi6TiCJ/EftY=; b=l7NVkYh7SwWMr0qjPcZLg7ykic
	ynErbNjy44aHCXNg3u5Qs8PKVEjNlX055riL9uECxSYKsminSKO3jDsqnz0T3F+pcwf8k9fCNi7PX
	4ztzaoL7xlhwPDZEuDDJstGuV4/OKa5TGVKwYuswmOM8eY4upa5TT/nKar4BwS//7wQisa/kWpkaZ
	Q3+gnIOZe/l7kL1NvcMO97sj/we+3se9TNr1xhwLegwfYuwQCnYxIDTNHasoIWJo3JPTsUvNtH8l+
	UStS3DEZdP0EA5bWyfEeHg3I0RgOPe2y0YlbMm88KLVTuNlTFhCHzl/06RO3mXLqte2irixVBEydK
	q0TsKaaw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uAjDT-002lRs-3C;
	Fri, 02 May 2025 13:45:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 May 2025 13:45:43 +0800
Date: Fri, 2 May 2025 13:45:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zurab Kvachadze <zurabid2016@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH 1/2] expand: Fix negative size parameter to memmove in
 subevalvar()
Message-ID: <aBRcB6IwkkehEVB8@gondor.apana.org.au>
References: <20250429214732.22390-2-zurabid2016@gmail.com>
 <aBRZWR5fFMN1-u_i@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBRZWR5fFMN1-u_i@gondor.apana.org.au>

On Fri, May 02, 2025 at 01:34:17PM +0800, Herbert Xu wrote:
>
> Thanks, but I think this is already fixed by:
> 
> https://patchwork.kernel.org/project/dash/patch/Z81WqTBtj9TRqQzy@gondor.apana.org.au/

Actually I think it's

https://git.kernel.org/pub/scm/utils/dash/dash.git/commit/?id=a76c0f428e64d6ccc37c066ed4d47f49b52f9ae7

which I forgot to push out.  It's out there now.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
