From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] expand: Fix trailing newlines processing in backquote
 expanding
Date: Mon, 20 Jan 2020 17:56:20 +0800
Message-ID: <20200120095620.aejcnfr74q7cbn37@gondor.apana.org.au>
References: <20190429141337.6804-1-n.merinov@inango-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:35840 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgATJ4W (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 20 Jan 2020 04:56:22 -0500
Content-Disposition: inline
In-Reply-To: <20190429141337.6804-1-n.merinov@inango-systems.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Nikolai Merinov <n.merinov@inango-systems.com>
Cc: dash@vger.kernel.org, os@inango-systems.com

On Mon, Apr 29, 2019 at 07:13:37PM +0500, Nikolai Merinov wrote:
> According to POSIX.1-2008 we should remove newlines only at the end of
> the substitution. Newlines-only substitions causes dash to remove
> newlines before beggining of the substitution. The following code:
> 
>     cat <<END
>     1
>     $(echo "")
>     2
>     END
> 
> prints "1<newline>2" instead of expected "1<newline><newline>2".
> 
> This patch fixes trailing newlines processing in backquote expanding.
> 
> Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
> ---
>  src/expand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
