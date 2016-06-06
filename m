From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [SHELL] Fix 64-bit Solaris build
Date: Mon, 6 Jun 2016 22:27:10 +0800
Message-ID: <20160606142710.GA23472@gondor.apana.org.au>
References: <20151211130714.GD54973@joyent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:50738 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbcFFO1N (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Jun 2016 10:27:13 -0400
Content-Disposition: inline
In-Reply-To: <20151211130714.GD54973@joyent.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Perkin <jperkin@joyent.com>
Cc: dash@vger.kernel.org

On Fri, Dec 11, 2015 at 01:07:14PM +0000, Jonathan Perkin wrote:
> In a 64-bit Solaris environment there is no stat64() function, only
> stat().  This conflicts with the stat64 #define used to support
> dietlibc/klibc when stat64() is not found and results in:
> 
>   ./../config.h:194:16: error: redefinition of 'struct stat'
>    #define stat64 stat
>                 ^
>   In file included from cd.c:36:0:
>   /usr/include/sys/stat.h:217:8: note: originally defined here
>    struct stat {
>           ^
> 
> Instead, add a AC_CHECK_DECL test for stat64, and only perform the
> AC_CHECK_FUNC test if it isn't already defined.

I don't understand, does stat64 exist or not? If it doesn't then
how can AC_CHECK_DECL help? Or do you mean that it only exists as
a macro?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
