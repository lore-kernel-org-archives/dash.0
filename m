Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E311C3527B
	for <linux-dash@archiver.kernel.org>; Mon,  7 Feb 2022 16:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiBGQFS (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377779AbiBGPzJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 7 Feb 2022 10:55:09 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74741C0401CC
        for <dash@vger.kernel.org>; Mon,  7 Feb 2022 07:55:07 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:e69:c5c8:93ab:b95] (unknown [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 5946E46F;
        Mon,  7 Feb 2022 15:55:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 5946E46F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1644249304;
        bh=4wWgh99JZSRGzNpkhTSeh9pBM2JMmFZpEtp6X0Wd2F0=; l=569;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dYJIF4DZ7HK0xf+EXggWp98QyloEtVYOEgeEXOhArCz7NBRlZNpBGgm6Rm4US7e+b
         U6cIXzsFRcxNgZGcsl6h7TLEEnE4wdNi3HvB+RScbkB95BD1xjg2Vodlv8PIQHmDzh
         wNqGlj7BGYUHMHuI/DOnj3Stx6dK6myoY/UxXWq0=
Message-ID: <d89a498d-f0c7-99c5-c6e5-901734abdc42@gigawatt.nl>
Date:   Mon, 7 Feb 2022 15:55:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: ANSI escape codes in printf don't work
Content-Language: en-GB
To:     Subhaditya Nath <sn03.general@gmail.com>, dash@vger.kernel.org
References: <CAPHxB8tN-aCb1vUTPPWqakyA5wVJfzXXQrr97fPE00fTQPuwkg@mail.gmail.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CAPHxB8tN-aCb1vUTPPWqakyA5wVJfzXXQrr97fPE00fTQPuwkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

On 07/02/2022 15:36, Subhaditya Nath wrote:
> Run this -
> 
>      /usr/bin/printf '\x1b[31m%s\x1b[m\n' FAIL
> 
> It should print FAIL in red foreground color.
> It does, on other shells.
> In dash, it doesn't.

Hexadecimal escape sequences are not specified by POSIX. They are a 
common extension in other shells as you noticed but dash generally 
limits itself to what POSIX specifies. Octal escape sequences are part 
of the standard and supported by dash, and offer the same functionality:

   printf '\033[31m%s\033[m\n' FAIL

Cheers,
Harald van Dijk
