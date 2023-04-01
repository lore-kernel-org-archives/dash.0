Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB9EC77B60
	for <linux-dash@archiver.kernel.org>; Sat,  1 Apr 2023 20:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDAUuT (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 1 Apr 2023 16:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDAUuS (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 1 Apr 2023 16:50:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BC72700F
        for <dash@vger.kernel.org>; Sat,  1 Apr 2023 13:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680382174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lsy5ooVlReT+7vFNJ2+va0ZU62hzPNrhZPFWK4pUb34=;
        b=NgYnkd0hBi6sVuDRgcapgum5TVKKRXsZTwelpgdNVmNzzMJwW/yXhk9kahKMNktbIyzmVx
        3Xym/b9unZio7xCiEbb+lQixxwP62t1BHs2drOJfuj35Kh26Sb1LYMPQK7pZY8aFxQlCP7
        /s0/b2jkPBaxMJypv4Nq7hwk6ze8OVg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-fQqd4-lyO0KcqS-zSvlNaQ-1; Sat, 01 Apr 2023 16:49:32 -0400
X-MC-Unique: fQqd4-lyO0KcqS-zSvlNaQ-1
Received: by mail-ed1-f72.google.com with SMTP id a40-20020a509eab000000b005024c025bf4so23802971edf.14
        for <dash@vger.kernel.org>; Sat, 01 Apr 2023 13:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680382171;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lsy5ooVlReT+7vFNJ2+va0ZU62hzPNrhZPFWK4pUb34=;
        b=QBM2IUtekXxwHL2qJt++v0bHtgLG44U458Forqm3r4ybN52NFrwE2Jmo5RuBJSOtXn
         4YB3uV2Pk0xEVwZXgAw3riQvgTPrGBPRq1mDZI3xMzdXcVNkNK9gLXiNcKRrO6bKiQe7
         Np13i9cnA8oap8ycPnuTlzQTJAob0UVsrqAcJ+6XAYJpX860QD1hZ+4Ft2S7P21XH5uq
         DBElqfJRqXQyc9bZ8yGXNHsk52F8PPO3/TXP51UQCBtyEJlVfAwVF8lvlAkvDWGQpB1D
         AEL0d24pToxHzQeGc+ZLW0tdQnJFI2hiu+TwBd6cfQb4XPFR4Rmx0aZujzo/GTNKOgOU
         nzjw==
X-Gm-Message-State: AAQBX9dL4eSvZYXniMBHEtYUiEWo42SBMpviQJ8XJ7vbXQSOnjQrac5k
        GkuVonTiaeZbZf6f0OIJroM1Jp7PQur/4l+sO+Kb1AmPHNhbqiDv2jCezaANzfcXY/ozFedsMJM
        oz2Nb0STo/LR2AgGNSQGj4w==
X-Received: by 2002:a17:907:1c21:b0:8dd:5710:a017 with SMTP id nc33-20020a1709071c2100b008dd5710a017mr39668055ejc.4.1680382171134;
        Sat, 01 Apr 2023 13:49:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350aK/zllMeTxg4gBbbhMpJfs7zd8bGqn3X4PDrGPhZaj2Y21IMAkFhDa21pyKRX61U3Ey+kImw==
X-Received: by 2002:a17:907:1c21:b0:8dd:5710:a017 with SMTP id nc33-20020a1709071c2100b008dd5710a017mr39668046ejc.4.1680382170854;
        Sat, 01 Apr 2023 13:49:30 -0700 (PDT)
Received: from [192.168.1.220] ([78.157.137.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a170906230600b008d68d018153sm2442391eja.23.2023.04.01.13.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 13:49:30 -0700 (PDT)
Message-ID: <e57e26c4-a37f-37e8-90bf-6f19295eab59@redhat.com>
Date:   Sat, 1 Apr 2023 22:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Are there users of ash's "pathopts"? Do other shells have such a
 thing?
Content-Language: en-US
To:     Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
References: <aad32205-1e0a-fea6-0825-8eb45c6ae915@redhat.com>
 <e69d7554-6047-f527-9489-0d8e872643ae@gigawatt.nl>
From:   Denys Vlasenko <dvlasenk@redhat.com>
In-Reply-To: <e69d7554-6047-f527-9489-0d8e872643ae@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 4/1/23 21:13, Harald van Dijk wrote:
>> I assume it's rarely (never?) used in the wild.
>> It interferes with valid directories with percents in names.
>> It's non-standard, and not a typical feature of other Bourne-like shells
>>    (maybe we (ash family) are the only ones?)
>> Code complication to support it is a chore.
> 
> It is not clear to me whether you mean "non-standard" as "conflicts with the standard", or "not required by the standard".

"not required".

More importantly, no one else among shells seems to have such extension.
This means it's probably not terribly useful.

There is value in *not* having extensions "just because we can".
Extensions fragment user base.
IOW: extensions make sense when they are *useful*.

Shells already have way too much of featuritis.
Just now, I learned that CDPATH is a thing... oh god.
Yet another danger of subtle bugs in scripts when one
of their innocuous "mkdir subdir; cd subdir" suddenly
cd's somewhere else...
..and this "feature" seems to be in bash too,
and who knows where else.

