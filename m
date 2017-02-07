From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] Don't execute binary files if execve() returned ENOEXEC.
Date: Tue, 7 Feb 2017 23:52:08 +0100
Message-ID: <20170207225208.GA743@stack.nl>
References: <20170207083307.14881-1-kilobyte@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mailout05.stack.nl ([131.155.140.202]:39652 "EHLO
        mailout.stack.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751336AbdBGWwM (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 7 Feb 2017 17:52:12 -0500
Content-Disposition: inline
In-Reply-To: <20170207083307.14881-1-kilobyte@angband.pl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
Cc: dash@vger.kernel.org

On Tue, Feb 07, 2017 at 09:33:07AM +0100, Adam Borowski wrote:
> Both "dash -c foo" and "./foo" are supposed to be able to run hashbang-less
> scripts, but attempts to execute common binary files tend to be nasty:
> especially both ELF and PE tend to make dash create a bunch of files with
> unprintable names, that in turn confuse some tools up to causing data loss.

> Thus, let's read the first line and see if it looks like text.  This is a
> variant of the approach used by bash and zsh; mksh instead checks for
> signatures of a bunch of common file types.

> POSIX says: "If the executable file is not a text file, the shell may bypass
> this command execution.".

> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
> This has been applied in Debian.  While technically it's only a "may" issue
> in dash itself, and is triggered by user error (trying to exec files you
> shouldn't exec), the fallout is nasty enough that the bug was classified as
> serious.

> The usual failure mode is to create files with names such as:
> (per submitter, a PE):
> 90 d4 f6
> (an ELF):
> 01 b0 40 40 08 01 40 38 02 40 04 03 01 05 40 40 ed ed
> 01 b0 40 40 f8 40 38 02 40 04 03 01 05 40 40 da da

In FreeBSD sh, I have done this slightly differently (since 2011), based
on POSIX's definition of a text file in XBD 3:

] A file that contains characters organized into zero or more lines. The
] lines do not contain NUL characters and none can exceed {LINE_MAX} bytes
] in length, including the <newline> character.

The check is simply for a 0 byte in the first 256 bytes (how many bytes
are read by pread() for 256 bytes). A file containing the byte 8, for
example, can still be a text file per POSIX's definition.

This check might cause a terse script with binary to fail to execute,
but I have not received bug reports about that.

Stopping the check with a \n will cause a PNG header to be considered
text.

Also, FreeBSD sh uses O_NONBLOCK when opening the file and pread() to
read the data, in order to minimize the potential for modifying things
by reading.

-- 
Jilles Tjoelker
