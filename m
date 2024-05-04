Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F428EA
	for <dash@vger.kernel.org>; Sat,  4 May 2024 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714800014; cv=none; b=U0VzWVT97VTFjGlCVpCO6ngd38QO5ygCOhDTG0O+9SfElFoZ58AZ2UKDf+PbDZw6app+Gy+6J1d3RtcFs/1I/I4HwB+uT0PkMEq2H1K4vqhCCOAK0Qtqf6ozW7QjEBbak0MfnhHc/scRHetm0LMpI4f18DWukHxolKK5bEhKonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714800014; c=relaxed/simple;
	bh=laL7bAXtJf1c/101D7dQsf/iwOmD3S5t7QyW0lsUyyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olkWqILprvGJDnKMxs3zL2AxUK5qZfJSmJzsQsDmEYQ7ZSkivHr2PcNZEfVYW4ephUghvwiyFEDI2t/mhxAZ/fsnX5FtA317OPwXcYCBd2DZg+tYdesm2X4Qpaq6qQKJwzOjjmEqtNbaj3qoW4UAwVEG9xCPKYG/LrsHFa3n4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s37ob-00AF0m-2l;
	Sat, 04 May 2024 13:20:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 04 May 2024 13:20:06 +0800
Date: Sat, 4 May 2024 13:20:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: DASH shell mailing list <dash@vger.kernel.org>
Subject: Re: [PATCH v2] Simplify alias storage.
Message-ID: <ZjXFhgpUpDxBcFAd@gondor.apana.org.au>
References: <c3903caf-06a7-e321-4fa9-5abe0a0f2ae9@gigawatt.nl>
 <ZhD3eVw1cXMZxZg6@gondor.apana.org.au>
 <b3609a6b-f47c-4aa6-a518-dac1be89fd01@gigawatt.nl>
 <ZisWPO5Zc9DdQjgd@gondor.apana.org.au>
 <b8e49c10-8d32-4c7b-a046-568c6e020eba@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e49c10-8d32-4c7b-a046-568c6e020eba@gigawatt.nl>

On Sun, Apr 28, 2024 at 01:43:37AM +0100, Harald van Dijk wrote:
> 
> Rather than storing the alias name and value separately, we can reduce
> simplify code and reduce code size by storing them in name=value form.
> This allows us to re-use some code from var.c to handle hashing and
> comparisons, so long as we update that to account for aliases' special
> handling of a leading = character. This is okay to do for variables as
> well, as for variables the leading character is guaranteed to not be =.
> ---
>  src/alias.c | 32 ++++++++++----------------------
>  src/input.c |  4 ++--
>  src/var.c   | 27 +++++++++++----------------
>  src/var.h   | 15 +++++++++++++++
>  4 files changed, 38 insertions(+), 40 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
