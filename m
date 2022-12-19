Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFAEC4332F
	for <linux-dash@archiver.kernel.org>; Mon, 19 Dec 2022 08:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiLSIJS (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 19 Dec 2022 03:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLSIJQ (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 19 Dec 2022 03:09:16 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9E862DB
        for <dash@vger.kernel.org>; Mon, 19 Dec 2022 00:09:15 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p7BCy-008RS1-Gb; Mon, 19 Dec 2022 16:09:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 19 Dec 2022 16:09:12 +0800
Date:   Mon, 19 Dec 2022 16:09:12 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] alias: aliascmd: refuse uninvokable aliases
Message-ID: <Y6AcKDT/CcPJcYTi@gondor.apana.org.au>
References: <20221217190705.atfwacsgggtafzl2@tarta.nabijaczleweli.xyz>
 <Y56DMzRWQB1CEH5J@gondor.apana.org.au>
 <20221218033456.fe5xpkw7s3ifvcin@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221218033456.fe5xpkw7s3ifvcin@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Sun, Dec 18, 2022 at 04:34:56AM +0100, наб wrote:
>
> In that case, how's about the scissor-patch below that fixes the main
> questionable part of this (these dubious aliases executed as code when
> re-evaled, which POSIX says should be fine)? It's roughly what zsh does.

Yes this looks simple enough.  I'll look into it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
