Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90626C433E9
	for <linux-dash@archiver.kernel.org>; Sat, 30 Jan 2021 16:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543E064E11
	for <linux-dash@archiver.kernel.org>; Sat, 30 Jan 2021 16:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhA3QWe (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 30 Jan 2021 11:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhA3PdA (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 30 Jan 2021 10:33:00 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTP id 82F54C06178A
        for <dash@vger.kernel.org>; Sat, 30 Jan 2021 07:31:34 -0800 (PST)
Received: from [IPv6:2a02:8010:68a1:0:3c8e:f6c9:90d1:c02a] (unknown [IPv6:2a02:8010:68a1:0:3c8e:f6c9:90d1:c02a])
        by mail.gigawatt.nl (Postfix) with UTF8SMTPSA id 09B1CD45;
        Sat, 30 Jan 2021 16:31:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 09B1CD45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1612020692;
        bh=19b5h2vaRjRpthTWb3luHXvrNMXvIXbmu1g+6bVZ2oc=; l=2073;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=nn74vBCGCByaOrcV8lu2Pmx2wJqmUXFSf8ve03gRGpWgo2xyZHm433q8mpcqEf7Oi
         CB03NQNsuvpdLuPA8U5q4iEFGoj86fOc+Q1nxS6voq0NZMqflK0pJdMAzKN/vFi3VP
         uoXEXRZ2vVm8kXy0azF3rxt1bSUdGkXRob5zACKk=
Subject: Re: getopts appears to not be shifting $@ when consuming options
From:   Harald van Dijk <harald@gigawatt.nl>
To:     earnestly <zibeon@gmail.com>, dash@vger.kernel.org
References: <YBRTFXGM6pLwR5hg@teapot>
 <c5b375e0-e6b4-df94-3dbd-26c05ecbe688@gigawatt.nl>
Message-ID: <7853ad4d-0eaf-3e91-d5bd-c7a969ed447f@gigawatt.nl>
Date:   Sat, 30 Jan 2021 15:31:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <c5b375e0-e6b4-df94-3dbd-26c05ecbe688@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 29/01/2021 20:15, Harald van Dijk wrote:
> I would suggest that if this is changed to conform to POSIX, a 
> non-standard method should remain available to allow shell functions to 
> use getopts internally, including when the getopts loop in the function 
> calls other functions that themselves use getopts, to ensure that any 
> existing scripts broken by the change can be easily updated. One way to 
> achieve that could be to special-case "local OPTIND=1" so that when the 
> function returns, it restores not just the value of OPTIND, but uses 
> that moment to additionally restore the extra internal state.

I have found that "local OPTIND=1" already works that way in bash, 
restoring upon function return not only the value of OPTIND but also the 
extra internal extra state. It is designed to work like that, not just a 
happy accident: it is listed as a new feature of 4.4. Because of that, 
if something like this is implemented, this would probably be the best 
syntax to use.

I have also found that this is easy to implement: currently, 
getoptsreset() just sets the internal state (shellparam.optind and 
shellparam.optoff) based on the text value of OPTIND. Instead, if:
- var.h defines a new flag to indicate that special hidden data is
   present past the end of OPTIND's text value,
- getopts() builds its own buffer, including the extra hidden data, and
   calls setvareq() directly with that special flag rather than relying
   on setvarint(),
- getoptsreset() checks it to either set the internal state as before
   or restore the internal state, depending on whether that special flag
   is set,
everything just works with no special casing needed in the 
implementation of the "local" command. The net result is even a small 
reduction in code size.

I am only posting a description of the changes rather than a patch or a 
link to a patch because I implemented this in my shell (a fork of dash), 
not dash itself, and the changes as I implemented them cannot be applied 
to dash without some modifications.

Cheers,
Harald van Dijk
