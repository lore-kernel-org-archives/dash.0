From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [BUG] Interactive (d)ash exits on assigning to readonly from
 'command eval'
Date: Sat, 29 Oct 2016 20:22:00 +0200
Message-ID: <501f83a0-9a46-f4af-dc56-ba8db958bad1@gigawatt.nl>
References: <177dba07-fb53-4958-3455-e047c7f32ee6@inlv.org>
 <CAK1hOcO25fYP71DRxk=Dga5UZ6=FfmdDHTj6AWNNGSu_J0B+Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:34148 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbcJ2SWE (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 29 Oct 2016 14:22:04 -0400
In-Reply-To: <CAK1hOcO25fYP71DRxk=Dga5UZ6=FfmdDHTj6AWNNGSu_J0B+Dw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>, Martijn Dekker <martijn@inlv.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, busybox <busybox@busybox.net>

On 28/10/16 15:55, Denys Vlasenko wrote:
> This will probably be mangled by gmail, but here is the proposed fix:

This looks about the right approach, but it causes problems in 
subshells, a double free:

$ ./busybox ash -c 'readonly x; echo $(command eval x=2)'
ash: eval: line 1: x: is read only
*** Error in `./busybox': free(): invalid pointer: 0x000055a784c1c300 ***
[...]

That's with busybox checked out from git (commit 
9db74e49e5b462089c6eec0182d819c0d4708e57), where your patch is applied, 
completely unpatched and completely default config.

I omitted the backtrace output, but it's popfile() getting called, after 
popallfiles() has already been called.

Cheers,
Harald van Dijk
