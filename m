From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: trap bug in recent versions of dash
Date: Sun, 28 Nov 2010 15:20:22 +0800
Message-ID: <20101128072022.GB8818@gondor.apana.org.au>
References: <20100811080616.GA18303@wopr.local.invalid> <20100815200551.GA19150@stack.nl> <20100816115154.GB11790@wopr.local.invalid> <20100822223227.GA49760@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:49347 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab0K1HUY (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 02:20:24 -0500
Content-Disposition: inline
In-Reply-To: <20100822223227.GA49760@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

On Sun, Aug 22, 2010 at 10:32:27PM +0000, Jilles Tjoelker wrote:
>
> diff --git a/src/eval.c b/src/eval.c
> index d5e5c95..e484bec 100644
> --- a/src/eval.c
> +++ b/src/eval.c
> @@ -307,9 +307,9 @@ setstatus:
>  		break;
>  	}
>  out:
> -	if ((checkexit & exitstatus) ||
> -	    (pendingsigs && dotrap()) ||
> -	    (flags & EV_EXIT))
> +	if (pendingsigs)
> +		dotrap();
> +	if ((flags & EV_EXIT) || (checkexit & exitstatus))
>  		exraise(EXEXIT);
>  }

Thanks, this is pretty much what I applied except that the set -e
check should be applied before dotraps (as was the case originally).
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
