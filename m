From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [MAN] Remove spurious space in descriptions of PS1,
	PS2, PS4
Date: Thu, 7 Jul 2011 15:03:06 +0800
Message-ID: <20110707070306.GF16157@gondor.apana.org.au>
References: <87fwozqy21.fsf@Pulska.kon.iki.fi> <20110430220553.GB20433@elie> <87liyqpudv.fsf@Pulska.kon.iki.fi> <20110502080648.GA16077@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:52227 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab1GGHDN (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 03:03:13 -0400
Content-Disposition: inline
In-Reply-To: <20110502080648.GA16077@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, Kalle Olavi Niemitalo <kon@iki.fi>

On Mon, May 02, 2011 at 08:07:01AM +0000, Jonathan Nieder wrote:
> From: Kalle Olavi Niemitalo <kon@iki.fi>
> 
> LANG=C man dash shows:
> 
>      PS1        The primary prompt string, which defaults to ``$  '', unless
>                 you are the superuser, in which case it defaults to ``#  ''.
> 
>      PS2        The secondary prompt string, which defaults to ``>  ''.
> 
>      PS4        Output before each line when execution trace (set -x) is
>                 enabled, defaults to ``+  ''.
> 
> Each of the documented default values has a graphic character and
> two spaces between the quotation marks.  However, the actual
> default values have only one space, rather than two.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
