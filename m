Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31A7C3DA7D
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 09:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjAEJoC (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 04:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjAEJn7 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 04:43:59 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196C2551D8
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 01:43:57 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDMmw-00E9SY-DO; Thu, 05 Jan 2023 17:43:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Jan 2023 17:43:54 +0800
Date:   Thu, 5 Jan 2023 17:43:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org, harald@gigawatt.nl
Subject: Re: [PATCH v2 1/3] parser: fixredir: invalid redirections are
 run-time, not syntax
Message-ID: <Y7ab2uSkRRw++6Me@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a7ba3fa786e34cde8ab158cb8578f0d39cf655e.1670979949.git.nabijaczleweli@nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> [-- text/plain, encoding quoted-printable, charset: us-ascii, 33 lines --]
> 
> This fixes a long-standing bug where
>  echo 'echo >&a' | sh
> errors out with
>  sh: 2: Syntax error: Bad fd number
> despite the error being on line 1
> 
> This patch makes the error
>  sh: 1: Bad fd number: a
> as expected
> 
> Adapted-from: https://github.com/hvdijk/gwsh/commit/d279523041c1c380d64b6dec7760feba20bbf6b5
> ---
> src/parser.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
