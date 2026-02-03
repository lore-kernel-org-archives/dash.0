Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128330FF29
	for <dash@vger.kernel.org>; Tue,  3 Feb 2026 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098216; cv=none; b=WrbMaHAzBEE8hDuVjcx6YwAPHyaQ5JlOIMx1/aTeO+17YSyCdUoTE9WRBWgOyjXCyDR9PS9Gyy4VmEXWKXodro4laCmdGQzAq/yUtkGIyNOHJS8d3J4jfIIG1QLFmhiFCZ85iCse598YvzpUuH4tWoC5ylGANy503tFQ1txJx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098216; c=relaxed/simple;
	bh=sHl9ZgATbgW3DsTbWOr+zDGuZW2CF724xUNTmfbUI2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q6DSyJKb/Zp5KrPyeetINClzQR0wIWne7bdFaPTxZSLRHdvTV97T3KAtU4JjFYIdpXM5axj6sTRU6XZSlu28yYfqmbyfu9n+uA7xHLXMd7ywUaXaiEA4VxUIrbWYjK3yGC5PpJNraAuQ39P38x9QB9VqR/2URzMtiaVWzF/kZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=iCE1B8gV; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="iCE1B8gV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=xnwX4kfSF9BUT7aYjs8ciwKGSt5HVQss+DEhTTgxCQg=; b=iCE1B8gViuReqmXhdPwikLmFWW
	2RMhc8c/oqi3FXJSi6+lNKqNh1qLt7y52p/4Rs8zAsuWaZR7sMY6gHom50jnlxNaIOcRzTrVRatQD
	FGxROWJDuQ8HB5ooj8N5L+fqD5/1WlbE+c1DWYQZyK0fOAPxOoLgdX/EF1JJbI44yPubZr0VNn9Ec
	0oZHWUGswYnsiPFaZup6RT7ETF76WdDeTmSttJCs42NYWpgh5gtoqBrPeGiOZ8jKSRy7s8SH0ofvX
	CDrKt0tKLovRmI+sTUuZYY7Jt/HyxlVNv4nDx8Ky8Rhirr3ioFn/+2yKjoqvKjjNnxK/ZO7ZnSWKu
	dsEvb/7w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vn9P7-0045B4-0I;
	Tue, 03 Feb 2026 13:56:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Feb 2026 13:56:49 +0800
Date: Tue, 3 Feb 2026 13:56:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jyri-Matti =?iso-8859-1?Q?L=E4hteenm=E4ki?= <jyri-matti@lahteenmaki.net>
Cc: dash@vger.kernel.org
Subject: Re: Fwd: Behavior change in Dash pipes/read?
Message-ID: <aYGOISV50n322VNF@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhYXO8svGM48o5kUGcBzcU6+ZuVzT1SynMU3Kpphvt7=P7a3Q@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Jyri-Matti Lähteenmäki <jyri-matti@lahteenmaki.net> wrote:
> 
> it seems that one does not simply run strace on a mac, and I'm
> certainly not an expert. Please let me know if you have an exact
> command to run (without disabling SIP).
> But I got these (among other stuff) with the Instruments GUI tool, one
> for 0.5.12 and another for 0.5.13.1
> Are these what you needed?
> If you have the tools to read the 24MB dump it generated, It's online
> in https://lahteenmaki.net/test.trace.zip

Sorry but I can't make sense of the output.

In another email someone mentioned that this worked for them on mac:

https://github.com/Mic92/strace-macos

Could you give it a go?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
