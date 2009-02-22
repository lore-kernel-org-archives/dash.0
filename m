From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [SHELL] print \n upon EOF (CTRL-D) when run
	interactively
Date: Sun, 22 Feb 2009 19:54:52 +0800
Message-ID: <20090222115452.GA3239@gondor.apana.org.au>
References: <20090211144300.18734.qmail@5183352cb764c2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:34367 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753821AbZBVLy6 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 22 Feb 2009 06:54:58 -0500
Content-Disposition: inline
In-Reply-To: <20090211144300.18734.qmail@5183352cb764c2.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
Cc: dash@vger.kernel.org

On Wed, Feb 11, 2009 at 02:43:00PM +0000, Gerrit Pape wrote:
> Suggested by jidanni through
>  http://bugs.debian.org/476422
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>

Sorry, I have to nack this.

This doesn't really contribute much at all to the usefulness of
dash and it increases its size.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
