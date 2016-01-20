From: jca@wxcvbn.org (=?utf-8?Q?J=C3=A9r=C3=A9mie_Courr=C3=A8ges-Anglas?=)
Subject: Re: [PATCH] man: Document ulimit -v
Date: Wed, 20 Jan 2016 19:02:47 +0100
Message-ID: <87fuxs5dtk.fsf@ritchie.wxcvbn.org>
References: <56938FD6.3010600@svario.it>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from chomsky.autogeree.net ([91.216.110.36]:52657 "EHLO
	chomsky.autogeree.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934613AbcATSOK (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 20 Jan 2016 13:14:10 -0500
In-Reply-To: <56938FD6.3010600@svario.it> (Gioele Barabucci's message of "Mon,
	11 Jan 2016 20:12:35 +0100")
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
Cc: dash@vger.kernel.org

Gioele Barabucci <gioele@svario.it> writes:

> Document that `ulimit` can set the `RLIMIT_AS` limit (virtual memory) with
> the `-v` flag.

I don't know much about RLIMIT_AS, but I know that it isn't supported on
all systems where dash runs, eg OpenBSD.  Maybe is it Linux-specific?

Anyway, it would be better if the manpage said that the -v flag may not
be implemented on all platforms.

The same could be said about ulimit -w. (I did not check the other flags).

> Fixes: https://bugs.debian.org/78556
> Reported-by: Vincent Lefevre <vincent@vinc17.net>
> Signed-off-by: Gioele Barabucci <gioele@svario.it>
> ---
>  src/dash.1 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/dash.1 b/src/dash.1
> index 832eae7..8b8026d 100644
> --- a/src/dash.1
> +++ b/src/dash.1
> @@ -2114,7 +2114,7 @@ printed; for commands and tracked aliases the complete pathname of the
>  command is printed.
>  .It ulimit Xo
>  .Op Fl H \*(Ba Fl S
> -.Op Fl a \*(Ba Fl tfdscmlpn Op Ar value
> +.Op Fl a \*(Ba Fl tfdscmlpnv Op Ar value
>  .Xc
>  Inquire about or set the hard or soft limits on processes or set new
>  limits.
> @@ -2164,6 +2164,9 @@ show or set the limit on the number of processes this user can
>  have at one time
>  .It Fl n
>  show or set the limit on the number files a process can have open at once
> +.It Fl v
> +show or set the limit on the total virtual memory that can be
> +in use by a process (in kilobytes)
>  .It Fl r
>  show or set the limit on the real-time scheduling priority of a process
>  .El

-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE
