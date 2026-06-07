Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0B1A6813
	for <dash@vger.kernel.org>; Sun,  7 Jun 2026 05:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780809948; cv=none; b=CmgY5JPhWbensQ+RTBNVWIzg7axm5KMO6RRXlOCnNktCapA7XSTsHtEkK1ktZzvy8yh8xhUPrKC1RH5/ehe8OPffCn5H0L4KxCjptsm70CG7Y3mNS67JEhRAgKq3XJ/HrzfxXllbkWYFuk44YlN3/JgXhyxX5VFvbJPcE3ak2gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780809948; c=relaxed/simple;
	bh=ZZpP/l+CiKxGaowaBcS3CLjcQzoclBTvyu2u6k7zxaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IIN9FQ2ybVVEdSAB6moIsoop/lef8U7bY8+E5Gs0SgO54Npuxbfw4w00LDtvdKdQ7mki1mozkd9t4gb/nLDCsnkGazsJ5nq7sYOZ70dlp0JXO3quXDn68yoit3BMasIlLSKUe1yOHytSVyxNIvHjNoKAtOSTrhh+TtXr/WMnrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=rgRuXXzm; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="rgRuXXzm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=FmJI46j2B88iihbFh1mATTSKx4zXzzRwpK92BEfvYE4=; b=rgRuXXzmR3W0QNEOik4LPgVCCC
	5wusugvXPX4dUoFrF9DUm+8JmFDvUFQfpzzQGyGYVeyI4t/RfaFvXnMXRAXpi9BSA1merYJ3VqYgj
	G3fd+Mbpwuh9HwL4Sfwf5MQIRk/vo15Id1H0F5LyptxH848RRZZy8Y9RPO1ghfw0KE24eGZZJpwJE
	WXeflu00pbR1Ez2UTKxnylszBuIYt9u6XJ2lkyVBCetUdKvMlaRuii7dTud2WReLnzVZAtPDtAnUR
	xMahLmZv2RcnYlfgY1C/xdpyOiCN+wK5X5KuMht0entfY0RjVEmr3C5eOCt4SDUcgNbpga2Wny+Am
	kaRr9sbg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wW611-003CKG-0b;
	Sun, 07 Jun 2026 13:25:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 07 Jun 2026 13:25:43 +0800
Date: Sun, 7 Jun 2026 13:25:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?iso-8859-1?Q?S=E9bastien?= Peterson-Boudreau <seb@stien.dev>
Cc: dash@vger.kernel.org, seb@stien.dev
Subject: Re: [PATCH] Use proper grave accent character
Message-ID: <aiUA190Dn3FWwWcw@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601045303.13750-1-seb@stien.dev>
X-Newsgroups: apana.lists.os.linux.dash

Sébastien Peterson-Boudreau <seb@stien.dev> wrote:
> In the troff(7) (may be groff(7) on your system) input language, the
> ascii grave accent (backtick) character is interpreted as a left
> typographers quotation on output devices that support it. Likewise, a '
> is interpreted as a right quotation.
> 
> IOW, if your terminal supports unicode (along with some other
> variables..),
> 
>        `command`
> 
> in dash.1 can end up being displayed as
> 
>        ‘command‘
> 
> which is not the input the shell expects, and so a user following
> examples in the manual will be very confused.
> 
> The way to typeset the grave accent character as it most likely
> appears on your keyboard, the character the shell expects for command
> expansion, you must use the troff character \(ga
> ---
> src/dash.1 | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
