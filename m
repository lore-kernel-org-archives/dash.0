From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [v2 PATCH] mktokens relative TMPDIR
Date: Thu, 30 Apr 2020 12:57:05 +1000
Message-ID: <20200430025705.GA12900@gondor.apana.org.au>
References: <m2k14k4kpx.fsf@pomona.edu>
 <20200429055923.GA17016@gondor.apana.org.au>
 <m21ro6w576.fsf@pomona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:59440 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD3C5I (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 29 Apr 2020 22:57:08 -0400
Content-Disposition: inline
In-Reply-To: <m21ro6w576.fsf@pomona.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Michael Greenberg <michael.greenberg@pomona.edu>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On Wed, Apr 29, 2020 at 10:51:41AM -0700, Michael Greenberg wrote:
> The mktokens script fails when /tmp isn't writable (e.g., when building
> in a sandbox with a different TMPDIR). Replace absolute references to
> /tmp to relative references to TMPDIR. If TMPDIR is unset or null,
> default to /tmp.
> 
> The mkbuiltins script was already hardened to work relative to TMPDIR,
> also defaulting to /tmp.
> 
> v2 ensures that TMPDIR is quoted.
> 
> Signed-off-by: Michael Greenberg <michael.greenberg@pomona.edu>
> 
> diff --git a/src/mktokens b/src/mktokens
> index cd52241..3ab7bc5 100644
> --- a/src/mktokens
> +++ b/src/mktokens
> @@ -37,7 +37,9 @@
>  # token marks the end of a list.  The third column is the name to print in
>  # error messages.
> 
> -cat > /tmp/ka$$ <<\!
> +: ${TMPDIR:=/tmp}

Could you quote this one too? Otherwise it could result in
unnecessary pattern expansion (e.g., someone does TMPDIR=/*/*/*).

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
