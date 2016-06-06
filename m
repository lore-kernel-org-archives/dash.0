From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: shell: Fix build on Solaris 9
Date: Mon, 6 Jun 2016 22:25:50 +0800
Message-ID: <20160606142550.GA23441@gondor.apana.org.au>
References: <20151211115623.GA54973@joyent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:34155 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbcFFO0B (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 6 Jun 2016 10:26:01 -0400
Content-Disposition: inline
In-Reply-To: <20151211115623.GA54973@joyent.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Perkin <jperkin@joyent.com>
Cc: dash@vger.kernel.org

On Fri, Dec 11, 2015 at 11:56:43AM +0000, Jonathan Perkin wrote:
> Ensure dash can build in a default Solaris 9 or older environment:
> 
>  - Execute scripts with $SHELL rather than /bin/sh, the latter does not
>    support e.g. "if ! .." used by mkbuiltins.
> 
>  - /bin/awk does not support ?: syntax, use explicit statements instead.
> 
>  - /bin/nl requires no spaces between options and arguments.

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
