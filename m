Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144C3C61DA4
	for <linux-dash@archiver.kernel.org>; Tue, 31 Jan 2023 03:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjAaDUk (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 30 Jan 2023 22:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjAaDUj (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 30 Jan 2023 22:20:39 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005B735B0
        for <dash@vger.kernel.org>; Mon, 30 Jan 2023 19:20:38 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pMhC5-005rxZ-Kg; Tue, 31 Jan 2023 11:20:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 31 Jan 2023 11:20:25 +0800
Date:   Tue, 31 Jan 2023 11:20:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ganael Laplanche <ganael.laplanche@martymac.org>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, jilles@stack.nl,
        dash@vger.kernel.org
Subject: Re: Monitor mode handling (bug ?)
Message-ID: <Y9iI+ehXvUlbFEGa@gondor.apana.org.au>
References: <Y9Olps/fwxaItE4j@gondor.apana.org.au>
 <2744018.j5hJsU0yqa@dmc12.centralesupelec.fr>
 <Y9dwEOSA7SR9+ovZ@gondor.apana.org.au>
 <5757811.Zv9zXsTiuT@home.martymac.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5757811.Zv9zXsTiuT@home.martymac.org>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Jan 30, 2023 at 12:37:28PM +0100, Ganael Laplanche wrote:
> 
> Well, it seems the previous patch had space problems.
> 
> Find a fixed version attached.

Thanks! This seems to have made it into patchwork.  I will review
it.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
