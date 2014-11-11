From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Bug#501566: dash: details of redirection/duplication in manpage
 are reversed
Date: Tue, 11 Nov 2014 23:08:05 +0800
Message-ID: <20141111150805.GA18820@gondor.apana.org.au>
References: <20141110111951.GA4185@free.fr>
 <20141110132409.GA8416@gondor.apana.org.au>
 <20141110134957.GA5664@free.fr>
 <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:59788 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaKKPIN (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Nov 2014 10:08:13 -0500
Content-Disposition: inline
In-Reply-To: <CAEuPzf47pS0u+uY9-RUjOgGOuuGb6o9htY5Quu-B6dMuOVWA3Q@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stephen Shirley <diamond@nonado.net>
Cc: =?iso-8859-1?Q?St=E9phane?= Aulery <saulery@free.fr>, dash@vger.kernel.org, 501566@bugs.debian.org

On Tue, Nov 11, 2014 at 02:23:21PM +0100, Stephen Shirley wrote:
>
> "[n1]>&n2    Redirect standard output (or n1) to n2."
> 
> It doesn't cover the case where n2 is later changed, and how n1 does
> not follow this, but it's the simplest fix i see.

Yes that sounds much better.  Please send a patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
