Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C32905
	for <dash@vger.kernel.org>; Mon,  6 Oct 2025 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759721325; cv=none; b=jk51Gq0K772Af5vfLOyuZy2x0KyRZ61tjUq+uWQvs/fOGluntBSb/lPIO70J2gVKChxPdpxkFD0W9gMgF/Hk7H9a1vPIJOAF4mB8Q5gZMUbWjSs0iMSPbV6Y7pTwqKOTIIRNwe0IcMDBYEwlhWnovYvZUYGtJJYUbQWyWZlVIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759721325; c=relaxed/simple;
	bh=4M1AL+D5whWiBDUhw+Otfin2HMKF1/LLOGtn/iZbfkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWl5nQ7+C9QNKlW1+C52jyLaJs4t3/oTHfW8ZWJluOxVdPvYt3LJryCdMihsw/bm/n6eWA3C0wPiQlo9EyWAQF0SA9t4k6Y2OqTfS1Hl/+eJY2rzd1GyTLMHrQxwNZ1E8v9QuYTzblfEPwn5Aj2ZyeAZmmBCkvSTxjn4ivstcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Bj/OG5+J; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Bj/OG5+J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=WUFB2kdCB4/UyZUhJj6mQpRv8BTXqe5TXY5fGMUp284=; 
	b=Bj/OG5+JxrsK9eaClPqzvVw9iNDCQY1C6QcOac8cr4Yv/JsaYhj6SlK6uDFYN9Ou+X7e9WUzG4x
	XMzX1NCeaoxqSsNvaVKG5pV8OA+H3Dm+b77ykIwPQrLIGYp1a5qL0DRMFT/BEiN40PxlIhcHUW4uk
	RE7SIQDLDwULObktMmXq8ap+RcYRHeYn1tJ2UuscL3RX9XhgzEYXuMrbYEZdhQ0B7r3j34GNLT4tq
	G2ic3U/cOaCWwUwDx7P/caj76mzdctHKP6kIAwUxlATJBVzde35bBzkaoahw2oKByCx/+tiH6D4LL
	zbx6rtYvy1AjuCMfyibNG/OPmJqVMzCYzrUQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v5btu-00AgnE-0l;
	Mon, 06 Oct 2025 11:28:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 06 Oct 2025 11:28:38 +0800
Date: Mon, 6 Oct 2025 11:28:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: Dash <dash@vger.kernel.org>
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Message-ID: <aOM3Zg-k5PoDzbVE@gondor.apana.org.au>
References: <ba3014e6-b1f6-4b6b-99ac-524dafd22f33@SystematicSW.ab.ca>
 <aNvMWqEu-uIiCbGk@gondor.apana.org.au>
 <81470aa2-3689-46a7-84bc-a7781cacf048@systematicsw.ab.ca>
 <aNx4g4eZSsdvXlRH@gondor.apana.org.au>
 <2b8b60af-82f0-437c-a99e-260aafe37b82@systematicsw.ab.ca>
 <aN97a6Nn2C56006t@gondor.apana.org.au>
 <e16023a7-bca3-4537-a8f8-f0e952c70e1b@systematicsw.ab.ca>
 <aOCb3piwcPXpm_NI@gondor.apana.org.au>
 <e4361489-5c2b-472e-a812-5e07f41c5774@SystematicSW.ab.ca>
 <aOMmNGZXShEvZdTV@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOMmNGZXShEvZdTV@gondor.apana.org.au>

On Mon, Oct 06, 2025 at 10:15:16AM +0800, Herbert Xu wrote:
>
> But did you replace your /bin/sh with the potentially buggy dash
> 0.5.13 when generating those scripts?

A new bug has just been discovered, please ensure that you have
this patch applied for testing:

https://lore.kernel.org/dash/aOM2ykncn3sL2LsJ@gondor.apana.org.au

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
