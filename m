Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4418C46467
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 09:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjADJ7x (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 04:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjADJ7w (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 04:59:52 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2471A3A9
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 01:59:50 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pD0Yl-00DlU8-Hz; Wed, 04 Jan 2023 17:59:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 04 Jan 2023 17:59:47 +0800
Date:   Wed, 4 Jan 2023 17:59:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] var: Do not add 1 to return value of strchrnul
Message-ID: <Y7VOEx/cE4vQZ0zE@gondor.apana.org.au>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
 <20230103122619.bhvn7lep5avoanji@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230103122619.bhvn7lep5avoanji@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Jan 03, 2023 at 01:26:19PM +0100, наб wrote:
>
> > However, I don't think we need to pass the flags to the action
> > function since none of them care about whether it's unset.  We
> > just need to pass a pointer to an empty string rather than some
> > bogus pointer.
> This, unsurprisingly, produces the same error, because getoptsreset()
> needs a valid number for OPTIND:
>   $ src/dash -c 'unset OPTIND'
>   src/dash: 1: unset: Illegal number:

You get the same result with OPTIND="" so I don't see the issue.

Am I missing something with respect to POSIX?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
