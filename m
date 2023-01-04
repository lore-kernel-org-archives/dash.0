Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF04BC3DA7D
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 02:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjADCKr (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Jan 2023 21:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjADCKq (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Jan 2023 21:10:46 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4DB5
        for <dash@vger.kernel.org>; Tue,  3 Jan 2023 18:10:43 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pCtEm-00DfpP-Ln; Wed, 04 Jan 2023 10:10:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 04 Jan 2023 10:10:40 +0800
Date:   Wed, 4 Jan 2023 10:10:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: type: ignore first --, per POSIX
Message-ID: <Y7TgIM0PFC5HaZk6@gondor.apana.org.au>
References: <b9085f1a9812a436d37bc6f8d96d17bdba4433c5.1670966008.git.nabijaczleweli@nabijaczleweli.xyz>
 <Y7KhlatS/XnFn3VP@gondor.apana.org.au>
 <20230102124628.w6mtevhvnuthco4j@tarta.nabijaczleweli.xyz>
 <Y7OHRV9Mf1agWIMC@gondor.apana.org.au>
 <20230103124052.wwnf3c5pync2lqk7@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230103124052.wwnf3c5pync2lqk7@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Jan 03, 2023 at 01:40:52PM +0100, наб wrote:
>
> If I can't convince you to apply this with the consistency argument of

If you can rephrase the patch description to not refer to
POSIX then I'm happy with your patch for type(1).

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
