Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E27C352A1
	for <linux-dash@archiver.kernel.org>; Tue,  6 Dec 2022 10:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiLFKP7 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 6 Dec 2022 05:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiLFKPq (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 6 Dec 2022 05:15:46 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B340C14
        for <dash@vger.kernel.org>; Tue,  6 Dec 2022 02:15:45 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:26d4:234:5292:8b5e] (unknown [IPv6:2a02:8010:68a1:0:26d4:234:5292:8b5e])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 44640744;
        Tue,  6 Dec 2022 10:15:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 44640744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1670321744;
        bh=yTGVEj67WN1S4U5PmgpNYRsAscnCM/KM0/ZXdVSIuSQ=; l=591;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=bbsIrjPdOQ3YNEY4zUNY1oZHIw+2UJJbuI0e9wcoYgYOyr3TZWRcj7v4Wgl7lydLY
         j/9cMcVgSq1CiwZFkMr4Ft9ipPDlo4jdjAgyuFuEiAG2XJq7zUr6M9PBRF7MOpvHpY
         gN/2hnqeuYkbshX/wchC8scGJhHg44A6u9BTeqAU=
Message-ID: <ce0c3ef7-66a9-08de-546f-d8ef8263b6da@gigawatt.nl>
Date:   Tue, 6 Dec 2022 10:15:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101
 Thunderbird/108.0
Subject: Re: [PATCH] eval: Always set exitstatus in evaltree
To:     Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
References: <Y48CCiIAagbl5q0L@gondor.apana.org.au>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Y48CCiIAagbl5q0L@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 06/12/2022 08:49, Herbert Xu wrote:
> There is no harm in setting exitstatus unconditionally in evaltree.

There is a long-standing bug that may or may not be harder to fix if 
this patch goes in, depending on how you want to fix it. Here's a script 
that already fails on current dash.

   f() {
     if ! return 0
     then :
     fi
   }
   f

This should return 0, and does return 0 in bash and ksh (and almost all 
shells), but returns 1 in dash.

There are a few possible ways of fixing it. Some of them rely on 
continuing to conditionally set exitstatus.

Cheers,
Harald van Dijk
