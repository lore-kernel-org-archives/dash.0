Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE71C53210
	for <linux-dash@archiver.kernel.org>; Sun,  8 Jan 2023 12:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjAHMbA (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 07:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHMa7 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 07:30:59 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18331A1AF
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 04:30:53 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id E940011F;
        Sun,  8 Jan 2023 12:30:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl E940011F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1673181052;
        bh=pc5KtfcOSmA7ztekw0sF6Tyoa/foPascXKpyvxm+oEg=; l=664;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dYCPufXK6ClHPar9KWV2wiyVo0z0Rm5ju+TyspTGEcUdAIikabmwWl8CtORVvww2s
         Y9Za+aylaj0yPcAKqrJfDTlHrqkIhAwkRND9W8l1UpgmfkGBS2QxmZyHwTftFdi1he
         LY/d7U7CpE/fT0N23JzF0/kIO5v9adybkiRsHoeg=
Message-ID: <fd514809-f5db-cba1-146c-5f6f60ac5237@gigawatt.nl>
Date:   Sun, 8 Jan 2023 12:30:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [PATCH] alias: aliascmd: refuse uninvokable aliases
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
References: <20221217190705.atfwacsgggtafzl2@tarta.nabijaczleweli.xyz>
Content-Language: en-GB
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20221217190705.atfwacsgggtafzl2@tarta.nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 17/12/2022 19:07, наб wrote:
> See standards quote within, but the fun bit is:
>    alias "a'b=c" "ls&id=cd"; alias
> outputs
>    ls&id='cd'
>    a'b='c'
> neither of which is What You Want, and also you can't invoke them
> because you need to escape the quote/&/whatever, which disables
> alias processing. Forbid the minimum broken set.

I didn't realise this at the time, and since it's not getting merged 
it's not very important, but for completeness: this patch also rejects 
some aliases that are invokable:

   alias $=echo
   $ hello world

This is because whether $ is special depends on the character that follows.

Cheers,
Harald van Dijk
