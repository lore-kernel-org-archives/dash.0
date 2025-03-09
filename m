Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5717ADF8
	for <dash@vger.kernel.org>; Sun,  9 Mar 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741508795; cv=none; b=UFw8zGgaoBV7+rRwTt4mw9EIilkn7agNhDl9tT4pHc0lyewm1hSRM3MzwsnuYxuogrTDRMjhLPWd4osvEQe8fvesFBZo/IXAtz+Xztyht2sAs0PsmC7K+Is/31ye13JP4FC0ovcyXClpsUoA3KeVOOaRogqehc3LbQiqNzqGBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741508795; c=relaxed/simple;
	bh=t7uPFQUCUj39CRzBYyYTWNTwk00QdtPQFUsf6glLFf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odm74Sj8yy59kqAILS90zRzrc+HrvZPISUX/Jxjj44+N/jwL7JGq3jdQimwlkFxNCOfFhR5oX38rsUh8mxFIvfIx8jbkGPPVNAyCpoA4B2IV9BlbztNNuhK3IGKhb31UDjva+g+2s7GqPXQMMdGNdczIZvEeDYAClpmYXb4yK8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=DoOwCu8e; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="DoOwCu8e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gOZ675bG0LRj6l/0lPAhXMDRGlrFCoka+8qu8FJ/gjQ=; b=DoOwCu8ekll/Tb7W5He8s/8uFR
	XZCaum23F+6aLIxEgkaBvCJF2sOYk2WxPncU/blu1ZaXMtUOB6OtUJZW3re8rGuxflG+hDpC3NUg7
	WEaz+vfY+cIG13gXn4tnzCY2DuVKMdZ7X3WWN9dthVwcl4oaxoVQp4FTWkbKvjjV/Us0+fHULDW1M
	+ddad4j/dM3ATYdB5TsuC5Z9ozDH4aKz/DD5vIxeEhBIehxy9F4qnjGdN8X/bGKS3arWxL7lvMZC4
	dUH4GJzlT6PrOM9pX13ctJ8BP8NNhCrH0t387fNa2F9rrvrZsv2W1j1u0JMvaWcfh3zAMANL4lKJZ
	9X5qOxhA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1trBzP-00522s-25;
	Sun, 09 Mar 2025 16:26:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Mar 2025 16:26:27 +0800
Date: Sun, 9 Mar 2025 16:26:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alain Knaff <alain@knaff.lu>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 10-ctype
Message-ID: <Z81Qs8xZBJVnKyLm@gondor.apana.org.au>
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
 <7d618f20-820c-41a5-8eb0-b6baf715064e@knaff.lu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d618f20-820c-41a5-8eb0-b6baf715064e@knaff.lu>

On Tue, Nov 12, 2024 at 11:42:47PM +0100, Alain Knaff wrote:
> 
> The 10th patch fixes the handling of the "functions" supplied by
> ctype.h
> 
> On many older platforms, those are not real functions but preprocessor
> macros, so it is not possible to take a function pointer of them.
> 
> Dash's current approach of wrapping them into real functions would
> work if prototypes for these functions were available somewhere.
> 
> I took a different approach, which is to replace the table of names
> and function pointers with a cascade of ifs, makes for shorter code as
> well.

This doesn't apply anymore because of multi-byte character support:

commit c5bf9702ea110bede687b57c0b5fa3fd0e15829e
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Jun 2 09:28:59 2024 +0800

    expand: Add multi-byte support to pmatch

    Add CTLMBCHAR support to pmatch.

    POSIX equivalence classes and collating symbols are not unsupported.

    Enable CTLMBCHAR generation in mbtodest.

    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
