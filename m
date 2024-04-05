Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5FC15F300
	for <dash@vger.kernel.org>; Fri,  5 Apr 2024 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306478; cv=none; b=s39q5MJcylqgURoqgupHNKNeqWbrWX7rRXFTtOm8/KBTYX8KiFSo/xptgrCN5/6uf+Ud6RQsOxy5VHyv3Ya5aXtCiZ+mcZvSfx+/4RaR6z7OSbRLRiWy42m2bhj7wJ0abaHHlBVoEkuybPPV00TT1+WUvoQE+c7IX1Sbru1wAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306478; c=relaxed/simple;
	bh=0GahQzD7WiWfwUKfUxe21e6iQH+KROng+03bx7aq2mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2y+p8xEyn3OdvnqQTU9jub0CR7Wcf0L5s7Xy+m7zxvX5Czqu/gl+j5JDh5kIxM45aunc1sgx0FKDgWEabufcY7v3gquyjVYTMgVQWQVtnUakOiZBMZPHuJG5oHTbYAR64sVrQ+l3vejcAUzduMyM5DyWZcGunPqVQz4GNgHPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rsf8J-00FV8A-UI; Fri, 05 Apr 2024 16:41:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Apr 2024 16:41:28 +0800
Date: Fri, 5 Apr 2024 16:41:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Vladimir N. Oleynik" <dzo@simtreas.ru>
Cc: dash@vger.kernel.org
Subject: Re: [PATH] forgoten set $PPID readonly
Message-ID: <Zg+5OFFIi5IAVwBx@gondor.apana.org.au>
References: <be7ceb79-c721-740a-7f5a-b65b15d4da24@simtreas.ru>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be7ceb79-c721-740a-7f5a-b65b15d4da24@simtreas.ru>

On Wed, Feb 03, 2021 at 04:54:24PM +0400, Vladimir N. Oleynik wrote:
> 
> You probably forgot to specify the readonly flag for $PPID.
> Micro patch attached.

This is not defined by POSIX.  In fact there seems to be no consensus
amongst other shells.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
