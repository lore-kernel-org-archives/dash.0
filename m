Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7814F70
	for <dash@vger.kernel.org>; Sun, 10 May 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778406072; cv=none; b=iXLLIMPaKmXZef9jfaZwlRYUmjMWqpJGJuOXZWypAP418g/aogCDNQLpvHn9cDQU+mSvNAHFifzJZ40OvlIWzCTxgiWJBfCy78zz2X30XpBWg+wRri2B8cZw5uldQ+2SNkWDjQf0YU0+H6EaYJFU+C2s47y0uIMOH6/JmDd/EqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778406072; c=relaxed/simple;
	bh=EHdpzJ3hIREYrHlPrDIQMk8vdFOs3YVIKyIS1Mzro+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aUA7eUP6RnobkJ9z5zcPZ7bdFXoV2a9CBkGPL85JcQNFq4J3jqbjXynqUc6oKuU3Lqyf31D7erL0wwcmc74Tp2rav6VTCY1jYCN3n42ibvWiAUYtFh+jODaC1wX9n8XWC4iWJvQJa9OCDInwZhJkDbcPeesf/C4C8mzq6TI71P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=lHNnajJy; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="lHNnajJy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=yHKGnq7gkwsae96dDu8dIbFgQ7LWX16IzOmZB99cHg8=; b=lHNnajJyQiUI5AIcWdluXVpM5c
	MQUSexfV//Cc83pjf9sWCUZT/r3tbOpT4duOcePmYBg1IucS/vUkRK3BNLgF7Emx8TNmK2Q3p86dz
	aA8Mtv8nMfgJvtzF4Frlzoq/B6u3QDsjl/ayJ2wNMIT2KOblqYU+QTqmVXXPbHuLJzXJskzhNHMVm
	skkXCJvvcbz01AjsqclQm5B8+kYNmkgu41inOotgwv0KEIUiy8gjvyptYe2yF642NWZRcPqEUu6MV
	OM/TR/M6jdZVNCVLnk3RB428uqWEzXocgm5X5poLOhtGfN87FdGy2FZIPvNRTq6lmxU0xjKjOw22x
	otHHhezg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wM0eg-00CoXV-2g;
	Sun, 10 May 2026 17:40:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 10 May 2026 17:40:58 +0800
Date: Sun, 10 May 2026 17:40:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sebastien Peterson-Boudreau <sebastien.peterson.boudreau@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Use proper grave accent character
Message-ID: <agBSqlE8ZkrKmnIo@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af9681mqftmoCPdK@HQ>
X-Newsgroups: apana.lists.os.linux.dash

Sebastien Peterson-Boudreau <sebastien.peterson.boudreau@gmail.com> wrote:
>> Sorry could you please explain why this makes any difference because
>> they look identical to my untrained eye.
> 
> No worries! In the troff(7)* language, the character ` becomes a left
> quotation on typesetters supporting it, and ' becomes a right quotation.
> 
> IOW, if your terminal supports unicode (along with a few other variables),
> 
>        `command`
> 
> in the input code can end up being displayed as
> 
>        ‘command‘
> 
> which is not the input the shell expects!
> The way to typeset the ` character is with either the \` escape sequence
> or the \(ga character -- both should be portable across different
> *roff's according to groff_char(7), so I opted for the latter.

Thanks for the explanation.  Please repost the patch with this
explanation included in the description.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
