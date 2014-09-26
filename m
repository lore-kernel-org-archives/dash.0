From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: possible bug in job control
Date: Fri, 26 Sep 2014 17:28:50 +0800
Message-ID: <20140926092850.GC14940@gondor.apana.org.au>
References: <CAKkO-EgtZw6EuoBz1ishWc-V7LNOzFO98O7A8T=Rqq42DA_T1A@mail.gmail.com>
 <51F6F10C.4060109@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:41664 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbaIZJ2y (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 26 Sep 2014 05:28:54 -0400
Content-Disposition: inline
In-Reply-To: <51F6F10C.4060109@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Luigi Tarenga <luigi.tarenga@gmail.com>, dash@vger.kernel.org

On Mon, Jul 29, 2013 at 10:47:40PM +0000, Harald van Dijk wrote:
> On 29/07/13 23:44, Luigi Tarenga wrote:
> > hi list,
> > while writing a script to execute parallel ssh command on many host I found
> > a strange behavior of dash. I can replicate it with a very simple script but
> > didn't find any documentation about dash or POSIX that can explain it.
> > 
> > tested on centos 6.4 (dash 0.5.5.1) and wih dash compiled from source (0.5.7)
> > the following script reports error:
> > 
> > #!/bin/dash
> > 
> > sleep 3 &
> > sleep 3 &
> > sleep 3 &
> > sleep 3 &
> > 
> > #/bin/true
> > jobs -l
> > 
> > wait %1
> > wait %2
> > wait %3
> > wait %4
> > 
> > [vortex@lizard ~]$ ./dash-0.5.7/src/dash test.sh
> > [4] + 4569 Running
> > [3] - 4568 Running
> > [2]   4567 Running
> > [1]   4566 Running
> > prova: 14: wait: No such job: %4
> > [vortex@lizard ~]$ echo $?
> > 2
> 
> Yes, this looks like a bug to me. The number of allocated jobs is always
> kept as a multiple of four, and the first check in considering whether
> the job number is valid is "if it's greater than or equal to the number
> of allocated job, it's invalid". That doesn't look right. That would
> only be right if jobs were zero-based, but they aren't. If it's exactly
> equal to the number of available jobs, it can still be valid. It works
> when adding /bin/true, because four more more jobs end up allocated
> internally.
> 
> The attached patch should fix it.
> 
> Cheers,
> Harald

> commit ddeba5485c3309ffc7010f8924d604a781908e1d
> Author: Harald van Dijk <harald@gigawatt.nl>
> Date:   Tue Jul 30 00:36:53 2013 +0200
> 
>     getjob: Fix off-by-one error for multiple of four job numbers

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
