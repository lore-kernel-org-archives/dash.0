From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH 1/3] Port to Solaris
Date: Fri, 21 Jan 2011 14:06:02 +0100
Message-ID: <20110121130602.GA70470@stack.nl>
References: <1295413636.4278.28.camel@gemini>
 <1295414140.6486.3.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:50121 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752519Ab1AUNGE (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 21 Jan 2011 08:06:04 -0500
Content-Disposition: inline
In-Reply-To: <1295414140.6486.3.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Brian Koropoff <bkoropoff@gmail.com>
Cc: dash@vger.kernel.org

On Tue, Jan 18, 2011 at 09:15:40PM -0800, Brian Koropoff wrote:
> - Older Solaris does not support %jd (intmax_t) in format
>   strings, but it does support %lld (long long), which is
>   the same size on all architectures it supports.  Do
>   a configure check for the sizes of both and prefer %lld
>   when it is safe to do so.

Pedantically, that's a regression for systems that do support %jd, and I
expect compilers to warn about it. If %jd is available, it must be used
for intmax_t, and not %lld, because that is for long long, not intmax_t.

What you can do is use PRIdMAX from <inttypes.h>, normally defined as
"jd". You can then define this to "lld" or "jd" if it is not defined.
I think this makes the code uglier (just like your change), but oh well.

> - Older Solaris lacks stdint.h, but inttypes.h provides the
>   same types and works on all platforms I've tried dash on,
>   so just use it instead.

<inttypes.h> is defined to be a superset of <stdint.h>, so that is ok.
It is also needed for the PRIdMAX suggestion above.

> [...]
> diff --git a/src/arith_yacc.c b/src/arith_yacc.c
> index 6c5a720..bf21830 100644
> --- a/src/arith_yacc.c
> +++ b/src/arith_yacc.c
> @@ -33,7 +33,6 @@
>   */
>  
>  #include <inttypes.h>
> -#include <stdint.h>
>  #include <stdlib.h>
>  #include "arith_yacc.h"
>  #include "expand.h"

This is useful regardless as the <stdint.h> is redundant. The
<inttypes.h> is already needed here because of imaxdiv().

By the way, I wonder what the advantage of imaxdiv() above separate %
and / is. Compilers can detect the matching between a % b and a / b and
do it in one operation, and any use of imaxdiv() trips gcc's
-Waggregate-return.

-- 
Jilles Tjoelker
