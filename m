From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 5/4] [EVAL] Remove unused EV_BACKCMD flag
Date: Thu, 7 Jul 2011 11:56:02 +0800
Message-ID: <20110707035602.GD16157@gondor.apana.org.au>
References: <20110410071734.GA16736@elie> <20110410073837.GE17649@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:57652 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab1GGD4F (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Jul 2011 23:56:05 -0400
Content-Disposition: inline
In-Reply-To: <20110410073837.GE17649@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

On Sun, Apr 10, 2011 at 07:38:37AM +0000, Jonathan Nieder wrote:
> The original ash defered forking commands in backquotes so builtins
> could be run in the same context as the shell.  This behavior was
> controlled using the EV_BACKCMD to evaltree.
> 
> Unfortunately, as Matthias Scheler noticed in 1999 (NetBSD PR/7814),
> the result was counterintuitive; for example, echo "`cd /`" would
> change the cwd.  So ash 0.3.5 left out that optimization.  The
> EV_BACKCMD codepath stayed around, unused.
> 
> Some time between ash 0.3.5-11 and ash 0.3.8-37, Debian ash omitted
> the EV_BACKCMD pathway by guarding it with #ifdef notyet.  In dash
> 0.5.1 and later, the commented code is no more.  Let's finish the job
> and remove the last vestiges.  If someone wants to work on omitting
> the fork in backcmd, the remaining hints are not going to be very
> helpful, anyway.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Patch applied.  Thanks a lot!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
