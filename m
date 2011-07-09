From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: 'continue' does not work in files sourced with dotcmd
Date: Sat, 9 Jul 2011 15:07:04 +0200
Message-ID: <20110709130704.GC14262@stack.nl>
References: <AANLkTimiFku8Uj9haYAxXWyJQOGSV7Uz3i2k75+aMvTU@mail.gmail.com>
 <20110707033749.GB16157@gondor.apana.org.au>
 <4E15B41A.9020601@redhat.com>
 <20110707144635.GA21272@gondor.apana.org.au>
 <4E15CE34.40403@redhat.com>
 <20110708080936.GA28335@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:58421 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752802Ab1GINHG (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 9 Jul 2011 09:07:06 -0400
Content-Disposition: inline
In-Reply-To: <20110708080936.GA28335@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <eblake@redhat.com>, "Taylan Ulrich B." <taylanbayirli@gmail.com>, dash <dash@vger.kernel.org>

On Fri, Jul 08, 2011 at 04:09:36PM +0800, Herbert Xu wrote:
> On Thu, Jul 07, 2011 at 09:18:12AM -0600, Eric Blake wrote:
> > Meanwhile, I still have to wonder about dash behavior - if dash is _not_
> > treating continue as a syntax error, then why is it aborting the dot
> > script?  Compare:

> This is a consequence of the way continue/break/return is implemented
> in dash.

> As this construct cannot be used portably anyway, I'm not inclined to
> make any changes unless you can do it without increasing the code
> size.

It is not a hard consequence, the behaviour can be fixed fairly easily.

I noticed a similar problem in FreeBSD sh and fixed it in head in August
2010, Subversion r211349.

A testcase is (note that this must be saved to a named file because it
sources itself):
####
# $FreeBSD: head/tools/regression/bin/sh/builtins/break1.0 211349 2010-08-15 21:06:53Z jilles $

if [ "$1" != nested ]; then
	while :; do
		set -- nested
		. "$0"
		echo bad2
		exit 2
	done
	exit 0
fi
# To trigger the bug, the following commands must be at the top level,
# with newlines in between.
break
echo bad1
exit 1
####

Given that quite a few shells pass this test, I consider it prudent to
make it work. It is not unlikely that someone somewhere has written a
script that depends on it, and treating the break or continue as a
return is rather surprising in a negative way. (Similar for break or
continue in eval or trap, though I think those work in dash.)

A fix for dash is below. The dash code is broken in a different way than
the FreeBSD sh code was, but the patched code is pretty much the same.
This makes the above test work and does not change the outcome of any
other tests in the FreeBSD sh testsuite.

diff --git a/src/main.c b/src/main.c
index af987c6..cdd91e2 100644
--- a/src/main.c
+++ b/src/main.c
@@ -242,7 +242,8 @@ cmdloop(int top)
 
 		skip = evalskip;
 		if (skip) {
-			evalskip = 0;
+			if (skip == SKIPFILE)
+				evalskip = 0;
 			break;
 		}
 	}

Using
	evalskip &= ~SKIPFILE;
instead of
	if (skip == SKIPFILE)
		evalskip = 0;
should also work and might generate shorter code.

-- 
Jilles Tjoelker
