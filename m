Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C1BC4361B
	for <linux-dash@archiver.kernel.org>; Thu, 10 Dec 2020 02:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99AC523B1F
	for <linux-dash@archiver.kernel.org>; Thu, 10 Dec 2020 02:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLJC5r (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:57:47 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55816 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgLJC5r (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 9 Dec 2020 21:57:47 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1knC8U-00050Z-NJ; Thu, 10 Dec 2020 13:56:55 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Dec 2020 13:56:54 +1100
Date:   Thu, 10 Dec 2020 13:56:54 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Aurelien Jarno <aurelien@aurel32.net>, 976865@bugs.debian.org
Cc:     andrew@shadura.me, dash@vger.kernel.org, peff@peff.net,
        976865@bugs.debian.org
Subject: Re: Bug#976865: Fwd: Bug#974900: dash removes trailing slash from
 script arguments
Message-ID: <20201210025654.GA26577@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209122717.GA2598168@aurel32.net>
X-Newsgroups: apana.lists.os.linux.dash,apana.lists.os.linux.debian.glibc,greathan.lists.debian.bugs.dist
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> Can you please describe more precisely what is the problem with glob(3)?

It's stripping trailing slashes from the pattern, even when the
name in question is a regular file.

https://patchwork.kernel.org/project/dash/patch/20201116025222.GA28742@gondor.apana.org.au/

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
