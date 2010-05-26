From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Assignment with command: export only, or sets variable, too?
Date: Wed, 26 May 2010 20:59:48 +1000
Message-ID: <20100526105948.GA26352@gondor.apana.org.au>
References: <201004052231.28372.j6t@kdbg.org> <201004052257.58768.j6t@kdbg.org> <20100407094356.GA16716@squonk.masqnet> <201004072033.59546.j6t@kdbg.org> <20100408081737.GA8018@squonk.masqnet> <chaz20100408104928.GA3959@yahoo.fr> <20100408111617.GB11737@squonk.masqnet> <20100409033953.GA32629@gondor.apana.org.au> <20100409082602.GA12973@squonk.masqnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:34504 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750727Ab0EZK7x (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 26 May 2010 06:59:53 -0400
Content-Disposition: inline
In-Reply-To: <20100409082602.GA12973@squonk.masqnet>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Geoff Clare <gwc@opengroup.org>
Cc: dash@vger.kernel.org, pape@smarden.org

On Fri, Apr 09, 2010 at 09:26:02AM +0100, Geoff Clare wrote:
> Herbert Xu <herbert@gondor.hengli.com.au> wrote, on 09 Apr 2010:
> >
> > While we're on this topic, what is the correct output for
> > 
> > 	X=a Y=${X=b} Z=$X sh -c 'echo $Z'
> 
> My reading of the standard is that this should output "b"
> (assuming X is unset beforehand).  But, as I mentioned earlier in
> the thread, this is a strict reading and might not be what was
> intended.

Thank you for your clarifications.

These four patches should help bring dash in-line with the POSIX
requirements.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
