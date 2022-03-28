Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D24C433F5
	for <linux-dash@archiver.kernel.org>; Mon, 28 Mar 2022 06:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbiC1GNd (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 28 Mar 2022 02:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiC1GNb (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 28 Mar 2022 02:13:31 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 320E9167D5
        for <dash@vger.kernel.org>; Sun, 27 Mar 2022 23:11:51 -0700 (PDT)
Received: from [IPV6:2a02:8010:68a1:0:d0d4:d13c:6697:df13] (unknown [IPv6:2a02:8010:68a1:0:d0d4:d13c:6697:df13])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 31974479;
        Mon, 28 Mar 2022 07:11:48 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 31974479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1648447908;
        bh=e1fbAxWENaTd7LOfOI9nC3eooDGTyQ6Hy+MEYDHlIPk=; l=478;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=FfDv4hYwk+mxoYHP6s5D2IvPJfeY7fwv/OH1A0QEkn87t/0cLKoUVnJnL6JqemQaY
         71M0PWbunw+n3rUGCSO8/g7KDTFWUhmp0Y+lW3PvvpTbLbY0/IUTQ06TKEMKu6MrkG
         EQRrDNHzPcCqq1JmmdkkDaQ4y6SpcvCxa7rrhJGk=
Message-ID: <82d7c35a-196c-8478-be58-0dea11c3c0c8@gigawatt.nl>
Date:   Mon, 28 Mar 2022 07:11:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:99.0) Gecko/20100101
 Thunderbird/99.0
Subject: Re: Printf %q
Content-Language: en-US
To:     =?UTF-8?Q?Bj=c3=b6rn_Bidar?= <bjorn.bidar@jolla.com>,
        "dash@vger.kernel.org" <dash@vger.kernel.org>
References: <6343726.ZXKkvaxoqQ@odin>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <6343726.ZXKkvaxoqQ@odin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 28/03/2022 05:45, Björn Bidar wrote:
> Dash also supports the $' ' syntax used by this.

Does it? As far as I can see, dash does not support the $' ' syntax. 
With the $' ' syntax,

   newline=$'\n'

assigns to newline a string of length 1 containing a newline character. 
In dash, what happens instead is that newline is assigned a string of 
length 3 containing the characters $, \, and n.

Tested with current master, commit 057cd650.

Cheers,
Harald van Dijk
