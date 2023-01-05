Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DDBC3DA7A
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 09:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjAEJpS (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 04:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjAEJpR (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 04:45:17 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB0F479EA
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 01:45:16 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDMoD-00E9WQ-UW; Thu, 05 Jan 2023 17:45:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Jan 2023 17:45:13 +0800
Date:   Thu, 5 Jan 2023 17:45:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH v3 1/2] man: printf: reword to avoid confusion v/v Ar
 argument[s]/arguments
Message-ID: <Y7acKd1zPPNo/wlr@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50b331b19b78fd56c5b2190f1f922a755e5f3270.1671063918.git.nabijaczleweli@nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> [-- text/plain, encoding quoted-printable, charset: us-ascii, 75 lines --]
> 
> The current wording says that given
>  printf a b c d
> a is the format, c and d are processed as noted,
> but b is unspecified
> ---
> Resending my patchset from August
> 
> src/dash.1 | 29 +++++++++++++----------------
> 1 file changed, 13 insertions(+), 16 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
