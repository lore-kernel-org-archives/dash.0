Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC3FC433E0
	for <linux-dash@archiver.kernel.org>; Thu,  7 Jan 2021 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86A623437
	for <linux-dash@archiver.kernel.org>; Thu,  7 Jan 2021 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbhAGTBB (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 7 Jan 2021 14:01:01 -0500
Received: from sdaoden.eu ([217.144.132.164]:25662 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbhAGTBB (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 7 Jan 2021 14:01:01 -0500
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 51AB916057; Thu,  7 Jan 2021 20:00:19 +0100 (CET)
Date:   Thu, 07 Jan 2021 20:00:18 +0100
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
Subject: Re: dash 0.5.11.2: somehow falsely waits
Message-ID: <20210107190018.SZVxv%steffen@sdaoden.eu>
In-Reply-To: <20210107025037.GA376@gondor.apana.org.au>
References: <20210107025037.GA376@gondor.apana.org.au>
User-Agent: s-nail v14.9.20-114-gd4288316
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Herbert Xu wrote in
 <20210107025037.GA376@gondor.apana.org.au>:
 |Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
 |>
 |>|Can you please retest with 6359d7aa739b9f02f622805f4dbddeaf0ae61981?
 |> 
 |> It works fine with the patch from the other message (repository at
 |> kernel.org does not know about the commit).
 |
 |Thanks for confirming.  It's strange that you can't find the
 |commit though because it appears to be there:
 |
 |https://git.kernel.org/pub/scm/utils/dash/dash.git/commit/?id=6359d7aa73\
 |9b9f02f622805f4dbddeaf0ae61981

Oh yes, that i have and used, plus the patch.  It seems i implied
that you referred to a new commit with the sigblock code .. which
you were not.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
