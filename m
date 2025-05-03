Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABAF1C683
	for <dash@vger.kernel.org>; Sat,  3 May 2025 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746257002; cv=none; b=pNulItkiOMa3RBLCMLiTx349wB8OgpCmufn6Hw+XF0MR6UMxYdsxIenmfWICKV5X/cUtKBjrZAFshcomk9M1PzA6AR+I9gJrGv+n5F5iBr1vrt9JUxoRiiXatAp+Li58e5eIYKkHjo1fUcQp067wNdyKOw15rZ4f8S0bWYvFKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746257002; c=relaxed/simple;
	bh=YIaWcLCL2K+t2dfr8wv1o1jIRpHgM2jaMwmSFVk25mA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DLIX6CYT0MyKkx45Q0yNg3FTL5Bq43xBOj3iDg4KPQjULUjToM2b7OE/Gy+p8f4naJQ+C3veXeH6z3dR/KD4yRSKVMPvU5Nf2jZNX1A9z6lG7QmoLHYA0JY6YRYLRaN1SIIWc4GXBhX9nolB6Sc/LWbpN9FgaGWQlNKKBnHaTP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=iIx9M8SN; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="iIx9M8SN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eqMwvjsP6ZkNWg8I8LCDLMBlRsi6bHhw+fM/USWBU38=; b=iIx9M8SNQ5lTdacDdEZxPyBxFX
	i6mgmIWVsVMOyQYeLrttZaZm+zVOUfmFbmRUl5Y/01HX4bsVG/p6XSI9ExwGbxLOaXSqKvbaXZByr
	L55fs61WgXHnnLmEk3GBzISKdtEGGXz/QOzANsgv8sTnvhnrYejHNMU40ZMWFbcXgsuMroytjIpwI
	i1Kde92rl9cDByAsGCW0ILAQLv38sI77vlmwhbkoO5ZAIqnbXLruSwi9oF5lqdHEAVxdF4NPBW942
	uAU3vghAoudC7a4D+mz7saSab3RWjjIT5V57xAGZpSMEhUDoMg98ooiK2zwdLuzhi9MUZA2KmRqd9
	VtsUXlNA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uB7DP-0031dW-0a;
	Sat, 03 May 2025 15:23:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 03 May 2025 15:23:15 +0800
Date: Sat, 3 May 2025 15:23:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zurab Kvachadze <zurabid2016@gmail.com>
Cc: dash@vger.kernel.org, zurabid2016@gmail.com
Subject: Re: [PATCH 2/2] expand: pmatch(): Fix buffer overread caused by
 passing array of chars as string
Message-ID: <aBXEY2ajXTaqzNYS@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429214732.22390-3-zurabid2016@gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Zurab Kvachadze <zurabid2016@gmail.com> wrote:
> strpbrk() accepts two null-terminated string arguments. stop[] is char
> array that is not null-terminated but is still passed as a second
> argument to strpbrk. This causes buffer overread, which is detected by
> AddressSanitizer.
> 
> This commit adds an explicit null-terminated to the end of the array.
> 
> Signed-off-by: Zurab Kvachadze <zurabid2016@gmail.com>
> ---
> src/expand.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
