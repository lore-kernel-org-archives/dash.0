Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE153C433FE
	for <linux-dash@archiver.kernel.org>; Wed, 23 Nov 2022 23:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiKWXbK (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKWXbJ (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 23 Nov 2022 18:31:09 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C98331370
        for <dash@vger.kernel.org>; Wed, 23 Nov 2022 15:31:05 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:26d4:234:5292:8b5e] (unknown [IPv6:2a02:8010:68a1:0:26d4:234:5292:8b5e])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 67DBF177;
        Wed, 23 Nov 2022 23:31:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 67DBF177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1669246264;
        bh=H5jBqWGzaGIrHU6YdqbzW9m4o3dvomAajRbf7MSi5jA=; l=722;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=FXFdA+tmsz3CKQLT9XFEKmSLAbP5Z+Xv9BkB2DT4ZFCpa+9vGBcpG0gxHzgQ65qdw
         rZKhDDGaUXzW6yjAdUNgly9fTr/M3YlIXveDzBfCRDjFEo+F7Q+9DdgXIwKJ/wigVm
         dbQIClbvoMvmXb+B+6G3Wu+y6Sgp28yrI+FL72TA=
Message-ID: <9b7465c0-a562-e175-292e-6c860ee9a091@gigawatt.nl>
Date:   Wed, 23 Nov 2022 23:30:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101
 Thunderbird/107.0
Subject: Re: segfault with invalid shell script
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        dash@vger.kernel.org
References: <b2e298215b3d51d8284296484caa138faddaa0e4.camel@scientia.org>
 <6af07303-357f-6274-6c16-df00835c7f6c@gigawatt.nl>
 <8710d1c3-d7c9-7332-4bc7-ce243a1cbd37@gigawatt.nl>
 <cb7fedc28911acde1f94b76d1dec1ad220172825.camel@scientia.org>
 <aa7ac22c-73ad-d7ff-f058-7c3e542326c7@gigawatt.nl>
 <fe9be702c676b43bba8e0136a94583f919a05a66.camel@scientia.org>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <fe9be702c676b43bba8e0136a94583f919a05a66.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 23/11/2022 17:21, Christoph Anton Mitterer wrote:
> On Wed, 2022-11-23 at 10:54 +0000, Harald van Dijk wrote:
>> With the busybox I have on my own system, I ran reproduce it with:
>>
>>     busybox ash -c 'f() { echo ${PWD-${PWD!}}; }; f'
>>
>> This segfaults.
> 
> Would you mind reporting this at busybox and klib-utils sh then?

Sure, I have reported this to the busybox list and CCed you. If there is 
a separate list for klib-utils where this should also be reported (I am 
not aware of one), could you forward it there?

Cheers,
Harald van Dijk

> I mean I could do, if you want me to, ... but since this was rather
> found by you now, you should take the "credit".
> 
> 
> Thanks,
> Chris.
> 
