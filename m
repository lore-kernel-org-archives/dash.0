Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B751C433E0
	for <linux-dash@archiver.kernel.org>; Wed, 10 Feb 2021 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13ED564E7C
	for <linux-dash@archiver.kernel.org>; Wed, 10 Feb 2021 15:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhBJPbJ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:31:09 -0500
Received: from ns.simtreas.ru ([94.25.26.30]:37440 "EHLO ns.simtreas.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhBJPbI (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 10 Feb 2021 10:31:08 -0500
Received: from [94.25.26.27] (IDENT:1000@dzo.simtreas.ru [94.25.26.27])
        by ns.simtreas.ru (8.14.2/8.14.2) with ESMTP id 11AFUF3o014028;
        Wed, 10 Feb 2021 19:30:15 +0400
Subject: Re: [PATCH] parser: Fix regression on ${#10} expansion
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
References: <20210208034127.GA31149@gondor.apana.org.au>
From:   "Vladimir N. Oleynik" <dzo@simtreas.ru>
Organization: Ulyanovsk Treasury
Message-ID: <97c1bec2-a3f3-31be-a7ce-a34fc2aba5f5@simtreas.ru>
Date:   Wed, 10 Feb 2021 19:30:17 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.5.1
MIME-Version: 1.0
In-Reply-To: <20210208034127.GA31149@gondor.apana.org.au>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-4.0.1 (ns.simtreas.ru [10.68.0.1]); Wed, 10 Feb 2021 19:30:16 +0400 (SAMT)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello, Herbert.

Herbert Xu wrote:

> Thanks for the patch!

> I would rather test against VSNORMAL.

Yes, its true for support indirection ${!var}
and realized by me :)

But I do not show this patch in
https://git.kernel.org/pub/scm/utils/dash/dash.git/
Its ok?


--w
vodz

