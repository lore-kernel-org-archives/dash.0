Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19025C71156
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD1B20809
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgLAK45 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:56:57 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:48558 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgLAK45 (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 05:56:57 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kk3KH-000353-1W; Tue, 01 Dec 2020 21:56:06 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 01 Dec 2020 21:56:05 +1100
Date:   Tue, 1 Dec 2020 21:56:05 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash@vger.kernel.org, Michael Biebl <biebl@debian.org>,
        974705@bugs.debian.org
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <20201201105604.GA28392@gondor.apana.org.au>
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <0e6bb3c5-96d9-18e1-e6bb-87cb34f85fab@gigawatt.nl>
 <20201201103448.GA28234@gondor.apana.org.au>
 <861e7a14-3dfc-83f7-8872-714b333d4246@gigawatt.nl>
 <20201201105328.GA28341@gondor.apana.org.au>
 <0db96973-afda-81a3-004f-786ffa60dca9@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db96973-afda-81a3-004f-786ffa60dca9@gigawatt.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Dec 01, 2020 at 10:55:06AM +0000, Harald van Dijk wrote:
> 
> You wrote: "So the problem is really in the parent of this shell, which
> appears to be bash:"

You should read my follow-up email too that suggested changing
the systemd script.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
