From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 4/4] [MAIN] Optimize dash -c "command" to avoid a fork
Date: Thu, 7 Jul 2011 11:48:33 +0800
Message-ID: <20110707034833.GC16157@gondor.apana.org.au>
References: <20110410071734.GA16736@elie> <20110410073649.GD17649@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:59584 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab1GGDsk (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Jul 2011 23:48:40 -0400
Content-Disposition: inline
In-Reply-To: <20110410073649.GD17649@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

On Sun, Apr 10, 2011 at 07:36:49AM +0000, Jonathan Nieder wrote:
> From: Jilles Tjoelker <jilles@stack.nl>
> Date: Sat, 13 Jun 2009 16:17:45 -0500
> 
> This change only affects strings passed to -c, when the -s option is
> not used.
> 
> Use the EV_EXIT flag to inform the eval machinery that the string
> being passed is the entirety of input.  This way, a fork may be
> omitted in many special cases.
> 
> If there are empty lines after the last command, the evalcmd will not
> see the end early enough and forks will not be omitted. The same thing
> seems to happen in bash.
> 
> Example:
>   sh -c 'ps lT'
> No longer shows a shell process waiting for ps to finish.
> 
> [jn: ported from FreeBSD SVN r194128.  Bugs are mine.]
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

OK I will take this patch since its impact is much smaller than
one that hacks around the input path, and seems to achieve most of
what you want anyway.

I will roll it and the EV_EXIT exporting patch into one.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
