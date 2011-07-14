From: Rudolf Polzer <divverent@xonotic.org>
Subject: Re: Bug: temporary assignments vs shell function
Date: Thu, 14 Jul 2011 12:09:15 +0200
Message-ID: <20110714100915.GA18946@div0.qc.to>
References: <20110714083455.GA25362@div0.qc.to> <20110714092615.GA15476@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rm.div0.qc.to ([94.23.21.40]:56821 "EHLO rm.div0.qc.to"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754083Ab1GNKJS (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 14 Jul 2011 06:09:18 -0400
Content-Disposition: inline
In-Reply-To: <20110714092615.GA15476@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org

On Thu, Jul 14, 2011 at 04:26:16AM -0500, Jonathan Nieder wrote:
> Hi,
> 
> Rudolf Polzer wrote:
> 
> > foo=bar func
> > echo "foo is now $foo"
> >
> > will export foo=bar in global scope (i.e. it affects the execution environment
> > after the function call).
> [...]
> > A shell function however isn't a "special built-in" and also counts as a
> > "command name", thus the last echo line really should output "foo is now foo",
> > which it does in e.g. bash and the FreeBSD /bin/sh.
> 
> From XCU 2.9.5:
> 
> | When a function is executed, it shall have the syntax-error and
> | variable-assignment properties described for special built-in
> | utilities in the enumerated list at the beginning of Section 2.14.

Interesting, and well hidden. So this weird behaviour isn't a bug, but an
actual feature. Or, they documented a bug of an early shell implementation and
made it into the spec ;)

> This seems to be one of those odd cases where "bash -o posix" behaves
> differently from bash.  Based on this test:
> 
> 	$sh -c 'func () { :; }; foo=bar func; echo $foo'
> 
> dash, ksh93, bash -o posix, pdksh and its derivatives, zsh with
> "emulate sh", and busybox sh implement the specified behavior.  I'm
> surprised to hear your copy of FreeBSD sh behaves differently.

I just retested with that very command, and yes, the FreeBSD /bin/sh does
behave the "non-POSIX" (and "obvious") way, and so does the Solaris /bin/sh.

So basically - when using an assignment for the duration of a shell command
execution, an explicit subshell must be used in portable scripts, as
interpretation of this construct differs among shells and thus cannot be relied
on. Also, I find this (although standardized) behavior entirely useless, never
"what you want", and in case you REALLY want it, adding a semicolon and
"export" fixes it.

I find it especially vile that this is a hidden way to export a variable... nice
for "obfuscated" shell scripts :P

exported() { :; }

foo=bar exported
sh -c 'echo $foo'

But, interesting that this weird and broken behaviour is standardized, and this
clearly means that dash does the right thing - also, having a difference
against bash here is good as it helps avoid this broken-in-the-spec construct.

Best regards,

Rudolf Polzer
