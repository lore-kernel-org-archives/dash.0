From: Martijn Dekker <martijn@inlv.org>
Subject: Re: [PATCH] quote arguments in xtrace output
Date: Mon, 27 Feb 2017 21:08:10 +0100
Message-ID: <6e8434e8-87e3-db2a-9d80-147f064c4793@inlv.org>
References: <e50519c3-4055-ab2a-b9f3-0776369e4106@inlv.org>
 <f9c5d0a5-69bc-c543-7de8-59e5e9cb105b@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:43342 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbdB0WFq (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 27 Feb 2017 17:05:46 -0500
In-Reply-To: <f9c5d0a5-69bc-c543-7de8-59e5e9cb105b@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

Op 27-02-17 om 20:24 schreef Harald van Dijk:
> The general approach looks nice. I think this misses a few cases though
> if you're aiming to make it suitable for re-entry:
> 
>   $ src/dash -c 'set -x; \!'
>   + !
>   src/dash: 1: !: not found
> 
>   $ src/dash -c 'set -x; \a=b'
>   + a=b
>   src/dash: 1: a=b: not found
> 
>   $ src/dash -c 'set -x; \if'
>   + if
>   src/dash: 1: if: not found
> 
> I could create binaries by those names to get rid of the errors.
> Regardless, in none these cases would the original command be
> re-executed if the set -x output were entered into the shell.

Good point.

The first and second cases would be fixed by simply removing "!" and "="
from SHELLSAFECHARS. Not a big loss.

Shell reserved words (a.k.a. shell keywords) such as "if" are harder to
fix. The single_quote() routine, if told to quote conditionally, would
have to iterate through the internal list of shell reserved words and
quote the string if it matches one of those. I will see if I can make
that happen.

Actually, after testing bash, yash, zsh, ksh93 and mksh as well as dash,
it looks like no current shell manages to quote strings that would
otherwise be shell keywords in xtrace output, with the exception of the
"!" keyword. So fixing this would make dash's xtrace output better than
any other shell's. :)

Since shell reserved words are part of the grammar, they never show up
in xtrace output, so at least the output is unambiguous: you know
anything that looks like a reserved word isn't.

> It may be okay to leave this as it is and acknowledge that it doesn't
> handle all cases, as long as it handles enough of them to be an
> improvement.

Yes. I would still remove "!" and "=" from SHELLSAFECHARS though; at
least that way you won't get output that looks like a negation or
assignment but isn't.

> If the modification to single_quote can handle all cases (perhaps
> quoting unnecessarily if it's unclear), then the conditional
> parameter could be removed and applied unconditionally: as far as I
> can tell, there are no existing calls that require the single quotes
> for simple words.

True, but this would change the output of something like:

$ dash -c 'alias stuff=xyz; trap true EXIT; alias; trap'

from:

stuff='xyz'
trap -- 'true' EXIT

to:

stuff=xyz
trap -- true EXIT

While there is technically nothing wrong with this, I think it's nicer
to leave those quoted unconditionally, because that facilitates editing
the output of those commands to feed it back to the shell.

- M.

