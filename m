Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074FEEBB
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395615; cv=none; b=Frm6WCIh7TabBUYp0ez4b4lyc2XE06V/MarFdAfmi7OyemlVqba8nPN1A3be5o0NsxqlM+KGZmabOgJ5BMlei+rWyIJo97E7hakitma6cxWFbWqbDsB84jOIXKsfNB2rRywPlty/O2djcvs4O6hxg4BDSJ6BMAnw1RBVxVCKGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395615; c=relaxed/simple;
	bh=HTVQ8i0B3sy0W3aC4/aCEFjzK3OaM8xv1RRmgYjrG+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjEF0QMK346GKhBa9EaebHoIDNuVewLhzNuSqVYoBEQkdraPKasaXUPRMkulsX+tJhuwDL8rpVfk/jhhRLkcFofWGRW6jKGRcK6Yo9q37F9zy4cpl3yIreoPDBHA0FnCYGC9dHBuZEayMMThcnzskX2A8dTAwjNA0TjwMKSauu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rt2Jz-00FtsB-SG; Sat, 06 Apr 2024 17:26:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Apr 2024 17:27:05 +0800
Date: Sat, 6 Apr 2024 17:27:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] jobs: drop unused node parameter in makejob()
Message-ID: <ZhEVaXL5f9vT4gte@gondor.apana.org.au>
References: <20230331125158.26821-1-dvlasenk@redhat.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331125158.26821-1-dvlasenk@redhat.com>

On Fri, Mar 31, 2023 at 02:51:57PM +0200, Denys Vlasenko wrote:
> CC: dash@vger.kernel.org
> CC: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> ---
>  src/eval.c | 6 +++---
>  src/jobs.c | 6 +++---
>  src/jobs.h | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
