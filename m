From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Job control bug in revision 3800d4934391b,
Date: Sat, 29 May 2010 08:43:34 +1000
Message-ID: <20100528224334.GA26879@gondor.apana.org.au>
References: <20100528153423.GA3885@jg.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:37039 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751121Ab0E1Wnj (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 28 May 2010 18:43:39 -0400
Content-Disposition: inline
In-Reply-To: <20100528153423.GA3885@jg.home>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Kris Maglione <maglione.k@gmail.com>
Cc: dash@vger.kernel.org

Kris Maglione <maglione.k@gmail.com> wrote:
>
> I should have mentioned that I tested it with every revision 
> upto and including that one (especially as it looked promising).
> 
> I definitely still have this problem as of 
> 207e4c2a322fe: [JOBS] Fix wait regression where it does not wait for all jobs  master 

Hmm, I can't reproduce this here at all.  Can you please run it
with strace -f and send the result to us?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
