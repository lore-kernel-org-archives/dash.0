Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D2517C
	for <dash@vger.kernel.org>; Sat, 20 Apr 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713572131; cv=none; b=RIEfGRVueUlKxpibmyP7ExyryP+s5TTRsDXLOLfImGKVbdyuXDvEWQR18bgWf00C0aaYZALpZ5aFWrZefAx4AnP3yXbK0ZIPZGhF/Zr7Lh5BkSvQYkDmx4cVrgpwLioAWxeolnnfUgKJrTOITIWqCVPY5/QSCvRHbMZUu2l4D4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713572131; c=relaxed/simple;
	bh=+FSxrixIxgFk5IR+XpSdjFv3QNBy1qAL91DnoZQlsNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qylArrkY+64aHQFeiDqRE2d9km1Sf/3uZrcPtsSNW1rkaJa8di3piZuUWU0eRHUZ86QsruBV9k4gbzIsNGTa0/0josAQlpiOs6PdMKFiIpAYqZ2ps+EUwYcQF//Nbt0oYt6Zy9dLiOIYK7VbeVgAgnbl+6Lh95z+yjP0utGH92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rxyO0-0047Qw-KB; Sat, 20 Apr 2024 08:15:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 20 Apr 2024 08:15:38 +0800
Date: Sat, 20 Apr 2024 08:15:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] redir: Use memfd_create instead of pipe
Message-ID: <ZiMJKhTAm5eyp7jO@gondor.apana.org.au>
References: <ZhuLCZfwRfflgv0v@gondor.apana.org.au>
 <20240419212446.GA24704@stack.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419212446.GA24704@stack.nl>

On Fri, Apr 19, 2024 at 11:24:46PM +0200, Jilles Tjoelker wrote:
>
> Using pipe or memfd conditionally based on the length of the
> here-document and whether memfd_create(2) fails transiently might cause
> even more obscure issues.

The reason is that memfd ends up being a lot slower than pipe.
Of course it's still way faster than fork + pipe, but until it
catches up with pipe, we're better off using both.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
