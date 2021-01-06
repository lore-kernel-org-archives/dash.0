Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C789C433E0
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 04:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193F422D01
	for <linux-dash@archiver.kernel.org>; Wed,  6 Jan 2021 04:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbhAFErJ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:47:09 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59480 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbhAFErJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 5 Jan 2021 23:47:09 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kx0iA-0007Lm-Ej; Wed, 06 Jan 2021 15:46:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 06 Jan 2021 15:46:18 +1100
Date:   Wed, 6 Jan 2021 15:46:18 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jilles Tjoelker <jilles@stack.nl>
Cc:     harald@gigawatt.nl, steffen@sdaoden.eu, dash@vger.kernel.org,
        vda.linux@googlemail.com
Subject: Re: dash 0.5.11.2, busybox sh 1.32.0, FreeBSD 12.2 sh: spring TTOU
 but should not i think
Message-ID: <20210106044618.GA28220@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221162442.GA26001@stack.nl>
X-Newsgroups: apana.lists.os.linux.dash
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
>
> This seems a good approach, but certain writes to the terminal may need
> the same treatment, for example the error message when fork fails for
> the second and further elements of a pipeline. This also makes me wonder
> why SIGTTOU is ignored at all by default.

I think the approach of blocking all signals should be able to
resolve this too if anyone cares enough about this case.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
