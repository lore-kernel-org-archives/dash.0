From: maximilian attems <max@stro.at>
Subject: Re: [PATCH] JOBS: fix klibc DEBUG compilation
Date: Sat, 4 Jun 2011 06:45:59 +0000
Message-ID: <20110604064559.GD22026@vostochny.stro.at>
References: <1307122707-30526-1-git-send-email-max@stro.at>
 <20110603181302.GA13418@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from vostochny.stro.at ([78.47.22.85]:49777 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185Ab1FDGqA (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 4 Jun 2011 02:46:00 -0400
Content-Disposition: inline
In-Reply-To: <20110603181302.GA13418@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, klibc@zytor.com, dash@vger.kernel.org

On Fri, Jun 03, 2011 at 08:13:02PM +0200, Jilles Tjoelker wrote:
> >  src/show.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> > diff --git a/src/show.c b/src/show.c
> > index 14dbef3..b4160e1 100644
> > --- a/src/show.c
> > +++ b/src/show.c
> > @@ -394,7 +394,9 @@ opentrace(void)
> >  	if ((flags = fcntl(fileno(tracefile), F_GETFL, 0)) >= 0)
> >  		fcntl(fileno(tracefile), F_SETFL, flags | O_APPEND);
> >  #endif
> > +#ifndef SMALL
> >  	setlinebuf(tracefile);
> > +#endif /* SMALL */
> >  	fputs("\nTracing started.\n", tracefile);
> >  }
> >  #endif /* DEBUG */
> 
> Why not just replace the non-standard setlinebuf() call with the
> standard  setvbuf(tracefile, NULL, _IOLBF, 0);  ? This appears to work
> just as well on FreeBSD and is C99 compliant (no POSIX needed here).
> 
> The #define SMALL is only for disabling line editing and history (using
> libedit). Setting the trace file line buffered is useful regardless of
> that.

If one doesn't support libedit one is assumed to define SMALL
and klibc does such.
http://www.spinics.net/lists/dash/msg00311.html

oh and I seem to not have recieved Herbert's answer from last Sept.
http://www.spinics.net/lists/dash/msg00367.html

I'll respin the patch based on it, thank you.

-- 
maks
