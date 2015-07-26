From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Ignored alias inside for loop
Date: Sun, 26 Jul 2015 17:26:02 +0200
Message-ID: <20150726152602.GA4346@stack.nl>
References: <55B4A728.9080303@openmailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:64059 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755153AbbGZPeu (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 26 Jul 2015 11:34:50 -0400
Content-Disposition: inline
In-Reply-To: <55B4A728.9080303@openmailbox.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Rusty Bird <rustybird@openmailbox.org>
Cc: dash@vger.kernel.org

On Sun, Jul 26, 2015 at 09:23:52AM +0000, Rusty Bird wrote:
> Why does this ...

> #!/bin/sh
> for i in 1; do
>     alias foobarbaz='echo ok'
>     foobarbaz
> done

> ... result in "foobarbaz: not found", but without the for loop it works?
> Maybe I'm missing something in the spec, because bash-as-sh behaves
> the same.

Aliases are expanded during parsing, not during execution (like
functions are). The for loop is parsed completely before it is executed.

Using a function instead of an alias, or using eval will do what you
want.

Note that some parts of the parse/execute split are not specified by
POSIX. In particular, ksh93 and the real Bourne shell parse dot scripts
completely before executing anything, while most other shells parse as
needed. Example: given the file alias1.sh below:

alias foobarbaz='echo ok'
foobarbaz

The result is ok when running  dash -c '. ./alias1.sh'  but a command
not found error message when running  ksh93 -c '. ./alias1.sh'.

Similarly, a string as passed to the -c option or eval or trap builtins
may or may not be parsed fully before execution.

-- 
Jilles Tjoelker
