From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: getopts doesn't properly update OPTIND when called from function
Date: Tue, 2 Jun 2015 00:10:46 +0200
Message-ID: <20150601221046.GA95455@stack.nl>
References: <20150529025809.GA16240@gondor.apana.org.au>
 <5567FE11.8060103@gigawatt.nl>
 <20150601062905.GB10460@gondor.apana.org.au>
 <556C96C6.5030600@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:52591 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751588AbbFAWVC (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 1 Jun 2015 18:21:02 -0400
Content-Disposition: inline
In-Reply-To: <556C96C6.5030600@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, martijn@inlv.org, dash@vger.kernel.org

On Mon, Jun 01, 2015 at 07:30:46PM +0200, Harald van Dijk wrote:
> On 01/06/2015 08:29, Herbert Xu wrote:
> > On Fri, May 29, 2015 at 07:50:09AM +0200, Harald van Dijk wrote:

> >> But the test script in this thread does invoke getopts with
> >> parameters that are the same in all invocations, and without
> >> modifying OPTIND. I don't see anything else in the normative
> >> sections that would make the result undefined or unspecified either.
> >> I do think the script is valid, and the results in dash should match
> >> those of other shells.

> > The bash behaviour makes it impossible to call shell functions
> > that invoke getopts while in the middle of an getopts loop.

> > IMHO the dash behaviour makes a lot more sense since a function
> > always brings with it a new set of parameters.  That plus the
> > fact that this behaviour has been there since day one makes me
> > reluctant to change it since the POSIX wording is not all that
> > clear.

> True. Given that almost no shell supports that anyway, there can't be 
> too many scripts that rely on it, but I did warn about the risk of 
> breaking another type of existing scripts as well, I agree that's a real 
> concern.

FreeBSD sh inherits similar code from ash and likewise has per-function
getopts state. Various shell scripts in the FreeBSD base system use
getopts in functions without setting OPTIND=1.

> One thing that doesn't really make sense, though: if the getopts 
> internal state is local to a function, then OPTIND and OPTARG really 
> should be too. Because they aren't, nested getopts loops already don't 
> really work in a useful way in dash, because the inner loop overwrites 
> the OPTIND and OPTARG variables. While OPTARG will typically be checked 
> right at the start of the loop, before any inner loop executes, OPTIND 
> is typically used at the end of the loop, in combination with the shift 
> command. The current behaviour makes the OPTIND value in that case 
> unreliable.

First, note that the OPTARG and OPTIND shell variables are not an input
to getopts, except for an assignment OPTIND=1 (restoring an OPTIND local
at function return does not reset getopts), and that getopts writes
OPTIND no matter whether getopts's internal optind changed in this
invocation.

With that, the value of OPTIND generally used in scripts is not
unreliable. OPTIND is generally only checked after getopts returned
false (end of options), in the sequence
  while getopts ...; do
    ...
  done
  shift "$((OPTIND - 1))"

> So either way, I think something should change. But if you prefer to get 
> clarification first about the intended meaning of the POSIX wording, 
> that certainly seems reasonable to me.

I think the POSIX wording is clear enough, but it may not be desirable
to change getopts to work that way.

-- 
Jilles Tjoelker
