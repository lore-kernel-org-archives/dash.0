From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] JOBS: fix klibc DEBUG compilation
Date: Fri, 3 Jun 2011 20:13:02 +0200
Message-ID: <20110603181302.GA13418@stack.nl>
References: <1307122707-30526-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:60739 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751426Ab1FCSU5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 3 Jun 2011 14:20:57 -0400
Content-Disposition: inline
In-Reply-To: <1307122707-30526-1-git-send-email-max@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, klibc@zytor.com, dash@vger.kernel.org

On Fri, Jun 03, 2011 at 07:38:27PM +0200, maximilian attems wrote:
> dash didn't compile in DEBUG mode against klibc for all long time.
> Now it fails at link stage for not having setlinebuf(3).

> Fixes:

> usr/dash/show.o: In function `opentrace':
> show.c:(.text+0x86): undefined reference to `setlinebuf'                        
> Signed-off-by: maximilian attems <max@stro.at>
> ---

> the last open error, looks more like a klibc bug to me,
> will fix it there:
> show.c:(.text+0x36): undefined reference to `freopen'

So it seems, freopen() is a perfectly valid standard C function.

>  src/show.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

> diff --git a/src/show.c b/src/show.c
> index 14dbef3..b4160e1 100644
> --- a/src/show.c
> +++ b/src/show.c
> @@ -394,7 +394,9 @@ opentrace(void)
>  	if ((flags = fcntl(fileno(tracefile), F_GETFL, 0)) >= 0)
>  		fcntl(fileno(tracefile), F_SETFL, flags | O_APPEND);
>  #endif
> +#ifndef SMALL
>  	setlinebuf(tracefile);
> +#endif /* SMALL */
>  	fputs("\nTracing started.\n", tracefile);
>  }
>  #endif /* DEBUG */

Why not just replace the non-standard setlinebuf() call with the
standard  setvbuf(tracefile, NULL, _IOLBF, 0);  ? This appears to work
just as well on FreeBSD and is C99 compliant (no POSIX needed here).

The #define SMALL is only for disabling line editing and history (using
libedit). Setting the trace file line buffered is useful regardless of
that.

-- 
Jilles Tjoelker
