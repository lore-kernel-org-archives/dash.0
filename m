From: "Dan McGee" <dan@archlinux.org>
Subject: Re: dash regression against klibc
Date: Sat, 3 May 2008 01:16:56 -0500
Message-ID: <449c10960805022316tf68b749rb7c4d2aeb6526853@mail.gmail.com>
References: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com>
	 <20080502052530.GA15890@gondor.apana.org.au>
	 <20080502062303.GA16356@gondor.apana.org.au>
	 <449c10960805021808k6f4bb039nc37ba5177a9584d5@mail.gmail.com>
	 <20080503022101.GA23067@gondor.apana.org.au>
	 <481C00DF.4060706@zytor.com>
	 <20080503061351.GA24061@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:36162 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbYECGQ4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 3 May 2008 02:16:56 -0400
Received: by rv-out-0506.google.com with SMTP id l9so346763rvb.1
        for <dash@vger.kernel.org>; Fri, 02 May 2008 23:16:56 -0700 (PDT)
In-Reply-To: <20080503061351.GA24061@gondor.apana.org.au>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>, dash@vger.kernel.org

On Sat, May 3, 2008 at 1:13 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Fri, May 02, 2008 at 11:06:23PM -0700, H. Peter Anvin wrote:
>  >
>  > _GNU_SOURCE is defined by the application, not by the library.
>
>  Yes, however the macro AC_GNU_SOURCE is supposed to define it
>  only for glibc.  Having seen the actual code though it seems
>  that the automake documentation is misleading and the macro is
>  always defined regardless of the library being used.
>
>  I'll change it to use __GLIBC__ instead.

That change makes it work fine here. Thanks for looking into all of this.

I forgot to hit reply to all on the last email I sent to just Herbert,
so I've included that below as well.

-Dan


>  Could you find out exactly what getcwd returned under klibc?
>  Or perhaps somehow _GNU_SOURCE is still being defined under
>  klibc?

OK, here we go:
#include <sys/types.h>
#include <limits.h>
#include <unistd.h>
#include <stdio.h>

main(int argc, char **argv)
{
       char buf[PATH_MAX];
       char *ptr;

       ptr = getcwd(buf, PATH_MAX);

       printf("%s", ptr);
}

$ klcc test.c

$ ./a.out
/home/dmcgee/projects/dash

$ env - ./a.out
/home/dmcgee/projects/dash

And yes, as hpa said while I was finishing up this email, _GNU_SOURCE
is still enabled during the compile even with klibc. I can see that it
is defined in config.h even when running with this configure line:
$ ./configure CC=klcc LD=klcc CFLAGS="-D__CTYPE_NO_INLINE"
