Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E493C433DB
	for <linux-dash@archiver.kernel.org>; Mon,  4 Jan 2021 21:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FD4216C4
	for <linux-dash@archiver.kernel.org>; Mon,  4 Jan 2021 21:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhADVUZ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 4 Jan 2021 16:20:25 -0500
Received: from mail.gigawatt.nl ([51.68.198.76]:51882 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbhADVUZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 4 Jan 2021 16:20:25 -0500
Received: from [192.168.1.5] (92.40.195.36.threembb.co.uk [92.40.195.36])
        by mail.gigawatt.nl (Postfix) with UTF8SMTPSA id 6E14048F;
        Mon,  4 Jan 2021 22:19:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 6E14048F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1609795180;
        bh=vSgO9x/VfUYs8AiZhPPJ4u5tvRGaHMtYirvQKiRZnMw=; l=448;
        h=From:Subject:To:References:Date:In-Reply-To:From;
        b=Dj4K6Dg4u5tmwSU/w1TMy/+TyL0Mj6OAJ4eRRx7OV1F2wWSM/aw3NuPsKs2aSR7g0
         8b91z/9u1rhXIP7P3twfjcIeYuGUIPu8LQ9F3/Z4E8C6YAKDJOWHJBe4itFeauFTvK
         yaDtgElX+KCkP6e50J+wOsX5fcINPqR1NAkwPjoE=
From:   Harald van Dijk <harald@gigawatt.nl>
Subject: Re: set -I is not required by standard, and does not match bash
To:     Denys Vlasenko <vda.linux@googlemail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        DASH shell mailing list <dash@vger.kernel.org>
References: <CAK1hOcPjYpXa8GQsD5dmYnkUHqc_KC2BXj0NC6d49qi10Qt4kA@mail.gmail.com>
Message-ID: <8043061e-50e7-f1c6-c551-b41a0f87aee4@gigawatt.nl>
Date:   Mon, 4 Jan 2021 21:19:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CAK1hOcPjYpXa8GQsD5dmYnkUHqc_KC2BXj0NC6d49qi10Qt4kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 04/01/2021 12:22, Denys Vlasenko wrote:
> Hello,
> 
> In dash, set -I is a short-option alias to set -o ignoreeof.
> 
> However, bash does not have such alias, it has an undocumented
> set -I which switches off "invisible variables"
> (I don't know what that is).

bash does not have any set -I. bash *had* a set -I, but dropped it in 
version 5.1, so there is no longer a compatibility issue to worry about.

Cheers,
Harald van Dijk
