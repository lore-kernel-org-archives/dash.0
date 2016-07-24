From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: export statements and command substitution
Date: Sun, 24 Jul 2016 16:05:02 +0200
Message-ID: <a3599e38-fa1c-92ea-8c67-97f1574c0339@gigawatt.nl>
References: <5e6f29ec-418c-32f9-7754-5a4fe1f66577@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:50811
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490AbcGXOFW (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 24 Jul 2016 10:05:22 -0400
In-Reply-To: <5e6f29ec-418c-32f9-7754-5a4fe1f66577@gmx.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Nico Huber <nico.h@gmx.de>, dash@vger.kernel.org

On 24/07/16 15:46, Nico Huber wrote:
> Hi dash folks,
>
> we stumbled over a little curiosity in dash's behavior when you combine
> a variable assignment within an export statement with command sub-
> stitution.
>
> The following works fine in bash:
>   $ export foo=$(echo foo bar)
>   $ echo $foo
>   foo bar
> dash, however, applies field splitting and thus takes `bar` as a second
> variable name:
>   $ export foo=$(echo foo bar)
>   $ echo $foo
>   foo
> which can easily be fixed by adding double quotes:
>   $ export foo="$(echo foo bar)"
>   $ echo $foo
>   foo bar
>
> I know bash shouldn't be the reference so I had a look at [1]. It
> states:
>  "If a command substitution occurs inside double-quotes, field
>   splitting and pathname expansion shall not be performed on the
>   results of the substitution."
> Which one could read as field splitting should take place if you don't
> supply double quotes. But in present shells variable assignments seem
> to be an exception.
>
> And even dash doesn't apply field splitting on a simple assignment:
>   $ foo=$(echo foo bar)
>   $ echo $foo
>   foo bar

Yes, that's as specified in 
<http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01>. 
First, commands are scanned to see what words are shell variable 
assignments. Then, those words that are not shell variable assignments 
are fully expanded. Finally, redirections are applied and shell variable 
assignments get a limited expansion that omits field splitting.

Note that the a=b in export a=b is not a shell variable assignment, as 
far as the parser is currently concerned, both in the dash 
implementation and in the language specification, it is just a word 
that's used as an argument for the export command. What the export 
command then does with it is another story.

> That's at least inconsistent and, IMO, the export statement should have
> the same semantics (i.e. not requiring double quotes) as things can get
> quite nasty if you think of evaluations like:
>   $ export foo=$(echo bar bar=foo)
>   $ echo $foo
>   bar
>   $ echo $bar
>   foo

The next version of POSIX will require this behaviour, see 
<http://austingroupbugs.net/view.php?id=351>, but the current version 
doesn't even allow it.

> Best regards,
> Nico
> [1]
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_03
