Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7883C388F9
	for <linux-dash@archiver.kernel.org>; Tue, 17 Nov 2020 03:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F40F24697
	for <linux-dash@archiver.kernel.org>; Tue, 17 Nov 2020 03:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKQDd5 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 16 Nov 2020 22:33:57 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:47406 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgKQDd5 (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 16 Nov 2020 22:33:57 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kerkg-0000s1-DD; Tue, 17 Nov 2020 14:33:55 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 17 Nov 2020 14:33:54 +1100
Date:   Tue, 17 Nov 2020 14:33:54 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc:     dash@vger.kernel.org, Michael Biebl <biebl@debian.org>
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <20201117033354.GA1112@gondor.apana.org.au>
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Mon, Nov 16, 2020 at 10:29:16AM +0000, Andrej Shadura wrote:
>
> I must note that I had troubles debugging it: I was only able to
> reproduce the issue in an autopkgtest virtual machine, but not on my
> normal system nor in a fresh Debian unstable Docker container.

Since you can reproduce it, could you please run the offending script
under strace -f and send me the result? That should pin-point the
problem.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
