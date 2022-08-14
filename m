Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D617C19F2D
	for <linux-dash@archiver.kernel.org>; Sun, 14 Aug 2022 01:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiHNBRJ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 13 Aug 2022 21:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiHNBRI (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 13 Aug 2022 21:17:08 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 Aug 2022 18:17:07 PDT
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3DA81AF05
        for <dash@vger.kernel.org>; Sat, 13 Aug 2022 18:17:07 -0700 (PDT)
Received: from [IPV6:2a02:8010:68a1:0:26d4:234:5292:8b5e] (unknown [IPv6:2a02:8010:68a1:0:26d4:234:5292:8b5e])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 0BFFE741;
        Sun, 14 Aug 2022 02:12:03 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 0BFFE741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1660439523;
        bh=V6amTdGWEwpx3BM7cRqiRGOV6k/F0PQZUcym/Fjlt3A=; l=607;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=UipKvNg62Qer2yZCdDwUSYBpSih6FHsylYqaPCKReClmUuIzKUFCzuekABuYXSmX5
         sWHls83yZpPNVIDgS4feAiT1fBUOPDeYIJpIH+piBLwOWvJikieoPjGcZqcqjENBge
         F8KWYiV5qcMl7yZdXM6a9gS0VoTLmYlcfkzLBrQg=
Message-ID: <af8be241-f3cc-4ca9-ee49-e856e658c683@gigawatt.nl>
Date:   Sun, 14 Aug 2022 02:11:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH 1/2] man: printf: all Ar arguments are processed
 identically
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
References: <ba1440bf05e22d3cae38521a25cb3ca90b30680d.1660436383.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <ba1440bf05e22d3cae38521a25cb3ca90b30680d.1660436383.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 14/08/2022 01:19, наб wrote:
> The current wording says that given
>    printf a b c d
> a is the format, c and d are processed as noted,
> but b is unspecified

I think the way "arguments after the first" is intended to be read is 
"arguments after the format string", as the format string is itself an 
argument. But this is not clear at all: "printf format [arguments ...]" 
can be read as saying that the format is not an argument.

Perhaps "arguments after the format string" or "arguments after format" 
would be a better replacement that avoids any ambiguity?

Cheers,
Harald van Dijk
