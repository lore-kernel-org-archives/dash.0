From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: shift "fatal error"
Date: Tue, 15 Mar 2011 22:31:16 +0100
Message-ID: <20110315213116.GA53303@stack.nl>
References: <AANLkTik1TC3jv-imnbChRGqtHzRCvKCcB5_LnqEnDc9u@mail.gmail.com>
 <20110310192333.GE3948@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:60054 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756981Ab1COVbR (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 15 Mar 2011 17:31:17 -0400
Content-Disposition: inline
In-Reply-To: <20110310192333.GE3948@wopr.local.invalid>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Muresan <danmbox@gmail.com>, dash@vger.kernel.org

On Thu, Mar 10, 2011 at 08:23:33PM +0100, Guido Berhoerster wrote:
> * Dan Muresan <danmbox@gmail.com> [2011-03-10 19:41]:
> > Hi, is there some consensus on whether shift should cause a "fatal
> > error" as reported by Herbert against bash:
> > 
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=252378
> > 
> > # doesn't print anything
> > dash -c 'shift 2; echo hi'
> > 
> > My copy of SUSv3 doesn't seem to imply any "fatal error" handling
> > requirement for shift:
> > 
> > --- 8-X ---
> > EXIT STATUS
> > 
> > The exit status is >0 if n>$#; otherwise, it is zero.
> > 
> > CONSEQUENCES OF ERRORS
> > 
> > Default.
> > --- 8-X ---

> For IEEE Std 1003.1-2008 see section 2.8.1 "Consequences of
> Shell Errors": a "utility syntax error (option or operand error)"
> with special built-ins shall cause the shell to exit. That's what
> dash, ksh93, and pdksh do.

That may have been the intention (considering that it matches the real
Bourne shell in addition to various flavours of Korn shell), but that is
not how I would interpret it. A too high shift count still seems
syntactically valid to me.

A statement about the exit status in a particular error situation also
usually indicates that the shell shall not abort.

Examples of shift commands that I think shall cause the shell to abort:
shift -S  # unless a -S option is supported as an extension
shift x   # unless arithmetic expressions are accepted as an extension
shift @   # unless there is some strange extension

The FreeBSD sh shift special builtin behaves this way (a too high shift
count is not fatal but a syntactically invalid number is). This was done
a few years ago when the syntax-error property of special builtins was
implemented, as making a too high shift count fatal caused a configure
script in the FreeBSD base system to fail.

I would not encourage the extension of accepting arithmetic expressions
because that requires a subtly different kind of arithmetic expression
without octal constants. POSIX is clear that 'shift 010' should shift
ten positions, not eight, while 'shift $((010))' should shift eight
positions.

-- 
Jilles Tjoelker
