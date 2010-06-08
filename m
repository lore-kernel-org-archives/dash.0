From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: debian patches to exit with code 127 for nonexistent/directory
	scripts
Date: Tue, 8 Jun 2010 20:19:08 +1000
Message-ID: <20100608101908.GA24113@gondor.apana.org.au>
References: <20100605160651.GA60028@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:47447 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754163Ab0FHKTM (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 8 Jun 2010 06:19:12 -0400
Content-Disposition: inline
In-Reply-To: <20100605160651.GA60028@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
> Debian's dash package has some local changes which cause an exit with
> code 127, as required by POSIX, if a script (passed with dash
> <filename>) cannot be opened or cannot be read because it is a
> directory.

Please report this through Debian's bug tracking system.

There is nothing that I can do about this.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
