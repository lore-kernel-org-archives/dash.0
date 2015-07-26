From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: shell: dash - large file support
Date: Sun, 26 Jul 2015 21:21:41 +0200
Message-ID: <20150726192141.GC4346@stack.nl>
References: <CAPaOzWwJkwozmDrk2BA5xHF+E6iM5mDrV9ORz=4RiFCdsKYbZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:61347 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755190AbbGZTVn (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 26 Jul 2015 15:21:43 -0400
Content-Disposition: inline
In-Reply-To: <CAPaOzWwJkwozmDrk2BA5xHF+E6iM5mDrV9ORz=4RiFCdsKYbZA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Aleksandar Ristovski <aleksandar.ristovski@gmail.com>
Cc: dash@vger.kernel.org

On Fri, Jul 24, 2015 at 02:50:48PM -0400, Aleksandar Ristovski wrote:
> For builds that build 32-bit dash, configure misses to setup large
> file support resulting in issues with large files.

> For example:
> ...dp/dash-0.5.8/build$ ls -l /tmp/largefile.sh
> -rw-rw-r-- 1 aristovski aristovski 3794653588 Jul 24 14:12 /tmp/largefile.sh
> ...dp/dash-0.5.8/build$ ./src/dash /tmp/largefile.sh
> ./src/dash: 0: Can't open /tmp/largefile.sh

> Where dash was configured (on a 64-bit platform) like so:

> ...dp/dash-0.5.8/build$ CFLAGS=-m32 ../configure && make -j8

> Now, if I make the change in configure.ac and reconfigure the project,
> I get proper operation:

> ...0.5.8.patched/build$ ./src/dash /tmp/largefile.sh
> Running...
> ...

> (the actual working of the 'largefile.sh' is removed for brevity)

> Patch:

> --- dash-0.5.8/configure.ac     2014-09-28 04:19:32.000000000 -0400
> +++ dash-0.5.8.patched/configure.ac     2015-07-24 14:41:05.855055430 -0400
> @@ -4,6 +4,9 @@ AC_CONFIG_SRCDIR([src/main.c])
> 
>  AC_CONFIG_HEADERS(config.h)
> 
> +dnl On 32-bit builds, check for large file support
> +AC_SYS_LARGEFILE
> +
>  dnl Checks for programs.
>  AC_PROG_CC
>  AC_GNU_SOURCE

If I were the maintainer, I would use AC_SYS_LARGEFILE and remove all
complexity related to using largefile interfaces in some situations and
non-largefile interfaces in other situations.

However, the maintainer seems to prefer using largefile interfaces only
when needed, apparently to reduce the size of the binary. In the case of
large shell scripts, this is POSIXly correct (see XCU 1.5 Considerations
for Utilities in Support of Files of Arbitrary Size).

However, using a non-largefile stat() or lstat() is always wrong, since
the inode number may not fit in a non-largefile ino_t. This happens in
various cases: test -ef/-nt/-ot, finding a dot script (. special
builtin) and some related to the current directory.

On another note, test -nt/-ot should really compare the nanoseconds
parts as well.

-- 
Jilles Tjoelker
