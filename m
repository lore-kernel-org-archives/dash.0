Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2202B30DEDC
	for <dash@vger.kernel.org>; Thu, 23 Oct 2025 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218989; cv=none; b=RDbJstc4CqUokEWrL3DEQCFXaO/LaeEvI8qn9luM3A3mo/DELgJMZ4mgUAtq9LY/szu8nlEPkYuSrEQvQ4xYHfc8oz66E6ZB+HSVmDTfRtAqCpfHNgYzbSocB8lDABe/DpRY+MlaL8tFlQtyC7w9Obeav2gsUWiiY8c+NQJWbOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218989; c=relaxed/simple;
	bh=9Uh9S7uN1FsqcXboc0wmNG1gvG4EV0v5GWnFOHuHfYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9VkIJ8jblDfCMUzVTEJoR1fzdBp99RgQoeRrBZgKThgvRPhVJn1YomDzqHiimLz/B09UcpbFicXM+aGQ4dl4f++vN1mkyQrW5lmcp64m8ED17h2S2F6Szzx+Ic4Cp9svxWE+CJXADT1U56bJhICueTvZeKbO4h1Eb8UuNFqbyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=fMD/rDcN; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="fMD/rDcN"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2DAF7240103
	for <dash@vger.kernel.org>; Thu, 23 Oct 2025 13:29:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1761218984; bh=R/mY5IGetxIP1/n0+3wCgrQIKXwrd/Gb1jadlbz7JRg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:From;
	b=fMD/rDcNehj4pBSrgX0rIYbjvC+lSG2IoLj5rUZPWty7sgd9vpE9kF8DQKIkpnLj2
	 WS4MNMbu9D7S/sjGVvsqyN6kOTRKI/+XnZBkVGSMynD+ToQABFV5r+SW5lkU+eoAAe
	 MTgDAg1HGmmvX+1ob7IrKIPgAczKi6r9WfV+URkdvLNeX0QYTNMrfQAduIj56T6V9s
	 7cxnMxNb0dxd5v8ZOmTjki711m06x+paII77r74Pdqd0NOuWKMxFfFGZf8Dd4iY7Gv
	 UlkJEbFibz2/Sjw74cXSCEBFI/zdJmE+sOyV7t5ft1u+hAsB+9SQiiPUEsXK+vhm3M
	 tjngeB3C9RlEw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cskMq4n0mz9rxM;
	Thu, 23 Oct 2025 13:29:43 +0200 (CEST)
Date: Thu, 23 Oct 2025 11:29:43 +0000
From: Juergen Daubert <j.daubert@posteo.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Dash <dash@vger.kernel.org>
Subject: Re: [PATCH] shell: Fix unsigned char promotion and truncation
Message-ID: <aPoRpuQWtKeQq5T-@jue>
References: <df9d5e861c3fc9bf6754fecc113616c1@posteo.de>
 <aPeKvExPB1HluHly@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPeKvExPB1HluHly@gondor.apana.org.au>

On Tue, Oct 21, 2025 at 09:29:32PM +0800, Herbert Xu wrote:
> On Mon, Oct 20, 2025 at 12:31:03PM +0000, j.daubert@posteo.de wrote:
> > We are using dash 0.5.13.1 as /bin/sh and running into several build
> > problems on ARM64,
> > for example curl:
> 
> Thanks for the report!
> 
> I can reproduce this and it appears to be a couple of instances of
> incorrect unsigned char (the default on arm64) promotion.
> 
> Please try this patch:

Thanks for the quick fix!

We've tested 0.5.13.1 together with that patch by building a lot of
important programs [1] with dash as /bin/sh and everything works fine 
now on x86_64 and ARM64. 

IMO we are at a stable point in the dash development again, looking
forward to see 0.5.14 ;)

Thanks again
Juergen


[1] https://git.crux.nu/ports/core


> 
> ---8<---
> When a char is promoted to an int, it needs to be signed as otherwise
> comparisons on it may fail.  Alternatively, an integer needs to be
> truncated to char before comparing it against another char.
> 
> Reported-by: Juergen Daubert <j.daubert@posteo.de> 
> Fixes: e878137f63e6 ("expand: Do not call rmescapes in expari")
> Fixes: c5bf9702ea11 ("expand: Add multi-byte support to pmatch")
> Fixes: 8f01c3796f0f ("[PARSER] Add FAKEEOFMARK for expandstr")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/src/expand.c b/src/expand.c
> index 912384d..8c8bf0e 100644
> --- a/src/expand.c
> +++ b/src/expand.c
> @@ -1914,7 +1914,7 @@ static int pmatch(char *pattern, const char *string)
>  			if (c == '?' || c == '[')
>  				c = CTLESC;
>  			for (;;) {
> -				if (c != CTLESC) {
> +				if (c != (char)CTLESC) {
>  					/* Stop should be null-terminated
>  					 * as it is passed as a string to
>  					 * strpbrk(3).
> @@ -1985,7 +1985,7 @@ static int pmatch(char *pattern, const char *string)
>  					p++;
>  					if (*p == (char)CTLESC)
>  						p++;
> -					else if (*p == CTLMBCHAR) {
> +					else if (*p == (char)CTLMBCHAR) {
>  						mbp = mbnext(p);
>  						p += mbp & 0xff;
>  						p += mbp >> 8;
> diff --git a/src/parser.c b/src/parser.c
> index eb402a7..5714958 100644
> --- a/src/parser.c
> +++ b/src/parser.c
> @@ -1240,7 +1240,7 @@ checkend: {
>  
>  		markloc = out - (char *)stackblock();
>  		for (p = eofmark; STPUTC(c, out), *p; p++) {
> -			if (c != *p)
> +			if (c != (signed char)*p)
>  				goto more_heredoc;
>  
>  			c = pgetc();
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 
