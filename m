From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Rename DOWAIT_NORMAL to DOWAIT_NONBLOCK
Date: Wed, 29 Apr 2020 16:07:35 +1000
Message-ID: <20200429060735.GA29645@gondor.apana.org.au>
References: <20200219103008.22230-1-dvlasenk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:52304 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgD2GHj (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 29 Apr 2020 02:07:39 -0400
Content-Disposition: inline
In-Reply-To: <20200219103008.22230-1-dvlasenk@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: dash@vger.kernel.org

On Wed, Feb 19, 2020 at 11:30:08AM +0100, Denys Vlasenko wrote:
> To make it clearer what it is doing: nonblocking wait()
> 
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> ---
>  src/jobs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
