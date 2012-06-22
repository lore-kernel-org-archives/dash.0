From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] Set SA_RESTART flag on SIGCHLD handler
Date: Sat, 23 Jun 2012 00:02:08 +0200
Message-ID: <20120622220208.GB33407@stack.nl>
References: <4F665E77.3060102@mit.edu>
 <20120319025201.GA24778@burratino>
 <4F66A6CA.4010002@mit.edu>
 <20120319033751.GA25237@burratino>
 <alpine.DEB.2.00.1206210345050.3236@dr-wily.mit.edu>
 <20120622003628.GD4730@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:59806 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758872Ab2FVWLg (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 Jun 2012 18:11:36 -0400
Content-Disposition: inline
In-Reply-To: <20120622003628.GD4730@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Anders Kaseorg <andersk@MIT.EDU>, dash@vger.kernel.org, git@packages.debian.org

On Thu, Jun 21, 2012 at 07:36:28PM -0500, Jonathan Nieder wrote:
> Anders Kaseorg wrote:
> > On Sun, 18 Mar 2012, Jonathan Nieder wrote:

> >> --- i/src/trap.c
> >> +++ w/src/trap.c
> >> @@ -259,7 +259,7 @@ setsignal(int signo)
> >>  		act.sa_handler =3D SIG_DFL;
> >>  	}
> >>  	*t =3D action;
> >> -	act.sa_flags =3D 0;
> >> +	act.sa_flags =3D SA_RESTART;
> >>  	sigfillset(&act.sa_mask);
> >>  	sigaction(signo, &act, 0);
> >>  }
> [...]
> > It looks like this was never forwarded to the dash mailing list.  A=
ny=20
> > thoughts from upstream?

> > Context: http://thread.gmane.org/gmane.comp.version-control.git.deb=
ian/147
> > (FTR, it did happen again.)

> Thanks.  Here's a less invasive patch to experiment with.

> POSIX (XCU =A72.11 "Signals and Error Handling") requires that the "w=
ait"
> utility must return immediately when interrupted by a trapped signal,
> so SA_RESTART is not appropriate for those.

Same thing for "read", even though that does not make much sense (the
only thing the trap handler can do is abandon the read, since bytes
already read but not part of a complete line may be lost).

On the other hand, this interruption is not specified to happen with
signals whose default action is to ignore. Many shells don't do this,
though (perhaps because of the difficulty of finding what the default
action is).

> It does not seem to give any advice on whether signals interrupt
> redirection.

=46or certain situations it certainly does. For simple commands without
command name, it says any redirections shall be performed in a subshell
environment; hence, trapped signals are reset to the default action.
This is what most shells appear to do in all cases. Again, this may not
be the most useful behaviour but it matches what the Bourne shell did.

> diff --git i/src/redir.c w/src/redir.c
> index f96a76bc..7fb7748f 100644
> --- i/src/redir.c
> +++ w/src/redir.c
> @@ -206,8 +206,11 @@ openredirect(union node *redir)
>  		/* FALLTHROUGH */
>  	case NCLOBBER:
>  		fname =3D redir->nfile.expfname;
> -		if ((f =3D open64(fname, O_WRONLY|O_CREAT|O_TRUNC, 0666)) < 0)
> +		while ((f =3D open64(fname, O_WRONLY|O_CREAT|O_TRUNC, 0666)) < 0) =
{
> +			if (errno =3D=3D EINTR)
> +				continue;
>  			goto ecreate;
> +		}
>  		break;
>  	case NAPPEND:
>  		fname =3D redir->nfile.expfname;

It looks like this patch breaks interrupting (via SIGINT) a blocking
open, for example of a fifo. Although the race condition associated wit=
h
relying on [EINTR] is very hard to close, I don't think that's reason t=
o
give up on it entirely.

I think it is better to rethink commit
3800d4934391b144fd261a7957aea72ced7d47ea that caused this bug (and some
others that have been fixed). A signal handler for SIGCHLD was added to
allow waiting for a trapped signal or a child process at the same time
(using sigsuspend, as was done, or sigwait). However, leaving the signa=
l
handler installed all the time causes unexpected [EINTR] errors, so I
suggest only installing it during the "wait" builtin or specifying
SA_RESTART only for this special SIGCHLD handler (while leaving all
other signal handlers interrupting). In either case, behaviour for
SIGCHLD handlers installed because of CHLD traps should remain
unchanged. The former seems safest because SA_RESTART handlers still
cause visible effects such as short writes.

In case of a script doing 'trap "" CHLD', it is perhaps undesirable for
"wait" to block forever, given that wait(2) doesn't do that either.

--=20
Jilles Tjoelker
