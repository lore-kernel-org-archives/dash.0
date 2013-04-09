From: Dan Kegel <dank@kegel.com>
Subject: Re: Crash on valid input
Date: Mon, 8 Apr 2013 20:12:31 -0700
Message-ID: <CAPF-yOZmkcKSpU+jVMsSi6Q8harUYZ-hS5Ugn7SsbBwm-GzhiQ@mail.gmail.com>
References: <CAPF-yOaPfWdK2c556eTcRuf-thaHEzUcMKa+xa8criaS8uFLUw@mail.gmail.com>
	<51638620.4030603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:63392 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934544Ab3DIDMd (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Apr 2013 23:12:33 -0400
Received: by mail-lb0-f172.google.com with SMTP id u10so6394335lbi.3
        for <dash@vger.kernel.org>; Mon, 08 Apr 2013 20:12:32 -0700 (PDT)
In-Reply-To: <51638620.4030603@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

Yes, my script was crap, I've fixed it.

Here's the reproducer.  Called with foo unset.  I think it doesn't
crash without -x.

#!/bin/dash
set -x
test ! $foo



On Mon, Apr 8, 2013 at 8:08 PM, Eric Blake <eblake@redhat.com> wrote:
> On 04/08/2013 08:43 PM, Dan Kegel wrote:
>> If I check for an empty string like this:
>>
>> + test ! $foo
>
> You know, this is highly reliant on $foo expanding to either nothing (it
> is empty, so you are really invoking the one-argument form 'test !'
> which is true) or a single shell word (the two-argument form 'test !
> nonempty' is false).  But if $foo has embedded whitespace, it expands to
> more than one word after word-splitting, and you're hosed ('test ! one
> two' can give interesting results, and probably not what you were
> expecting).
>
> You might want to fix your script to just use the safer:
>
> ! test "$foo"
>
> which works even if $foo has embedded whitespace.  That said, you are
> correct that dash should never crash.
>
>>
>> dash crashes.  This occurs both in the version shipped with ubuntu
>> 10.04 and 12.04
>> as well as with dash from git.
>>
>> Here's the stack:
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> __strcmp_sse4_2 () at ../sysdeps/i386/i686/multiarch/strcmp-sse4.S:221
>> 221 ../sysdeps/i386/i686/multiarch/strcmp-sse4.S: No such file or directory.
>> (gdb) bt
>> #0  __strcmp_sse4_2 () at ../sysdeps/i386/i686/multiarch/strcmp-sse4.S:221
>> #1  0x0805938a in getop (s=0x202b <Address 0x202b out of bounds>) at
>> bltin/test.c:168
>> #2  0x08059c91 in t_lex (tp=0x806581c) at bltin/test.c:431
>> #3  0x080595cb in aexpr (n=UNOT) at bltin/test.c:260
>> #4  0x08059557 in oexpr (n=UNOT) at bltin/test.c:243
>> #5  0x080594ba in testcmd (argc=1, argv=0x8065814) at bltin/test.c:219
>> #6  0x0804c526 in evalbltin (cmd=0x805da1c, argc=2, argv=0x8065810,
>> flags=0) at eval.c:910
>
> and given this part of the stack trace, it looks like you were invoking
> 'test ! word'?  But I was unable to reproduce a crash when I tried
> dash.git, so it would be helpful to know exactly what $foo was in your
> reproducer.
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
