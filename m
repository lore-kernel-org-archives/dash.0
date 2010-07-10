From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash klibc DEBUG more compile trouble
Date: Sun, 11 Jul 2010 06:15:18 +0800
Message-ID: <20100710221518.GA9154@gondor.apana.org.au>
References: <20100709144330.GA23188@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:52471 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab0GJWPX (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 10 Jul 2010 18:15:23 -0400
Content-Disposition: inline
In-Reply-To: <20100709144330.GA23188@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: dash@vger.kernel.org, klibc@zytor.com

maximilian attems <max@stro.at> wrote:
> once taken that stat/stat64 appart, histedit appears to be a minefield:

Unless you have libedit, you're supposed to define SMALL.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
