Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC04BC53210
	for <linux-dash@archiver.kernel.org>; Sun,  8 Jan 2023 16:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjAHQcX (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 11:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHQbw (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 11:31:52 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B8B41E1
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 08:31:51 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id A687610D7;
        Sun,  8 Jan 2023 16:31:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl A687610D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1673195510;
        bh=bK8Sy3fczntZamz7C5Zel7mOeBqxiKEYrnD3hXrZaq4=; l=363;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=IB0C9xEDhVDArx8qsYqW9aj6djGGuvBy4LWwDlAsvXmXGxhVk22nTgy8snUO8C8IY
         a3pp3NqI/YNc7Org8PiItbAchrw/IDCwUSmKl2/Z57Jc9qfyEVfmQIXY5Q369LoOlt
         LsaGOFW6F5iis1rFJx3G70M0qwJQ4EtP8DbplePc=
Message-ID: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
Date:   Sun, 8 Jan 2023 16:31:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: dash repeats first line in history entry forever with fc -s
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
References: <20230108160906.xf7w5vsd74kr22pc@tarta.nabijaczleweli.xyz>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20230108160906.xf7w5vsd74kr22pc@tarta.nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 08/01/2023 16:10, наб wrote:
> Hi!
> 
> Fun test for ya (--with-libedit):
>    $ printf '%s\n' id 'fc 1' a ls . w q 'fc -s 1' | src/dash -i

Indeed. This was reported also by Martijn Dekker, 
<https://marc.info/?l=dash&m=154635285309187>, that thread lists some 
more related problems in the implementation of the fc command.

Cheers,
Harald van Dijk
