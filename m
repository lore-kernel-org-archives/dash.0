Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C187EC54EBD
	for <linux-dash@archiver.kernel.org>; Mon,  9 Jan 2023 00:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjAIAbA (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 19:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjAIAa7 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 19:30:59 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A9181130
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 16:30:52 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id D30DC1214;
        Mon,  9 Jan 2023 00:30:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl D30DC1214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1673224252;
        bh=06qNOdJR9p/Pju7iJkaPwTw7FdI2vurGNVMZfAMFo6I=; l=885;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HFH+hpiU7vHj06RaWzchNtxouVj0HX1g6BYiPzq6tD09IR4g9JBnFTmdF89gotcHd
         l40qmiwdISUorHQZVIMM1uMLnmAwmk9inIPUfl+k3Vnile7S7jaVsgvWDBRfyeTC7B
         4S0HYhuO7XSjVJlfvP3MNTnOtA7JCKi5OkSwzGww=
Message-ID: <7f1920ef-dc74-3a34-6453-507bbb349b8b@gigawatt.nl>
Date:   Mon, 9 Jan 2023 00:30:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [PATCH v2] alias: fix name quoting in printalias
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
References: <20230109001219.2ylktzb7uckoeti5@tarta.nabijaczleweli.xyz>
 <20230109001543.vpk6khjtqkjtrjox@tarta.nabijaczleweli.xyz>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20230109001543.vpk6khjtqkjtrjox@tarta.nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 09/01/2023 00:15, наб wrote:
> single_quote() over-writes the stack string, so just output the name
> separately first.
> 
> Fixes: commit 4ec545e8dc98a3f461cf56bed03adafa81c64aec ("alias: Quote
>   name in printalias")
> ---
> really not my year sorry

This one works, thanks.

I'm wondering if we can save on code size by storing aliases differently 
instead, allowing for a simpler fix here. If we store aliases in memory 
in name=value form in a single block of memory, we only need a single 
savestr() when creating the alias, we only need a single single_quote() 
call here, we only need a single free() when we're done with the alias, 
and may be able to share some code with src/var.c for checking the alias 
name and stopping at the '='.

That'd be a larger change though, and even if it is possible, I am not 
sure it's worth it.

Cheers,
Harald van Dijk
