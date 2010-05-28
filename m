From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Job control bug in revision 3800d4934391b,
Date: Fri, 28 May 2010 14:53:16 +1000
Message-ID: <20100528045316.GA18560@gondor.apana.org.au>
References: <20100527202157.08a1fa53@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:33706 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750915Ab0E1ExT (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 28 May 2010 00:53:19 -0400
Content-Disposition: inline
In-Reply-To: <20100527202157.08a1fa53@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kris Maglione <maglione.k@gmail.com>
Cc: dash@vger.kernel.org

Kris Maglione <maglione.k@gmail.com> wrote:
> 
> I'm not sure how to describe this bug, but it's affected one of my
> scripts, and those of several of my users. Basically, we've had loops
> dieing when backgrounded programs exit. This is the simplest test case
> I can come up with:
> 
> #!/bin/dash
> {
>        echo foo
>        sleep 1
>        echo foo
>        echo done>/dev/tty
> } | while read p; do
>        ( echo good & ) &
> done
> echo done
> 
> 
> In versions prior to 3800d4934391b, the output would
> "good\ndone\ndone\ngood" (or some permutation thereof depending on
> system load), but from 3800d4934391b on, it's "good\ndone".

This should be fixed by the patch that I posted yesterday.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
