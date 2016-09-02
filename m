From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Fri, 2 Sep 2016 17:12:59 +0200
Message-ID: <20160902151259.GB87540@stack.nl>
References: <0ce0bca2-3bdd-a1f5-169e-0291a49cd6c7@gigawatt.nl>
 <20160902140437.GA12639@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:34843 "EHLO mx1.stack.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932182AbcIBPNC (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 11:13:02 -0400
Content-Disposition: inline
In-Reply-To: <20160902140437.GA12639@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, olof@ethup.se, dash@vger.kernel.org

On Fri, Sep 02, 2016 at 10:04:37PM +0800, Herbert Xu wrote:
> Harald van Dijk <harald@gigawatt.nl> wrote:
> > Yes, this looks like a bug in dash. With the default --disable-fnmatch 
> > code, when dash encounters [ in a pattern, it immediately treats the 
> > following characters as part of the set. If it then encounters the end 
> > of the pattern without having seen a matching ], it attempts to reset 
> > the state and continue as if [ was treated as a literal character right 
> > from the start. The attempt to reset the state doesn't look right, and 
> > has been like this since at least the initial Git commit in 2005.

> pdksh exhibits the same behaviour:

> $ pdksh -c 'foo=[abc]; echo ${foo#[}'
> [abc]
> $

> POSIX says:

> 9.3.3 BRE Special Characters

> A BRE special character has special properties in certain contexts.
> Outside those contexts, or when preceded by a backslash, such a
> character is a BRE that matches the special character itself. The
> BRE special characters and the contexts in which they have their
> special meaning are as follows:

> .[\
> The period, left-bracket, and backslash shall be special except
> when used in a bracket expression (see RE Bracket Expression). An
> expression containing a '[' that is not preceded by a backslash
> and is not part of a bracket expression produces undefined results.

I think this interpretation of POSIX is incorrect. This is about shell
patterns, not basic regular expressions. Shell patterns are specified in
XCU 2.13 Pattern Matching Notation. In XCU 2.13.1, it is written:

] [
] If an open bracket introduces a bracket expression as in XBD Section
] 9.3.5, except that the <exclamation-mark> character ('!') shall
] replace the <circumflex> character ('^') in its role in a non-matching
] list in the regular expression notation, it shall introduce a pattern
] bracket expression. A bracket expression starting with an unquoted
] <circumflex> character produces unspecified results. Otherwise, '['
] shall match the character itself.

Therefore, pdksh is wrong and the output should be abc].

It is normally better to test against the actively developed mksh
instead of pdksh, but here mksh has the same bug. OpenBSD's ksh also has
some active development but stays closer to the original pdksh.

> > This also affects

> >     case [a in [?) echo ok ;; *) echo bad ;; esac

> > which should print ok.

> Even ksh prints bad here.

I think POSIX may be saying something different here from what it really
wants to say. There is text in 2.13.3 Patterns Used for Filename
Expansion that leaves unspecified whether [? matches only the literal
filename component [? or all two-character filename components starting
with [ (other slash-separated components in the same pattern are
unaffected). However, if ksh93 behaves similarly in a case statement,
that may have been what the standard had intended to say.

Looking at as simple code as possible, this seems, however, unhelpful.
Since a pattern like *[ should match the literal string *[ in the choice
where brackets that do not introduce a bracket expression are supposed
to disable other special characters and any earlier work on the * is
therefore wrong, implementing this choice requires an additional scan
for brackets that do not introduce a bracket expression.

-- 
Jilles Tjoelker
