Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E55BC3A5A7
	for <linux-dash@archiver.kernel.org>; Tue,  6 Dec 2022 03:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiLFDxQ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 5 Dec 2022 22:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiLFDxP (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 5 Dec 2022 22:53:15 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4217BDF93
        for <dash@vger.kernel.org>; Mon,  5 Dec 2022 19:53:14 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2P15-004KzE-31; Tue, 06 Dec 2022 11:53:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 06 Dec 2022 11:53:11 +0800
Date:   Tue, 6 Dec 2022 11:53:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Alex Gorinson <algore3698@gmail.com>, dash@vger.kernel.org
Subject: Re: [v2 PATCH] expand: Add ifsfree to expand to fix a logic error
 that causes a buffer over-read
Message-ID: <Y468pyawHplC+k8B@gondor.apana.org.au>
References: <CAOKKkHc=bt4p1d4hMzFbQeE14mZJJ7d1REpJ-D_BQD02re1Pdw@mail.gmail.com>
 <Y44H6WLH/b/6+Dey@gondor.apana.org.au>
 <2f8aff20-ed7f-ee61-9f3d-b7e649cbe56d@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8aff20-ed7f-ee61-9f3d-b7e649cbe56d@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Dec 05, 2022 at 03:24:22PM +0000, Harald van Dijk wrote:
>
> FWIW, the possibility of other sh_error calls being overlooked is why I
> ended up doing it differently myself: I ended up with exverror() calling
> ifsfree(). It is a smaller change than this; it works because there is
> currently no case where preserving IFS regions after an error is wanted
> anyway, and I cannot imagine a future change that would change that. But it
> is possible that my imagination is lacking there.
> 
> Q: If exception != EXERROR, longjmp() is called without first calling
> ifsfree(), leaving IFS regions in place for a higher level to deal with. If
> execution ultimately ends up at exitreset(), which calls ifsfree() anyway,
> that is fine. Is that guaranteed to always be the case?

Yes I've checked all the setjmp spots for this.

Longer time we should do away with the global variables and change
the sh_error paradigm to one of direct error returns.  Then we can
simply handle this in expandarg itself.

We could do it now too of course by just adding a setjmp there.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
