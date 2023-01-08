Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E68C54EBC
	for <linux-dash@archiver.kernel.org>; Sun,  8 Jan 2023 12:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjAHMHF (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 07:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjAHMHE (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 07:07:04 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9712A10075
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 04:07:03 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pEUS4-00FD3J-UA; Sun, 08 Jan 2023 20:07:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 08 Jan 2023 20:07:00 +0800
Date:   Sun, 8 Jan 2023 20:07:00 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH RESEND] alias: printalias: quote the name, too
Message-ID: <Y7qx5BXv1lwHeHdL@gondor.apana.org.au>
References: <Y7aTHHpWKPB2FfA7@gondor.apana.org.au>
 <20230105124947.ewohzmmwddcpj4en@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105124947.ewohzmmwddcpj4en@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Jan 05, 2023 at 01:49:47PM +0100, наб wrote:
> This ensures even something like
>   alias 'a|b|c=d'
> is output by alias as
>   'a|b|c'='d'
> instead of
>   a|b|c='d'
> which is both "suitable for reinput to the shell" per POSIX
> and doesn't execute the aliases as code.
> ---
>  src/alias.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
