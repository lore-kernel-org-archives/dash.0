Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27FB221FC7
	for <dash@vger.kernel.org>; Fri,  3 Oct 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476595; cv=none; b=artq8u91ipy1jRl0aHsoc+XH0v5YVi6+O3bs6mnXkQfNcrbMqMzZ9yuqA0JiMhzXzKXCAV5Xx+QrLqMDCYlLYOGhqmbKK+GtEHyO7RR9BkIJbipVZcvgokvg+wbrF/YpbkHc+CvbZG3vg/xt4UzdwElpJ4gWisLrgBCSrtDLvz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476595; c=relaxed/simple;
	bh=r5fDj74h0OGUIc5pXcz89Eh2TspAWTWVQV8iIFyXmO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E96OBX1RUNLbZg3M69Oite1NOopEuX+fIforxEr40NxX6jXnNmQQQNOzK3d+YvSc4o0JGvrJoNC1/PqHYzf02Qew+5gj75wcfqpnsAL+QVXzHvg/RvOX5LxWHQGK+uf/C5u0QocOBQiZmkw4HvI0QIIR1SwKtny2tcU2HsF5M7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=hazWCvCP; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="hazWCvCP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	reply-to; bh=Umwsv06coXHfI3nz7uXZNLdUJn9mrYkbRiVe7CtNTls=; b=hazWCvCP4Yd61RYf
	K7P10sQNbbvr9FES+iJhwH4wF5ebTnri3waO9jYPd+IDVzxtAEcvNmkAO9ItVhKvq085A9Iww5m78
	0AXEMi+GuMkTtZ01ZH+Zz+cpEsm/U4f0+73ZKI1cWHgtp54aRew/uoFQ5ChXu0VOL72W/sbdom53e
	XGP5LWICuUJ+q6er8jfvo2KnfF/+A8OR3+VuufpbvsjrOQAMT+HUYDuf4rY40qRREkq4lNykApLmL
	zOBI81aH06/Ouic1fMTHgW8yQuMGcmXGcA4FUGTt2wzbijMXVxdo8tedzmgaIYUb6Y3MLeDdPS3sA
	f0kdtAexfRSjuOcsyw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v4aEd-00ABgu-1X;
	Fri, 03 Oct 2025 15:29:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Oct 2025 15:29:47 +0800
Date: Fri, 3 Oct 2025 15:29:47 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: Dash <dash@vger.kernel.org>
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Message-ID: <aN97a6Nn2C56006t@gondor.apana.org.au>
References: <ba3014e6-b1f6-4b6b-99ac-524dafd22f33@SystematicSW.ab.ca>
 <aNvMWqEu-uIiCbGk@gondor.apana.org.au>
 <81470aa2-3689-46a7-84bc-a7781cacf048@systematicsw.ab.ca>
 <aNx4g4eZSsdvXlRH@gondor.apana.org.au>
 <2b8b60af-82f0-437c-a99e-260aafe37b82@systematicsw.ab.ca>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b8b60af-82f0-437c-a99e-260aafe37b82@systematicsw.ab.ca>

On Thu, Oct 02, 2025 at 03:56:47PM -0600, Brian Inglis wrote:
>
> As config files are not distributed in the repo, it appears to be caused by
> autoreconfig 2.72 as I cannot even build 0.5.12 without your packaged config
> scripts, so I have already raised an autoconf issue!

Hang on, but you previously said that dash 0.5.12 was able to build
dash 0.5.13, is this not the case?

I have tried building dash 0.5.13 with 2.72 and it works fine.
So I suspect there is something specific to Cygwin that is causing
this failure.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
