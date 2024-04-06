Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C61C697
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712388124; cv=none; b=N3d2txhCGr7iSR3R2DYpICuN8aXRE+VQAFFS9Bzvt3kGyYD/0a1koSODLfuAOHE78S4txuAFTY2oKASvFSY/EUQZHU4dic1gCQ0pTNe2vsrQ6SIXe6lLK1BFk/hQpfaSjZluc+sSUZNv4HBh+7zUXxHT5TqgBLphdIKI5g74CKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712388124; c=relaxed/simple;
	bh=BToMUXT/1WPOFPf45M3K5YZCm64cEmuaQNcgBhji3WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgFCP1OABCh6D/FeJjyIF4cgYqGiaRYustbwSeF1X9yvQ47A5pXnSS1+87ZZkG5nJ1tOuaJKozJ+HOmmCZ7bjq+SiaNFf9GhJfctoO2cPr3bDU30p7S2VoYBQ3tfYpqTmK7J9kX/IIEEuCeu+Zu6g6h4CacyTZffz7+8GxctXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rt0NA-00FqH5-8t; Sat, 06 Apr 2024 15:21:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Apr 2024 15:22:13 +0800
Date: Sat, 6 Apr 2024 15:22:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Steffen Nurpmeso <steffen@sdaoden.eu>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Allow enabling job control without a tty in
 non-interactive mode..
Message-ID: <ZhD4JcqNct+rmxca@gondor.apana.org.au>
References: <dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu>

On Mon, Jan 30, 2023 at 10:15:40PM +0100, Steffen Nurpmeso wrote:
> This is a take-over of the FreeBSD bin/sh
> 
>   commit cd60e2c67d52e1f957841af19128c7227880743a
>   Author:     Jilles Tjoelker <jilles@FreeBSD.org>
>   AuthorDate: 2014-09-04 21:48:33 +0000
>   Commit:     Jilles Tjoelker <jilles@FreeBSD.org>
>   CommitDate: 2014-09-04 21:48:33 +0000
> 
>       sh: Allow enabling job control without a tty in non-interactive mode.
> 
>       If no tty is available, 'set -m' is still useful to put jobs in their own
>       process groups.

I don't see why dash needs this.  Please keep in mind that one
of the primary goals of dash it to be minimal.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
