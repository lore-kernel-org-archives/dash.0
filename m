From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH] Don't execute binary files if execve() returned ENOEXEC.
Date: Wed, 8 Feb 2017 09:02:33 +0100
Message-ID: <20170208080233.ekkaosleemxbw6ml@angband.pl>
References: <20170207083307.14881-1-kilobyte@angband.pl>
 <20170207225208.GA743@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:40467 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbdBHICj (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 8 Feb 2017 03:02:39 -0500
Content-Disposition: inline
In-Reply-To: <20170207225208.GA743@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

On Tue, Feb 07, 2017 at 11:52:08PM +0100, Jilles Tjoelker wrote:
> On Tue, Feb 07, 2017 at 09:33:07AM +0100, Adam Borowski wrote:
> > Both "dash -c foo" and "./foo" are supposed to be able to run hashbang-less
> > scripts, but attempts to execute common binary files tend to be nasty:
> > especially both ELF and PE tend to make dash create a bunch of files with
> > unprintable names, that in turn confuse some tools up to causing data loss.
> 
> > Thus, let's read the first line and see if it looks like text.  This is a
> > variant of the approach used by bash and zsh; mksh instead checks for
> > signatures of a bunch of common file types.
> 
> > POSIX says: "If the executable file is not a text file, the shell may bypass
> > this command execution.".
> 
> In FreeBSD sh, I have done this slightly differently (since 2011), based
> on POSIX's definition of a text file in XBD 3:
> 
> ] A file that contains characters organized into zero or more lines. The
> ] lines do not contain NUL characters and none can exceed {LINE_MAX} bytes
> ] in length, including the <newline> character.

Using that definition would require reading the whole file, which can
obviously be slow and/or lead to DoS.

Also, it would reject some scripts currently accepted by popular shells,
including bash, mksh and present version of dash -- none of which ban
lines above LINE_MAX (2048) in length.

> The check is simply for a 0 byte in the first 256 bytes (how many bytes
> are read by pread() for 256 bytes). A file containing the byte 8, for
> example, can still be a text file per POSIX's definition.

The XBD 3 cannot possibly specify allowed byte values, as it doesn't even
know which is the newline, nor does it require even its own "portable
character set" being directly accessible (merely that it's included in one
of shiftable sets provided by a locale).

On the other hand, not only dash assumes 8-bit bytes and ASCII-compatible
charset (what a limitation!), but we also have knowledge about which byte
values are not a part of any printable string in any locale on a supported
platform.  And the set of supported character sets is going to only
decrease[1].

> This check might cause a terse script with binary to fail to execute,
> but I have not received bug reports about that.

In today's brave "curl|sudo sh" world, it's a concern I wouldn't dismiss.
The first line will be a legitimate command to the shell, the rest is often
arbitrary binary junk.

> Stopping the check with a \n will cause a PNG header to be considered
> text.

Good point.  It does fool bash and mksh (with mksh's different approach)
too.  On the other hand, PNG files are not something that's likely to have a
bogus +x permission, and unlike PE or ELF files, empirically I didn't notice
any nasty results.  It's still bad -- not sure what's the best solution.

> Also, FreeBSD sh uses O_NONBLOCK when opening the file and pread() to
> read the data, in order to minimize the potential for modifying things
> by reading.

The manpage for open(2) on Linux says that, while currently O_NONBLOCK has
no effect for regular files and block devices, the expected semantics might
eventually be implemented -- and I guess you're not going to prefault the
beginning of the file before reading, are you?  Thus, O_NONBLOCK is a bad
idea.

As for pread, dash execs a new process (via /bin/sh which might or might not
be dash) so there's no optimization in not reopening the file.  As for
avoiding fifos, the kernel has just checked whether it's a valid executable
anyway.  Am I missing something else?



Meow!

[1]. I've recently gathered stats about use of ancient encodings, and it's
so close to zero that I plan to raise discussion about dropping support for
non-UTF8 in Debian soon.  You might be reluctant to do so in dash for now,
but having a single encoding for all locales would make it easy to fix a
number of POSIX requirements dash fails at because you consider locale
support to be infeasible.  Like, making ${#foo} give length in characters is
a matter of counting bytes outside 0x80..0xBF if assuming well-formed
strings is okay, or not a lot more complex even if full validation is
required.
-- 
Autotools hint: to do a zx-spectrum build on a pdp11 host, type:
  ./configure --host=zx-spectrum --build=pdp11
