From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH/RFC dash 0/4] Avoid a fork before running last command
 given to -c
Date: Mon, 18 Apr 2011 00:13:27 +0200
Message-ID: <20110417221326.GA18973@stack.nl>
References: <20110410071734.GA16736@elie>
 <20110415130709.GA3735@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:51289 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751526Ab1DQWN2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 17 Apr 2011 18:13:28 -0400
Content-Disposition: inline
In-Reply-To: <20110415130709.GA3735@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jonathan Nieder <jrnieder@gmail.com>, dash@vger.kernel.org, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

On Fri, Apr 15, 2011 at 09:07:09PM +0800, Herbert Xu wrote:
> On Sun, Apr 10, 2011 at 07:18:17AM +0000, Jonathan Nieder wrote:
> > Jilles Tjoelker wrote[0]:

> > > Regarding sh -c optimization, I am in favour of this. Uselessly waiting
> > > 'sh -c' processes annoy me. I made the change for FreeBSD 8.0 sh, which
> > > is very similar to dash. The SVN changeset is r194128.

> > So I grabbed that changeset with

> > 	svn log -v svn://svn.freebsd.org/base/head/bin/sh -r 194128
> > 	svn diff -r 194127:194128 svn://svn.freebsd.org/base/head/bin/sh

> > and made it a tiny bit smaller.   Here's the result.

> >    text    data     bss     dec     hex filename
> >   83994    1784   11128   96906   17a8a dash.before-O2
> >   83994    1784   11128   96906   17a8a dash.before-Os
> >   84146    1784   11128   97058   17b22 dash.after-O2
> >   84146    1784   11128   97058   17b22 dash.after-Os

> > On this amd64 the cost is 152 bytes of text.  Thoughts?

> I must say that I don't see much value in this feature.  Adding
> exec to the invocation is trivial.

It is trivial when writing command lines that are obviously going to be
passed to sh -c, but in practice it is often not done. The optimization
would be useful with system(), popen() and Makefiles; rarely does one
see an "exec" in such contexts. In a Makefile, "exec" can be actively
detrimental since it usually forces the command to be run using the
shell, preventing a direct execve() by make.

In all contexts, "exec" is detrimental if a builtin version of the
executed utility exists. If the utility is a special builtin, prepending
"exec" is very likely to cause the command to stop working, and
otherwise it adds a useless execve().

It was proposed to add text encouraging "exec" prepending to POSIX, but
this was rejected. See http://austingroupbugs.net/view.php?id=236 and
http://thread.gmane.org/gmane.comp.standards.posix.austin.general/1918 .

-- 
Jilles Tjoelker
