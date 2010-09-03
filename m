From: Steve Schnepp <steve.schnepp@gmail.com>
Subject: Re: read() builtin doesn't read integer value /proc files (but bash's does)
Date: Fri, 3 Sep 2010 11:23:21 +0200
Message-ID: <AANLkTikb7iJ_i=BfnFukSuby2i8ueSEcO9T0zqNy9X-+@mail.gmail.com>
References: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com> <20100902190947.GA66603@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54561 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab0ICJYD (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 3 Sep 2010 05:24:03 -0400
Received: by vws3 with SMTP id 3so1192693vws.19
        for <dash@vger.kernel.org>; Fri, 03 Sep 2010 02:24:01 -0700 (PDT)
In-Reply-To: <20100902190947.GA66603@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org, 595063@bugs.debian.org

2010/9/2 Jilles Tjoelker <jilles@stack.nl>:

Thanks for your prompt reply.

> Note that a change in the file between the single-byte reads will cause
> an inconsistent value to be read. This is also the case with regular
> files on a filesystem, so it is acceptable.

Are you implying that:
- if the procfs is made to support char per char reads, dash reading
an inconsistent value is actually a feature ?
- buffering should, therefore, always be explicit ?

On a side note, the whole procfs seems to be designed around one
unique page read if possible (1x 4K).
I think it does so in order to be able to vastly simplify its
usage/implementation by kernel modules.

> If single-byte reads are really unacceptable, then the proper way to
> read these files needs to be documented, and clear violations that will
> not work properly should cause an error (in this case, this means that
> reading one byte from offset 0 should fail like reading one byte from
> offset 1 does).

+1 for "the proper way to read these files needs to be documented" and
I also think that emitting an error would be better than silently
returning erroneous data. [ EOVERFLOW is coming to my mind ]

--
Steve Schnepp
http://blog.pwkf.org/
