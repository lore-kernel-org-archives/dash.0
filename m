From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 2/2] [BUILTIN] respect eventual TMPDIR set
Date: Fri, 2 Apr 2010 13:03:51 +0800
Message-ID: <20100402050351.GB28307@gondor.apana.org.au>
References: <1269213818-23910-1-git-send-email-max@stro.at> <1269213818-23910-2-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:36123 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757938Ab0DBFZ3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 Apr 2010 01:25:29 -0400
Content-Disposition: inline
In-Reply-To: <1269213818-23910-2-git-send-email-max@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: dash@vger.kernel.org

On Mon, Mar 22, 2010 at 12:23:38AM +0100, maximilian attems wrote:
> From: Herbert Xu <herbert@gondor.apana.org.au>
> 
> while merging upstream dash in klibc,
> noticed that klibc dash had grown that useful feature.
> 
> Signed-off-by: maximilian attems <max@stro.at>

Patch applied.  BTW, please cc dash@vger.kernel.org on all patch
submissions.

Thanks,

> ---
>  src/mkbuiltins |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/mkbuiltins b/src/mkbuiltins
> index 064cb76..e38ce4c 100644
> --- a/src/mkbuiltins
> +++ b/src/mkbuiltins
> @@ -37,7 +37,7 @@
>  
>  tempfile=tempfile
>  if ! type tempfile > /dev/null 2>&1; then
> -	tempfile='mktemp /tmp/mkbuiltins.XXXXXX'
> +	tempfile="mktemp ${TMPDIR:-/tmp}/builtin.XXXXXX"
>  fi
>  
>  trap 'rm -f $temp $temp2' EXIT
> -- 
> 1.7.0.2
> 

-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
