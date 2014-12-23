From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Possibly wrong handling of $_?
Date: Wed, 24 Dec 2014 00:21:09 +0100
Message-ID: <5499F8E5.205@gigawatt.nl>
References: <E1Y3Y2d-000276-SL@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.217]:42615 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751261AbaLWXVP (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 23 Dec 2014 18:21:15 -0500
In-Reply-To: <E1Y3Y2d-000276-SL@smtp.tt-solutions.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Vadim Zeitlin <vz-dash@zeitlins.org>
Cc: dash@vger.kernel.org

On 23/12/2014 23:34, Vadim Zeitlin wrote:
>   Hello,
>
>   I'm not exactly sure if this is a bug because I didn't find any
> specification about how is this supposed to behave (to my surprise it
> turned out that $_ was not in POSIX), but please consider this:
>
> 	% zsh -c 'echo -n foo && echo $_'
> 	foofoo
> 	% bash -c 'echo -n foo && echo $_'
> 	foofoo
> 	% dash -c 'echo -n foo && echo $_'
> 	foo/usr/bin/dash

This does come across as somewhat confusing, but $_ is really not a 
special variable at all in dash. The shell you're using to launch dash 
does make it a special variable. That shell puts _ in the environment, 
which dash then picks up, and ignores, other than making it available as $_.

You can see what your usual shell is doing by testing with other 
commands: just run

   env | grep '^_='

and you'll probably see

   _=/usr/bin/env

It works the same way when starting dash.

> I've tested several different versions of zsh (4 and 5) and bash (3 and 4)
> and dash 0.5.5 and 0.5.7 from Debian and they all produced the results as
> above.
>
>   Shouldn't dash follow the other shells here?
> VZ

If dash did something special with $_, then I agree it would be nice if 
it would be somewhat compatible with other shells. If dash simply does 
not implement a feature, that feature is not required by any standard, 
and that feature is not widely used, then I suspect there won't be a lot 
of interest in implementing that feature.

Don't be put off by that, though. You are free, of course, if you feel 
so, to attempt to convince people $_ is an important feature that all 
shells should implement. If you have compelling use cases, if it solves 
real problems, and if many other shells already implement it, you might 
even get it standardised. I have never seen a need for it, but that's 
just me speaking from personal experience, others may feel differently.

Cheers,
Harald van Dijk
