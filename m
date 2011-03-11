From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] [PARSER] Remove backslash before } in double-quotes in
 variable
Date: Fri, 11 Mar 2011 19:32:27 +0100
Message-ID: <20110311183227.GA80688@stack.nl>
References: <20101119135406.GA24391@gondor.apana.org.au>
 <4CE71991.3020108@gigawatt.nl>
 <20101121134222.GC17293@stack.nl>
 <20110310085927.GA10824@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:62490 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753171Ab1CKSca (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 11 Mar 2011 13:32:30 -0500
Content-Disposition: inline
In-Reply-To: <20110310085927.GA10824@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org, jrnieder@gmail.com

On Thu, Mar 10, 2011 at 04:59:27PM +0800, Herbert Xu wrote:
> On Sun, Nov 21, 2010 at 02:42:22PM +0100, Jilles Tjoelker wrote:
> > The backslash prevents the closing brace from terminating the
> > substitution, therefore it should be removed.
> > 
> > FreeBSD sh test expansion/plus-minus2.0 starts working, no other tests
> > are affected.
> > 
> > Example:
> >   printf "%s\n" ${$+\}} ${$+"\}"} "${$+\}}"
> > should print } three times, without backslashes.

> I agree with respect to the last one, but not the middle one.

> ${$+"\}"} should be identical in behaviour to "\}", which with
> all shells I have access to produces a brace with a backslash.

> So please update your patch so that we do not regress on the
> second one.

Meh. Now that I read http://austingroupbugs.net/view.php?id=221#c399
again, that particular bit is not so clear anymore. :(
That change only seems to affect parameter expansions inside
double-quotes, not double-quotes inside parameter expansions.

On the other hand, removing the backslash makes some sense because
${$+"}"} is unspecified (even though it expands to } in many shells). In
dash in particular it has an undesirable effect. When I wrote the code
to remove the backslash in FreeBSD sh, the first } ended the
substitution which as a result ended double-quoted although it started
unquoted; I changed this later so that the first } is literal, but did
not change the treatment of \} in that case.

My patch for dash goes further than what I did in FreeBSD in that it
also affects the four varieties of parameter expansion for substring
processing (#/##/%/%%). I think that is wrong and the FreeBSD behaviour
is correct. In the standard as modified by the aforementioned
interpretation, ${v#"}"} and ${v#'}'} seem valid (the pattern is a
literal closing brace). Therefore there seems no reason to remove the
backslash in ${v#"\}"}, even though ksh93 does it.

Distinguishing #/##/%/%% from the others at parse time is not possible
with the way dash's parser.c currently works. So a simple patch would
attempt to change \} inside "${...}" only (test dqvarnest instead of
varnest). I think that does not affect the end result for #/##/%/%% so
perhaps it can be committed as an small improvement.

At some point a larger change is probably necessary to fix things like
"${v#'a'}" which should trim the letter a, not single-quote a
single-quote. This works in FreeBSD 9 sh but I think its
Bourne/Korn-like approach to POSIX-unspecified constructs like
"${v+"what*is*this"}", which generates pathnames, just like the original
ash and older FreeBSD code, may not be appreciated in dash.

Some examples:

FreeBSD 9 sh does this:

% sh
$ v='a\}b'
$ echo ${v%"\}"*}
a
$ echo ${v+"\}"}
}

while dash with my original patch and ksh93 do this:

% ksh93
$ v='a\}b'
$ echo ${v%"\}"*}
a\
$ echo ${v+"\}"}
}

-- 
Jilles Tjoelker
