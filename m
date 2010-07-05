From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [EVAL] with set -e exit the shell if a subshell exits
	non-zero
Date: Mon, 5 Jul 2010 16:26:37 +0800
Message-ID: <20100705082637.GA4706@gondor.apana.org.au>
References: <4C28A0B6.5010305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:49068 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680Ab0GEI0k (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 5 Jul 2010 04:26:40 -0400
Content-Disposition: inline
In-Reply-To: <4C28A0B6.5010305@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org, cristian.ionescu-idbohrn@axis.com

Eric Blake <eblake@redhat.com> wrote:
> [-- text/plain, encoding quoted-printable, charset: ISO-8859-1, 62 lines --]
> 
> On 06/28/2010 01:22 AM, Cristian Ionescu-Idbohrn wrote:
>>> Has bash's behaviour changed recently (I'm using an ancient
>>> version)?
> 
> Yes - bash 4.1 tries harder to be compliant with the recent Austin Group
> interpretations (and more like ksh).

OK I'll apply the patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
