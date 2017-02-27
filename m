From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] quote arguments in xtrace output
Date: Mon, 27 Feb 2017 20:24:35 +0100
Message-ID: <f9c5d0a5-69bc-c543-7de8-59e5e9cb105b@gigawatt.nl>
References: <e50519c3-4055-ab2a-b9f3-0776369e4106@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:58596 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdB0T0A (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 27 Feb 2017 14:26:00 -0500
In-Reply-To: <e50519c3-4055-ab2a-b9f3-0776369e4106@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>, dash <dash@vger.kernel.org>

On 27/02/2017 07:22, Martijn Dekker wrote:
> The xtrace (set -x) output in dash is a bit of a pain, because arguments
> containing whitespace aren't quoted. This can it impossible to tell
> which bit belongs to which argument:

Agreed.

> $ dash -c 'set -x; printf "%s\n" one "two three" four'
> + printf %s\n one two three four
> one
> two three
> four
>
> Another disadvantage is you cannot simply copy and paste the commands
> from this xtrace output to repeat them for debugging purposes.
>
> I wrote the attached patch which fixes this. I've been testing it for
> about a week and had no issues.
>
> The patch changes the following:
>
> - Since we don't want every command name and argument quoted but only
> those containing non-shell-safe characters, single_quote() has acquired
> an extra argument indicating whether quoting should be conditional upon
> the string containing non-shell-safe characters (1) or unconditional
> (0). Shell-safe characters are defined as this set:
> 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz%+,./:=@_^!-
>
> - Quoting of variable assignments preceding commands needs to be handled
> specially; in order for the output to be suitable for re-entry into the
> shell, only the part after the "=" must be quoted. For this purpose, I
> changed eprintlist() into two functions, eprintvarlist() to print the
> variable assignments and eprintarglist() to print the rest.

The general approach looks nice. I think this misses a few cases though 
if you're aiming to make it suitable for re-entry:

   $ src/dash -c 'set -x; \!'
   + !
   src/dash: 1: !: not found

   $ src/dash -c 'set -x; \a=b'
   + a=b
   src/dash: 1: a=b: not found

   $ src/dash -c 'set -x; \if'
   + if
   src/dash: 1: if: not found

I could create binaries by those names to get rid of the errors. 
Regardless, in none these cases would the original command be 
re-executed if the set -x output were entered into the shell.

Aside from the first, bash doesn't quote them either. It may be okay to 
leave this as it is and acknowledge that it doesn't handle all cases, as 
long as it handles enough of them to be an improvement.

Depending on what happens with 
<http://austingroupbugs.net/view.php?id=249>, if support for $'...' will 
become required in a future version of POSIX, it may additionally make 
sense to use that syntax for control characters already right now.

It feels like the set of shell-safe characters should be able to use the 
generated syntax.[ch] files, but none of the existing categories quite 
matches.

If the modification to single_quote can handle all cases (perhaps 
quoting unnecessarily if it's unclear), then the conditional parameter 
could be removed and applied unconditionally: as far as I can tell, 
there are no existing calls that require the single quotes for simple words.

> Hope this is useful,
>
> - Martijn

It looks useful to me. :)

Cheers,
Harald van Dijk
