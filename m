Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998A5C54EBC
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 09:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjAEJHE (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 04:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjAEJGk (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 04:06:40 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CE83D9FD
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 01:06:39 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDMCq-00E8p5-To; Thu, 05 Jan 2023 17:06:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Jan 2023 17:06:36 +0800
Date:   Thu, 5 Jan 2023 17:06:36 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] alias: aliascmd: refuse uninvokable aliases
Message-ID: <Y7aTHHpWKPB2FfA7@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221218033456.fe5xpkw7s3ifvcin@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> -- >8 --
> Subject: [PATCH] alias: printalias: quote the name, too

Please resend this with a new Subject line as otherwise it doesn't
get tracked properly by patchwork.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
