Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F23C71155
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 23:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8C42224B
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 23:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgLAX06 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:26:58 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51504 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgLAX06 (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 18:26:58 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kkF26-0003Ch-R7; Wed, 02 Dec 2020 10:26:07 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 02 Dec 2020 10:26:06 +1100
Date:   Wed, 2 Dec 2020 10:26:06 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Michael Biebl <biebl@debian.org>
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash@vger.kernel.org, 974705@bugs.debian.org
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <20201201232606.GA32382@gondor.apana.org.au>
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <20201201065623.GA27646@gondor.apana.org.au>
 <86689c77-34c6-2dbe-32d2-95f826bfa634@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86689c77-34c6-2dbe-32d2-95f826bfa634@debian.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Wed, Dec 02, 2020 at 12:21:52AM +0100, Michael Biebl wrote:
>
> I'll update the timedated test accordingly.
> Incidentally we already have
> https://salsa.debian.org/systemd-team/systemd/-/merge_requests/110

Thanks.

I will make dash not wait for existing children as this is indeed
a change in behaviour which is undesirable.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
