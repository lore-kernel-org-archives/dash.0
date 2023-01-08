Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0C2C54EBC
	for <linux-dash@archiver.kernel.org>; Sun,  8 Jan 2023 23:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjAHXvs (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 18:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAHXvq (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 18:51:46 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF1771CF
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 15:51:44 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id EEBE7DC7;
        Sun,  8 Jan 2023 23:51:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl EEBE7DC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1673221904;
        bh=94opif0W1f7OUcb9TNTHU/47FawcrxhDmelhc5ZJkDU=; l=815;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RX47DNyN2OHn6Hx92jHpbJmrWhIbTJZDQ11mSq1pIZav3XjjLVgcIaCVppN/eeHpl
         FS0lgR/79oL3p7uOL9gpjXOo6iRls0j4gl+yqSwtxPPcAQ+YWHSd4P884oUB4uJ6nU
         OOuVF7TfUGb827Di1CTieO1uMUKR47h5r8Z5tAIk=
Message-ID: <ae838562-3d6d-aad8-f3ae-8d7d23e25c4d@gigawatt.nl>
Date:   Sun, 8 Jan 2023 23:51:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [PATCH RESEND] alias: printalias: quote the name, too
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
References: <Y7aTHHpWKPB2FfA7@gondor.apana.org.au>
 <20230105124947.ewohzmmwddcpj4en@tarta.nabijaczleweli.xyz>
 <Y7qx5BXv1lwHeHdL@gondor.apana.org.au>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Y7qx5BXv1lwHeHdL@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 08/01/2023 12:07, Herbert Xu wrote:
> On Thu, Jan 05, 2023 at 01:49:47PM +0100, наб wrote:
>> This ensures even something like
>>    alias 'a|b|c=d'
>> is output by alias as
>>    'a|b|c'='d'
>> instead of
>>    a|b|c='d'
>> which is both "suitable for reinput to the shell" per POSIX
>> and doesn't execute the aliases as code.
>> ---
>>   src/alias.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Patch applied.  Thanks.

Did either of you test this patch before submitting and pushing it? 
Actually running current dash git, I'm seeing

   $ src/dash -c 'alias foo=bar; alias foo'
   'bar'='bar'

single_quote() is written so that it writes to stackblock() without 
reserving the memory. The second single_quote() call is always going to 
clobber the first.

Cheers,
Harald van Dijk
