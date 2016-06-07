From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [SHELL] Fix 64-bit Solaris build
Date: Tue, 7 Jun 2016 14:50:59 +0800
Message-ID: <20160607065059.GA29507@gondor.apana.org.au>
References: <20151211130714.GD54973@joyent.com>
 <20160606142710.GA23472@gondor.apana.org.au>
 <20160606152259.GE5022@joyent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:55082 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbcFGGvG (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 7 Jun 2016 02:51:06 -0400
Content-Disposition: inline
In-Reply-To: <20160606152259.GE5022@joyent.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Perkin <jperkin@joyent.com>
Cc: dash@vger.kernel.org

On Mon, Jun 06, 2016 at 04:22:59PM +0100, Jonathan Perkin wrote:
>
> Right, it only exists as a macro, defined as
> 
>   #define stat64 stat
>   
> in sys/stat.h.  The AC_CHECK_FUNC test fails as it doesn't pull in any
> includes, and cannot find a stat64() function in libc.
> 
> Adding the AC_CHECK_DECL test finds the definition and avoids running
> the AC_CHECK_FUNC tests if that is the case.

OK, how about just changing the AC_CHECK_FUNC to AC_CHECK_DECL?

Please resubmit the patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
