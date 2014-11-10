From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: % in $PATH
Date: Mon, 10 Nov 2014 21:30:48 +0000
Message-ID: <20141110213048.GA3938@chaz.gmail.com>
References: <20141105115946.GA4029@chaz.gmail.com>
 <20141110132002.GA8372@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59300 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbaKJVfR (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 10 Nov 2014 16:35:17 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1XnwcF-0004sE-GF
	for dash@vger.kernel.org; Mon, 10 Nov 2014 22:35:15 +0100
Received: from 5ec33b79.skybroadband.com ([94.195.59.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 10 Nov 2014 22:35:15 +0100
Received: from stephane.chazelas by 5ec33b79.skybroadband.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 10 Nov 2014 22:35:15 +0100
Content-Disposition: inline
In-Reply-To: <20141110132002.GA8372@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2014-11-10 21:20:02 +0800, Herbert Xu:
> On Wed, Nov 05, 2014 at 11:59:47AM +0000, Stephane Chazelas wrote:
> > Hello,
> > 
> > ash/dash have a nice feature that allows to have:
> > 
> > PATH=/bin:%builtin:/usr/bin:/some/dir%func:/sbin
> > 
> > To have commands in /bin take precedence over builtins and
> > files in /some/dir being looked up for autoloaded functions (a
> > bit like FPATH in ksh/zsh).
> > 
> > That's nice but the way it is implemented, that means that %
> > characters in $PATH cause problems. See for instance:
> > 
> > http://unix.stackexchange.com/questions/126955/percent-in-path-environment-variable
> 
> I'm inclined to just kill this feature, or at least make it a
> configuration option that's disabled by default.
[...]

Though I'd agree there's little chance of many people using it as
the documentation about it has been removed in dash, I don't
think there's any harm in leaving it in but implemented the way
I suggest.

It's useful as an equivalent to bash's exported functions (and
is a better/safer approach IMO) as an instrumentation tool.

Example: redefine "echo" as a Unix conformant one before running
something that expects a Unix conformant "echo":

$ printf '%s\n' 'echo() { local IFS=" "; printf "%b\n" "$*"; }' > echo
$ PATH=$PWD%func:%builtins:$PATH dash -c 'echo "-n\c"; echo x'
-nx

I don't see the point in keeping it if it's to make it disabled
by default though (unless we add an equivalent of BASHOPTS which
can be used to turn it on via the environment)

-- 
Stephane

