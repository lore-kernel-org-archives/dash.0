From: Eduardo Bustamante <dualbus@gmail.com>
Subject: Re: Bug? "fstat64(f, &sb) < 0 && S_ISREG(sb.st_mode)"
Date: Tue, 25 Oct 2016 12:13:51 -0500
Message-ID: <CAOSMAutbPNXKy_GVHDWiJv8=LRDnMPNBrsN1RgwYGVL4gJTwmg@mail.gmail.com>
References: <CAK1hOcMV9YoUNDC_spEawpfFf9hcYdOd-BiF_7rm0CFJ0ZyLaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34323 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754630AbcJYROM (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 25 Oct 2016 13:14:12 -0400
Received: by mail-vk0-f54.google.com with SMTP id b186so181044082vkb.1
        for <dash@vger.kernel.org>; Tue, 25 Oct 2016 10:14:12 -0700 (PDT)
In-Reply-To: <CAK1hOcMV9YoUNDC_spEawpfFf9hcYdOd-BiF_7rm0CFJ0ZyLaQ@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

I see the change was introduced here
http://git.kernel.org/cgit/utils/dash/dash.git/commit/?id=f78674ed6f95b594dcac0e96d6a76c5f64aa2cbf,
by importing code from FreeBSD's sh.

What I find interesting is testing the contents of 'sb', when the
fstat64 call failed. FreeBSD's code has the opposite:
https://github.com/freebsd/freebsd/blob/master/bin/sh/redir.c#L200,
i.e. they do:

    if (fstat(f, &sb) != -1 && S_ISREG(sb.st_mode)) {

BTW, that code was introduced here:
https://github.com/freebsd/freebsd/commit/e3cb9d1015e8283f4f9d116cf50f510741f8c0dd

Also, the way the open is performed has an interesting consequence,
i.e. the redirection operation on a FIFO blocks until something is
written to the FIFO:

hp% dash -Cc 'rm ff; mkfifo ff; echo a > ff'
^Cdash: 1: cannot create ff: Interrupted system call

It seems to be the same case for mksh, ksh93, posh, pdksh. Not that it
matters though.
