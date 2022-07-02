Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19832C433EF
	for <linux-dash@archiver.kernel.org>; Sat,  2 Jul 2022 08:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiGBIUi (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 2 Jul 2022 04:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBIUh (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 2 Jul 2022 04:20:37 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A618140DD
        for <dash@vger.kernel.org>; Sat,  2 Jul 2022 01:20:36 -0700 (PDT)
Received: from [IPV6:2a02:8010:68a1:0:26d4:234:5292:8b5e] (unknown [IPv6:2a02:8010:68a1:0:26d4:234:5292:8b5e])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 1C7D5D2;
        Sat,  2 Jul 2022 09:20:32 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 1C7D5D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1656750032;
        bh=EceNLgiA7mX40jx0xHOqGjGI48dVSSlUylRVtJziFjE=; l=1036;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LtPjF++0eypuwlA435awikNzGgQJhNwb2OUnF2cZ8Of6BCxQQNamaQ4dLZp+kMV6M
         gryWHxo4EkT+qkjHMkwcVvMPsml2xmmUkmetPcaCNJxpUhxSlv1WogQq1q4hVFDhRF
         YQ+qEwFTbXnb+gm8h0j21/qmYNeSlkA1yxkTq884=
Message-ID: <cf3a9ac8-9cf8-ad57-bb33-2a5c5a93e532@gigawatt.nl>
Date:   Sat, 2 Jul 2022 09:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0
Subject: Re: $(()) pre/postfix bug
To:     Robert Elz <kre@munnari.OZ.AU>,
        Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
References: <20220701231439.egWzS%steffen@sdaoden.eu>
 <3508.1656721712@jacaranda.noi.kre.to>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <3508.1656721712@jacaranda.noi.kre.to>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 02/07/2022 01:28, Robert Elz wrote:
>    | FreeBSD 13.1
>    | #|f-1301-x86:~$ sh -c '(i=10; echo $((++-+++i)))'
>    | sh: arithmetic expression: expecting primary: "++-+++i"
> 
> We used to do that as well (our arith parser is derived from
> theirs, which is derived from dash's with extensions) but no-one ever
> understood what a "primary" was (relates to internal implementation
> function names) so I altered the err msg.

While there is a function called primary, I actually think that may not 
be what the error message refers to, not directly. The grammar is 
supposed to be the C grammar with unsupported constructs removed, the C 
grammar defines a "primary-expression", and the error message in dash 
shows up where a straightforward parser directly based on the C grammar 
would result in an error where the grammar demands a primary-expression.

The function called primary ended up doing more than parse a 
primary-expression, but that does not change which cases result in that 
error.

Cheers,
Harald van Dijk
