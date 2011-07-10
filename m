From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: 'continue' does not work in files sourced with dotcmd
Date: Sun, 10 Jul 2011 21:03:34 +0200
Message-ID: <20110710190334.GA47384@stack.nl>
References: <AANLkTimiFku8Uj9haYAxXWyJQOGSV7Uz3i2k75+aMvTU@mail.gmail.com>
 <20110707033749.GB16157@gondor.apana.org.au>
 <4E15B41A.9020601@redhat.com>
 <20110707144635.GA21272@gondor.apana.org.au>
 <4E15CE34.40403@redhat.com>
 <20110708080936.GA28335@gondor.apana.org.au>
 <20110709130704.GC14262@stack.nl>
 <20110709140730.GA6901@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:56598 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753090Ab1GJTDg (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 10 Jul 2011 15:03:36 -0400
Content-Disposition: inline
In-Reply-To: <20110709140730.GA6901@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <eblake@redhat.com>, "Taylan Ulrich B." <taylanbayirli@gmail.com>, dash <dash@vger.kernel.org>

On Sat, Jul 09, 2011 at 10:07:30PM +0800, Herbert Xu wrote:
> On Sat, Jul 09, 2011 at 03:07:04PM +0200, Jilles Tjoelker wrote:
> > A fix for dash is below. The dash code is broken in a different way than
> > the FreeBSD sh code was, but the patched code is pretty much the same.
> > This makes the above test work and does not change the outcome of any
> > other tests in the FreeBSD sh testsuite.

> You're right.  But I think your patch may introduce a problem
> with a return statement inside a dot script.  That should not
> have an effect after exiting the script.

Interesting. Dash has been returning from the closest scope (function or
sourced script) for a while, but the SKIPFUNC/SKIPFILE distinction and
the comment in eval.c returncmd()

]  	/*
]  	 * If called outside a function, do what ksh does;
]  	 * skip the rest of the file.
]  	 */

still gave me the impression that it behaved like older ash (also in
FreeBSD and NetBSD), trying to be bug-compatible with the Bourne shell
by having 'return' return from a function, if any, and only return from
a dot script if there is no function (because the Bourne shell gives an
error in that case).

It may be better to name the constant SKIPRETURN rather than SKIPFUNC.

> Anyway, the following patch based on your idea should fix the
> problem.

> commit 4f7e206782675b548565ca2bc82bc8c262a0f20e
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Sat Jul 9 22:05:22 2011 +0800
> 
>     [BUILTIN] Merge SKIPFUNC/SKIPFILE and only clear SKIPFUNC when leaving dotcmd

Yes, this works too.

-- 
Jilles Tjoelker
