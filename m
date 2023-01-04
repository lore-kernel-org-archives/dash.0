Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3B3C54EBC
	for <linux-dash@archiver.kernel.org>; Wed,  4 Jan 2023 14:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbjADOc2 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Jan 2023 09:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbjADOcT (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Jan 2023 09:32:19 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 114E937522
        for <dash@vger.kernel.org>; Wed,  4 Jan 2023 06:32:15 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id A031B477;
        Wed,  4 Jan 2023 14:32:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl A031B477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1672842734;
        bh=EQMZYVYVBIoASd1WQllQeX8/FjCnDdo9F5LXCuPTugg=; l=1086;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o3EbMbS9sTKkUrpV540zGY8Cxz+FrbUsj5OpEFJJSlttXy3S9wKttqPYDAlnOv3NG
         ax76JBcJXGtnkvr6ywGNgLRzXxuSsC8vEGUrx56HS6p5uwzhCy3+KxK2OUs5/MDg2Y
         kh/XknkCaIePjvXH4PcsGilqVkqXmR4FIKirSPBI=
Message-ID: <6883838e-4340-c80a-cca4-83d2d57078ba@gigawatt.nl>
Date:   Wed, 4 Jan 2023 14:30:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [PATCH v2 2/3] parser: synerror: explicitly consume the entire
 invalid line
Content-Language: en-US, en-GB
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
References: <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
 <bb422d70-0ba5-e29b-3ec8-8fc1c4630233@gigawatt.nl>
 <Y7VMJGPXXziUrBio@gondor.apana.org.au>
 <8ddcc8a3-9588-435a-9d5f-1edbcd121012@gigawatt.nl>
 <Y7WIuSnsIbkHrEvH@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Y7WIuSnsIbkHrEvH@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 04/01/2023 14:10, Herbert Xu wrote:
> On Wed, Jan 04, 2023 at 11:25:09AM +0000, Harald van Dijk wrote:
>>
>> Since the only case where special care is needed is when the problematic
>> token was newline, it can be handled as simply as
>>
>>    if (lasttoken != TNL)
>>      skipline();
> 
> You're assuming that the only way of exiting the parser is
> through synerror.  That's not the case.  We could also exit
> through sh_error, e.g., if ckmalloc runs out of memory.

In theory, yes. In practice, because of the default Linux overcommit 
behaviour, that is not going to happen, that's going to cause the OOM 
killer to kick in and forcibly kill the whole process without any way of 
handling it. Either that, or forcibly kill some other process that we 
get no indication of.

Even if we change the overcommit settings, I'm struggling to think of 
any situation where parsing fails because we run out of memory, but 
freeing the memory we've already allocated for parsing that one line of 
input frees enough to allow us to meaningfully continue.

Cheers,
Harald van Dijk
