From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: parameter expansion and double quotes
Date: Sat, 16 Jan 2010 23:16:26 +1100
Message-ID: <20100116121626.GA24920@gondor.apana.org.au>
References: <20100115202052.GE14452@slt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:57956 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752380Ab0APMQd (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 16 Jan 2010 07:16:33 -0500
Content-Disposition: inline
In-Reply-To: <20100115202052.GE14452@slt>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: SamLT <samuel.lethiec@intelunix.fr>
Cc: dash@vger.kernel.org

SamLT <samuel.lethiec@intelunix.fr> wrote:
> 
> 
> Hello,
> 
> I'm using dash 0.5.5.1, and noticed a strange behaviour:
> 
> | $ t=123
> | $ echo ${t%${t#?}}
> | 1
> | $ echo "${t%${t#?}}"
> | 
> | $
> 
> Is it a bug or something?

Yes, this looks like a bug.  I'll look into it.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
