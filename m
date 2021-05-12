Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151D9C433B4
	for <linux-dash@archiver.kernel.org>; Wed, 12 May 2021 23:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFBD061413
	for <linux-dash@archiver.kernel.org>; Wed, 12 May 2021 23:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhELXp0 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 12 May 2021 19:45:26 -0400
Received: from mail.gigawatt.nl ([51.68.198.76]:37748 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347756AbhELXPv (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 12 May 2021 19:15:51 -0400
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 May 2021 19:15:51 EDT
Received: from localhost (unknown [IPv6:2a02:8010:68a1:0:3c8e:f6c9:90d1:c02a])
        by mail.gigawatt.nl (Postfix) with UTF8SMTPSA id 62DF3761;
        Thu, 13 May 2021 00:06:09 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 62DF3761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1620860769;
        bh=mRnMObIL/6bkELfmB0i3A67XYBrwl+rZW/lyjtGHJ20=; l=583;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=SX6GCvvxzmTTFOcdyrgTfCn6OGZzN0T3K4+nsxgWsuEDB2KoIJQsxDf8t/nohgbum
         HDbSvurnoznPrfB5Q6/nAFJFsBgsYlhcFAabLreSEhqDv4VfVpQquFX065pdMi9dLB
         v/nKxOThwvJA/FK61D9nvV9ZpIUxRDuL6PMeK7ug=
Message-ID: <71144bd0-153d-f144-efd4-7600a2f96740@gigawatt.nl>
Date:   Thu, 13 May 2021 00:06:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: 0.5.11.3: fyi: reverse solidus "expanded away"
Content-Language: en-US
To:     Steffen Nurpmeso <steffen@sdaoden.eu>,
        DASH shell mailing list <dash@vger.kernel.org>
References: <20210512213648.Df_R7%steffen@sdaoden.eu>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20210512213648.Df_R7%steffen@sdaoden.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 12/05/2021 22:36, Steffen Nurpmeso wrote:
> Hello.
> 
> Just fyi, i stumbled upon this a minute ago:
> 
>    #?0|kent:steffen$ echo du \\\\\
>    > hey
>    du \\hey
> 
> That was bash 5.1.8.
> 
>    #?0|kent:steffen$ dash
>    #kent:$ echo du \\\\\
>    > das
>    du \das
>    #kent:$
> 
> This is dash 0.5.11.3 (compiled by gcc (CRUX-x86_64-multilib)
> 10.2.0 on 2020-12-26), running on CRUX-Linux via glibc 2.32/3.
> Ciao,

This is expected as dash's echo always processes backslashes. bash will 
give the same output when its xpg_echo option is enabled.

Cheers,
Harald van Dijk
