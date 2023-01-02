Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748CDC3DA7A
	for <linux-dash@archiver.kernel.org>; Mon,  2 Jan 2023 13:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjABNhA (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 2 Jan 2023 08:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjABNgv (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 2 Jan 2023 08:36:51 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 215BBF2
        for <dash@vger.kernel.org>; Mon,  2 Jan 2023 05:36:49 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 2D3A2744;
        Mon,  2 Jan 2023 13:36:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 2D3A2744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1672666608;
        bh=b/+EnZYvMs6y7RKP21Wd9RhRI9o29wjXmZZkTo499EI=; l=750;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lWwy0FOf1ACZmC1zg+a+izyfUzidXpXSYbPTR05rG5hqgV8w6eo/gwHGCI8EcoFB3
         V7rJjCoRW/bYVdlA3QIWHDZahsQ+ft22jPxshhuSZKNZPzGikmcUqlfGTwhtTLevOh
         y0QBAJlg6mk17J6tKlvxrRL0teE5H8qq8J44cJRg=
Message-ID: <8f9890b8-225c-a091-ef2c-27f3bb508940@gigawatt.nl>
Date:   Mon, 2 Jan 2023 13:34:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [PATCH 1/2] exec: type: ignore first --, per POSIX
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dash@vger.kernel.org
References: <b9085f1a9812a436d37bc6f8d96d17bdba4433c5.1670966008.git.nabijaczleweli@nabijaczleweli.xyz>
 <Y7KhlatS/XnFn3VP@gondor.apana.org.au>
 <20230102124628.w6mtevhvnuthco4j@tarta.nabijaczleweli.xyz>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20230102124628.w6mtevhvnuthco4j@tarta.nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 02/01/2023 12:46, наб wrote:
> On Mon, Jan 02, 2023 at 05:19:17PM +0800, Herbert Xu wrote:
>> наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
>>> Issue 7, XCU, type, OPTIONS reads "None.",
>> type is marked XSI.  dash does claim conformance with respect
>> to XSI.
> Which means it ought to abide by "None." in the OPTIONS sexion,
> as out-lined in the subsequent lines, i.e. discard an initial --, yes.
> 
> Good to see we agree, I guess?

I'm pretty sure that was a pretty bad typo and meant to say "dash does 
*not* claim conformance with respect to XSI." See e.g. 
<https://lore.kernel.org/dash/20130904032000.GA19583@gondor.apana.org.au/>, 
"In any case, dash does not claim XSI conformance, [...]"

Cheers,
Harald van Dijk
