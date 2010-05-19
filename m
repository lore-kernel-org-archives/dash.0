From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: unexpected parameter expansion
Date: Thu, 20 May 2010 00:01:10 +0200
Message-ID: <20100519220109.GA81407@stack.nl>
References: <20100519191928.28202.qmail@10218569f54974.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:59388 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751252Ab0ESWBM (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 19 May 2010 18:01:12 -0400
Received: from turtle.stack.nl (turtle.stack.nl [IPv6:2001:610:1108:5010::132])
	by mx1.stack.nl (Postfix) with ESMTP id 787451DD638
	for <dash@vger.kernel.org>; Thu, 20 May 2010 00:01:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100519191928.28202.qmail@10218569f54974.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Wed, May 19, 2010 at 07:19:28PM +0000, Gerrit Pape wrote:
> Hi, I get unexpected output with dash doing parameter expansions with }
> within quotes involved, e.g.

> $ dash -c 'foo=; echo ${foo:-"{a}bar"}'
> {abar}
> $ 

> I expected:
> {a}bar

Just for clarification, the open brace is inconsequential here. It does
not pair with a close brace (only ${ does). Certain versions of bash and
ksh implemented it that way, but it has since been corrected.

> http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02

When reading this, make sure to consider the recent discussion on the
Austin Group.

Except for single-quotes inside double-quoted #% substitutions, there
appears to be consensus about the change in note #399 in
http://austingroupbugs.net/view.php?id=221

This post of mine is particularly interesting for dash:
http://permalink.gmane.org/gmane.comp.standards.posix.austin.general/1924

> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=581428

That one does
  foo="${foo:-"{a}bar"}"
(note the extra double-quotes) which can only result in {abar}, an error
or an incomplete command with dash's approach. The inner quotes have no
effect whatsoever on dash's parser.c state and only generate
CTLQUOTEMARK bytes for expand.c. This is not so bad as these nested
double-quotes with +-=? substitutions result in unspecified behaviour,
and shells differ in what it means.

Dash is not the only shell that doesn't do what the parole people
expect. FreeBSD sh (pretty much all versions, including with my reworked
substitutions in 9-CURRENT, although I could change it fairly easily)
and the System V sh (from Heirloom Toolchest) also assign {abar} (but
accept it as a complete command).

I recommend splitting up the command. Although
  foo=${foo:-{a\}bar}
will work, some shells keep the backslash in
  foo="${foo:-{a\}bar}"
and some people are tempted to add double-quotes everywhere, even where
they are not needed and silent breakage would result.

> Sorry, I don't have a patch to suggest.

I think this part needs a testsuite before any further changes :)

You could start from the posh or FreeBSD sh testsuites and what's in the
commit messages. Or if you have little programmer time but lots of CPU
time, rebuild all packages in the debian archive :)

-- 
Jilles Tjoelker
