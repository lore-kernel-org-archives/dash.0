From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: heredoc and subshell
Date: Wed, 24 Feb 2016 00:18:44 +0100
Message-ID: <20160223231843.GA55161@stack.nl>
References: <2978711456265264@web9h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:57980 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751740AbcBWX21 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Feb 2016 18:28:27 -0500
Content-Disposition: inline
In-Reply-To: <2978711456265264@web9h.yandex.ru>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Bulatov <oleg@bulatov.me>
Cc: dash@vger.kernel.org

On Wed, Feb 24, 2016 at 01:07:44AM +0300, Oleg Bulatov wrote:
> trying to minimize a shell code I found an unobvious moment with
> heredocs and subshells.

> Is it specified by POSIX how next code should be parsed? dash output
> for this code differs from bash and zsh.

> --- code
> prefix() { sed -e "s/^/$1:/"; }
> DASH_CODE() { :; }
> 
> prefix A <<XXX && echo "$(prefix B <<XXX
> echo line 1
> XXX
> echo line 2)" && prefix DASH_CODE <<DASH_CODE
> echo line 3
> XXX
> echo line 4)"
> echo line 5
> DASH_CODE

> --- bash 4.3.42 output:
> A:echo line 3
> B:echo line 1
> line 2
> DASH_CODE:echo line 4)"
> DASH_CODE:echo line 5

> --- dash 0.5.8 output:
> A:echo line 1
> B:echo line 2)" && prefix DASH_CODE <<DASH_CODE
> B:echo line 3
> line 4
> line 5

I think POSIX is clear that the bash/zsh behaviour is correct and the
dash behaviour is wrong. In XCU 2.6.3 Command Substitution, it says:

] With the $(command) form, all characters following the open
] parenthesis to the matching closing parenthesis constitute the
] command.

Therefore, the shell should not start reading the here-document
belonging to  prefix A <<XXX  while it is still inside the command
substitution  $(prefix B <<XXX.

Instead, the here-document belonging to  prefix B <<XXX  should be read.
The line ending the command substitution contains another <<
redirection; the here-documents are read in order of the <<
redirections.

In FreeBSD sh, another ash derivative, I fixed this in
FreeBSD SVN r208655,
https://github.com/freebsd/freebsd/commit/930ce3922652c50fc8b621b14b6238b325d7f16f

Interestingly, mksh parses this in yet another way. In unmodified form,
it fails with  here document 'XXX' unclosed. After appending an XXX
line, it outputs:

A:echo line 5
A:DASH_CODE
B:echo line 2)" && prefix DASH_CODE <<DASH_CODE
B:echo line 3
line 4

The here-document containing line 1 seems lost entirely.

The ksh93 93u+ 2012-08-01 from FreeBSD ports segfaults while executing
the script.

Concludingly, it seems unwise to rely on this construct in scripts to be
distributed.

-- 
Jilles Tjoelker
