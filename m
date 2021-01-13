Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD56C433DB
	for <linux-dash@archiver.kernel.org>; Wed, 13 Jan 2021 06:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155EA2310F
	for <linux-dash@archiver.kernel.org>; Wed, 13 Jan 2021 06:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbhAMGXG (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 13 Jan 2021 01:23:06 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37474 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbhAMGXG (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 13 Jan 2021 01:23:06 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kzZXz-000889-PJ; Wed, 13 Jan 2021 17:22:24 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 13 Jan 2021 17:22:23 +1100
Date:   Wed, 13 Jan 2021 17:22:23 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "C. McEnroe" <june@causal.agency>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] Fail if building --with-libedit and can't find libedit
Message-ID: <20210113062223.GA12459@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223004650.33486-1-june@causal.agency>
X-Newsgroups: apana.lists.os.linux.dash
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

C. McEnroe <june@causal.agency> wrote:
> Previously, configure --with-libedit would only fail in the case where
> libedit is available but its header file histedit.h is not.
> ---
> configure.ac | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
