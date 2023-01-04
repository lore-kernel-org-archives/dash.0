Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC272C54EBD
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 14:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjADON1 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 09:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbjADOMj (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 09:12:39 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE99A1E3C8
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 06:12:38 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pD4VQ-00DqJ5-5X; Wed, 04 Jan 2023 22:12:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 04 Jan 2023 22:12:36 +0800
Date:   Wed, 4 Jan 2023 22:12:36 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] var: Do not add 1 to return value of strchrnul
Message-ID: <Y7WJVBPWsNhTvRuJ@gondor.apana.org.au>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
 <Y7P33bSfbmpe7EI/@gondor.apana.org.au>
 <20230103122619.bhvn7lep5avoanji@tarta.nabijaczleweli.xyz>
 <Y7VOEx/cE4vQZ0zE@gondor.apana.org.au>
 <20230104125421.rmjbjzme7a6qbxhx@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104125421.rmjbjzme7a6qbxhx@tarta.nabijaczleweli.xyz>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Jan 04, 2023 at 01:54:21PM +0100, наб wrote:
> 
> AFAICT, after trawling through the Issue 8 Draft 2.1,
> there are no special provisions for unset/OPTIND,

Well it says this regarding OPTIND:

: If the application sets OPTIND to the value 1, a new set of parameters
: can be used: either the current positional parameters or new arg
: values. Any other attempt to invoke getopts multiple times in a single
: shell execution environment with parameters (positional parameters
: or arg operands) that are not the same in all invocations, or with an
: OPTIND value modified to be a value other than 1, produces unspecified
: results.

Unsetting OPTIND ought to do the same thing as setting it to "",
which produces unspecified results and I see nothing wrong with
printing an error in this case.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
