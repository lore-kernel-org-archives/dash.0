From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [BUG] $PATH not fully searched
Date: Wed, 10 Jan 2018 23:18:15 +0100
Message-ID: <20180110221815.GA44971@stack.nl>
References: <1997619.aMy8rkrhBo@debian-thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mailout05.stack.nl ([131.155.140.202]:45622 "EHLO
        mailout.stack.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751733AbeAJWZG (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 10 Jan 2018 17:25:06 -0500
Content-Disposition: inline
In-Reply-To: <1997619.aMy8rkrhBo@debian-thinkpad>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Joshua Nelson <jynelson@email.sc.edu>
Cc: dash@vger.kernel.org, cdaniels@fastmail.com

On Wed, Jan 10, 2018 at 01:36:18PM -0500, Joshua Nelson wrote:
> I've come across an error with the PATH variable in `dash`. Instead of
> fully searching PATH for commands, dash will respond 'command not
> found' if `command -p <executable>` fails.  The same command works
> fine in Bash.

> The following example was performed in a live cd of Debian 9.1 Stretch
> (run in a virtual machine), with dash version 0.5.8-2.4:

> ```bash
> user@debian:~$ PATH="~/my_bin:$PATH" dash
> $ echo $PATH
> ~/my_bin:/usr/local/bin:/usr/bin:/usr/local/games:/usr/games
> $ ls -l ~/my_bin/list
> -rwxr--r-- 1 user user 18 Jan 10 17:42 /home/user/my_bin/list
> $ list
> dash: 3: list: not found
> $ exit
> user@debian:~$ PATH="$PATH:~/my_bin" list
> Desktop Documents Downloads Music my_bin Pictures Public Templates Videos
> ```

> I believe but am not certain that this is related to the following patch:
> https://www.mail-archive.com/dash@vger.kernel.org/msg01329.html

In your example, the tilde is quoted and ends up literally in PATH.
Then, in bash only, tilde expansion is attempted again during the
search. In my testing, zsh, mksh, ksh93, dash and FreeBSD sh do not
implement this feature. Enabling POSIX mode in bash also disables the
feature.

What works more portably is
  PATH=~/my_bin:$PATH dash
or
  PATH=$PATH:~/my_bin list
which expands the tilde at the time of the assignment. This works pretty
much everywhere except in old real Bourne shells, which do not implement
tilde expansion at all.

If you want to quote the $PATH part, it is possible but not necessary
since it is in a variable assignment which is not subject to pathname
generation and word splitting anyway. However, if "export" is prepended,
I strongly recommend quoting it since some shells such as dash do not
implement the special rule for assignment utilities yet.

-- 
Jilles Tjoelker
