From: Martijn Dekker <martijn@inlv.org>
Subject: Re: getopts doesn't properly update OPTIND when called from function
Date: Thu, 04 Jun 2015 21:56:20 +0200
Message-ID: <5570AD64.6030303@inlv.org>
References: <5567644F.3080909@inlv.org> <5567990E.3090902@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:49130 "EHLO
	lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753027AbbFDT40 (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 4 Jun 2015 15:56:26 -0400
In-Reply-To: <5567990E.3090902@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Harald van Dijk schreef op 29-05-15 om 00:39:
> A quick patch to make sure it is global, and isn't reset when it
> shouldn't or doesn't need to be, is attached. You can experiment with
> it, if you like.

I've been using dash with this patch since you posted it, and it works
like a charm (including my function that extends getopts'
functionality). No issues encountered. Thanks.

Further discussion in this thread shows that the patch may conflict with
existing usage of 'getopts' for parsing the options within a function (a
usage that would make the script quite shell-specific, by the way,
because it would rely on Almquist-specific behaviour).

The issue, as I understand it, is that 'getopts' keeps not just the
OPTIND variable but also an additional invisible internal variable to
maintain its state. This is necessary to keep track of combined short
options.[*]

There appear to be two possible use cases for calling 'getopts' within a
function:

1. The option parsing loop is in the function, parsing the function's
options. This requires a function-local internal state of 'getopts',
otherwise calling a function using getopts from a main getopts loop
couldn't possibly work, because there is no way to directly save or
restore the unnamed internal state variable of getopts.

2. The option parsing loop is in the main shell environment, but instead
of calling getopts directly, the option parsing loop calls a function,
passing on the main positional parameters, and that function then calls
'getopts' and does additional things (in my case, re-parse GNU-style
--long options in terms of a special short option '--' with argument;
but of course it could be anything). This requires a global internal
'getopts' state.

Use case 1 requires a global internal 'getopts' state and use case 2
requires a local one, so they are mutually incompatible.

But I'm thinking that perhaps there is a way for the shell to
distinguish between these two use cases so that they can be reconciled.

The standard says that OPTIND is a global variable in any case, so use
case 1 above could only work if, before starting the function's option
parsing loop, OPTIND is either explicitly declared a function-local
variable using the non-standard 'local' keyword or is reinitialized
using an assignment.

On the other hand, use case 2 could only work if OPTIND is completely
left alone by the function, allowing a 'getopts' with a global state to
do its thing without interference.

So I would suggest the following might reconcile both use cases: By
default, make the 'getopts' internal state global. However, whenever
OPTIND is either assigned a value within a function or declared local
within a function, automatically make the 'getopts' internal state local
to the function.

Comments?

- M.

[*] Just as a datapoint, I found that yash has a different strategy for
this: it stores both values in OPTIND, separated by a semicolon -- e.g.
an $OPTIND of 3:2 means getopts is at the second option in the third
argument.

