Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44A61C697
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712387953; cv=none; b=l9AYdt9Sr9alaa6BQH2LiEZmTcI07zFFWf551zIy6yp42169aAZqb4VvDIp5UJeo9rVOZPKZQm7Jo5d7lkzImTgKixr31WqNeEOV0YMEksRP/WsjfWF+PCCpwcK6dl+JT3vyEjovRaXaSchWk3DCsPRuSGQ6WORnomE3qmfn03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712387953; c=relaxed/simple;
	bh=UlSFZcoEUdPitS7C2iUF9BitBMznmM80MkPvtQLVSwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtkQPeodHPAa1uUSOgDhf8D/RP7PsZrJb+AoPdznrotsLYdrOZooT69oCSH0A6/cAz63lMZN9L9pgfA6g//wlA/rfv+yTfjTaRl8d6cGDK4SZtWL15suNqPyl6FgPEKdH27z7xxUlKTr+2A4HyAFUoF3RWwH/Re/NRg0Us7+RNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rt0KN-00FqED-W1; Sat, 06 Apr 2024 15:19:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Apr 2024 15:19:21 +0800
Date: Sat, 6 Apr 2024 15:19:21 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: DASH shell mailing list <dash@vger.kernel.org>
Subject: Re: [PATCH] Simplify alias storage.
Message-ID: <ZhD3eVw1cXMZxZg6@gondor.apana.org.au>
References: <c3903caf-06a7-e321-4fa9-5abe0a0f2ae9@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3903caf-06a7-e321-4fa9-5abe0a0f2ae9@gigawatt.nl>

On Wed, Jan 11, 2023 at 06:23:41PM +0000, Harald van Dijk wrote:
>
>  	if (ap) {
>  		if (!(ap->flag & ALIASINUSE)) {
> -			ckfree(ap->val);
> +			ckfree(ap->name);
>  		}

I think this breaks ALIASINUSE.  When an alias is marked as INUSE,
it will be freed by input.c (popstring).  However, your patch doesn't
touch input.c at all.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
