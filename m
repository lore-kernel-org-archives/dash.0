From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] mktokens relative TMPDIR
Date: Wed, 29 Apr 2020 15:59:24 +1000
Message-ID: <20200429055923.GA17016@gondor.apana.org.au>
References: <m2k14k4kpx.fsf@pomona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:52276 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgD2F71 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 29 Apr 2020 01:59:27 -0400
Content-Disposition: inline
In-Reply-To: <m2k14k4kpx.fsf@pomona.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Michael Greenberg <michael.greenberg@pomona.edu>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On Mon, Feb 17, 2020 at 07:50:50PM -0800, Michael Greenberg wrote:
> The mktokens script fails when /tmp isn't writable (e.g., when building
> in a sandbox with a different TMPDIR). Replace absolute references to
> /tmp to relative references to TMPDIR. If TMPDIR is unset or null,
> default to /tmp.
> 
> The mkbuiltins script was already hardened to work relative to TMPDIR,
> also defaulting to /tmp.
> 
> Signed-off-by: Michael Greenberg <michael.greenberg@pomona.edu>

Please make sure TMPDIR is quoted.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
