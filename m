From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [v3 PATCH] mktokens relative TMPDIR
Date: Fri, 15 May 2020 16:30:23 +1000
Message-ID: <20200515063023.GB28688@gondor.apana.org.au>
References: <m2k14k4kpx.fsf@pomona.edu>
 <20200429055923.GA17016@gondor.apana.org.au>
 <m21ro6w576.fsf@pomona.edu>
 <20200430025705.GA12900@gondor.apana.org.au>
 <m27dxxr7wq.fsf@pomona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:34374 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgEOGa2 (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 15 May 2020 02:30:28 -0400
Content-Disposition: inline
In-Reply-To: <m27dxxr7wq.fsf@pomona.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Michael Greenberg <michael.greenberg@pomona.edu>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On Wed, Apr 29, 2020 at 08:04:21PM -0700, Michael Greenberg wrote:
> The mktokens script fails when /tmp isn't writable (e.g., when building
> in a sandbox with a different TMPDIR). Replace absolute references to
> /tmp to relative references to TMPDIR. If TMPDIR is unset or null,
> default to /tmp.
> 
> The mkbuiltins script was already hardened to work relative to TMPDIR,
> also defaulting to /tmp.
> 
> v2 ensures that TMPDIR is quoted.
> v3 adds an extra quotation that prevents extra pathname expansions.
> 
> Signed-off-by: Michael Greenberg <michael.greenberg@pomona.edu>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
