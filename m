From: "Oleg Verych" <olecom@gmail.com>
Subject: Re: job control (Re: dash race)
Date: Sun, 27 Apr 2008 21:35:16 +0100
Message-ID: <8499950a0804271335l168d259by51346743721ce0cb@mail.gmail.com>
References: <4811D0F1.20801@gmail.com> <20080425161721.GM24008@flower.upol.cz>
	 <4814624D.6010108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:33577 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbYD0UfS (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 27 Apr 2008 16:35:18 -0400
Received: by fk-out-0910.google.com with SMTP id 19so5581087fkr.5
        for <dash@vger.kernel.org>; Sun, 27 Apr 2008 13:35:17 -0700 (PDT)
In-Reply-To: <4814624D.6010108@gmail.com>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

Alexey Gladkov @ Sun, Apr 27, 2008 at 12:23 PM:

> > What script tries to do?
>
>  This script forking child process and send to parent signals.

Let's define what "shell script" is. Such script is a text file (string)
containing shell syntax. This text is read by shell interpreter
command after command. Each command gets executed; in
case of asynchronous one (&, "background" is term of interactive
shell), shell doesn't wait for completion and goes further.

So, script doesn't fork anything, shell does; more accurately,
shell process of PID=N executes commands by forking itself
(i.e. PID=M, M != N), establishing requested environment and
then doing replacing `exec` of a command.

Please correct me, if i'm wrong, but asynchronous shell functions
don't have this logic clear: $$ = N, but not M.

So, if $$ = N, what is "the parent"? Making shell scripting look
more like ordinary programming by mean of such confusion
in functions or in pipes[0] is a bad thing. Shell is a mean of
talking with operating system in the first place, not
programming an application.

[0] when shell is on the right side of | pipe, variables don't set in
  parent process -- it's sub shell, different execution environment --
  common problem of ordinary programmers trying to do shell
  scripting.

Signals. This are not a good way of communication between
processes[1]. Unfortunately "shell specification" didn't bother to
introduce anything like select() to make e.g. pipes (or other usual
fd-based means) usable in this case.

[1] http://www.dore.ru/perl/nntp.pl?f=1&gid=22&mid=25149
Thread: http://www.dore.ru/perl/nntp.pl?f=2&gid=22&mid=25126#25126

> If you are confused with functions it is possible to replace them by
> other script (see below).

I've asked about script (yours) and what it tries to do (on your opinion)

> > which is kind of strage. Messing with functions especially in background
> > isn't a good idea. I wonder what is semantics of functions WRT traps,
> > forks, signals, etc..
>
>  Maybe this is not good idea, but shell specification allow this.

I want to say, that function usage here may have side effects.

>  Another example:

I think, that implementation of background processes management
is incomplete and buggy. It was designed around interactive shell usage
with obsolete control terminal interface and must not be used otherwise.
For example, `bash` has `disown` command to explicitly remove a process
from the job list, don't know any such in `dash`. `dash` doesn't send
SIGHUP to its "children", instead every sub shell must be scripted so,
that it ends its execution if and when needed.

-- 
sed 'sed && sh + olecom = love' << ''
-o--=O`C
 #oo'L O
<___=E M
