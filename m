Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB38C64E7A
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 11:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DD020809
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 11:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="b+xmhBfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgLALAC (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbgLALAC (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 06:00:02 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9F61C0613CF
        for <dash@vger.kernel.org>; Tue,  1 Dec 2020 02:59:21 -0800 (PST)
Received: from [192.168.1.7] (hvdijk.plus.com [81.174.157.28])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id E88A9137;
        Tue,  1 Dec 2020 11:59:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl E88A9137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1606820361;
        bh=3LfhKxHjYESnaULmDphpHf76CHBQkVWK0eu/pcqDTO0=; l=522;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b+xmhBfToCYAjT6AbpXK/f89FnRsKh4w22QoLHnShBeTMJeHxEeTRfWig1SSgTPEY
         Ca1W6hNk5UcKru9/W+W0f8rCZorc6Ow6vGvMRkRAAzRgIqwLxyjehdYhBE4spIuS19
         TYTXVHSYpVgwCp1CFkS+MTXO/E5WTWnz3W8xlkm0=
Subject: Re: Changes to job handling cause hangs in wait
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash@vger.kernel.org, Michael Biebl <biebl@debian.org>,
        974705@bugs.debian.org
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <0e6bb3c5-96d9-18e1-e6bb-87cb34f85fab@gigawatt.nl>
 <20201201103448.GA28234@gondor.apana.org.au>
 <861e7a14-3dfc-83f7-8872-714b333d4246@gigawatt.nl>
 <20201201105328.GA28341@gondor.apana.org.au>
 <0db96973-afda-81a3-004f-786ffa60dca9@gigawatt.nl>
 <20201201105604.GA28392@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <f49a6670-dab4-9e0b-24c0-9506cbf76b03@gigawatt.nl>
Date:   Tue, 1 Dec 2020 10:59:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201105604.GA28392@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 01/12/2020 10:56, Herbert Xu wrote:
> On Tue, Dec 01, 2020 at 10:55:06AM +0000, Harald van Dijk wrote:
>>
>> You wrote: "So the problem is really in the parent of this shell, which
>> appears to be bash:"
> 
> You should read my follow-up email too that suggested changing
> the systemd script.

I do not appreciate your false accusation that I did not read your 
follow-up email. You suggested that as an alternative, without 
retracting your claim that this is a problem in bash.

Cheers,
Harald van Dijk
