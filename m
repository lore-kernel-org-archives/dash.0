Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E596BC433DB
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 21:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7338B64E0C
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 21:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhA2VU0 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 29 Jan 2021 16:20:26 -0500
Received: from mail.gigawatt.nl ([51.68.198.76]:49912 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233278AbhA2VU0 (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 29 Jan 2021 16:20:26 -0500
Received: from [IPv6:2a02:8010:68a1:0:3c8e:f6c9:90d1:c02a] (unknown [IPv6:2a02:8010:68a1:0:3c8e:f6c9:90d1:c02a])
        by mail.gigawatt.nl (Postfix) with UTF8SMTPSA id 1D41B13A;
        Fri, 29 Jan 2021 22:19:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 1D41B13A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1611955184;
        bh=dL8kJIKHtwNcUSq7PrtoDqltazwx7Ok+dFrsYn/FP9g=; l=700;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=nvUYrFN5HmOBljct2woJ5Fcq33QKv+fzEhJ6F227Xx4zmzd6FjD/T6++4LwUTitsm
         Qw3AZZk0iOX9Umn5S0pEd0ErNfnpzxzKtN+OviGGfs73D5tZzLjpT40+5wJZu8f2hC
         RaH76gxblh002HyIEbyaTTvBnMOCy7YT1/NQcsDc=
Subject: Re: getopts appears to not be shifting $@ when consuming options
To:     Jilles Tjoelker <jilles@stack.nl>, earnestly <zibeon@gmail.com>,
        dash@vger.kernel.org
References: <YBRTFXGM6pLwR5hg@teapot> <20210129203650.GA21262@stack.nl>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <534e13b9-af67-2441-bb77-2e18c38b5ec8@gigawatt.nl>
Date:   Fri, 29 Jan 2021 21:19:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210129203650.GA21262@stack.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 29/01/2021 20:36, Jilles Tjoelker wrote:
> Unfortunately, dash and FreeBSD sh reset the getopts state when the
> positional parameters are modified via set or shift. They probably do
> this to avoid use after free and out of bounds memory access when a
> script violates POSIX's rule.

In dash, the getopts command guards against this. getoptscmd() checks 
that shellparam.optind is in bounds before calling getopts(), and 
getopts() checks that shellparam.optoff is in bounds, so as far as 
correctness goes, it should be enough to just remove the resetting of 
shellparam.optind and shellparam.optoff in those places that are not 
supposed to reset the state.

Cheers,
Harald van Dijk
