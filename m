Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11965C433F5
	for <linux-dash@archiver.kernel.org>; Thu, 17 Feb 2022 16:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbiBQQR3 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:17:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243021AbiBQQRZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 17 Feb 2022 11:17:25 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B49D23C85A
        for <dash@vger.kernel.org>; Thu, 17 Feb 2022 08:17:10 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:d0d4:d13c:6697:df13] (unknown [IPv6:2a02:8010:68a1:0:d0d4:d13c:6697:df13])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 8C7FC477;
        Thu, 17 Feb 2022 16:17:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 8C7FC477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1645114629;
        bh=Bz/bQrws4pcuW9MfVYPa/BrBQEPXpzLXPstTtItaAtA=; l=896;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fP655+2a5zKB/FbnOG8en3UU4IIffnttCno1I5hbUrAqJIbAo3rNDXtB1fPE19vT8
         vI6gZ3uyiK/I8WsHFPt6uBoXY45ftzntKPEFmCweEglgIcJc8/XmZUgK34sMOxJn3V
         JwEnn/t+bVA5MzRBhMQOHqSjVPFswt5a7uB5CLVU=
Message-ID: <39a80930-6890-9a09-c1d4-8da335d967f8@gigawatt.nl>
Date:   Thu, 17 Feb 2022 16:17:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:97.0) Gecko/20100101
 Thunderbird/97.0
Subject: Re: dash doesn't support switching LC_* during a script/session
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        dash@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>
References: <e312d45e17b49c418c3a62a56da758977067b563.camel@scientia.org>
 <13f96ba3-7d6f-fdb2-1cd8-b010465567f8@gigawatt.nl>
 <53c982b79d7d9b29cb5c9183f6d03b1f4f48103e.camel@scientia.org>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <53c982b79d7d9b29cb5c9183f6d03b1f4f48103e.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 17/02/2022 16:09, Christoph Anton Mitterer wrote:
> Hey.
> 
> 
> On Wed, 2022-02-16 at 23:28 +0000, Harald van Dijk wrote:
>> You were right to guess that POSIX does mandate that shells support
>> locales. The lack thereof is a longstanding area of nonconformance in
>> dash.
> 
> Well actually it is conforming then, since POSIX indeed doesn't demand
> support for any locales other than C/POSIX.

It indeed doesn't, but an implementation that supports locales is 
required to support them in all utilities, including sh. However...

> My testing back then was a bit flawed, and I had thought that dash
> would support locales and that just the switching fails.
> But AFAIU now, it simply doesn't support them at all, and always runs
> in C.
> 
> Which is btw. also ok for my purposes ;-)

...if you don't need that, that's good news for you. :)

Cheers,
Harald van Dijk
