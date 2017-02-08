From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] Don't execute binary files if execve() returned ENOEXEC.
Date: Wed, 8 Feb 2017 23:11:24 +0100
Message-ID: <20170208221123.GA9111@stack.nl>
References: <20170207083307.14881-1-kilobyte@angband.pl>
 <20170207225208.GA743@stack.nl>
 <20170208080233.ekkaosleemxbw6ml@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mailout05.stack.nl ([131.155.140.202]:39971 "EHLO
        mailout.stack.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752240AbdBHWLd (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 8 Feb 2017 17:11:33 -0500
Content-Disposition: inline
In-Reply-To: <20170208080233.ekkaosleemxbw6ml@angband.pl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
Cc: dash@vger.kernel.org

On Wed, Feb 08, 2017 at 09:02:33AM +0100, Adam Borowski wrote:
> On Tue, Feb 07, 2017 at 11:52:08PM +0100, Jilles Tjoelker wrote:
> > On Tue, Feb 07, 2017 at 09:33:07AM +0100, Adam Borowski wrote:
> > > Both "dash -c foo" and "./foo" are supposed to be able to run hashbang-less
> > > scripts, but attempts to execute common binary files tend to be nasty:
> > > especially both ELF and PE tend to make dash create a bunch of files with
> > > unprintable names, that in turn confuse some tools up to causing data loss.

> > > Thus, let's read the first line and see if it looks like text.  This is a
> > > variant of the approach used by bash and zsh; mksh instead checks for
> > > signatures of a bunch of common file types.

> > > POSIX says: "If the executable file is not a text file, the shell may bypass
> > > this command execution.".

> > In FreeBSD sh, I have done this slightly differently (since 2011), based
> > on POSIX's definition of a text file in XBD 3:

> > ] A file that contains characters organized into zero or more lines. The
> > ] lines do not contain NUL characters and none can exceed {LINE_MAX} bytes
> > ] in length, including the <newline> character.

> Using that definition would require reading the whole file, which can
> obviously be slow and/or lead to DoS.

> Also, it would reject some scripts currently accepted by popular shells,
> including bash, mksh and present version of dash -- none of which ban
> lines above LINE_MAX (2048) in length.

The part you quoted has does not require that the shell bypass the
execution (of the shell) for any file that is not a text file, but that
the shell not bypass the execution for any file that is a text file.

Therefore, the shell may (but is not required to) bypass the execution
if the file contains 0 bytes, contains invalid byte sequences that do
not form a character, contains lines longer than {LINE_MAX} or ends with
a character that is not a newline. Otherwise, the shell must perform the
execution.

The line length is indeed somewhat strange: the INPUT FILES section of
XCU 4 Utilities -> sh requires the shell to read scripts without the
{LINE_MAX} limit, but the part you quoted does not use this modified
definition of a text file. In practice this is not relevant since shells
are not going to read more than {LINE_MAX} for this check anyway, as you
say.

> > The check is simply for a 0 byte in the first 256 bytes (how many bytes
> > are read by pread() for 256 bytes). A file containing the byte 8, for
> > example, can still be a text file per POSIX's definition.

> The XBD 3 cannot possibly specify allowed byte values, as it doesn't even
> know which is the newline, nor does it require even its own "portable
> character set" being directly accessible (merely that it's included in one
> of shiftable sets provided by a locale).

> On the other hand, not only dash assumes 8-bit bytes and ASCII-compatible
> charset (what a limitation!), but we also have knowledge about which byte
> values are not a part of any printable string in any locale on a supported
> platform.  And the set of supported character sets is going to only
> decrease[1].

Text files need not contain printable characters only.

> > This check might cause a terse script with binary to fail to execute,
> > but I have not received bug reports about that.

> In today's brave "curl|sudo sh" world, it's a concern I wouldn't dismiss.
> The first line will be a legitimate command to the shell, the rest is often
> arbitrary binary junk.

I think problems are unlikely because most scripts use the #! method
instead of relying on this shell feature.

> > Stopping the check with a \n will cause a PNG header to be considered
> > text.

> Good point.  It does fool bash and mksh (with mksh's different approach)
> too.  On the other hand, PNG files are not something that's likely to have a
> bogus +x permission, and unlike PE or ELF files, empirically I didn't notice
> any nasty results.  It's still bad -- not sure what's the best solution.

Anything can have a bogus +x permission on FAT, NTFS and other
filesystems that do not support executable permissions at all.

> > Also, FreeBSD sh uses O_NONBLOCK when opening the file and pread() to
> > read the data, in order to minimize the potential for modifying things
> > by reading.

> The manpage for open(2) on Linux says that, while currently O_NONBLOCK has
> no effect for regular files and block devices, the expected semantics might
> eventually be implemented -- and I guess you're not going to prefault the
> beginning of the file before reading, are you?  Thus, O_NONBLOCK is a bad
> idea.

Hmm, I doubt such a basic thing will ever be changed.

> As for pread, dash execs a new process (via /bin/sh which might or might not
> be dash) so there's no optimization in not reopening the file.  As for
> avoiding fifos, the kernel has just checked whether it's a valid executable
> anyway.  Am I missing something else?

This guards against a file change between execve and open in the parent
shell, but not against a file change between open in the parent and
newly executed shell.

The O_NOCTTY you added is similar. I did not add this because O_NOCTTY
has no effect in the FreeBSD kernel.

> Meow!

> [1]. I've recently gathered stats about use of ancient encodings, and it's
> so close to zero that I plan to raise discussion about dropping support for
> non-UTF8 in Debian soon.  You might be reluctant to do so in dash for now,
> but having a single encoding for all locales would make it easy to fix a
> number of POSIX requirements dash fails at because you consider locale
> support to be infeasible.  Like, making ${#foo} give length in characters is
> a matter of counting bytes outside 0x80..0xBF if assuming well-formed
> strings is okay, or not a lot more complex even if full validation is
> required.

I think UTF-8 and character=byte are the useful options for character
encodings these days. The latter is useful to process non-character data
without [EILSEQ] problems, or to process ASCII data with higher
performance (such as in sort(1)).

FreeBSD sh supports these two options and nothing more. The handling for
${#foo} in an UTF-8 locale is, in fact, what you are suggesting here.

Some advantages compared to generic approaches based on mbrtowc() or
similar are higher performance, simpler code and the possibility to
design handling for invalid sequences for each situation (most users do
not like the shell aborting at random places because of invalid UTF-8).

-- 
Jilles Tjoelker
