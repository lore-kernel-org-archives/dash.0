Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCABC433DB
	for <linux-dash@archiver.kernel.org>; Thu, 11 Feb 2021 04:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A38D64E3C
	for <linux-dash@archiver.kernel.org>; Thu, 11 Feb 2021 04:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhBKE4o (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 10 Feb 2021 23:56:44 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55136 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhBKE4o (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 10 Feb 2021 23:56:44 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lA41F-0003Q8-4e; Thu, 11 Feb 2021 15:55:58 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Feb 2021 15:55:57 +1100
Date:   Thu, 11 Feb 2021 15:55:57 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Vladimir N. Oleynik" <dzo@simtreas.ru>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH] parser: Fix regression on ${#10} expansion
Message-ID: <20210211045556.GA7835@gondor.apana.org.au>
References: <20210208034127.GA31149@gondor.apana.org.au>
 <97c1bec2-a3f3-31be-a7ce-a34fc2aba5f5@simtreas.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c1bec2-a3f3-31be-a7ce-a34fc2aba5f5@simtreas.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Feb 10, 2021 at 07:30:17PM +0400, Vladimir N. Oleynik wrote:
>
> But I do not show this patch in
> https://git.kernel.org/pub/scm/utils/dash/dash.git/
> Its ok?

It's still in the review process:

https://patchwork.kernel.org/project/dash/list/

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
