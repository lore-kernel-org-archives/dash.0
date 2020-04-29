From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Remove poplocalvars() always-zero argument, make it
 static
Date: Wed, 29 Apr 2020 16:07:51 +1000
Message-ID: <20200429060751.GA27009@gondor.apana.org.au>
References: <20200219163913.11951-1-dvlasenk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:52310 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgD2GHy (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 29 Apr 2020 02:07:54 -0400
Content-Disposition: inline
In-Reply-To: <20200219163913.11951-1-dvlasenk@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: dash@vger.kernel.org

On Wed, Feb 19, 2020 at 05:39:13PM +0100, Denys Vlasenko wrote:
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> ---
>  src/var.c | 24 ++++--------------------
>  src/var.h |  1 -
>  2 files changed, 4 insertions(+), 21 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
