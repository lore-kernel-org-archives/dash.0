Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B83C3DA7D
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 08:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjAEIds (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 03:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjAEIdr (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 03:33:47 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE09C4C712
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 00:33:45 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id DF4E2744;
        Thu,  5 Jan 2023 08:33:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl DF4E2744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1672907625;
        bh=JTB5gFwfBahcwBaThS+5tjo/ydDlyJrES9d+Dgpiqxk=; l=880;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aaqtyLwOhn6aGxnhQef3o+OfQc69xwfz2+KEDI2KbOFPQ4Aq1bLUYImWEkeG36s1B
         PzvnILK/zurnZ3yiqIaDR7CEoS2z5/xEi/DRb1HEQbEZ2/xyFPHOzgWHhkfjN/uMhT
         hcnMeDdSfUaxuqZX0789nCg9aD9td4IaNGTUJtG8=
Message-ID: <22abb780-d23b-3c55-56af-09e52e2fdb15@gigawatt.nl>
Date:   Thu, 5 Jan 2023 08:33:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [PATCH] input: Only skip blank lines on PS1
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
References: <Y7PIHqN4ic4UBOBb@gondor.apana.org.au>
 <9a6c2bc5-11aa-db99-8db5-541060624b01@gigawatt.nl>
 <Y7U/2PnYCDA5stZ8@gondor.apana.org.au>
 <83fb967d-19e3-d7de-becc-179af3045e59@gigawatt.nl>
 <Y7Z7kiVnwF+sltL+@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Y7Z7kiVnwF+sltL+@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 05/01/2023 07:26, Herbert Xu wrote:
> On Wed, Jan 04, 2023 at 11:18:49AM +0000, Harald van Dijk wrote:
>>
>> One is that because of what you say, the history recording for commands
>> greater than BUFSIZ is already buggy, but unlikely to pose a problem in
>> practice currently because normally, people don't write such long commands.
> 
> It's not just that people don't write long lines, it's the fact
> that most people use the shell with a terminal device in canonical
> mode and the line length is capped in canonical mode to some value
> less than 8K.

Remember that we're talking about builds of dash here with libedit 
support, as otherwise history is disabled anyway. In builds with libedit 
support, I would imagine the more common use is that libedit is used for 
entry, in which case the terminal is *not* in canonical mode.

Cheers,
Harald van Dijk
