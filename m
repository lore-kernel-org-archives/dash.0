Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573442628D
	for <dash@vger.kernel.org>; Mon, 11 Aug 2025 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754888458; cv=none; b=OCXOxnHf1FJt05O6RGbgfJXpQ11U14GAr7aA2DRyy0ur5bGp9xGDs2qAfw2ojAliC3H/QWurWHfnAZZJB/rO/SGhWi5alF7v8RbhmH4iVkEGxy6ASYe6dl9Jv31zV2PxXYJTg48+8kXGlv7VDkyByaRGHOfbLnA3zYrG3Q37dlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754888458; c=relaxed/simple;
	bh=EP0EMGdzIdwbhzSrkThyf/fQuYLwsUr6FjXWtv50rRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbyMONwS+faSbLR81Vxfo9JgNiovido+eLJcU1MYB6gQLKXwWE1lL2OUr5ZKuDJWU5CU7umboUJJ0tHwzQ6zpzzE7/tO4js9Am1PrbiKRRSCp+MzUfD4Z+F8w67rzOwRz+0dxAvlVsKfIRf3cDRi6XyOmJ6T7XoeGxAbkOOflRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Zw/JOKvw; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Zw/JOKvw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dhLdD9+v/ssYnfjIkoc5bMOscSmzKjmZLa/mpHBiL/k=; b=Zw/JOKvwUiR8lKzUqX+FjKhOLM
	4gocJ7O21E6840Ig7q1R5Xvutj30XYwtWrWctmg5MRNsXPYwU06QTc3BZAF618QuSIIen/Sk/T9D8
	EUlWQ3g3AvbGMdsOjDoIrMlbBXSjPTCCUdl7rMd8Bf5jyhFayTIBkig7CY5wJsjHxSNyxWUstI0Nd
	SJFOLXquZiGQykfmrC3kggNNJZ5gJf5KN/XZoBL3plffskWviOl8J4iBC8t7ytPmgT/w9400CcZ1D
	3ujCD3Zavtv5UK9MmJ3xzTMnRwVmLxI30anbmfPewDrHNJ3uisPlBoMF0xwX8akTaVCeuNUXyKIwP
	GhMH7U5Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ulKOv-00D9b5-1H;
	Mon, 11 Aug 2025 13:00:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 11 Aug 2025 13:00:45 +0800
Date: Mon, 11 Aug 2025 13:00:45 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org
Subject: Re: Looking at "int vforked" in signal handler is racy
Message-ID: <aJl4_WsQeHF6PI0N@gondor.apana.org.au>
References: <dadfa485-b5ee-30d7-7154-362cf2eb04cd@redhat.com>
 <031e429e-e20c-4856-91dd-aedef155aae5@gigawatt.nl>
 <559d8542-bda1-15a0-2e68-9b3ea04db2e7@redhat.com>
 <b6a063f8-9844-4f81-90a8-0f65e7c819bf@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a063f8-9844-4f81-90a8-0f65e7c819bf@gigawatt.nl>

On Sun, Aug 10, 2025 at 11:20:40PM +0100, Harald van Dijk wrote:
>
> That approach seems solid to me at a very quick glance. I think you don't
> even need separate have_vfork_sibling and vfork_parent_pid variables, just
> make the existing vforked variable a pid, or 0. A mostly untested patch
> using that:

Looks good to me.  Could you turn this into a patch please? If
you could run some quick speed tests on this versus the existing
code that would be even better :)

> I do wonder if the use of vforked in a signal handler, even in current dash,
> would require the use of volatile to ensure no compiler optimisations mess
> with it, but I think that is not affected by this patch. If it is necessary,
> it is already necessary now, and if it is not necessary now, it will not
> become necessary with this patch.

Yes vfork should be marked as volatile.  Although being a global
variable means that there shouldn't be any practical difference.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
