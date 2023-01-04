Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EA9C4332F
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 14:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbjADOLm (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 09:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjADOL1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 09:11:27 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19BB32187
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 06:10:17 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pD4Sv-00DqFb-Ph; Wed, 04 Jan 2023 22:10:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 04 Jan 2023 22:10:01 +0800
Date:   Wed, 4 Jan 2023 22:10:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: Re: [PATCH v2 2/3] parser: synerror: explicitly consume the entire
 invalid line
Message-ID: <Y7WIuSnsIbkHrEvH@gondor.apana.org.au>
References: <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
 <bb422d70-0ba5-e29b-3ec8-8fc1c4630233@gigawatt.nl>
 <Y7VMJGPXXziUrBio@gondor.apana.org.au>
 <8ddcc8a3-9588-435a-9d5f-1edbcd121012@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ddcc8a3-9588-435a-9d5f-1edbcd121012@gigawatt.nl>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Jan 04, 2023 at 11:25:09AM +0000, Harald van Dijk wrote:
> 
> Since the only case where special care is needed is when the problematic
> token was newline, it can be handled as simply as
> 
>   if (lasttoken != TNL)
>     skipline();

You're assuming that the only way of exiting the parser is
through synerror.  That's not the case.  We could also exit
through sh_error, e.g., if ckmalloc runs out of memory.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
