From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Bug? "fstat64(f, &sb) < 0 && S_ISREG(sb.st_mode)"
Date: Wed, 26 Oct 2016 23:43:09 +0200
Message-ID: <20161026214309.GA78242@stack.nl>
References: <CAK1hOcMV9YoUNDC_spEawpfFf9hcYdOd-BiF_7rm0CFJ0ZyLaQ@mail.gmail.com>
 <CAOSMAutbPNXKy_GVHDWiJv8=LRDnMPNBrsN1RgwYGVL4gJTwmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mailout05.stack.nl ([131.155.140.202]:36066 "EHLO
        mailout.stack.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933183AbcJZVnN (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 26 Oct 2016 17:43:13 -0400
Content-Disposition: inline
In-Reply-To: <CAOSMAutbPNXKy_GVHDWiJv8=LRDnMPNBrsN1RgwYGVL4gJTwmg@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eduardo Bustamante <dualbus@gmail.com>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

On Tue, Oct 25, 2016 at 12:13:51PM -0500, Eduardo Bustamante wrote:
> I see the change was introduced here
> http://git.kernel.org/cgit/utils/dash/dash.git/commit/?id=f78674ed6f95b594dcac0e96d6a76c5f64aa2cbf,
> by importing code from FreeBSD's sh.

> What I find interesting is testing the contents of 'sb', when the
> fstat64 call failed. FreeBSD's code has the opposite:
> https://github.com/freebsd/freebsd/blob/master/bin/sh/redir.c#L200,
> i.e. they do:

>     if (fstat(f, &sb) != -1 && S_ISREG(sb.st_mode)) {

> BTW, that code was introduced here:
> https://github.com/freebsd/freebsd/commit/e3cb9d1015e8283f4f9d116cf50f510741f8c0dd

The FreeBSD code is how it was intended to be. I don't know how the dash
bug was introduced. The bug only appears when a parallel actor replaces
an openable non-regular file (such as a symlink to /dev/null) with a
regular file and may cause corruption of the file.

As noted on austin-group-l recently, the code does suffer from an issue
where a noclobber open may fail if a parallel actor deletes a
non-regular file (stat reports non-regular file, open fails). Many other
shells have this issue, though.

> Also, the way the open is performed has an interesting consequence,
> i.e. the redirection operation on a FIFO blocks until something is
> written to the FIFO:

> hp% dash -Cc 'rm ff; mkfifo ff; echo a > ff'
> ^Cdash: 1: cannot create ff: Interrupted system call

> It seems to be the same case for mksh, ksh93, posh, pdksh. Not that it
> matters though.

Blocking is intended behaviour when opening a fifo without a
counterparty. It can be used to good effect for synchronizing processes,
sometimes even without transferring any data.

-- 
Jilles Tjoelker
