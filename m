Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EECC433DB
	for <linux-dash@archiver.kernel.org>; Thu, 14 Jan 2021 20:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C5623117
	for <linux-dash@archiver.kernel.org>; Thu, 14 Jan 2021 20:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbhANUNl (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:13:41 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:43682 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbhANUNk (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 14 Jan 2021 15:13:40 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l08zK-0007Xt-67; Fri, 15 Jan 2021 07:12:59 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 Jan 2021 07:12:58 +1100
Date:   Fri, 15 Jan 2021 07:12:58 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     June Bug <june@causal.agency>
Cc:     dash@vger.kernel.org
Subject: Re: [PATCH v2] Cache the expanded prompt for editline
Message-ID: <20210114201257.GA15898@gondor.apana.org.au>
References: <20210113061802.GA6215@gondor.apana.org.au>
 <F9311B17-4FC9-4623-9512-8022D4B96BFB@causal.agency>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F9311B17-4FC9-4623-9512-8022D4B96BFB@causal.agency>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Jan 14, 2021 at 10:43:21AM -0500, June Bug wrote:
> 
> It seems unlikely given the lack of consistency of when libedit
> calls the prompt callback. I only noticed it was happening when I
> patched in support for EL_RPROMPT (right-aligned prompts), which
> when active causes libedit to call the prompt callback on *every*
> keypress. It seemed not to happen with only a regular prompt and
> it took some experimenting to notice typing backspaces causes it.
> The behaviour is completely undocumented in libedit.
> 
> Anecdotally, typing at the prompt becomes painful when it is expanded
> over and over and does anything non-trivial, even just a command
> substitution that runs no external commands.

OK, in that case I think it's best to fix this in libedit instead.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
