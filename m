Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4328CC433E0
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 20:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DF464DE7
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 20:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhA2UPv (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:15:51 -0500
Received: from mail.gigawatt.nl ([51.68.198.76]:49784 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232727AbhA2UPu (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 29 Jan 2021 15:15:50 -0500
Received: from [IPv6:2a02:8010:68a1:0:3c8e:f6c9:90d1:c02a] (unknown [IPv6:2a02:8010:68a1:0:3c8e:f6c9:90d1:c02a])
        by mail.gigawatt.nl (Postfix) with UTF8SMTPSA id 4B01C4AC;
        Fri, 29 Jan 2021 21:15:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 4B01C4AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1611951308;
        bh=PRahr8v1oR6/gedY17Wua2T+ZOlsOaSt/9wArdD5iIY=; l=2061;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GbKz/S/q6VJeNBzvvbyGlHDqGqzHOwuXVYaNmF18AOOVcdqTYb+aGQGVcdBzPfiG8
         64Pm1YA6o5cRgkKTTr2Ise3HWk5t4FRng2CBKDqr1hiD6A/qdVbLqUYYRSXF2m2kMK
         zVhMALFkrO8uOisCAd/yYisz9bTEz3PfW+ejRbxE=
Subject: Re: getopts appears to not be shifting $@ when consuming options
To:     earnestly <zibeon@gmail.com>, dash@vger.kernel.org
References: <YBRTFXGM6pLwR5hg@teapot>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <c5b375e0-e6b4-df94-3dbd-26c05ecbe688@gigawatt.nl>
Date:   Fri, 29 Jan 2021 20:15:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YBRTFXGM6pLwR5hg@teapot>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

On 29/01/2021 18:25, earnestly wrote:
> In this example dash will repeatedly append 'attr=foo' to the list of
> parameters in an infinite loop:
> 
>      #!/bin/dash -x
> 
>      while getopts :a: arg -a foo -a bar; do
>          case $arg in
>              a) set -- "$@" attr="$OPTARG"
>          esac
>      done
>      shift "$((OPTIND - 1))"
> 
> Instead I expected this to result in parameter list containing
> 'attr=foo' and 'attr=bar'.

You are correct in your expectation, I believe: ending the loop after 
processing both arguments is what your script should do.

The reason that dash is behaving the way it does is that dash resets the 
getopts state when the positional arguments are changed by the set or 
shift commands. The getopts state is also reset when the positional 
arguments are changed because of a function call, but restored after the 
function returns. This is something shared across ash-based shells; you 
will also find it in FreeBSD's /bin/sh, and if I am not misreading the 
code, NetBSD's /bin/sh as well.

Although there are certainly cases where this behaviour is useful, 
especially the part where it saves and restores state for function 
calls, there are also where it is not, such as yours. Additionally, it 
appears to be in conflict with POSIX, which requires the getopts state 
to be preserved as long as it continues to be called with the same 
arguments: only resetting OPTIND to 1 is specified to reset the state to 
allow arguments to be parsed anew.

I would suggest that if this is changed to conform to POSIX, a 
non-standard method should remain available to allow shell functions to 
use getopts internally, including when the getopts loop in the function 
calls other functions that themselves use getopts, to ensure that any 
existing scripts broken by the change can be easily updated. One way to 
achieve that could be to special-case "local OPTIND=1" so that when the 
function returns, it restores not just the value of OPTIND, but uses 
that moment to additionally restore the extra internal state.

Cheers,
Harald van Dijk
