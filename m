Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4B0C64E7B
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFCC20809
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgLAKyT (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:54:19 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:48534 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730215AbgLAKyS (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 05:54:18 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kk3Hk-00032g-7V; Tue, 01 Dec 2020 21:53:29 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 01 Dec 2020 21:53:28 +1100
Date:   Tue, 1 Dec 2020 21:53:28 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash@vger.kernel.org, Michael Biebl <biebl@debian.org>,
        974705@bugs.debian.org
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <20201201105328.GA28341@gondor.apana.org.au>
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <0e6bb3c5-96d9-18e1-e6bb-87cb34f85fab@gigawatt.nl>
 <20201201103448.GA28234@gondor.apana.org.au>
 <861e7a14-3dfc-83f7-8872-714b333d4246@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861e7a14-3dfc-83f7-8872-714b333d4246@gigawatt.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Dec 01, 2020 at 10:50:19AM +0000, Harald van Dijk wrote:
> 
> This used to exit immediately, leaving the sleep process running in the
> background without waiting for it. On the dash that's currently provided by
> Ubuntu, based on 0.5.10.2, it still behaves that way. With current dash from
> Git, it does not. This is clearly a change in behaviour in dash not in
> response to any bug (real or not) in bash.

I'm not suggesting it's a bug in bash.  If anything it's a bug
in the script.  You should never do a naked wait unless you are
sure that there are no other children around that you don't know of.

In the original bug, the proper solution is to wait on the PID
that the script just sent a kill signal to.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
