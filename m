Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1537AC433E0
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 04:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C2222CE3
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 04:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbhAFEr4 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:47:56 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59504 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbhAFEr4 (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 5 Jan 2021 23:47:56 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kx0iy-0007NL-V2; Wed, 06 Jan 2021 15:47:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 06 Jan 2021 15:47:08 +1100
Date:   Wed, 6 Jan 2021 15:47:08 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     dash@vger.kernel.org
Subject: Re: dash 0.5.11.2: somehow falsely waits
Message-ID: <20210106044708.GA28288@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220014300.8lXtI%steffen@sdaoden.eu>
X-Newsgroups: apana.lists.os.linux.dash
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
> Hello.
> 
> There is another issue with at least dash (the others not yet
> tested).  I cloned the git repo and it is still present at
> 6ba88b3ed28fb4b52f20b730194c4ad3d8aad037.

Can you please retest with 6359d7aa739b9f02f622805f4dbddeaf0ae61981?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
