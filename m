From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: shell: Always use explicit large file API
Date: Sat, 9 May 2020 15:13:08 +0200
Message-ID: <20200509131308.GA4393@stack.nl>
References: <20200507134212.GA17032@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ws0.zlo.nu ([190.2.135.243]:60228 "EHLO ecc05.stack.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbgEINWp (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 9 May 2020 09:22:45 -0400
Content-Disposition: inline
In-Reply-To: <20200507134212.GA17032@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, 759230@bugs.debian.org

On Thu, May 07, 2020 at 11:42:12PM +1000, Herbert Xu wrote:
> There are some remaining stat/readdir calls in dash that may lead
> to spurious EOVERFLOW errors on 32-bit platforms.  This patch changes
> them (as well as open(2)) to use the explicit large file API.

> Reported-by: Tatsuki Sugiura <sugi@nemui.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

> diff --git a/configure.ac b/configure.ac
> index 5dab5aa..dbd97d8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -144,8 +144,13 @@ AC_CHECK_FUNC(stat64,, [
>  	AC_DEFINE(fstat64, fstat, [64-bit operations are the same as 32-bit])
>  	AC_DEFINE(lstat64, lstat, [64-bit operations are the same as 32-bit])
>  	AC_DEFINE(stat64, stat, [64-bit operations are the same as 32-bit])
> +	AC_DEFINE(readdir64, readdir,
> +		  [64-bit operations are the same as 32-bit])
> +	AC_DEFINE(dirent64, dirent,
> +		  [64-bit operations are the same as 32-bit])
>  ])
> [snip]

Is it possible to use AC_SYS_LARGEFILE and the normal
fstat/lstat/readdir/dirent/open/etc instead of the non-standard "64"
interfaces?

I understand that dash formerly used the "64" interfaces selectively, so
that the binary could be a bit smaller by avoiding 64-bit numbers where
they were not necessary. Now that the feature "supports files with inode
numbers that do not fit in 32 bits" is considered essential, this
complexity seems unnecessary.

I'm sorry for not providing a patch.

-- 
Jilles Tjoelker
