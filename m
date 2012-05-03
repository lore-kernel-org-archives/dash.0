From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: wait and ctrl+Z
Date: Fri, 4 May 2012 00:46:38 +0200
Message-ID: <20120503224638.GA67644@stack.nl>
References: <20120503215122.GA2885@gondor.apana.org.au>
 <alpine.DEB.2.02.1205040022560.2988@laptop-mg.saclay.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:55060 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756296Ab2ECWql (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 3 May 2012 18:46:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1205040022560.2988@laptop-mg.saclay.inria.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Marc Glisse <marc.glisse@inria.fr>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

On Fri, May 04, 2012 at 12:28:17AM +0200, Marc Glisse wrote:
> On Fri, 4 May 2012, Herbert Xu wrote:
> > Marc Glisse <marc.glisse@inria.fr> wrote:
> >> Hello,

> >> I noticed a strange behavior of "wait" when I suspend and resume a script.

> >> $ cat a.sh
> >> #!/bin/dash
> >> (sleep 7; echo blah) &
> >> (sleep 7; echo bloh) &
> >> wait ; echo coucou
> >> $ ./a.sh
> >> ^Z
> >> zsh: suspended  ./a.sh
> >> $ fg
> >> [1]  + continued  ./a.sh
> >> coucou
> >> $ blah
> >> bloh

> >> As you can see, the instruction after "wait" was executed immediatly on
> >> resume, without waiting for the jobs.

> >> If I replace the ';' after "wait" by "&&" and do the same suspend+resume,
> >> "coucou" is never printed.

> >> I am using dash version 0.5.7-3 in debian testing.

> > That's normal as wait was interrupted by a signal.  If you want
> > to wait even after an interruption, you should check the return
> > value of wait.

> Hello, and thanks for you answer.

> I find that quite surprising. I re-read the posix description of wait, and 
> my understanding is that the return value of wait should depend on what 
> happened to the waited process (exit code, signal), not to wait itself. 
> And other shells seem to agree.

This is not actually said in the XCU 'wait' page but in XCU 2.11 Signals
and Error Handling.

However, it says something subtly different: only a signal for which a
trap has been set should cause 'wait' to return immediately with an exit
status greater than 128.

Because no trap has been set on SIGTSTP, 'wait' should not be
interrupted here and the shell should continue waiting.

Likewise, if the shell internally uses SIGCHLD to get notified about
process termination, this does not interrupt 'wait'; dash implements
that aspect properly.

> Are you suggesting that wait should always be used in a loop? With what 
> check exactly?

Only if you have set any traps that resume execution of the original
script (i.e. do not exit the process).

Otherwise, if 'wait' is being called without parameters, you can do
something like
  until wait; do :; done

If 'wait' is being called with parameters, the required loop is very
complicated.

-- 
Jilles Tjoelker
