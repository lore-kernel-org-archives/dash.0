From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Program flow corruption involving 'command .' and an invalid
 expansion
Date: Mon, 20 Jan 2020 18:02:54 +0800
Message-ID: <20200120100254.sae75vhaovaqnu6k@gondor.apana.org.au>
References: <cd5f5782-428b-a976-10c6-415265b377ae@inlv.org>
 <16187f8b-b3b2-3ef3-993c-ff6f2cb3408e@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:36128 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgATKDB (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 20 Jan 2020 05:03:01 -0500
Content-Disposition: inline
In-Reply-To: <16187f8b-b3b2-3ef3-993c-ff6f2cb3408e@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Martijn Dekker <martijn@inlv.org>, DASH shell mailing list <dash@vger.kernel.org>

On Fri, Nov 08, 2019 at 11:21:00PM +0000, Harald van Dijk wrote:
>
> This is another manifestation of the bug you reported in January, e-mail
> thread "[BUG] dash hangs on 'eval' syntax error in dot script". Herbert Xu's
> patch there helps with this new test case too, even if as I reported at the
> time, I personally do not consider it a complete fix. Nothing has been
> pushed to the git repository though.

I think this was fixed by

	https://patchwork.kernel.org/patch/10837039/

but I forgot to push it out when I applied it.  It is pushed out
now so if it still doesn't work please let me know.

commit 02a00569ba60e502f876c36d894ba0cc2d0682b3
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Mar 3 21:57:50 2019 +0800

    eval: Reset handler when entering a subshell

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
