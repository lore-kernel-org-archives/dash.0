From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [BUG] Interactive (d)ash exits on assigning to readonly from
 'command eval'
Date: Sun, 30 Oct 2016 18:32:20 +0100
Message-ID: <CAK1hOcPrFvLy=C9La+69_N2w22XWp8stGPR9S8+TxyVNOeYe-Q@mail.gmail.com>
References: <177dba07-fb53-4958-3455-e047c7f32ee6@inlv.org>
 <CAK1hOcO25fYP71DRxk=Dga5UZ6=FfmdDHTj6AWNNGSu_J0B+Dw@mail.gmail.com> <501f83a0-9a46-f4af-dc56-ba8db958bad1@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34472 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbcJ3Rcm (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 30 Oct 2016 13:32:42 -0400
Received: by mail-qt0-f195.google.com with SMTP id l20so453412qta.1
        for <dash@vger.kernel.org>; Sun, 30 Oct 2016 10:32:41 -0700 (PDT)
In-Reply-To: <501f83a0-9a46-f4af-dc56-ba8db958bad1@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Martijn Dekker <martijn@inlv.org>, Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org, busybox <busybox@busybox.net>

On Sat, Oct 29, 2016 at 8:22 PM, Harald van Dijk <harald@gigawatt.nl> wrote:
> On 28/10/16 15:55, Denys Vlasenko wrote:
>>
>> This will probably be mangled by gmail, but here is the proposed fix:
>
>
> This looks about the right approach, but it causes problems in subshells, a
> double free:
>
> $ ./busybox ash -c 'readonly x; echo $(command eval x=2)'
> ash: eval: line 1: x: is read only
> *** Error in `./busybox': free(): invalid pointer: 0x000055a784c1c300 ***
> [...]
>
> That's with busybox checked out from git (commit
> 9db74e49e5b462089c6eec0182d819c0d4708e57), where your patch is applied,
> completely unpatched and completely default config.
>
> I omitted the backtrace output, but it's popfile() getting called, after
> popallfiles() has already been called.

Thanks! Hopefully fixed in git, please try it.
