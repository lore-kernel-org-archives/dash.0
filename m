From: Geoff Nixon <geoff@geoff.codes>
Subject: Re: The behavior of `jobs -p` is definitely, without a doubt, a bug
Date: Wed, 18 May 2016 17:03:44 -0700
Message-ID: <154c6533dbf.f33a196d271361.3835032381744891755@geoff.codes>
References: <154a7ddad4a.edbc789338466.8966956162476476079@geoff.codes> <573CD8BF.9080404@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:24710 "EHLO
	sender163-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbcESAEU (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 18 May 2016 20:04:20 -0400
In-Reply-To: <573CD8BF.9080404@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>, "482999@bugs.debian.org" <482999@bugs.debian.org>


---- On Wed, 18 May 2016 14:03:59 -0700 Harald van Dijk <harald@gigawatt.nl> wrote ---- 
> Hi, 
> 
> On 13/05/16 04:06, Geoff Nixon wrote: 
> > Let me start with a couple of corrections to that previous thread. 
> > 
> > 
> > 1. The line: jobs -p > /tmp/pids # this works 
> > 
> > Does *not*, in fact, work. Meaning there is *no* instance in which it 
> works. 
> 
> This should work just fine. Do you have a short test script where it 
> does not work for you? 

Sorry, you are absolutely right, this does *does* work. I could have sworn it
didn't when I tried before, but perhaps I was conflating it with something like
`jobs -p | tee /tmp/pids`, which doesn't work.

> > But they do not. The present behavior is to simply dump the process 
> IDs directly 
> > to the TTY, it seems. Which is not, at all, what the specification 
> dictates. 
> 
> That's not what happens. While there are a lot of contexts where you can 
> reasonably argue that jobs -p should output PIDs to stdout and where 
> dash doesn't, when it doesn't, it doesn't output anything. It doesn't 
> somehow start dumping PIDs elsewhere. 

Indeed, you are correct again; my mistake. Due to my incorrect conclusion
(that `jobs -p > /tmp/pids` fails), along with the fact that the
output of `jobs` fails in a pipeline, I drew the incorrect assumption that the
output of `jobs` *never* was sent to stdout. Apologies.

> > In review, a subshell inherits a duplicate of the parent environment, 
> which 
> > includes the asynchronous list of background tasks, and the shell 
> environment is 
> > *explicitly* not to be changed, unless otherwise specified. Which it 
> is not. 
> 
> This is the main point of your message...

Yes, that is the core of my argument.

> .... and it's reasonable, but it's 
> not clearly right or clearly wrong. ksh and mksh agree with your 
> interpretation. bash comes across as inconsistent (but there may be a 
> logic that's simply not immediately obvious). dash disagrees with your 
> interpretation, and zsh appears to disagree as well. 
> 
> sleep 1 & 
> echo $(jobs -p) 
> (jobs -p) 
> jobs -p 
> 
> ksh and mksh print the PID thrice. 
> bash prints the PID twice, it omits it in (jobs -p). 
> dash prints the PID once. 
> zsh is a bit unclear since its -p option has a more limited effect, but 
> appears to work like dash, only printing one (non-empty) line of output. 

Oops! I somehow forgot to include the results of my tests with other
shells. You are correct, and in addition to what you mention above: pdksh, oksh,
and yash all also exhibit the "thrice" behavior, while busybox's ash
(at least my old 1.20.0 version) exhibits the same behavior as bash -- that is,
`(jobs -p)` does not work, but the others do.

I don't think zsh should be considered here, since it is explicitly
documented that `jobs -p` does something entirely different (process groups):
http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html

> Your logic relies on the list of jobs being a property of the 
> environment. That's a reasonable interpretation, but not the only one. 
> Another interpretation is the environment that started a job being a 
> property of the job. In that interpretation, that information is not 
> part of the environment and hence not copied when duplicating the 
> environment.

While it's not really worth bickering about, I do in fact believe my
"interpretation" is *specified*. It's not on the `jobs` page, but in
"Shell Command Language", where it dictates that the environment includes:
" - Process IDs of the last commands in asynchronous lists known to this
shell environment".

> And it wouldn't be the first time that the "Application 
> Usage" section of a utility contradicts the normative requirements. 

True ;)

> That said, it does seem extremely likely that trivial examples such as 
> echo $(jobs -p) 
> are intended to work the way you expect, regardless of whether the 
> standard manages to state the requirements correctly. Other cases are 
> not so clear, not when looking at the standard, and also not when 
> looking at what other shells do. This makes it difficult to come up with 
> a complete fix.

Again, speaking for myself, I think the standard is actually pretty clear here.
Referring again to the "Shell Command Language" page:

    The format for grouping commands is as follows:
    (compound-list)
    Execute compound-list in a *subshell environment*...

That is, I believe the behavior of bash and busybox does not fully adhere to the
the standard; pdksh, ksh93, mksh, yash, and oksh are compliant.

> Personally, I feel that even if your interpretation is wrong (and I'm 
> not saying it is), it is still less undesirable than dash's current 
> behaviour. If there's a reasonable chance a patch for it would be 
> accepted, I'd be willing to try to make it so. 

Agreed. I'd very much like to see a patch for this; and I certainly hope it
would be accepted!

At the *very, very least*, I think the fact that `jobs -p` can have stdout
redirected to a file, yet cannot be used in a pipeline, is most definitely 
bug. Can you think of any other command where stdout can be redirected to a file
but cannot be piped?

I'd be willing to take a stab at a patch myself as well, but I'd much rather
leave this to more capable hands (someone more familiar with the dash codebase).
So I appreciate the offer!

Best,
Geoff

> 
> Cheers, 
> Harald van Dijk 

