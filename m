From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [BUG] quoted substring parameter expansion ignores single-quotes
 in the arg
Date: Sat, 21 Oct 2017 14:13:43 +0200
Message-ID: <20171021121343.GA29646@stack.nl>
References: <20170926034148.ohemy3jubd2nskyj@gmx.com>
 <20171019104103.7gzflupyi27artlg@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mailout05.stack.nl ([131.155.140.202]:58899 "EHLO
        mailout.stack.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753358AbdJUMVu (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 21 Oct 2017 08:21:50 -0400
Content-Disposition: inline
In-Reply-To: <20171019104103.7gzflupyi27artlg@gmx.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "G.raud" <graud@gmx.com>
Cc: dash@vger.kernel.org

On Thu, Oct 19, 2017 at 12:41:30PM +0200, G.raud wrote:
> Wrong bug report.

> In fact the beahviour of dash on "a=\\'a\\'; echo \"\${a%'}\"" is that
> of POSIX and of zsh 5.  However 'bash --posix', 'mksh -o posix' and
> pdksh fail to parse the command and ksh does not remove the quote from
> $a.

I think your original bug report is actually valid. Although the POSIX
standard may be hard to interpret (make sure to use the latest (2016)
edition), I think it is sufficiently clear that various special
characters are active in ${param#word}, whether the outer substitution
is within double-quotes or not. See this sentence in 2.6.2 Parameter
Expansion:

] Enclosing the full parameter expansion string in double-quotes shall
] not cause the following four varieties of pattern characters to be
] quoted, whereas quoting characters within the braces shall have this
] effect.

More generally, if bash --posix and ksh93 agree about something, it is
usually correct (use something like "${a#'*'}", since "${a#'}" is
wrong). Although zsh is a good interactive shell, it does not follow
POSIX as closely; not even in sh or ksh emulation mode.

Also note that dash does implement this correctly if a metacharacter is
quoted using a single-quote or a backslash:

$ v=**
$ echo "${v#*}"
**
$ echo "${v#"*"}"
*
$ echo "${v#\*}"
*

In dash's internals, this bug is caused by not distinguishing between
+/-/=/? and #/##/%/%% varieties in the parser. Not maintaining state for
eacg nesting level makes the parser more elegant, but it is untenable
since there is no way one can parse both "${v+'}" and "${v#'*'}"
correctly without it.

-- 
Jilles Tjoelker
