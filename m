From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [BUG] dash doesn't report syntax error when it should on stray
 "fi"
Date: Wed, 25 Apr 2012 00:47:03 +0200
Message-ID: <20120424224703.GA24960@stack.nl>
References: <4F958907.9030508@gmail.com>
 <20120423170339.GA9635@burratino>
 <4F95AD25.3060200@case.edu>
 <20120423194453.GA13576@burratino>
 <4F95B1F8.8080502@case.edu>
 <20120423195458.GB13576@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:49842 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758249Ab2DXWrG (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 24 Apr 2012 18:47:06 -0400
Content-Disposition: inline
In-Reply-To: <20120423195458.GB13576@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Chet Ramey <chet.ramey@case.edu>, Stefano Lattarini <stefano.lattarini@gmail.com>, dash@vger.kernel.org

On Mon, Apr 23, 2012 at 02:54:58PM -0500, Jonathan Nieder wrote:
> Chet Ramey wrote:

> > The way I read 2.10.2, Posix requires that the "fi" resolve to the
> > reserved word `fi' in this case, since it's in a position where a
> > command name is expected (Rule 1, [Command Name]).  I would think that
> > would make it a syntax error in any application, conforming or not.

> Yes, I think you're right.

> For some reason I thought that using reserved words in ways not
> permitted by the grammar produced undefined behavior, to support
> shells with extensions like the arithmetic "for".  But now that I read
> more closely, it looks like "function", "[[", "]]", and "select"
> produce unspecified behavior but everything else is pretty well
> specified.  Thanks for clarifying.

In what way does a lone "fi" differ from constructions like the below,
which do not match the POSIX grammar but are accepted by some subset of
shells that attempt to comply to POSIX:

case x in (esac) ;; esac

for i; do echo "$i"; done

for i;
do echo "$i"; done

for i { echo "$i"; }

for ((i = 0; i < 10; i += 1)) do echo "$i"; done

f() :

The only difference seems to be that the lone "fi" is somehow "wrong"
while the above are not "wrong". That's too vague for a specification.

Unfortunately, the XCU volume is very thin on constraints (as found, for
example, in the C standard). Many ways to do things "wrong" are instead
left open for implementation extensions. In practice, many such
extensions exist.

That said, rejecting the lone "fi" is still a quality of implementation
issue, particularly because dash's current behaviour is poorly defined.
I fixed it in FreeBSD a while ago (9.0 has the fix).

In making this change, a testsuite is very useful to guard against bugs
and to ensure no cases are missed, but latent bugs in shell scripts may
still cause annoyance. If there is an error in a command substitution
that is normally not executed, most shells (except ash derivatives) will
not notice this.

For example, FreeBSD 9.0's sh is one of the few shells that detects the
error in:

if false; then `fi`; fi

-- 
Jilles Tjoelker
