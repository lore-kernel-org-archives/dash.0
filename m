From: maximilian attems <max@stro.at>
Subject: Re: dash klibc DEBUG compile trouble
Date: Thu, 8 Jul 2010 18:20:17 +0200
Message-ID: <20100708162017.GF9869@baikonur.stro.at>
References: <20100708084834.GB6829@stro.at> <20100708130401.GA20383@gondor.apana.org.au> <20100708131753.GE9869@baikonur.stro.at> <20100708135114.GA20673@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:52561 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0GHQ3V (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 8 Jul 2010 12:29:21 -0400
Content-Disposition: inline
In-Reply-To: <20100708135114.GA20673@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, klibc@zytor.com

On Thu, Jul 08, 2010 at 09:51:14PM +0800, Herbert Xu wrote:
> On Thu, Jul 08, 2010 at 03:17:53PM +0200, maximilian attems wrote:
> > 
> > It says that the 64 bit operations are the same as the 32 bit ones,
> > that's why I'm confused.
> 
> Ah, klibc must be undefining stat64, which then causes struct
> stat64 to be undeclared.
> 
> I'll look into it.

ihmm well seems to be a klibc bug and not a dash trouble:
~/src/klibc-latest$ egrep stat64 -r usr/klibc/
usr/klibc/SYSCALLS.def:<!ppc64> int stat64,stat::stat(const char *, struct stat *);
usr/klibc/SYSCALLS.def:<!ppc64> int lstat64,lstat::lstat(const char *, struct stat *);
usr/klibc/SYSCALLS.def:<!ppc64> int fstat64,fstat::fstat(int, struct stat *);


but no mention in the headers. 
