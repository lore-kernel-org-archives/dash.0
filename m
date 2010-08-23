From: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Subject: Re: trap bug in recent versions of dash
Date: Mon, 23 Aug 2010 12:40:48 +0200
Message-ID: <20100823103617.GA9302@wopr.local.invalid>
References: <20100811080616.GA18303@wopr.local.invalid>
 <20100815200551.GA19150@stack.nl>
 <20100816115154.GB11790@wopr.local.invalid>
 <20100822223227.GA49760@stack.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="U+BazGySraz5kW0T"
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([83.169.16.167]:59377 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab0HWKf5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Aug 2010 06:35:57 -0400
Received: from wopr.local.invalid (p57BD705D.dip.t-dialin.net [87.189.112.93])
	by multivac.heapoverflow.de (Postfix) with ESMTPSA id A19F5A3F812C
	for <dash@vger.kernel.org>; Mon, 23 Aug 2010 12:35:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100822223227.GA49760@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Jilles Tjoelker <jilles@stack.nl> [2010-08-23 00:32]:
> If you want to try something, here is a patch. I have verified that the
> only change to the results of FreeBSD sh's testsuite is that the test
> builtins/break2.0 starts working (there are still 51 other broken
> tests). There is no change in output from the posh testsuite (run with
>   -C sh,posix,no-typeset,no-arrays,no-coprocs,no-herestrings,no-history
> ).
> 
> diff --git a/src/eval.c b/src/eval.c
> index d5e5c95..e484bec 100644
> --- a/src/eval.c
> +++ b/src/eval.c
> @@ -307,9 +307,9 @@ setstatus:
>  		break;
>  	}
>  out:
> -	if ((checkexit & exitstatus) ||
> -	    (pendingsigs && dotrap()) ||
> -	    (flags & EV_EXIT))
> +	if (pendingsigs)
> +		dotrap();
> +	if ((flags & EV_EXIT) || (checkexit & exitstatus))
>  		exraise(EXEXIT);
>  }

Unfortunately this seems to corrupt variables.
See the attached test script, after the TERM signal $value
is not empty anymore but contains garbage.

Where can I find FreeBSD's sh tests?
-- 
Guido Berhoerster

--U+BazGySraz5kW0T
Content-Type: application/x-shellscript
Content-Disposition: attachment; filename="timed-read.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Aread_timeout () {=0A    saved_traps=3D"$(trap)"=0A    trap '=
printf "timed out\n"; eval "${saved_traps}"; return' TERM=0A    { sleep $1;=
 kill -TERM $$; } >/dev/null 2>&1 &=0A    timer_pid=3D$!=0A    read $2=0A  =
  kill $timer_pid 2>/dev/null=0A    eval "${saved_traps}"=0A}=0A=0A# exampl=
e=0Aread_timeout 1 value=0Aprintf "read \"%s\"\n" "${value:=3Ddefault}"=0A
--U+BazGySraz5kW0T--
