From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Quoted closing brace in variable default expansion
Date: Sat, 13 Nov 2010 18:51:53 +0100
Message-ID: <20101113175153.GC79975@stack.nl>
References: <4CDEBC7B.5050805@gigawatt.nl>
 <20101113164147.GB5535@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:64655 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755994Ab0KMRvz (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 13 Nov 2010 12:51:55 -0500
Content-Disposition: inline
In-Reply-To: <20101113164147.GB5535@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

On Sat, Nov 13, 2010 at 10:41:47AM -0600, Jonathan Nieder wrote:
> Harald van Dijk wrote:

> >   $ ksh -c 'echo "${x:-"}"}"'
> >   }
> >   $ dash -c 'echo "${x:-"}"}"'
> >   dash: 1: Syntax error: Unterminated quoted string
> >   $ busybox sh -c 'echo "${x:-"}"}"'
> >   sh: syntax error: unterminated quoted string

> > It looks like dash and other ash derivatives stop the expansion with
> > the first }, instead of the first unquoted }. I'm getting confused
> > trying to figure out whether this is a bug in dash or in the script
> > relying on it.

> The answer depends on how portable the script is meant to be.  If
> the goal is to be portable to shells implementing future versions of
> the POSIX standard, there seems to be have been an interpretation[1]
> approved for the next major revision:

>  http://austingroupbugs.net/view.php?id=221
>  note #399

> which would make the example nonconformant because there are an odd
> number of unescaped double-quotes before the first unescaped closing
> brace.

Correct.

> See http://thread.gmane.org/gmane.comp.shells.dash/262/focus=263 for
> a nice summary (thanks, Jilles!).

Note that I have changed FreeBSD 9 sh since I wrote that. To preserve
sanity in expand.c, a substitution now ends with the same quoting level
as it started. Closing braces that do not conform to this are taken
literally. Making the parole configure script do what the author
expected was a bonus.

The change was needed to implement word splitting in WORD in ${v+WORD}.
For that, expand.c needs to know the quoted state of any character
of a word in ${v+-word}. Like NetBSD sh and dash have done, I added a
new magic character CTLQUOTEEND that shows the end of the quoted part
and interpreted CTLQUOTEMARK as the start. If I now have something like
  ${v-abc${vv-def"ghi}jkl"}
I would have to pass through the fact that the quotes were opened in
${vv-def"ghi} to the outer substitution, and I did not want that. The
change avoids it.

FreeBSD 9 sh is now very close to ksh93 in treatment of POSIX
substitutions and I am happy with this. (One of the deliberate
differences is that the above incorrect construct is flagged as an error
(missing '}') while ksh93 treats it as an incomplete command.)

As for the portable alternative, split up the command. Either put the
'}'-containing thing in a variable and use that as alternative or use an
explicit conditional. The Autoconf documentation has more information,
for example.

-- 
Jilles Tjoelker
