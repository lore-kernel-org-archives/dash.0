Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DFDC433DB
	for <linux-dash@archiver.kernel.org>; Thu,  7 Jan 2021 21:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 404CD233CF
	for <linux-dash@archiver.kernel.org>; Thu,  7 Jan 2021 21:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbhAGVIB (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:08:01 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37824 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbhAGVIB (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 7 Jan 2021 16:08:01 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kxcUz-0007hc-1U; Fri, 08 Jan 2021 08:07:14 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Jan 2021 08:07:12 +1100
Date:   Fri, 8 Jan 2021 08:07:12 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     dash@vger.kernel.org
Subject: Re: dash 0.5.11.2: somehow falsely waits
Message-ID: <20210107210712.GA3821@gondor.apana.org.au>
References: <20210107025037.GA376@gondor.apana.org.au>
 <20210107190018.SZVxv%steffen@sdaoden.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107190018.SZVxv%steffen@sdaoden.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Jan 07, 2021 at 08:00:18PM +0100, Steffen Nurpmeso wrote:
>
> Oh yes, that i have and used, plus the patch.  It seems i implied
> that you referred to a new commit with the sigblock code .. which
> you were not.

The new patch hasn't been merged yet.  You can track its status
through patchwork at:

https://patchwork.kernel.org/project/dash/list/

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
