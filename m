Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA18DC433FE
	for <linux-dash@archiver.kernel.org>; Wed, 23 Nov 2022 11:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiKWLCQ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbiKWLCC (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 23 Nov 2022 06:02:02 -0500
X-Greylist: delayed 31011 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Nov 2022 02:57:13 PST
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6372212A9A
        for <dash@vger.kernel.org>; Wed, 23 Nov 2022 02:57:12 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 4FC4D177;
        Wed, 23 Nov 2022 10:57:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 4FC4D177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1669201031;
        bh=1Hfl5A2vovSRbzvstIUNTbw/F+EaZ7YW5h3kebZKPB4=; l=545;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=MByoLnNPKJsnZh8bc73ZT7tzQtJHHgm2cVA2lPDL1O6UpcYODx+qYw1qMzaLrmgeh
         lNKnbN0RP3gvS0A7vvNk583HGFnJQAdM/7JjOdVSexXv4ikMR4SGfWJ0bZxWQVWr4R
         NoflbVEyjxrreN4+dfbaD3f5hUvDI9j/Vut9Oc1o=
Message-ID: <aa7ac22c-73ad-d7ff-f058-7c3e542326c7@gigawatt.nl>
Date:   Wed, 23 Nov 2022 10:54:55 +0000
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
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <cb7fedc28911acde1f94b76d1dec1ad220172825.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 23/11/2022 04:04, Christoph Anton Mitterer wrote:
> Hey.
> 
> Wasn't busxybox' sh (and that of klibc-utils) based on dash/ash as
> well?

Yes, it is.

> Tried it with them, but there I couldn't reproduce the issue.

With the busybox I have on my own system, I ran reproduce it with:

   busybox ash -c 'f() { echo ${PWD-${PWD!}}; }; f'

This segfaults.

If you try it with ${...//...}, busybox added code to implement that, so 
it does not hit the "Bad substitution" logic.

Cheers,
Harald van Dijk

> Thanks,
> Chris.
> 
