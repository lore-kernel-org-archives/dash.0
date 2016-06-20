From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v4] builtin: Fix handling of trailing IFS white spaces
Date: Mon, 20 Jun 2016 09:28:04 +0800
Message-ID: <20160620012804.GA7606@gondor.apana.org.au>
References: <5661EEB7.8080908@gigawatt.nl>
 <20160606084805.GA20946@gondor.apana.org.au>
 <5755E07B.6090300@gigawatt.nl>
 <20160607092539.GA30397@gondor.apana.org.au>
 <575D3AE3.1080700@gigawatt.nl>
 <20160612110643.GA927@gondor.apana.org.au>
 <575D4381.2080903@gigawatt.nl>
 <20160612121748.GA1270@gondor.apana.org.au>
 <5767162C.5020709@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:60404 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbcFTB2X (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 19 Jun 2016 21:28:23 -0400
Content-Disposition: inline
In-Reply-To: <5767162C.5020709@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Stephane Chazelas <stephane.chazelas@gmail.com>, Gioele Barabucci <gioele@svario.it>

On Mon, Jun 20, 2016 at 12:01:16AM +0200, Harald van Dijk wrote:
> 
> FWIW, I've been testing this along with your eval patch, haven't
> spotted any more issues, either from code inspection or from actual
> use, and don't expect to spot any more issues. Very nice.

Thanks for testing! I'll add a

Tested-by: Harald van Dijk <harald@gigawatt.nl>

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
