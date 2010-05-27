From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: IFS regression in 55c46b7
Date: Thu, 27 May 2010 17:34:27 +1000
Message-ID: <20100527073427.GA7095@gondor.apana.org.au>
References: <20100513235017.5480.qmail@9329a0bb15f239.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:35088 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751978Ab0E0Hea (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 27 May 2010 03:34:30 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1OHXbo-0002Dx-5H
	for <dash@vger.kernel.org>; Thu, 27 May 2010 17:34:28 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1OHXbn-0001rT-IM
	for dash@vger.kernel.org; Thu, 27 May 2010 17:34:27 +1000
Content-Disposition: inline
In-Reply-To: <20100513235017.5480.qmail@9329a0bb15f239.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Thu, May 13, 2010 at 11:50:17PM +0000, Gerrit Pape wrote:
> Hi, commit 55c46b7 introduces a regression in IFS handling, see
> http://bugs.debian.org/581351
> 
> To reproduce, run
> $ echo a:b |src/dash -c 'IFS=: read a b; echo $a $b'
> 
> with dash built from 55c46b7^:
> $ echo a:b |src/dash -c 'IFS=: read a b; echo $a $b'
> a b
> 
> with 55c46b7 and HEAD
> $  echo a:b |src/dash -c 'IFS=: read a b; echo $a $b'
> a:b

It appears to be fixed in the latest tree.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
