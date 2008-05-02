From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash regression against klibc
Date: Fri, 2 May 2008 13:25:30 +0800
Message-ID: <20080502052530.GA15890@gondor.apana.org.au>
References: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:33720 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751806AbYEBFZd (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 May 2008 01:25:33 -0400
Content-Disposition: inline
In-Reply-To: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan McGee <dan@archlinux.org>
Cc: dash@vger.kernel.org

On Thu, May 01, 2008 at 12:25:58PM -0500, Dan McGee wrote:
> I wanted to let you know of an issue one of our users discovered with
> dash compiled against klibc- working directory lookups appear to be an
> issue in a clean environment:
> http://bugs.archlinux.org/task/10327
> 
> What is interesting is it works fine if you just run dash from within
> bash- it only fails as seen there if you run using the 'env -'
> wrapper.
> 
> If you want me to look into this and/or help out with a fix, let me
> know. Thanks!

Could you please run it under ltrace and send us the output?
Something like

env - ltrace /bin/dash -c pwd

should do the trick.

I suspect the problem is klibc's getcwd implementation but this
should confirm it for us.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
