Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B5C61DA4
	for <linux-dash@archiver.kernel.org>; Thu,  9 Mar 2023 09:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCIJ4L (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 9 Mar 2023 04:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCIJ4K (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 9 Mar 2023 04:56:10 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C450B5FE9E
        for <dash@vger.kernel.org>; Thu,  9 Mar 2023 01:56:05 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paD03-0024hN-Io; Thu, 09 Mar 2023 17:55:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Mar 2023 17:55:51 +0800
Date:   Thu, 9 Mar 2023 17:55:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <ZAmtJ6IHkECJeVsp@gondor.apana.org.au>
References: <Y9Olps/fwxaItE4j@gondor.apana.org.au>
 <1742108.iAzbLhWyP0@dmc12.centralesupelec.fr>
 <ZAl0zmzBKjTINyEp@gondor.apana.org.au>
 <2151930.yCM3HcAoFy@dmc12.centralesupelec.fr>
 <ZAmlT1GX5hTzCrMg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAmlT1GX5hTzCrMg@gondor.apana.org.au>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Mar 09, 2023 at 05:22:23PM +0800, Herbert Xu wrote:
>
> Nasty, something is automatically archiving all the patches.
> 
> I'll try to find out why.

I've changed all the patches to "Under Review" and hopefully
that should keep them from being moved back into the archive.

If you notice anything strange please let me know.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
