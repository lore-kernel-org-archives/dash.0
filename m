From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] [BUILTIN] Fix corruption of reads with byte 0x81
Date: Fri, 11 Mar 2011 01:04:25 +0100
Message-ID: <20110311000425.GA64385@stack.nl>
References: <4D5C4EE2.9060504@gmail.com>
 <4D664470.7070707@gmail.com>
 <20110310130145.GF10824@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:62754 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754114Ab1CKAE0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 10 Mar 2011 19:04:26 -0500
Content-Disposition: inline
In-Reply-To: <20110310130145.GF10824@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, dash@vger.kernel.org

On Thu, Mar 10, 2011 at 09:01:45PM +0800, Herbert Xu wrote:
> On Thu, Feb 24, 2011 at 11:43:44AM +0000, Alexey Gladkov wrote:
> > Starting with commit 55c46b dash removes CTLESC bytes ('\x81')
> > from read sequence. This leads to breakage of some UTF8
> > characters. Like in commit f8231a, this change fixes corruption
> > by removing the faulty code.

> Thanks for the diagnosis and patch!

> Unfortunately we can't just delete the rmescaps call since we do
> use CTLESC to represent backslash characters in the input stream
> which prevents field splitting.

> So the correct fix is to add extra CTLESCs wherever CTLESC appears
> in the input.  The following patch should fix the problem.

That is not how ifsbreakup() works. As I have written in FreeBSD sh
expand.c:

/*
 * Break the argument string into pieces based upon IFS and add the
 * strings to the argument list.  The regions of the string to be
 * searched for IFS characters have been stored by recordregion.
 * CTLESC characters are preserved but have little effect in this pass
 * other than escaping CTL* characters.  In particular, they do not escape
 * IFS characters: that should be done with the ifsregion mechanism.
 * CTLQUOTEMARK characters are used to preserve empty quoted strings.
 * This pass treats them as a regular character, making the string non-empty.
 * Later, they are removed along with the other CTL* characters.
 */

The ifsbreakup() function works the same way in dash. (One reason is
that this allows using the CTL* bytes in IFS, although it may not be
that useful because of the prevalence of UTF-8.)

So while this patch fixes corruption with byte 0x81, backslashes
continue to have no effect at all. Instead, all non-backslashed
characters should be marked with recordregion(), leaving CTLESC
prefixing for CTLESC only.

Apart from that, there is corruption with byte 0x88, CTLQUOTEMARK. I
think that can be fixed in the same way by prefixing with CTLESC.

By the way, in the data pointed to by NARG nodes, dash does use CTLESC
for backslashed characters that should not be IFS splitting points,
which is only relevant for WORD in ${VAR+WORD} and ${VAR-WORD}. A
downside of this is that quoted and unquoted CTL* bytes cannot be
distinguished; therefore I have solved this differently in FreeBSD.

-- 
Jilles Tjoelker
