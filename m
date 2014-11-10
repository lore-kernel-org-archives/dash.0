From: Guido Berhoerster <gber@opensuse.org>
Subject: Re: % in $PATH
Date: Mon, 10 Nov 2014 22:59:38 +0100
Message-ID: <20141110215938.GA25437@hal.lan>
References: <20141105115946.GA4029@chaz.gmail.com>
 <20141110132002.GA8372@gondor.apana.org.au>
 <20141110213048.GA3938@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([78.47.51.218]:39803 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbaKJWIE (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 10 Nov 2014 17:08:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by multivac.heapoverflow.de (Postfix) with ESMTP id 663792067A
	for <dash@vger.kernel.org>; Mon, 10 Nov 2014 22:59:26 +0100 (CET)
Received: from hal.lan (p5B219B24.dip0.t-ipconnect.de [91.33.155.36])
	by multivac.heapoverflow.de (Postfix) with ESMTPSA id 4F1062039E
	for <dash@vger.kernel.org>; Mon, 10 Nov 2014 22:59:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141110213048.GA3938@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

* Stephane Chazelas <stephane.chazelas@gmail.com> [2014-11-10 22:35]:
> 2014-11-10 21:20:02 +0800, Herbert Xu:
> > On Wed, Nov 05, 2014 at 11:59:47AM +0000, Stephane Chazelas wrote:
> > > Hello,
> > > 
> > > ash/dash have a nice feature that allows to have:
> > > 
> > > PATH=/bin:%builtin:/usr/bin:/some/dir%func:/sbin
> > > 
> > > To have commands in /bin take precedence over builtins and
> > > files in /some/dir being looked up for autoloaded functions (a
> > > bit like FPATH in ksh/zsh).
> > > 
> > > That's nice but the way it is implemented, that means that %
> > > characters in $PATH cause problems. See for instance:
> > > 
> > > http://unix.stackexchange.com/questions/126955/percent-in-path-environment-variable
> > 
> > I'm inclined to just kill this feature, or at least make it a
> > configuration option that's disabled by default.
> [...]
> 
> Though I'd agree there's little chance of many people using it as
> the documentation about it has been removed in dash, I don't
> think there's any harm in leaving it in but implemented the way
> I suggest.
> 
> It's useful as an equivalent to bash's exported functions (and
> is a better/safer approach IMO) as an instrumentation tool.
> 
> Example: redefine "echo" as a Unix conformant one before running
> something that expects a Unix conformant "echo":
> 
> $ printf '%s\n' 'echo() { local IFS=" "; printf "%b\n" "$*"; }' > echo
> $ PATH=$PWD%func:%builtins:$PATH dash -c 'echo "-n\c"; echo x'
> -nx
> 
> I don't see the point in keeping it if it's to make it disabled
> by default though (unless we add an equivalent of BASHOPTS which
> can be used to turn it on via the environment)

A much nicer solution would be to do something similar to the
original Korn shell and assign additional builtins a virtual
path which can be freely assigned in PATH and with which they can
be explicitly called. No more "%" in PATH and the feature can
be retained.
-- 
Guido Berhoerster
