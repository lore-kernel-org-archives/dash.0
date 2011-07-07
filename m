From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: set -m under setsid doesn't create pgrp's
Date: Thu, 7 Jul 2011 11:32:45 +0800
Message-ID: <20110707033245.GA16157@gondor.apana.org.au>
References: <AANLkTikxM==3q9AtL-SU+kqDjLheBbYde=BWMB6bom4+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:38807 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab1GGDcs (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Jul 2011 23:32:48 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikxM==3q9AtL-SU+kqDjLheBbYde=BWMB6bom4+@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Muresan <danmbox@gmail.com>
Cc: dash@vger.kernel.org

On Tue, Feb 15, 2011 at 10:45:58AM +0000, Dan Muresan wrote:
> dash (0.5.5.1-3ubuntu2) doesn't seem put jobs in their own pgrp when
> setsid'ed, as required by the "set -o monitor" (set -m) option:
> 
> 
> $ cat >test.sh <<EOF
> #!/bin/sh
> set -m
> sh -c 'while :; do sleep 3; done' &
> set +m
> echo "Waiting for $!"; wait; echo Done
> EOF
> 
> $ setsid test.sh
> Waiting for 25828
> $ kill -- -25828
> kill: (-25828) - No such process
> $ ps -Leo pid,ppid,pgrp,cmd  # pgrp of job is pid of test.sh
> 
> This does not happen with bash, or if running the script directly
> without setsid.

This is not a bug.  setsid causes the shell to run with no
controlling terminal, which makes proper job control impossible.

Other shells simply ignore the error while continuing to provide
limited job control.

So if you want job control with setsid, you must ensure that
a controlling tty is attached afterwards.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
