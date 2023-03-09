Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5B9C6FD1C
	for <linux-dash@archiver.kernel.org>; Thu,  9 Mar 2023 09:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCIJWm (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 9 Mar 2023 04:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCIJWl (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 9 Mar 2023 04:22:41 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C496546C
        for <dash@vger.kernel.org>; Thu,  9 Mar 2023 01:22:38 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paCTf-00240v-4L; Thu, 09 Mar 2023 17:22:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Mar 2023 17:22:23 +0800
Date:   Thu, 9 Mar 2023 17:22:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <ZAmlT1GX5hTzCrMg@gondor.apana.org.au>
References: <Y9Olps/fwxaItE4j@gondor.apana.org.au>
 <1742108.iAzbLhWyP0@dmc12.centralesupelec.fr>
 <ZAl0zmzBKjTINyEp@gondor.apana.org.au>
 <2151930.yCM3HcAoFy@dmc12.centralesupelec.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2151930.yCM3HcAoFy@dmc12.centralesupelec.fr>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Mar 09, 2023 at 07:40:42AM +0100, Ganael Laplanche wrote:
>
> Thanks, but it still appears as archived ("State: New, archived") and does not 
> show up in :
> 
> https://patchwork.kernel.org/project/dash/list/
> 
> It seems it has been flagged as "New" but the old "archived" flag is still 
> there...

Nasty, something is automatically archiving all the patches.

I'll try to find out why.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
