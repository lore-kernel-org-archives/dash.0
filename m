Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2901803D
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712384747; cv=none; b=LrCr8yZg4I3PQR/BVyrLBzAm6T4VZFa9sEqH7GjaTdZ0ovul1mbZA5JAn0ZkgXRE+yFU7+uQ6nQJu48IwkUatUYb5ubho8ZdoephlTJpVxmKqN81Jrxwq+zhmSINtVAaVm91FHqMUWSJxIrnYpnYrEAPuSJcTIJBmC2bGBOeX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712384747; c=relaxed/simple;
	bh=qYKYu101K7C401vPY4NLYMgPN+wRMRXh6iUOUE1b5Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtqDy1K4RK8oOKfORq8NpgtoYcCH1BiMtH33/8ksKKrRXOP2z+/wveOo77SLdUEJo98K880KpI/nKEMX7RJcq8JxGL5FIwem7Ijim9FdT8F8VTBtbSVJYgblAYuYiM3zq7/cqjX0XfKDADPcuY25IwJmWQ0f/1RiAUJHn1xxBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rszUg-00Fpqs-Vp; Sat, 06 Apr 2024 14:25:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Apr 2024 14:25:56 +0800
Date: Sat, 6 Apr 2024 14:25:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alain Knaff <alain@knaff.lu>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC
Message-ID: <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cacf608-326e-211a-7d37-164041710980@knaff.lu>

On Sat, Oct 01, 2022 at 08:45:50PM +0200, Alain Knaff wrote:
> 
> Sorry, yet another update to the patch. Apparently when I did the diff, 
> the src/system.c file of my "reference" tree was not clean.

Thanks but this needs to be split up into smaller patches so
that each patch fixes just one problem.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
