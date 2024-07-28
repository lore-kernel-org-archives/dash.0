Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1426E4A05
	for <dash@vger.kernel.org>; Sun, 28 Jul 2024 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722136089; cv=none; b=d0FXZLAhIM94L7vZIIbGTje8eJcjDA1mz40yLJq4eINqAKPi7WUOZhvfPEui/2JLxKUSiSU9hAphkZJl03CLICzBD3nUUFDm2i5IBF6/VRp3qfK0UwboiTeb61o3Aa48oD0SNklcU6VamljAxRA/GFz9G6dy5fbG+oFEvxI2mz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722136089; c=relaxed/simple;
	bh=stwg+sbYacMpCFS5Z51Ug6mxFr/VSMsMTy5tusZSAds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDhN+/0FVWd/jDJschCZ5Gi0vhXNYKCnkAehiJiWumyMNwaIiia1CvsElYyDZHW0L68LcwcgIiH+gpCGnPI9HPh95PEMzpbB1D+EPoxBiNI1T5erbB/ghKFYmK0XsI4wvwqg3EmneJ23EXCKLoEfib7ppujfBg5+0F6/DOctULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sXu7x-000e2T-0A;
	Sun, 28 Jul 2024 11:08:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Jul 2024 11:08:02 +0800
Date: Sun, 28 Jul 2024 11:08:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH v2] bltin/test: align -nt and -ot with POSIX.1-2024
Message-ID: <ZqW2EsFB5i5ZUz7n@gondor.apana.org.au>
References: <ZqWuqe25h-VkDqnj@gondor.apana.org.au>
 <cvvclqjh5f7lkvwzrcv4akogr3ko7bqdwqilrw5rslebgovdyh@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cvvclqjh5f7lkvwzrcv4akogr3ko7bqdwqilrw5rslebgovdyh@tarta.nabijaczleweli.xyz>

On Sun, Jul 28, 2024 at 04:42:52AM +0200, наб wrote:
> 117027  pathname1 −nt pathname2
> 117028    True if pathname1 resolves to an existing file and pathname2 cannot be resolved, or if
> 117029    both resolve to existing files and pathname1 is newer than pathname2 according to
> 117030    their last data modification timestamps; otherwise, false.
> 117031  pathname1 −ot pathname2
> 117032    True if pathname2 resolves to an existing file and pathname1 cannot be resolved, or if
> 117033    both resolve to existing files and pathname1 is older than pathname2 according to
> 117034    their last data modification timestamps; otherwise, false.
> 
> The correct output is
>   $ [ 2024 -nt 2023 ] && echo yes
>   yes
>   $ [ 2023 -nt 2024 ] && echo yes
>   $ [ 2023 -nt ENOENT ] && echo yes
>   yes
>   $ [ ENOENT -nt 2024 ] && echo yes
> and
>   $ [ 2024 -ot 2023 ] && echo yes
>   $ [ 2023 -ot 2024 ] && echo yes
>   yes
>   $ [ 2023 -ot ENOENT ] && echo yes
>   $ [ ENOENT -ot 2024 ] && echo yes
>   yes
> but dash currently returned only the first yes out of both blocks.
> ---
>  src/bltin/test.c | 31 +++++++++++++++++--------------
>  src/dash.1       | 14 ++++++++++++--
>  2 files changed, 29 insertions(+), 16 deletions(-)

Patch applied with newerf/olderf changed to return bool, header
sorting and some reformatting of the time comparisons.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
