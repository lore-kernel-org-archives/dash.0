From: Jonathan Perkin <jperkin@joyent.com>
Subject: Re: [SHELL] Fix 64-bit Solaris build
Date: Mon, 6 Jun 2016 16:22:59 +0100
Message-ID: <20160606152259.GE5022@joyent.com>
References: <20151211130714.GD54973@joyent.com>
 <20160606142710.GA23472@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:32986 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbcFFPXE (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Jun 2016 11:23:04 -0400
Received: by mail-wm0-f54.google.com with SMTP id r5so3414224wmr.0
        for <dash@vger.kernel.org>; Mon, 06 Jun 2016 08:23:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160606142710.GA23472@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

* On 2016-06-06 at 15:27 BST, Herbert Xu wrote:

> On Fri, Dec 11, 2015 at 01:07:14PM +0000, Jonathan Perkin wrote:
> > In a 64-bit Solaris environment there is no stat64() function, only
> > stat().  This conflicts with the stat64 #define used to support
> > dietlibc/klibc when stat64() is not found and results in:
> > 
> >   ./../config.h:194:16: error: redefinition of 'struct stat'
> >    #define stat64 stat
> >                 ^
> >   In file included from cd.c:36:0:
> >   /usr/include/sys/stat.h:217:8: note: originally defined here
> >    struct stat {
> >           ^
> > 
> > Instead, add a AC_CHECK_DECL test for stat64, and only perform the
> > AC_CHECK_FUNC test if it isn't already defined.
> 
> I don't understand, does stat64 exist or not? If it doesn't then
> how can AC_CHECK_DECL help? Or do you mean that it only exists as
> a macro?

Right, it only exists as a macro, defined as

  #define stat64 stat
  
in sys/stat.h.  The AC_CHECK_FUNC test fails as it doesn't pull in any
includes, and cannot find a stat64() function in libc.

Adding the AC_CHECK_DECL test finds the definition and avoids running
the AC_CHECK_FUNC tests if that is the case.

-- 
Jonathan Perkin  -  Joyent, Inc.  -  www.joyent.com
