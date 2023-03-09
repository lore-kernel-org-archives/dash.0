Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBACC61DA4
	for <linux-dash@archiver.kernel.org>; Thu,  9 Mar 2023 05:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCIFzs (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 9 Mar 2023 00:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCIFzr (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 9 Mar 2023 00:55:47 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B3EB8627
        for <dash@vger.kernel.org>; Wed,  8 Mar 2023 21:55:43 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pa9FO-0020CL-KE; Thu, 09 Mar 2023 13:55:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Mar 2023 13:55:26 +0800
Date:   Thu, 9 Mar 2023 13:55:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <ZAl0zmzBKjTINyEp@gondor.apana.org.au>
References: <Y9Olps/fwxaItE4j@gondor.apana.org.au>
 <Y9iI+ehXvUlbFEGa@gondor.apana.org.au>
 <2865051.slGk94SIus@home.martymac.org>
 <1742108.iAzbLhWyP0@dmc12.centralesupelec.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742108.iAzbLhWyP0@dmc12.centralesupelec.fr>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Mar 08, 2023 at 12:47:23PM +0100, Ganael Laplanche wrote:
>
> It seems the patch has been archived in Patchwork :
> 
> https://patchwork.kernel.org/project/dash/patch/
> dedaa3fa370ea9c4aeb1771b5568a7bef4065b04.1675113321.git.steffen@sdaoden.eu/
> 
> Is that Intended ? Has it been refused ?

Thanks for letting me know! I have no idea how this happened.

I did a search and discovered quite a few archived patches.
I've unarcived all of them.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
