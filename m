From: Eduardo Bustamante <dualbus@gmail.com>
Subject: Re: Bug? "fstat64(f, &sb) < 0 && S_ISREG(sb.st_mode)"
Date: Wed, 26 Oct 2016 19:35:22 -0500
Message-ID: <CAOSMAus_wZWxxsbmiGi2+edcc9rgH9LvToUH62Qr=ePq9SkNOw@mail.gmail.com>
References: <CAK1hOcMV9YoUNDC_spEawpfFf9hcYdOd-BiF_7rm0CFJ0ZyLaQ@mail.gmail.com>
 <CAOSMAutbPNXKy_GVHDWiJv8=LRDnMPNBrsN1RgwYGVL4gJTwmg@mail.gmail.com> <20161026214309.GA78242@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33538 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932388AbcJ0Agl (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 26 Oct 2016 20:36:41 -0400
Received: by mail-oi0-f44.google.com with SMTP id y2so21946372oie.0
        for <dash@vger.kernel.org>; Wed, 26 Oct 2016 17:35:43 -0700 (PDT)
In-Reply-To: <20161026214309.GA78242@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

>> hp% dash -Cc 'rm ff; mkfifo ff; echo a > ff'
>> ^Cdash: 1: cannot create ff: Interrupted system call
>
>> It seems to be the same case for mksh, ksh93, posh, pdksh. Not that it
>> matters though.
>
> Blocking is intended behaviour when opening a fifo without a
> counterparty. It can be used to good effect for synchronizing processes,
> sometimes even without transferring any data.

Yup, sorry about the noise there. That was just a misunderstanding on my part.
