From: Isaac Jurado <diptongo@gmail.com>
Subject: Re: [PATCH] [BUILTIN] Allow SIG* signal names.
Date: Mon, 2 Jul 2012 21:21:01 +0200
Message-ID: <CALqPu34mq_J-=nKxri3y1MQcgmPhgdEmgo4ff5yThpqwyTChHA@mail.gmail.com>
References: <4ff0274f.c54fb40a.47e2.6814@mx.google.com>
	<4FF1A76F.6020307@redhat.com>
	<2D2FC58C-ACD5-4113-9A1D-C53A854C3CD7@aim.com>
	<4FF1AE9C.7040307@redhat.com>
	<CALqPu34=a629YmEiqk008a7aMF26ObEz=MCGA3vZBKTkr25hQA@mail.gmail.com>
	<4FF1F16A.7010103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41003 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab2GBTVC (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 2 Jul 2012 15:21:02 -0400
Received: by vbbff1 with SMTP id ff1so3753606vbb.19
        for <dash@vger.kernel.org>; Mon, 02 Jul 2012 12:21:01 -0700 (PDT)
In-Reply-To: <4FF1F16A.7010103@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Paul Gilmartin <PaulGBoulder@aim.com>, dash <dash@vger.kernel.org>

On Mon, Jul 2, 2012 at 9:07 PM, Eric Blake <eblake@redhat.com> wrote:
>
> I'm not the maintainer, so my decision is not indicative of what the
> dash maintainer will choose.  But my personal preference would be that
> we change this area of code, either to:
>
> 1. be lighter-weight (drop strcasecmp, which is locale-dependent, and
>    replace it with strcmp)
>
> 2. be more user-friendly (accept optional case-insensitive SIG prefix)
>
> Both approaches are permitted by POSIX, so it boils down to a judgment
> call of whether providing useful extensions or providing a minimally
> compliant shell is more important.

Reasonable enough.

> Even one byte larger in the final executable size has been deemed
> bloat on this list in the past.  Dash prides itself on being
> minimalistic, but you happened to point out an area of code that is
> not currently minimal.

But swapping strcasecm with strcmp is not going to affect final binary
size (well, except for the extra bytes in the PLT), so I deduce that
bloat for dash also means runtime efficiency.

> Indeed, that would provide faster lookup, but it would also cost more
> executable size (the storage requirements for a perfect hash table are
> larger than the size of a loop comparison); I don't know whether the
> preference is for speed, for minimal size, or for a hybrid of the two
> (where larger size is okay only if it proves to have more speed).  So
> hopefully the dash maintainer will chime in on the topic.

I'm looking forward.  Thanks a lot for the explanations.

Cheers

P.S.: I guess the SIG* prefix check may be "minimized" with some ugly
casts and masks (in a platform dependent way and assuming the string is
properly aligned, of course).

-- 
Isaac Jurado

"The noblest pleasure is the joy of understanding"
Leonardo da Vinci
