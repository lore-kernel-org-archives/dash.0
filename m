Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F1161B4E
	for <dash@vger.kernel.org>; Fri,  5 Apr 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312363; cv=none; b=AHpsu8PX6o9g8ceo0aORVtatkei3lpKnDFVqXSU37/7U1flYv0zhvvb8Qhlz/V7pN4ghI6mymlVvTHAPJ7lRa18B3JwCUJhj33qBuMhqNQ/3Tz36kurSEUFRyR97926bIoN/U8vj/MvucwsHZRPgNnjfNpCKGBFgqezLJq567zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312363; c=relaxed/simple;
	bh=sXz7FF490IZ55fD1U66jFslN6yW/A9ZhGxG5jXvfb4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTZozH2CgGvbBvziao2hq+MYrW0pvcLC8tmA7z9GSsQAd0o9gjXj5UaURPuCqxZcGFm0OWAKH16v3Vsq28WBSoHcS1QHqcYoxD1HkgSL2fJmL7/k1pPHNmlg+C07jaEw/kyGtpm5mRM5k/A4wDvp/Cq9mkpfLdBZVdSS38BgnsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsgfD-00FXXC-Ux; Fri, 05 Apr 2024 18:19:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 18:19:33 +0800
Date: Fri, 5 Apr 2024 18:19:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chris Novakovic <chris@chrisn.me.uk>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] jobs: Implement pipefail option
Message-ID: <Zg/QNZ9xxQ1t4lFV@gondor.apana.org.au>
References: <20220422211013.18195-1-chris@chrisn.me.uk>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422211013.18195-1-chris@chrisn.me.uk>

On Fri, Apr 22, 2022 at 10:10:13PM +0100, Chris Novakovic wrote:
> With the pipefail option set, a pipeline's exit status is the exit
> status of the rightmost command that failed, or zero if all commands
> succeeded.
> 
> This is planned for inclusion in the next revision of POSIX [1],
> although the details are yet to be finalised. The semantics of this
> implementation are the same as those proposed in [2], which have also
> been adopted by the BSD shells.
> 
> [1] https://www.austingroupbugs.net/view.php?id=789
> [2] https://www.austingroupbugs.net/view.php?id=789#c4115
> ---
>  src/dash.1    | 31 ++++++++++++++++++++++++-------
>  src/jobs.c    |  9 ++++++++-
>  src/options.c |  2 ++
>  src/options.h |  5 +++--
>  4 files changed, 37 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
