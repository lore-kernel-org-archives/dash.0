Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391A7C433DB
	for <linux-dash@archiver.kernel.org>; Sun, 10 Jan 2021 23:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D2722955
	for <linux-dash@archiver.kernel.org>; Sun, 10 Jan 2021 23:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbhAJX4w (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 10 Jan 2021 18:56:52 -0500
Received: from mail.gigawatt.nl ([51.68.198.76]:42256 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbhAJX4v (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 10 Jan 2021 18:56:51 -0500
Received: from [192.168.1.5] (92.40.194.3.threembb.co.uk [92.40.194.3])
        by mail.gigawatt.nl (Postfix) with UTF8SMTPSA id 90DF43C8;
        Mon, 11 Jan 2021 00:56:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 90DF43C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1610322969;
        bh=xnc0w3tJy/s5y6M4CmzSdl+vRcwYQVk4lX5wIkStF+w=; l=1701;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=RC2KM7xUMticZUdXpVNASMgBMcQx7DCc+VhcUpdMpiw3MiRccgHluFXSkmpS9fHfJ
         w4BDYLMwQbpQluZKcH+jkgKSxVBoNp0L9TfpXgxyL9jfJdFpb7XNySDixPxlrDzii6
         5DJ8P43yJtACMpQvMiQrbbNWgSOdksAwdKi8MylI=
Subject: Re: dash 0.5.11.2, busybox sh 1.32.0, FreeBSD 12.2 sh: spring TTOU
 but should not i think
From:   Harald van Dijk <harald@gigawatt.nl>
To:     Jilles Tjoelker <jilles@stack.nl>
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>,
        DASH shell mailing list <dash@vger.kernel.org>,
        Denys Vlasenko <vda.linux@googlemail.com>
References: <20201219172838.1B-WB%steffen@sdaoden.eu>
 <20201219222122.p9UYT%steffen@sdaoden.eu>
 <9bb6fbb5-20e1-eae1-0144-67a4c7e20496@gigawatt.nl>
 <20201221162442.GA26001@stack.nl>
 <bf6e1634-e472-1e9f-056a-ae98be7ec9d1@gigawatt.nl>
Message-ID: <e66acdb5-9a1b-c8ee-38d1-cb04af914cbd@gigawatt.nl>
Date:   Sun, 10 Jan 2021 23:56:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <bf6e1634-e472-1e9f-056a-ae98be7ec9d1@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 23/12/2020 20:18, Harald van Dijk wrote:
> On 21/12/2020 16:24, Jilles Tjoelker wrote:
>> Tradition is for job control shells to be a process group leader, but I
>> don't really know why. Changing this will not fix the issue entirely
>> anyway since the shell must perform tcsetpgrp() from the background when
>> a foreground job has terminated.
> [...]
> This should, in my opinion, *only* happen for interactive shells, not 
> for job-control-enabled non-interactive shells. [...]
Consider also an extra difficulty arising from this process group switching:

   : | dash -m

When a job-control-enabled shell terminates, or when job control is 
disabled via set +m, it attempts to re-join its initial process group 
and set that as the foreground process group. This can fail if the 
process group has ceased to exist after the shell left it, as it does 
here, resulting in:

   $ : | dash -m
   dash: 0: Cannot set tty process group (No such process)

In theory, because of PID reuse, this may even result in some random 
unrelated process group temporarily becoming the foreground process group.

I am leaning towards saying that once the shell has committed to 
becoming a process group leader, it should remain one. By basing this on 
the shell being interactive rather than on job control being enabled, 
this is easier to handle, as as far as POSIX is concerned "interactive" 
is a property that cannot be changed once the shell has started: set -i 
and set +i are extensions not required by POSIX, and if they are 
nonetheless supported it is easy to defend them not being fully 
equivalent to specifying or leaving out -i on the shell invocation.

Cheers,
Harald van Dijk
