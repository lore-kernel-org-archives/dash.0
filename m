From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: The behavior of `jobs -p` is definitely, without a doubt, a bug
Date: Wed, 18 May 2016 23:03:59 +0200
Message-ID: <573CD8BF.9080404@gigawatt.nl>
References: <154a7ddad4a.edbc789338466.8966956162476476079@geoff.codes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:33171
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932233AbcERVED (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 18 May 2016 17:04:03 -0400
In-Reply-To: <154a7ddad4a.edbc789338466.8966956162476476079@geoff.codes>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>
Cc: Geoff Nixon <geoff@geoff.codes>

Hi,

On 13/05/16 04:06, Geoff Nixon wrote:
 > Let me start with a couple of corrections to that previous thread.
 >
 >
 > 1. The line: jobs -p > /tmp/pids                   # this works
 >
 > Does *not*, in fact, work. Meaning there is *no* instance in which it 
works.

This should work just fine. Do you have a short test script where it 
does not work for you?

 > But they do not. The present behavior is to simply dump the process 
IDs directly
 > to the TTY, it seems. Which is not, at all, what the specification 
dictates.

That's not what happens. While there are a lot of contexts where you can 
reasonably argue that jobs -p should output PIDs to stdout and where 
dash doesn't, when it doesn't, it doesn't output anything. It doesn't 
somehow start dumping PIDs elsewhere.

 > In review, a subshell inherits a duplicate of the parent environment, 
which
 > includes the asynchronous list of background tasks, and the shell 
environment is
 > *explicitly* not to be changed, unless otherwise specified. Which it 
is not.

This is the main point of your message, and it's reasonable, but it's 
not clearly right or clearly wrong. ksh and mksh agree with your 
interpretation. bash comes across as inconsistent (but there may be a 
logic that's simply not immediately obvious). dash disagrees with your 
interpretation, and zsh appears to disagree as well.

   sleep 1 &
   echo $(jobs -p)
   (jobs -p)
   jobs -p

ksh and mksh print the PID thrice.
bash prints the PID twice, it omits it in (jobs -p).
dash prints the PID once.
zsh is a bit unclear since its -p option has a more limited effect, but 
appears to work like dash, only printing one (non-empty) line of output.

Your logic relies on the list of jobs being a property of the 
environment. That's a reasonable interpretation, but not the only one. 
Another interpretation is the environment that started a job being a 
property of the job. In that interpretation, that information is not 
part of the environment and hence not copied when duplicating the 
environment. And it wouldn't be the first time that the "Application 
Usage" section of a utility contradicts the normative requirements.

That said, it does seem extremely likely that trivial examples such as
   echo $(jobs -p)
are intended to work the way you expect, regardless of whether the 
standard manages to state the requirements correctly. Other cases are 
not so clear, not when looking at the standard, and also not when 
looking at what other shells do. This makes it difficult to come up with 
a complete fix.

Personally, I feel that even if your interpretation is wrong (and I'm 
not saying it is), it is still less undesirable than dash's current 
behaviour. If there's a reasonable chance a patch for it would be 
accepted, I'd be willing to try to make it so.

Cheers,
Harald van Dijk
