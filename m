From: Isaac Jurado <diptongo@gmail.com>
Subject: Re: [PATCH] [BUILTIN] Allow SIG* signal names.
Date: Mon, 2 Jul 2012 20:53:20 +0200
Message-ID: <CALqPu34=a629YmEiqk008a7aMF26ObEz=MCGA3vZBKTkr25hQA@mail.gmail.com>
References: <4ff0274f.c54fb40a.47e2.6814@mx.google.com>
	<4FF1A76F.6020307@redhat.com>
	<2D2FC58C-ACD5-4113-9A1D-C53A854C3CD7@aim.com>
	<4FF1AE9C.7040307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52666 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab2GBSxW (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 2 Jul 2012 14:53:22 -0400
Received: by vcbf11 with SMTP id f11so3717975vcb.19
        for <dash@vger.kernel.org>; Mon, 02 Jul 2012 11:53:21 -0700 (PDT)
In-Reply-To: <4FF1AE9C.7040307@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Paul Gilmartin <PaulGBoulder@aim.com>, dash <dash@vger.kernel.org>

On Mon, Jul 2, 2012 at 4:22 PM, Eric Blake <eblake@redhat.com> wrote:
> On 07/02/2012 08:11 AM, Paul Gilmartin wrote:
>> On Jul 2, 2012, at 07:51, Eric Blake wrote:
>>>
>>> ... non-required bloat ...
>>>
>> The key phrase.  And one value of a shell lacking such
>> extensions is that it provides an excellent test bed for
>> code intended to be portable within the POSIX spec.
>
> That argues that we should drop our strcasecmp() for the much simpler
> strcmp(), in order to remove the bloat we already have.

I guess my patch has no chance to be accepted.  But I'm still curious
about what kind of "bloat" you are referring to.  I'm assuming it's not
code bloat in terms of lines of code.

If the signal name to number conversion seems too expensive (linear
search multiplied by the string lengths, wether it is case sensitive or
not), there is a much more elegant solution: perfect hashing.

Since the set of signal names to be recognized is known at compile time,
you can use a perfect hash function generator like GNU Perf [1] which
minimizes character comparisons in order to return the desired constant
assigned to a name/symbol/token/whatever-string.

Furthermore, you could even support POSIX and SIG* prefixed names,
wether they are case sensitive or not, at no additional cost.  Gperf is
a comple time dependency so the final binary can remain only linked to
libc.

Best regards.

-- 
Isaac Jurado

"The noblest pleasure is the joy of understanding"
Leonardo da Vinci
