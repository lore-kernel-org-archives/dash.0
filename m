Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72471C0DF3
	for <dash@vger.kernel.org>; Sun,  7 Apr 2024 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712467255; cv=none; b=cnx1MvV3I5jN+WhXtyseWapsdhKlngQNBHCLFDvHm86Fr50zZkZMKoyuNMTa4s9YWNG8NGFkP71vQrMRpKjab8u2v/pzcVIx5S107q1M4VBgjFWrfDEMdO81L95Wb04ORATjld/OMGIZ8a7LbfHukDGnXUQRJdjzd7OVIZFw0aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712467255; c=relaxed/simple;
	bh=XB6Xn0ssLc4omFJfjOnyPK+/kjTvEw5e/+xbNhIw1R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR+8Aj0koPMkMF0HVJFq1XVT2mfN/8TIjxwjn3qdsgCQqh1HWyYBHP/Te376NGoblwzYiMWo7RdnXIIeecA27584rzISycm6+GAazLpwbUNjESg8NIzgZI1kEnExJUBmIQqFjS0Csa2M3ND1rSeIk9mHCYaaR65TTPSMttgezNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rtKxR-00G7Qm-C5; Sun, 07 Apr 2024 13:20:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 07 Apr 2024 13:21:02 +0800
Date: Sun, 7 Apr 2024 13:21:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Steffen Nurpmeso <steffen@sdaoden.eu>
Cc: dash@vger.kernel.org, Ganael Laplanche <ganael.laplanche@martymac.org>,
	Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] Allow enabling job control without a tty in
 non-interactive mode..
Message-ID: <ZhItPuyxuuI8d9Tr@gondor.apana.org.au>
References: <dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu>
 <ZhD4JcqNct+rmxca@gondor.apana.org.au>
 <20240406230704.Tr-SBJb2@steffen%sdaoden.eu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406230704.Tr-SBJb2@steffen%sdaoden.eu>

On Sun, Apr 07, 2024 at 01:07:04AM +0200, Steffen Nurpmeso wrote:
> Herbert Xu wrote in
>  <ZhD4JcqNct+rmxca@gondor.apana.org.au>:
>  |On Mon, Jan 30, 2023 at 10:15:40PM +0100, Steffen Nurpmeso wrote:
>  |> This is a take-over of the FreeBSD bin/sh
>  |> 
>  |>   commit cd60e2c67d52e1f957841af19128c7227880743a
>  |>   Author:     Jilles Tjoelker <jilles@FreeBSD.org>
>  |>   AuthorDate: 2014-09-04 21:48:33 +0000
>  |>   Commit:     Jilles Tjoelker <jilles@FreeBSD.org>
>  |>   CommitDate: 2014-09-04 21:48:33 +0000
>  |> 
>  |>       sh: Allow enabling job control without a tty in non-interactive \
>  |>       mode.
>  |> 
>  |>       If no tty is available, 'set -m' is still useful to put jobs \
>  |>       in their own
>  |>       process groups.
>  |
>  |I don't see why dash needs this.  Please keep in mind that one
>  |of the primary goals of dash it to be minimal.
> 
> Isn't that standardized answer a bit misplaced for that patch?
> It was about Ganael Laplanche having problems with creating
> process groups in backgrounded jobs (2023-01-12):

Sorry, I'd lost the context to the original discussion.  I'll
look into your patch again.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
