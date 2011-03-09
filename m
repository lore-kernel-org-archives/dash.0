From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: jobs in scripts?
Date: Wed, 9 Mar 2011 23:54:13 +0100
Message-ID: <20110309225413.GA45552@stack.nl>
References: <AANLkTinDKV9uCZQPhh8LtX9fAwYix0+9bP5LTXAuSCAL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:53218 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750814Ab1CIXFT (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 9 Mar 2011 18:05:19 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinDKV9uCZQPhh8LtX9fAwYix0+9bP5LTXAuSCAL@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Muresan <danmbox@gmail.com>
Cc: dash@vger.kernel.org

On Tue, Mar 08, 2011 at 09:02:30PM +0200, Dan Muresan wrote:
> Hi, is the following normal? With set -m the problem disappears; bash
> & ksh don't need set -m.

> SUSv3 doesn't say job control is to be disabled completely unless "set
> -m" is active. And, if job control *is* disabled, why does "job"
> report a non-empty list?

> 0.5.5.1-3ubuntu2 on Ubuntu 10.04 here.

> ---

> $ cat x
> #set -m
> sleep 100 &
> echo "Before kill:"; jobs -l
> kill -s TERM %1
> sleep 0.5
> echo "After kill:"; jobs -l
> pidof sleep

> $ dash x
> Before kill:
> [1] + 18775 Running
> kill: 4: No such process

> After kill:
> [1] + 18775 Running
> 18775

See the description of "set" in XCU 2.14 Special Built-In Utilities. It
is deliberate that "jobs" still works, as "set -m" only enables putting
jobs in separate process groups and various notices that are only
meaningful in interactive mode (there are no prompts in non-interactive
mode, therefore the notices about completed and stopped background jobs
do not happen, and if a foreground job stops in non-interactive mode
this tends to lead to unexpected results).

That much is clear. However, "kill" and "jobs -p" are less clear. Their
descriptions depend on the process group of a job, which does not exist
if job control was disabled when the job was started -- in that case the
job is run in the shell's process group. This could be interpreted as an
implicit requirement on the application that the job must have been
started with job control enabled if "kill" or "jobs -p" are to be used
on it.

In your case, I recommend getting the PID via $!. This allows 'kill'
without depending on obscure corners of shells.

If your script runs for a long time, use of $! should be paired with
'wait' (either for all $! values obtained or without parameters) so that
the shell can forget about old jobs. Some shells are buggy and remember
the jobs anyway.

-- 
Jilles Tjoelker
