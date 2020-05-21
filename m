From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Bug in Dash's unquoting of backslashes within backquoted strings
Date: Thu, 21 May 2020 23:02:02 +0100
Message-ID: <e8735922-37c2-0250-1956-079ea761f1fd@gigawatt.nl>
References: <b2fe3536-23b8-4d04-8197-701ab50da86f@mattwhitlock.name>
 <5ec6f4d5.8pMzL3JNioCKa/Fi%rmy@frippery.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.gigawatt.nl ([51.68.198.76]:44796 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgEUWCq (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 21 May 2020 18:02:46 -0400
In-Reply-To: <5ec6f4d5.8pMzL3JNioCKa/Fi%rmy@frippery.org>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Ron Yorston <rmy@frippery.org>, dash@vger.kernel.org, dash@mattwhitlock.name

On 21/05/2020 22:38, Ron Yorston wrote:
> Matt Whitlock wrote:
>> A minimal example:
>>
>> : `: "\\\\
>> \\$(bug)"`
> 
>> However, when it appears inside a backquoted subcommand (with the
>> backslash characters being appropriately escaped), such as given at the top
>> of this report, then Dash processes it incorrectly:
>>
>> /bin/sh: 1: bug: not found
> 
> This seems to have been introduced by commit 6bbc71d (parser: use
> pgetc_eatbnl() in more places).  Reverting the following part of the
> commit makes the problem go away:

Yes, that commit (a patch I had submitted) was buggy and the part that 
you suggest reverting should be.

Cheers,
Harald van Dijk
