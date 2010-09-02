From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: read() builtin doesn't read integer value /proc files (but
 bash's does)
Date: Thu, 2 Sep 2010 21:09:47 +0200
Message-ID: <20100902190947.GA66603@stack.nl>
References: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:51138 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753434Ab0IBTJt (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 2 Sep 2010 15:09:49 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Steve Schnepp <steve.schnepp@gmail.com>
Cc: dash@vger.kernel.org, 595063@bugs.debian.org

On Wed, Sep 01, 2010 at 10:10:11AM +0200, Steve Schnepp wrote:
> Hi, I opened bug 595063 on the debian BTS [1] and I was suggested to
> resend the email upstream.

> So I copied the body of the bug below :

> dash's read() builtin seems to read the underlying file 1 char at a
> time. This doesn't work with some files under /proc, since procfs isn't
> fully POSIX compliant.

> [snip]

> After a little digging, it only appears on files that contains just an
> integer value. When asked to read with a non-null offset (*ppos != 0),
> __do_proc_dointvec() just returns 0 (meaning an EOF) as shown on [2].

> I'm aware that the issue isn't strictly a dash one, since it has the
> right to read one character at a time. But since fixing procfs to be
> conforming to POSIX isn't a realistic option, would it be possible to
> have a workaround that doesn't involve an external tool like cat(1) ?

Given that other files in /proc do work, I don't see why the ones that
only contain an integer value cannot be fixed. All the necessary state
to produce the second and further bytes is available.

Choosing a powerful abstraction like a regular file has its
implications.

Note that a change in the file between the single-byte reads will cause
an inconsistent value to be read. This is also the case with regular
files on a filesystem, so it is acceptable.

If single-byte reads are really unacceptable, then the proper way to
read these files needs to be documented, and clear violations that will
not work properly should cause an error (in this case, this means that
reading one byte from offset 0 should fail like reading one byte from
offset 1 does).

-- 
Jilles Tjoelker
