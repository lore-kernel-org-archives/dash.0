From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: evaluation of env variables in DASH
Date: Wed, 19 Oct 2011 23:58:44 +0200
Message-ID: <20111019215844.GA6049@stack.nl>
References: <87aa8woesd.fsf@minignu.minidns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:53741 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754339Ab1JSWFg (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 19 Oct 2011 18:05:36 -0400
Content-Disposition: inline
In-Reply-To: <87aa8woesd.fsf@minignu.minidns.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dima Sorkin <dima@minignu.minidns.net>
Cc: dash@vger.kernel.org, herbert@gondor.apana.org.au

On Wed, Oct 19, 2011 at 11:24:50PM +0200, Dima Sorkin wrote:
>   The following DASH behaviour seems buggy to me

> -----------------
> $ export A='\n'
> $ echo $A
> 
> $
> -----------------

> whereas using BASH would result in printing literally \n .

> I.e. presumingly DASH does secondary interpolation of escaped
> symols in values of environment variables. 

The echo builtin in dash differs from most other echo utilities on Linux
and *BSD in interpreting System V-like backslash escape sequences. This
is the "expansion" you are seeing and the same thing can be seen in
  echo '\n'
It is documented in dash's manual page.

This also happens in bash if you 'shopt -s xpg_echo'.

This behaviour is permitted by POSIX and required for the XSI option,
and is more commonly seen on Solaris or other System V derivatives.

The fix is to use printf(1) instead of echo(1) if there is a possibility
the string may start with '-' or contain '\'. In this case,
  printf '%s\n' "$A"

This has been asked/reported more frequently and the answer has been
that it will not be changed.

-- 
Jilles Tjoelker
