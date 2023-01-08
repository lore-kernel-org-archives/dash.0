Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00693C53210
	for <linux-dash@archiver.kernel.org>; Sun,  8 Jan 2023 12:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjAHMGg (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 07:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjAHMGe (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 07:06:34 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A4C10075
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 04:06:31 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pEURZ-00FD2W-0R; Sun, 08 Jan 2023 20:06:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 08 Jan 2023 20:06:29 +0800
Date:   Sun, 8 Jan 2023 20:06:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH v2 1/2] options: getopts: ignore first --, per POSIX
Message-ID: <Y7qxxfHlZC5uRKRO@gondor.apana.org.au>
References: <Y7TgIM0PFC5HaZk6@gondor.apana.org.au>
 <728796762ed62a1e9a38cf62762e57509e5027a2.1672831998.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <728796762ed62a1e9a38cf62762e57509e5027a2.1672831998.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Jan 04, 2023 at 12:33:45PM +0100, наб wrote:
> Issue 7, XCU, getopts, OPTIONS reads "None.",
> and getopts isn't a special built-in listed in sexion 2.14 ‒
> this means that XCU, 1. Introduction, 1.4 Utility Description Defaults,
> OPTIONS, Default Behavior applies:
>   Default Behavior: When this section is listed as "None.", it means
>   that the implementation need not support any options. Standard
>   utilities that do not accept options, but that do accept operands,
>   shall recognize "--" as a first argument to be discarded.
> 
> Test with: getopts -- d: a
> Correct output is no output, exit 1
> Wrong output errors out with d: being an invalid argument name
> ---
>  src/options.c | 3 +++
>  1 file changed, 3 insertions(+)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
