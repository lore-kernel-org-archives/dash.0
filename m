Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D9C433E0
	for <linux-dash@archiver.kernel.org>; Wed, 13 Jan 2021 06:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73DE923131
	for <linux-dash@archiver.kernel.org>; Wed, 13 Jan 2021 06:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbhAMGSq (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 13 Jan 2021 01:18:46 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37466 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbhAMGSq (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 13 Jan 2021 01:18:46 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kzZTm-00086C-Bv; Wed, 13 Jan 2021 17:18:03 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 13 Jan 2021 17:18:02 +1100
Date:   Wed, 13 Jan 2021 17:18:02 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "C. McEnroe" <june@causal.agency>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH v2] Cache the expanded prompt for editline
Message-ID: <20210113061802.GA6215@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223210257.78887-1-june@causal.agency>
X-Newsgroups: apana.lists.os.linux.dash
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

C. McEnroe <june@causal.agency> wrote:
> Previously, the prompt would be expanded every time editline called the
> getprompt callback. I think the code may have been written assuming that
> editline only calls getprompt once per prompt, but it may actually call
> it many times, for instance every time you type backspace. This results
> not only in slower editing from expanding complex prompts repeatedly, it
> also consumes more and more stack memory each time getprompt is called.
> This can be seen by setting PS1 to some command substitution, typing
> many characters at the prompt, then holding backspace and observing
> memory usage. Thankfully all this stack memory is freed between prompts
> by the stackmark calls around el_gets.
> 
> This change causes prompt expansion to always happen in the setprompt
> call, as it would when editline is disabled, and a cached copy of the
> prompt is saved for getprompt to return every time editline calls it.
> Since getprompt is no longer doing expansion, the stackmark calls
> surrounding el_gets can be removed.
> ---
> 
> v2: Missed adding breaks when replacing returns with assignments.

What if someone actually wanted the prompt to change?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
