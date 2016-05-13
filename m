From: Geoff Nixon <geoff@geoff.codes>
Subject: The behavior of `jobs -p` is definitely, without a doubt, a bug
Date: Thu, 12 May 2016 19:06:43 -0700
Message-ID: <154a7ddad4a.edbc789338466.8966956162476476079@geoff.codes>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:24063 "EHLO
	sender163-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbcEMCGr (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 12 May 2016 22:06:47 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>, "482999@bugs.debian.org" <482999@bugs.debian.org>

Package: dash
Version: build-from-git-HEAD--http://git.kernel.org/cgit/utils/dash/dash
Severity: serious
X-Debbugs-CC: herbert@gondor.apana.org.au
---

To Whom It May Concern:

I wrote most of this before I read through the Debian bug report process.
I'm actually not sure whether this is supposed to go to Debian or to the
kernel.org address; So I apologize if some of it is redundant or sounds a
bit weird; I assumed I'd be "creating a new thread", so I refer to this
thread as "that thread", etc.

If I've made any other errors, again apologizes in advance; it's the first time
I've worked with the Debian process, and I'm using dash on another platform, so
I don't have access to "reportbug", etc.

Also, if I come off a bit pissy, petulant, pedantic, or arrogant, it's only
because I have so many, many times *been* "that guy" -- someone who takes the
time and goes out of his way to write and file a bug report and send it through
the proper channels -- only have it basically dismissed out of hand. So when
I found myself in the position of not only reporting a bug, but having to
refute the incorrect arguments made that led to the bug report being dismissed,
and thinking about how this could have been fixed 8 years ago, it did irk me.
So yes, I was a bit peeved as I wrote it, it is absolutely nothing personal
(except in that it's some of my own emotional baggage).

So, once again, apologies, I truly mean no disrespect.

-------------------------------------------------------------------------------

So I thought I was going to be reporting a "new" bug today.

But it turns out, this came up way back in 2008:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=482999

At at the time, the curt response and resolution seemed to be all of "no", and
"you should just use $!".

So I guess rather than a "bug report" per se, this is a vociferous argument
questioning that conclusion, and a request that it be reconsidered.

To me, this is definitely, absolutely, positively a bug.

---

Let me start with a couple of corrections to that previous thread.


1. The line: jobs -p > /tmp/pids                   # this works

Does *not*, in fact, work. Meaning there is *no* instance in which it works.

Now (8 years later), to the assertions made in that thread.

2. This response:

> Hi, I don't think that's a bug, the jobs builtin 'shall display the
> status of jobs that were started in the current shell environment;'[0]
> 
> When running jobs in a subshell, you change the shell environment for
> the jobs builtin.
> 
> Regards, Gerrit.
> 
> [0] http://www.opengroup.org/onlinepubs/009695399/utilities/jobs.html

Is just flat incorrect. In fact, it is almost the complete opposite of
what the standard says. Perhaps we should refer back to (I'm intentionally
using Issue 6 here, since that was the standard at the time of the original
discussion, but nothing of relevance differs in Issue 7)
http://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html,
"Shell Command Lanuage", in particular (all emphasis mine):

  2.12. Shell Execution Environment
  ---------------------------------
  ...

  *The environment of the shell process shall not be changed by the utility
  unless explicitly specified by the utility description* (for example, cd and
  umask).

  A subshell environment *shall be created as a duplicate of the shell
  environment*, except that signal traps that are not being ignored shall be
  set to the default action. Changes made to the subshell environment shall not
  affect the shell environment. *Command substitution*, commands that are
  grouped with parentheses, and *asynchronous lists* shall be executed in a
  subshell environment.

and

  2.9.3 Lists
  -----------
  ...

  Asynchronous Lists

  If a command is terminated by the control operator ampersand ( '&' ), the
shell shall execute the command asynchronously in a subshell. 
  ...
  When an element of an asynchronous list (the portion of the list ended by an
  ampersand ...), is started by the shell, the process ID of the last command
  in the asynchronous list element shall become known in the current shell
  execution environment; see Shell Execution Environment.

In review, a subshell inherits a duplicate of the parent environment, which
includes the asynchronous list of background tasks, and the shell environment is
*explicitly* not to be changed, unless otherwise specified. Which it is not.

Basically:  `(this)`, `$(this)`, `this &`, a few other cases, are subshells.
They inherit the environment of the parent shell. The other interpretation given
describes something like that which occurs with an invocation of `sh -c '...'`,
which is not the case here.

3. But let us return to the specification for "jobs". Since subshells are
really not even the issue here at all. Indeed, the specification does says it

  'shall display the status of jobs that were started in the current shell
  environment'

as quoted. In the description, but if you read a bit futher, it goes on to in
face specify *how* it should do so. This includes, specifically,

  STDOUT
  ------
  If the -p option is specified, the output shall consist of one line for each
  process ID:

  "%d\n", <process ID>

That is: `jobs -p` *is supposed to go to standard output*, and something like
the line below (note, here, we have no subshell):

  `jobs -p | while read job; do echo $job; done`

should work, as should all the examples in the original bug report:

  `echo $(jobs -p)`
  `for i in $(jobs -p); do echo $i; done`
  `jobs -p | xargs`

But they do not. The present behavior is to simply dump the process IDs directly
to the TTY, it seems. Which is not, at all, what the specification dictates.

5. Then lets read a bit further, shall we? Although from the "informative" part
of the spec, there's this:

  APPLICATION USAGE
  -----------------
  *The -p option is the only portable way* to find out the process group of a
  job because different implementations have different strategies for defining
  the process group of the job. *Usage such as ** $(jobs -p) ** provides a way
  of referring to the process group of the job in an implementation-independent
  way.

  The jobs utility does not work as expected when it is operating in its own
  utility execution environment because that environment has no applicable jobs
  to manipulate... For this reason, jobs is generally implemented as a shell
regular built-in. 

So, I'm pretty sure the specification intends for echo $(jobs -p) to work.
Since it *directly references that exact usage*. I'm not sure what's exactly
meant by "generally implemented as a shell regular built-in" -- but I indeed
just tried for an hour to see if I could write a shell function that could be
used to emulate the same behavior. But I couldn't find (and I doubt there is) a
way to do it without at lease something non-POSX, like a ksh DEBUG trap.

And finally, do I really need to lay out the reasons why one might need the
ability to list *all* jobs, as opposed to simply the last one used?

To me, "just use $!" sounds to me a lot more like "just go use another shell".


I apologize for being brusk.
Thank you for your attention to this matter.


Geoff Nixon
geoff at geoff.codes

