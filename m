Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568D35893
	for <dash@vger.kernel.org>; Sat, 20 Jun 2026 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781933209; cv=none; b=o2pLaYb4PMk+b0ry/JvuLms8x7AXWaqW/EuisYB/0gb3PliWA6mWk0w5qqvgPdJKu5D8tY7RRYImmhgZswRqIjo16FjAmF5vMWerA6nV5fGm8SXh1hUhJL1dLL+bg4cQ6CL40STZm+p2Hu02riBq/nu0rfvmEDdGtNmHcud8IUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781933209; c=relaxed/simple;
	bh=ypv8mXuGXIEcurgXjM12iLPrUZnWJfT8IWWtDP0RsM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=daOEbaUJZkN2LnKdjbaQo7iNtrUZKtkz5AmXqtmkCRN2O+EqR9PCbp1RpG5IehmZMR8G0hYJiRXcqt0GyxcenVb/gWEDwDFAnLS4wCueWjizMo3pWcN3Qc6Q9KR8s28X9qma3ruKmVHcNcCUyWo5PawEgsNx1b7PNp8C6h8Irno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=gmv3nDBd; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="gmv3nDBd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=Ot5OfAC4EZx+ONkuT2sUm89neBxaBCxlq5GA9InBf6k=; b=gmv3nDBdIlv8BEc/TkYdT3i3az
	Yz2eN1eazKs0ziKGT5PENdzxka+rJ57zMkHeloeEUJ6ZlpuUXd26e1p8tUrjWEdZ+yaH5E/Qx8WGJ
	iWNQi10fEqw9DmuNwyEpbBMuktlvGZp+dd680jECSIFRvOhPkkz2t5JS5eQ7FSBZC8rTIqspsk91F
	USJEhuVmd2zix4C9r0RLZtHPo7ynN5wVT5j3wxs8/il7ZW6IreT/1Qwhg3Dwot/kJws6UlDJ6D8t9
	hummBRyk9DTPSm1xCWUGaNyEtd13kImcWg5vkAAS3ao98cV350nVdFt/lhwFlPNsKXdMnSuJ3oeRT
	lz42Kp+Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1waoDy-00000006ozJ-32h3;
	Sat, 20 Jun 2026 13:26:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 20 Jun 2026 13:26:34 +0800
Date: Sat, 20 Jun 2026 13:26:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kerin Millar <kfm@plushkava.net>
Cc: dash@vger.kernel.org, sam@gentoo.org
Subject: Re: The read builtin erroneously consumes null bytes
Message-ID: <ajYkiqisEQHQtmf5@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf5516e9-e59f-444a-81c6-7b112b71563a@app.fastmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Kerin Millar <kfm@plushkava.net> wrote:
> Hi,
> 
> Consider the following test case. It demonstrates NUL being consumed by the read builtin, rather than by cat(1) as it should have been.
> 
> $ printf 'a\n\0bc' | dash -c 'read x; cat' | od -An -t x1 -c
>  62  63
>   b   c
> 
> This defect may be attributable to https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/input.c?h=v0.5.13.4#n411.
> 
> Incidentally, it results in tests #5510, #5558 and #6020 failing for git v2.54.0.

Is this a regression? If so please bisect it to the commit that
introduced it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
