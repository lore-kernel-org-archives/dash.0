From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 4/4] [MAIN] Optimize dash -c "command" to avoid a fork
Date: Thu, 7 Jul 2011 12:57:19 +0800
Message-ID: <20110707045719.GA16810@gondor.apana.org.au>
References: <20110410071734.GA16736@elie> <20110410073649.GD17649@elie> <20110707034833.GC16157@gondor.apana.org.au> <20110707042753.GA7684@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:37362 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab1GGE5X (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 00:57:23 -0400
Content-Disposition: inline
In-Reply-To: <20110707042753.GA7684@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

On Wed, Jul 06, 2011 at 11:27:53PM -0500, Jonathan Nieder wrote:
>
> Will that work?  Without the preadateof check, I would worry that
> passing EV_EXIT to evalstring would break:
> 
> 	$ dash -c 'echo one
> 		echo two'
> 	one

You're right.  I'll back this out for now.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
