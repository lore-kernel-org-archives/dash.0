Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9956FC3DA7D
	for <linux-dash@archiver.kernel.org>; Thu,  5 Jan 2023 09:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjAEJRx (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 5 Jan 2023 04:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjAEJRr (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 5 Jan 2023 04:17:47 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C12B50F4E
        for <dash@vger.kernel.org>; Thu,  5 Jan 2023 01:17:46 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDMNX-00E92U-LT; Thu, 05 Jan 2023 17:17:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Jan 2023 17:17:39 +0800
Date:   Thu, 5 Jan 2023 17:17:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     jilles@stack.nl, dash@vger.kernel.org
Subject: Re: [PATCH v2] redir: savefd: use F_DUPFD_CLOEXEC instead of
 F_DUPFD+F_SETFD, if available
Message-ID: <Y7aVs5pglzAvbnfn@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221218025934.hgg6zzq4pwvja7t4@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> [-- text/plain, encoding quoted-printable, charset: us-ascii, 64 lines --]
> 
> This saves a syscall on every source file open, &c.;
> F_DUPFD_CLOEXEC is a mandatory part of POSIX since Issue 7
> (Austin Group Interpretation 1003.1-2001 #171).
> ---
> autoconf bits adapted almost-verbatim from the st_mtim check above
> 
> configure.ac | 13 +++++++++++++
> src/redir.c  |  7 +++++++
> 2 files changed, 20 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 52aa429..b870a59 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -177,6 +177,19 @@ if test "$have_st_mtim" = "yes"; then
>                [Define if your `struct stat' has `st_mtim'])
> fi
> 
> +dnl F_DUPFD_CLOEXEC is a mandatory part of POSIX since Issue 7
> +AC_MSG_CHECKING(for F_DUPFD_CLOEXEC)
> +AC_COMPILE_IFELSE(
> +[AC_LANG_PROGRAM([#include <unistd.h>
> +#include <fcntl.h>],
> +[return fcntl(0, F_DUPFD_CLOEXEC, 0)])],
> +have_dupfd_cloexec=yes, have_dupfd_cloexec=no)
> +AC_MSG_RESULT($have_dupfd_cloexec)
> +if test "$have_dupfd_cloexec" = "yes"; then
> +       AC_DEFINE([HAVE_F_DUPFD_CLOEXEC], [1],
> +               [Define if your system supports F_DUPFD_CLOEXEC])
> +fi

Could you please define this symbol always? That is,

...
have_dupfd_cloexec=1, have_dupfd_cloexec=0)
AC_DEFINE([HAVE_F_DUPFD_CLOEXEC], [${have_dupfd_cloexec}],
	  [Set to 1 if your system supports F_DUPFD_CLOEXEC])

>        err = newfd < 0 ? errno : 0;
>        if (err != EBADF) {
>                close(ofd);
>                if (err)
>                        sh_error("%d: %s", from, strerror(err));
> +#if !HAVE_F_DUPFD_CLOEXEC
>                else
>                        fcntl(newfd, F_SETFD, FD_CLOEXEC);
> +#endif

Then we could change this to

		else if (!HAVE_F_DUPFD_CLOEXEC)
			fcntl(newfd, F_SETFD, FD_CLOEXEC);

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
