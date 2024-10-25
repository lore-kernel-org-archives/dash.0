Received: from mail02.stack.nl (scw01.stack.nl [51.15.111.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954717DFFC
	for <dash@vger.kernel.org>; Fri, 25 Oct 2024 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.15.111.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869746; cv=none; b=FiKTcBf7hW5Ms2kMHRPupbPNaz1C7xd33wpux8MaFJVeJ+aqs5cUYGWVlFZrkF73HSNoYJo2xq+4Ay74DKGX72Q86BnuFCJ0uOnuzJRQ0aGBLR6v73Cdq66P3D7oCgDxzbr1nMce2JQ1Pxk5lW35nZapStPZLQXPDF1mv2OL49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869746; c=relaxed/simple;
	bh=jdPI1yIS/0lrukhMiDpZDDqs2gfXE6foiFJTDPOhXqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WikCTfn+FejgvKRLvn/xhQHeNCxYnVg1gszj6J2ZuoV2qX8Ve72P+crME/uN4cvooDPvjTdEvHS9fFAbyqwUW7zL2FXHsbcf4l5s/kp/aCBc+3kbnwsJRZtsSTEkZEDVbzWiQ6ZCKgV0ANz5W8ojXAN2lIU3rFansSU+G3Swr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stack.nl; spf=pass smtp.mailfrom=stack.nl; arc=none smtp.client-ip=51.15.111.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stack.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stack.nl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail02.stack.nl (Postfix) with ESMTP id 4AD4D1E005C;
	Fri, 25 Oct 2024 15:14:36 +0000 (UTC)
Received: from mail02.stack.nl ([127.0.0.1])
	by localhost (mail02.stack.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xpgdu_oSB8AV; Fri, 25 Oct 2024 15:14:34 +0000 (UTC)
Received: from blade.stack.nl (blade.stack.nl [192.168.121.130])
	by mail02.stack.nl (Postfix) with ESMTP id 1511B1E0055;
	Fri, 25 Oct 2024 15:14:34 +0000 (UTC)
Received: by blade.stack.nl (Postfix, from userid 1677)
	id F0D32237C4D; Fri, 25 Oct 2024 17:14:33 +0200 (CEST)
Date: Fri, 25 Oct 2024 17:14:33 +0200
From: Jilles Tjoelker <jilles@stack.nl>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: dash@vger.kernel.org
Subject: Re: exit in traps
Message-ID: <20241025151433.GA14777@stack.nl>
References: <5e867ba59bb7fb8fd08a28f654658d0e3958942c.camel@scientia.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e867ba59bb7fb8fd08a28f654658d0e3958942c.camel@scientia.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Oct 25, 2024 at 01:51:28AM +0200, Christoph Anton Mitterer wrote:
> Not sure whether this is a bug:
>    #!/bin/sh

>    #trap -- "echo EXIT" EXIT
>    trap -- 'echo $?; echo INT; exit' INT

>    foo=$(exit 44)
>    read -r tmp

> Running that and <Ctrl-C>ing at the read prompt:
> $ dash x.sh ; echo $?
> ^C1
> INT
> 1
> $ 

> $ bash x.sh ; echo $?
> ^C44
> INT
> 0
> $ 

> First, shouldn’t dash’s echo $? give 44, like bash’s does? The most
> recent pipeline is foo=$(exit 44), as the read hasn't completed yet, so
> $? should be 44.

The read has completed, exiting on SIGINT. According to the text in XCU
2.11 Signals and Error Handling, the shell shall not execute the trap
action until a foreground utility has completed. Only special builtins
are excluded from the definition of "utility" and "wait" has a special
case here, and read is neither. It is more common in the POSIX shell
that the difference between non-special builtins and external programs
are to be minimized.

So the value of $? printed by the trap action shall be greater than 128,
and passing it to kill -l shall result in INT.

Perhaps people could deviate from this by saying that the trap action is
executed after the utility completes but before the pipeline (containing
only that utility in this case).

Note that the special case for "wait" is not restricted to signals that
have a default action of terminating the process. So, for example, if a
trap on WINCH has been set, a received SIGWINCH shall interrupt "wait"
but not "read". This might not be as intended.

> Second, for the final exit state:
> POSIX says[0] for `exit`:
> > If n is not specified, the result shall be as if n were specified
> > with the current value of the special parameter '?' (see 2.5.2
> > Special Parameters ), except that if the exit command would cause the
> > end of execution of a trap action, the value for the special
> > parameter '?' that is considered "current" shall be the value it had
> > immediately preceding the trap action.

> I'd read that as if a blank `exit` in a trap action (but only one that
> actually causes the trap to end (i.e. not something like $(exit) ),
> should cause an overall exit status of 44 here, too.

> Both, dash and bash would do that wrong.

I agree with that, except that the value of $? needs to be as above,
greater than 128.

In FreeBSD sh I tweaked this a bit more, making the shell send the
signal to itself, so it is easier to implement such logic (something
like kill -INT $$ will not work in a subshell).

In ksh93, the initial value of $? is as above (258 in this case), but
the exit status is still 44, which I do not understand.

> If one uncomments the trap on EXIT:
> $ dash x.sh ; echo $?
> ^C1
> INT
> EXIT
> 1

> Which I don't understand either.
> IMO the INT trap should need to end with 44 here (but only because of
> the literal exit - I think it should rather end with 0 if there were
> not exit in it).
> But then, dash executes the EXIT action, and in that the original $?
> should be 44, too, (from the INT action’s exit, not directly from
> outside the trap actions) but why does the shell end with 1? Shouldn't
> it be 0 because of echo EXIT?

As documented in XCU 2.14 Special Built-In Utilities trap, the value of
$? after the trap action completes shall be the value it had before it
was invoked. So the "echo EXIT" shall not affect the final exit status,
and I think that behaviour is more useful: this way, exit statuses from
the outer script are preserved without the trap action needing to do
anything special. A trap action can invoke "exit" if it wants to replace
the script's exit status.

-- 
Jilles Tjoelker
