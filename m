From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Parameter expansion fails when assigning a local variable
Date: Tue, 30 Jun 2009 09:38:07 +0800
Message-ID: <20090630013807.GA13339@gondor.apana.org.au>
References: <A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8@xmail3.se.axis.com> <20090622085729.GA22431@gondor.apana.org.au> <0906282220250.1491@somehost> <20090629004750.GA2019@gondor.apana.org.au> <0906291823520.16266@somehost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:49932 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751486AbZF3BiH (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 29 Jun 2009 21:38:07 -0400
Content-Disposition: inline
In-Reply-To: <0906291823520.16266@somehost>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Cc: Jesper Bengtsson <jesper.bengtsson@axis.com>, dash@vger.kernel.org

On Mon, Jun 29, 2009 at 07:10:29PM +0200, Cristian Ionescu-Idbohrn wrote:
>
> Please consider this example script:
> 
> ---8<---
> #!/bin/dash
> 
> set -e
> #set -x
> 
> func() {
> 	local i=0 v xx="$@"
> 
> 	for v; do
> 		i=$(($i + 1))
> 		echo "func arg. $i: '$v'"
> 	done
> 	echo "inside func: NOONE_SHOULD_TOUCH_THIS=$NOONE_SHOULD_TOUCH_THIS"
> }
> 
> NOONE_SHOULD_TOUCH_THIS=protected
> echo "main, bef. func: NOONE_SHOULD_TOUCH_THIS=$NOONE_SHOULD_TOUCH_THIS"
> func "$@"
> echo "main, aft. func: NOONE_SHOULD_TOUCH_THIS=$NOONE_SHOULD_TOUCH_THIS"
> 
> exit 0
> ---8<---
> 
> and run the script like this:
> 
> 	$ <script path> abc NOONE_SHOULD_TOUCH_THIS=overwritten
> 
> Is it the intended behaviour?  Should one be able to overwrite script
> function variables from command line?

As I said, you should be using "$*" instead of "$@" which is
designed exactly for this purpose and is completely portable.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
