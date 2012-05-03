From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: wait and ctrl+Z
Date: Fri, 4 May 2012 07:51:22 +1000
Message-ID: <20120503215122.GA2885@gondor.apana.org.au>
References: <alpine.DEB.2.02.1204201316550.2583@laptop-mg.saclay.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from sting.hengli.com.au ([178.18.18.71]:50997 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754455Ab2ECVv0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 3 May 2012 17:51:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1204201316550.2583@laptop-mg.saclay.inria.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Marc Glisse <marc.glisse@inria.fr>
Cc: dash@vger.kernel.org

Marc Glisse <marc.glisse@inria.fr> wrote:
> Hello,
> 
> I noticed a strange behavior of "wait" when I suspend and resume a script.
> 
> $ cat a.sh
> #!/bin/dash
> (sleep 7; echo blah) &
> (sleep 7; echo bloh) &
> wait ; echo coucou
> $ ./a.sh
> ^Z
> zsh: suspended  ./a.sh
> $ fg
> [1]  + continued  ./a.sh
> coucou
> $ blah
> bloh
> 
> As you can see, the instruction after "wait" was executed immediatly on 
> resume, without waiting for the jobs.
> 
> If I replace the ';' after "wait" by "&&" and do the same suspend+resume, 
> "coucou" is never printed.
> 
> I am using dash version 0.5.7-3 in debian testing.

That's normal as wait was interrupted by a signal.  If you want
to wait even after an interruption, you should check the return
value of wait.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
