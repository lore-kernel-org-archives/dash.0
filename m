Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1741C68F
	for <dash@vger.kernel.org>; Mon, 13 Apr 2026 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124118; cv=none; b=B9E+00zNUeVW83/4Ab5CABFKQ/gkEaY81uXcL6yhHgx0Etmui81+VR3SsXgceKZI6WNovaGnJxYocLo00mwvNTKcN1fV881BuVbIjdaAPzm2dRTn/pm/32cn6Dty/On3+lCB/dZMJX3+f7VkRtbwFhSBx+NsWYIa3ECz4PQ6Mq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124118; c=relaxed/simple;
	bh=Y9kKIoNRv0bRZbEFmuP27UW+zoYdI77SEbUkNSRSNSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tMB5djWHSoa9wR0P8BQmnSeyE/OlIW489JvsA2wW53d1bpmvL9SlEyQhIOuiASy2CeUGJhZWn3RH34EwNieXceHOgp0WAFR5PQeZwKpvI03IncEu2bMJ8yTsYk8yqNQKWY/1VNHYa1qODXxSO6FA305u2WamNfwGOTCV7ZEviNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KjVnJkEA; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="KjVnJkEA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=QkEdC/24pzTkF2lDTUH5sn9Gx37LFGhskw/sWvaoJg0=; b=KjVnJkEAUU5roVElXjtk5zDTI9
	eNeKN83K6Y8o6xiK6pNHv5/CPW3kxigEWh7t5QCm9iOPRpvlqfg+ZzIG1ry22ydDZtsfQJTymFJOd
	Ttfz/AP9GeTmjMvdr5nuccb7hhTEGYq4auau1jIAXWMas4dIcu8uVa44aheZ5Ia3ambLbLRwi5Qej
	8hT8udnX1oJPW996YsFYF0hz7O6sHTOaRHAI+5/dT3p0TrQZJ8s6LpWh1J56R0Enli/z95ORRgVIR
	7/9l9JzcyUYc2nuNDVp5dXqZ4eWUf9s5bT3PwNGj6LtLoBUG0+94Bw2f6i3zX67SlVoaWjbvSaa89
	h9ChnkJQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wCQbZ-005sIx-0b;
	Tue, 14 Apr 2026 07:48:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 14 Apr 2026 07:48:28 +0800
Date: Tue, 14 Apr 2026 07:48:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: 996029583@qq.com, dash@vger.kernel.org
Subject: Re: [v2 PATCH] arith: Fix CVE-2026-31323 INTMAX_MIN / -1 overflow
Message-ID: <ad2AzCSwtmxQF4sd@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d0c907d-28d6-4d07-9c8d-09d5c128373a@gigawatt.nl>
X-Newsgroups: apana.lists.os.linux.dash

Harald van Dijk <harald@gigawatt.nl> wrote:
>
> This looks fine if it's a conscious decision, but it differs from what 
> dash generally does when the result of arithmetic is not representable 
> in intmax_t, and also differs from bash. Depending on the reason there's 
> apparently a CVE for this, this may be an issue, see below.

This is not a normal overflow.  This actually raises an exception and
kills the thread.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
