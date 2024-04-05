Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F415FCF8
	for <dash@vger.kernel.org>; Fri,  5 Apr 2024 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306179; cv=none; b=f/pHziO78+ibZKZMp+Bw+B+hAK4TBRmWQ6FwdhHFYep6prFvH5tcoUXrigwOWikRlJ7KJXOzvfG63BmRnfpHXRGaLSObgol0qvt5w/Zp7t1ovDUK94uGwIaXoY+zqyAtMX02lhcoWn/L/XghqBeC4cm/9opZh0qp17ZJ7bjxWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306179; c=relaxed/simple;
	bh=YCsGvgU54qV/L+f8RsT4CxUYmC01az3BdInw8Q04eWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnW8PRLhUd10IK9DPySWMFeVafGSaQ6nX+4DjScAllWWmEZEW9iqLh5m1oJ4MueSKtZP5BdqOSsi8vCBqcWg59JObJJSQXZAJrFTsGK8xmpozpdCx9HJEFaNE5ibMnGI5925UN6W4rF4luBcFCu54ksGCrscYjUZiU8n/BWsF0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsf3T-00FV0g-S4; Fri, 05 Apr 2024 16:36:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 16:36:28 +0800
Date: Fri, 5 Apr 2024 16:36:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Vladimir N. Oleynik" <dzo@simtreas.ru>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH]: allow $(())
Message-ID: <Zg+4DCTzW9pv5kcJ@gondor.apana.org.au>
References: <08178d03-1912-76e7-0733-75e8f1d691af@simtreas.ru>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08178d03-1912-76e7-0733-75e8f1d691af@simtreas.ru>

On Fri, Jan 29, 2021 at 11:49:20PM +0400, Vladimir N. Oleynik wrote:
> 
> My micro patch for allow $(( )) as 0

Thanks but we don't add features that are not required by POSIX.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
