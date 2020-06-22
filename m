From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Don't include config.h when building helpers using the
 native compiler
Date: Mon, 22 Jun 2020 17:42:23 +1000
Message-ID: <20200622074223.GA1827@gondor.apana.org.au>
References: <20200622052513.1850288-1-fontaine.fabrice@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:43178 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731381AbgFVHm1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 22 Jun 2020 03:42:27 -0400
Content-Disposition: inline
In-Reply-To: <20200622052513.1850288-1-fontaine.fabrice@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
Cc: dash@vger.kernel.org, fontaine.fabrice@gmail.com, jacmet@sunsite.dk

Fabrice Fontaine <fontaine.fabrice@gmail.com> wrote:
> config.h contains settings for the cross compiler (most importantly
> 32/64bit versions of functions), so don't include it when calling the
> native compiler to build the helpers.
> 
> Otherwise we get build errors like:
> 
> /usr/bin/gcc -include ../config.h -DBSD=1 -DSHELL -DIFS_BROKEN  -g -O2 -Wall    -o mkinit mkinit.c
> In file included from /usr/include/sys/stat.h:107,
>                 from /usr/include/fcntl.h:38,
>                 from mkinit.c:50:
> /usr/include/bits/stat.h:117: error: redefinition of ‘struct stat’
> In file included from /usr/include/fcntl.h:38,
>                 from mkinit.c:50:
> /usr/include/sys/stat.h:504: error: redefinition of ‘stat’
> /usr/include/sys/stat.h:455: note: previous definition of ‘stat’ was here
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> [Retrieved from:
> https://git.buildroot.net/buildroot/tree/package/dash/0001-no-config.h-for-helpers.patch]
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
> src/Makefile.am | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 1732465..3b1b54e 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -7,7 +7,6 @@ COMMON_CPPFLAGS = \
> AM_CFLAGS = $(COMMON_CFLAGS)
> AM_CPPFLAGS = -include $(top_builddir)/config.h $(COMMON_CPPFLAGS)
> AM_CFLAGS_FOR_BUILD = -g -O2 $(COMMON_CFLAGS) 
> -AM_CPPFLAGS_FOR_BUILD = $(COMMON_CPPFLAGS)

Hmm, why is config.h ending up in COMMON_CPPFLAGS at all?

I don't see in my build:

$ make V=1 -C build
...
gcc -I. -I../../src -I.. -DBSD=1 -DSHELL  -g -O2 -Wall    -o mkinit ../../src/mkinit.c
./mkinit ../../src/alias.c ../../src/arith_yacc.c ../../src/arith_yylex.c ../../src/cd.c ../../src/error.c ../../src/eval.c ../../src/exec.c ../../src/expand.c ../../src/histedit.c ../../src/input.c ../../src/jobs.c ../../src/mail.c ../../src/main.c ../../src/memalloc.c ../../src/miscbltin.c ../../src/mystring.c ../../src/options.c ../../src/parser.c ../../src/redir.c ../../src/show.c ../../src/trap.c ../../src/output.c ../../src/bltin/printf.c ../../src/system.c ../../src/bltin/test.c ../../src/bltin/times.c ../../src/var.c

I'm not cross-compiling though.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
