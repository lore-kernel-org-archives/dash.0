From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Small cleanup to src/dash.1 - Command Line Editing
Date: Fri, 23 Jun 2017 16:41:28 +0200
Message-ID: <20170623144128.GA15837@stack.nl>
References: <6csf1e-9n5.ln1@sabon.larryhynes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mailout05.stack.nl ([131.155.140.202]:38439 "EHLO
        mailout.stack.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750932AbdFWOuP (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 23 Jun 2017 10:50:15 -0400
Content-Disposition: inline
In-Reply-To: <6csf1e-9n5.ln1@sabon.larryhynes.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Larry Hynes <larry@larryhynes.com>
Cc: dash@vger.kernel.org

On Sat, Jun 17, 2017 at 03:53:26PM +0100, Larry Hynes wrote:
> src/dash.1, under Command Line Editing, states:

> 	It's similar to vi: typing <ESC> will throw you into command
> 	VI command mode.

> - There appears to be no need for both occurrences of 'command'
> - I can't see a reason for VI to be capitalised
> - 'will throw you into' seems a little... enthusiastic

> Following diff changes it to

> 	It's similar to vi: typing <ESC> enters vi command mode.

> diff --git a/src/dash.1 b/src/dash.1
> index 8b8026d..f35d89d 100644
> --- a/src/dash.1
> +++ b/src/dash.1
> @@ -2232,7 +2232,7 @@ enabled, sh can be switched between insert mode and command mode.
>  The editor is not described in full here, but will be in a later document.
>  It's similar to vi: typing
>  .Aq ESC
> -will throw you into command VI command mode.
> +enters vi command mode.
>  Hitting
>  .Aq return
>  while in command mode will pass the line to the shell.

I agree. If you're changing things here anyway, I suggest getting rid of
the contraction as well (changing It's to It is). The fairly formal
style of man pages avoids contractions, just like it avoids "you".

The reference to the "later document" can probably be removed as well,
since said document does not exist yet after many years.

-- 
Jilles Tjoelker
