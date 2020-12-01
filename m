Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1269C71155
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174DD20674
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="J6gnRfFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgLAKzt (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgLAKzt (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 05:55:49 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C4A9C0613D2
        for <dash@vger.kernel.org>; Tue,  1 Dec 2020 02:55:09 -0800 (PST)
Received: from [192.168.1.7] (hvdijk.plus.com [81.174.157.28])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 7A71E739;
        Tue,  1 Dec 2020 11:55:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 7A71E739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1606820106;
        bh=UnbELA0egQ+KjQ4jWFDKepwVXjR8Jtpg5nOrqTwbsZQ=; l=641;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J6gnRfFTwkaR0piDCG1cmvZZtlykzst9kyGabCXQV36/Oor0iCEKS+qvOTkP1jtQ9
         i7PVAjB+NnuhDW+lYgcu5XtR6UvIh8zIHel4+Mfa82bOPXuNi6BAGxxX0zyzF2IIVN
         Xo8GGapq51j3CsVJQWhPzHwX9zFdBvlUSTdE+h2s=
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
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <0db96973-afda-81a3-004f-786ffa60dca9@gigawatt.nl>
Date:   Tue, 1 Dec 2020 10:55:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201105328.GA28341@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 01/12/2020 10:53, Herbert Xu wrote:
> On Tue, Dec 01, 2020 at 10:50:19AM +0000, Harald van Dijk wrote:
>>
>> This used to exit immediately, leaving the sleep process running in the
>> background without waiting for it. On the dash that's currently provided by
>> Ubuntu, based on 0.5.10.2, it still behaves that way. With current dash from
>> Git, it does not. This is clearly a change in behaviour in dash not in
>> response to any bug (real or not) in bash.
> 
> I'm not suggesting it's a bug in bash.

You wrote: "So the problem is really in the parent of this shell, which 
appears to be bash:"

Cheers,
Harald van Dijk
