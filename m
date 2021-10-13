Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81921C433EF
	for <linux-dash@archiver.kernel.org>; Wed, 13 Oct 2021 09:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A4761056
	for <linux-dash@archiver.kernel.org>; Wed, 13 Oct 2021 09:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbhJMJ6F (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 13 Oct 2021 05:58:05 -0400
Received: from mail.gigawatt.nl ([51.68.198.76]:53380 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237603AbhJMJ6F (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 13 Oct 2021 05:58:05 -0400
Received: from [IPV6:2a02:8010:68a1:0:e69:c5c8:93ab:b95] (unknown [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id EEBEC759;
        Wed, 13 Oct 2021 10:56:00 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl EEBEC759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1634118961;
        bh=6jYuP2JwB6nMBm89O34ojl7FRM9hgLqpMPW4l3Huwck=; l=898;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dTQIvEXDbt0g+m+vxnmy5Xnvn8DADlLNDQoNEkeDQ7NafUYv2cEnNn9+TLdRZw5DH
         BI7bwVWSN0OLLIeP3gn7qrOOkelIZrN09UMn6gpaRi7Jp552Grudxn1Vv8KYFz2jYh
         CC9oZwZMi0Xrzm3n3hYUDb4rhCo7qNNa8BP9bpB8=
Message-ID: <61f9c77a-b8c9-d25d-c72d-34e342917f58@gigawatt.nl>
Date:   Wed, 13 Oct 2021 10:55:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: $ENV handling depends on defined(linux), why??
Content-Language: en-GB
To:     Denys Vlasenko <vda.linux@googlemail.com>,
        DASH shell mailing list <dash@vger.kernel.org>
References: <CAK1hOcNgTbRgWVjidA63NJqa4_+ExRuE5XpSM14s5VGw2eQT_A@mail.gmail.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CAK1hOcNgTbRgWVjidA63NJqa4_+ExRuE5XpSM14s5VGw2eQT_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 13/10/2021 10:39, Denys Vlasenko wrote:
>                      Who in their right mind would have a *setuid*
> shell executable on any system where security matters?

I suspect this was originally not for the benefit of setuid shell 
executables, but setuid shell scripts. Linux does not support those, so 
the check is considered unnecessary on Linux.

However, actually, doing something along those lines is useful even on 
Linux when setuid applications can be tricked to launch shell processes 
in insecure ways. bash implements "privileged mode" which drops shell 
privileges except when the setuid application specifically requests 
keeping them, which I would like to see in dash as well.  Tavis Ormandy 
started a thread on that in 2013 with a patch, 
https://www.mail-archive.com/dash@vger.kernel.org/msg00788.html, it 
would be good to get something along those lines in.

Cheers,
Harald van Dijk
