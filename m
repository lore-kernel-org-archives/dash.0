Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63F4A33
	for <dash@vger.kernel.org>; Mon,  6 Oct 2025 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759716930; cv=none; b=X5qqjRd9yUriZkgqoBv1pVrYmCfRtzzYvjovw+gCGzJcm2nNBKSWi8h6V2zZ5vSH940uci17w0S77kbPinJuNknc+DNk9Xrwmy32kdv1ls6L7L2POsDTOtFo+Eamxye2oEqB7E2/xJzyf0XlgTy8CKxvAS2SANsavWkSgGK64u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759716930; c=relaxed/simple;
	bh=cMY1Jkx+887O4oUR0gEDVGrjUb0B4cJT4LqhqNRBZOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGgU+zhVQj5QwfQZvYXRgbJ2XTEOeDtpa4XooS9VRa1JRQDsVHnztiD0qi8/pcul+/0Oo4Rv7DYAlJjhF8NoAv0b38MRLZZuBiAHPT6tlNrPjKxZVQ4H1q4hQV8VlD7mMThvTF656yfHUeYEQ9F8wAgin9cGVIuo56rqnuSgSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Oic9uQVw; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Oic9uQVw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=CSAIo+uBBbNw72q+VB1X+TL1K0nAJniIKdNWcjL1Sco=; 
	b=Oic9uQVwI8V8gxsFDfPEU7/NQ4RLttmPzKLrKuIj6dKKFODR2iLfzILPYzSxB2+UUnVsPFZZLMj
	SVXnq8px2UizogzmrhN2qw6vR8zx7b+pTvKbT1bdKyTI3LbGPPE32JfbcPefVrL0Qgxz7qmcU+sjc
	oeVbPHxyzW51p9MNf2UkY42lDlKDnLySRj+6sPwy7sTlP0/oURnYBoGeA8m3utK1knT4r7HIvd9AV
	lp/TBd4+s1DTwfHlPkYExTZB0H10dxGCQwvuVYJVIwFGr6lvZ9XOkrX6Np6lOWjGJuLULw+HLn2hh
	kcPJeFZrWTKgdeqRWmDdEOh+LUyyIqjpnpKg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v5aku-00AgSx-2T;
	Mon, 06 Oct 2025 10:15:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 06 Oct 2025 10:15:16 +0800
Date: Mon, 6 Oct 2025 10:15:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: Dash <dash@vger.kernel.org>
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Message-ID: <aOMmNGZXShEvZdTV@gondor.apana.org.au>
References: <ba3014e6-b1f6-4b6b-99ac-524dafd22f33@SystematicSW.ab.ca>
 <aNvMWqEu-uIiCbGk@gondor.apana.org.au>
 <81470aa2-3689-46a7-84bc-a7781cacf048@systematicsw.ab.ca>
 <aNx4g4eZSsdvXlRH@gondor.apana.org.au>
 <2b8b60af-82f0-437c-a99e-260aafe37b82@systematicsw.ab.ca>
 <aN97a6Nn2C56006t@gondor.apana.org.au>
 <e16023a7-bca3-4537-a8f8-f0e952c70e1b@systematicsw.ab.ca>
 <aOCb3piwcPXpm_NI@gondor.apana.org.au>
 <e4361489-5c2b-472e-a812-5e07f41c5774@SystematicSW.ab.ca>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4361489-5c2b-472e-a812-5e07f41c5774@SystematicSW.ab.ca>

On Sat, Oct 04, 2025 at 04:47:05PM -0600, Brian Inglis wrote:
>
> Nothing to bisect as all commit configs from 0.5.12..0.5.13 fail, because
> your repo code does not include all your autoupdated config files checked
> in, and my autoreconfig always generates config files that fail at that
> point.

But did you replace your /bin/sh with the potentially buggy dash
0.5.13 when generating those scripts?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
