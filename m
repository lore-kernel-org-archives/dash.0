From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: bug with $? after .
Date: Mon, 31 Aug 2009 21:51:16 +1000
Message-ID: <20090831115116.GA7311@gondor.apana.org.au>
References: <loom.20090709T210608-909@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:49960 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752113AbZHaLvP (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Aug 2009 07:51:15 -0400
Content-Disposition: inline
In-Reply-To: <loom.20090709T210608-909@post.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
Cc: dash@vger.kernel.org

On Thu, Jul 09, 2009 at 09:09:11PM +0000, Eric Blake wrote:
> According to POSIX, the status of . shall be 0 if no command was executed during
> the sourced script.  Therefore, this is a bug:
> 
> $ dash -c 'false; . /dev/null; echo $?'
> 1
> 
> and should be fixed to output 0.

It's on my todo list.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
