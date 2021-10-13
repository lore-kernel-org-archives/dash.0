Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742FCC433F5
	for <linux-dash@archiver.kernel.org>; Wed, 13 Oct 2021 21:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 479A161163
	for <linux-dash@archiver.kernel.org>; Wed, 13 Oct 2021 21:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJMVdI (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 13 Oct 2021 17:33:08 -0400
Received: from mail.gigawatt.nl ([51.68.198.76]:54700 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhJMVdI (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 13 Oct 2021 17:33:08 -0400
Received: from [IPV6:2a02:8010:68a1:0:4959:4cdf:35e8:52a0] (unknown [IPv6:2a02:8010:68a1:0:4959:4cdf:35e8:52a0])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 410C43EB;
        Wed, 13 Oct 2021 22:31:00 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 410C43EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1634160660;
        bh=kSgVi0LowI1OEUDcCcy2jwaLfkQMvhQSlJpYwUkNLF8=; l=1657;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UR0HuuUib43unayzuBEw2yRqp9XXtbl05tiKl/eAOOK6ACaMeCzENJGVlbtODR2Bw
         DyG4B3nJFiMUwvTY8yRvInseXSxcCXxWsaLrqP0OHe/xFYNA/9Ow/vO61vbHvbEEM7
         1e9BbxYEr22yd/ch85Z6yAGbYMRPqHMU87nALomM=
Message-ID: <246b57f4-3ff0-d47c-0747-c372166af345@gigawatt.nl>
Date:   Wed, 13 Oct 2021 22:31:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: $ENV handling depends on defined(linux), why??
To:     Denys Vlasenko <vda.linux@googlemail.com>
Cc:     DASH shell mailing list <dash@vger.kernel.org>
References: <CAK1hOcNgTbRgWVjidA63NJqa4_+ExRuE5XpSM14s5VGw2eQT_A@mail.gmail.com>
 <61f9c77a-b8c9-d25d-c72d-34e342917f58@gigawatt.nl>
 <CAK1hOcM9mQnbsgGz47fYr+A059hr1SW++_25_cGCdVVFfnofUA@mail.gmail.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CAK1hOcM9mQnbsgGz47fYr+A059hr1SW++_25_cGCdVVFfnofUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 13/10/2021 20:17, Denys Vlasenko wrote:
> On Wed, Oct 13, 2021 at 11:56 AM Harald van Dijk <harald@gigawatt.nl> wrote:
>> On 13/10/2021 10:39, Denys Vlasenko wrote:
>>>                       Who in their right mind would have a *setuid*
>>> shell executable on any system where security matters?
>>
>> I suspect this was originally not for the benefit of setuid shell
>> executables, but setuid shell scripts. Linux does not support those, so
>> the check is considered unnecessary on Linux.
>>
>> However, actually, doing something along those lines is useful even on
>> Linux when setuid applications can be tricked to launch shell processes
>> in insecure ways.
> 
> Not sourcing $ENV is nowhere near enough to ploug this hole,

Agreed.

> so doing it is still pointless.

If someone were proposing to do this now, then I would agree. But the 
fact that this has been in forever makes me personally think there's 
nothing gained by changing it now to something we'd already know will 
need changing again later: on Linux the only effect of the change would 
be to cause conflicts for distros that already picked up the privmode 
patches years ago.

For better or worse, what dash implements now, except for the #ifndef 
linux, is specified by POSIX, by the way: "ENV shall be ignored if the 
user's real and effective user IDs or real and effective group IDs are 
different." That'd actually be an argument in favour of the opposite 
direction: removing only the #ifndef/#endif to make sure this check is 
performed on all operating systems. But as that's less secure than what 
bash does, I'd still favour following bash.

Cheers,
Harald van Dijk
