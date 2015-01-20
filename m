From: Seb <sbb@tuxfamily.org>
Subject: Re: Inconsistent behaviour between 'jobs' and 'echo "$(jobs)"'
Date: Tue, 20 Jan 2015 20:07:39 +0100
Message-ID: <20150120190739.GA823@ein.free.fr>
References: <54BD4691.7050906@ertelnet.rybnik.pl>
 <20150120084438.GA751@ein.free.fr>
 <54BE89D6.7040101@ertelnet.rybnik.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:54369 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbbATTHj (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 20 Jan 2015 14:07:39 -0500
Content-Disposition: inline
In-Reply-To: <54BE89D6.7040101@ertelnet.rybnik.pl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>

On Tue, Jan 20, 2015 at 06:01:10PM +0100, Damian Wrobel wrote:
> On 01/20/2015 09:44 AM, Seb wrote:
> >On Mon, Jan 19, 2015 at 07:01:53PM +0100, Damian Wrobel wrote:
> >
> >Hello,
> >
> >>I'm observing an inconsistent behaviour between:
> >>  jobs
> >>and
> >>  echo "$(jobs)"
> >
> >It's because the command is ran in a sub-shell, where there is indeed no
> >running job.
> >
> >Bash has a special mechanism to handle this and get the current shell
> >context returned, that's why you may feel some inconsistency here (like
> >I myself did :)
> 
> There is an application usage [1] where this case is specifically mentioned
> with a suggestion that: "For this reason, jobs is generally implemented as a
> shell regular built-in."

Indeed, it seems the standard requires, or at least expects this to
work:

 "The -p option is the only portable way to find out the
  process group of a job because different implementations
  have different strategies for defining the process group of
  the job. Usage such as $(jobs -p) provides a way of
  referring to the process group of the job in an
  implementation-independent way."


> Now it looks that even the following doesn't work in a dash:
> 
> $ jobs -p | xargs kill

For the same reason as above: each member of the pipe is ran in its own
sub-shell.


> I would prefer not to code something like the following:
> 
> $ jobs -p >/tmp/jobs-$$ && kill $(cat /tmp/jobs-$$); rm /tmp/jobs-$$

I agree it's not very nice.

++
Seb.

