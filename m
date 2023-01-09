Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B2CC54EBD
	for <linux-dash@archiver.kernel.org>; Mon,  9 Jan 2023 04:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjAIEky (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 23:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbjAIEkG (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 23:40:06 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD3C2DD5
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 20:37:16 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pEjuI-00FSeU-Mu; Mon, 09 Jan 2023 12:37:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 09 Jan 2023 12:37:10 +0800
Date:   Mon, 9 Jan 2023 12:37:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: Re: [PATCH v2] alias: fix name quoting in printalias
Message-ID: <Y7uZ9oBO1WjxW/3q@gondor.apana.org.au>
References: <20230109001219.2ylktzb7uckoeti5@tarta.nabijaczleweli.xyz>
 <20230109001543.vpk6khjtqkjtrjox@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109001543.vpk6khjtqkjtrjox@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Jan 09, 2023 at 01:15:43AM +0100, наб wrote:
> single_quote() over-writes the stack string, so just output the name
> separately first.
> 
> Fixes: commit 4ec545e8dc98a3f461cf56bed03adafa81c64aec ("alias: Quote
>  name in printalias")
> ---
> really not my year sorry
> 
>  src/alias.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
