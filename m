Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E417C4361B
	for <linux-dash@archiver.kernel.org>; Wed,  9 Dec 2020 13:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5346A23B45
	for <linux-dash@archiver.kernel.org>; Wed,  9 Dec 2020 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbgLINCU (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 9 Dec 2020 08:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731844AbgLINCU (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 9 Dec 2020 08:02:20 -0500
X-Greylist: delayed 2054 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Dec 2020 05:01:40 PST
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF1C0613CF
        for <dash@vger.kernel.org>; Wed,  9 Dec 2020 05:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=pUaEuqWeUnevT+CMDOpkNucubJP7OQUhXuDAxCODv+Q=; b=VOPu5LfIWwF47zdvnCBpJsjWgP
        9aZHccawjI5TntJ4MYjr1pvl9ehT9jqcz/vqpSfpcWkPbzMoTNN9UwWECqLkcTvvncq7qlsB1Db2a
        I/zH3wuwcnYxyg7XLZmfyyXei4aHj1foNrgm6L9QkKBh5bOPagnbYZNz63M95L7J2DpQjdLK8aoEG
        wo92FmVPniXxWdIzyzHoQdu8JX28wmdDQqxpBMTuygU3W7po5/AmjgkgKx/tiF/ojGAz/NSnatRjK
        lyqRtrQ3VLJCad+ooq+SHOREjGDH6WJvO6AJtFVWDXhdo59SZOMEK7hdLSHOAGumhhyXbu+rxzi5d
        THQeesDg==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1kmyYv-00019F-UH; Wed, 09 Dec 2020 13:27:17 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
        (envelope-from <aurelien@aurel32.net>)
        id 1kmyYv-00Atuo-8S; Wed, 09 Dec 2020 13:27:17 +0100
Date:   Wed, 9 Dec 2020 13:27:17 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrej Shadura <andrew@shadura.me>, dash@vger.kernel.org,
        peff@peff.net, 976865@bugs.debian.org
Subject: Re: Fwd: Bug#974900: dash removes trailing slash from script
 arguments
Message-ID: <20201209122717.GA2598168@aurel32.net>
References: <f957f8b9-3430-4752-9798-9c5417d9707a@www.fastmail.com>
 <20201117033203.GA1084@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117033203.GA1084@gondor.apana.org.au>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 2020-11-17 14:32, Herbert Xu wrote:
> Andrej Shadura <andrew@shadura.me> wrote:
> > 
> > this is another bug report I have received.
> 
> This is a bug in glob(3).  Please dup and reassign to libc6.  There
> is a patch in the queue to disable glob by default again.
> 

Can you please describe more precisely what is the problem with glob(3)?

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
