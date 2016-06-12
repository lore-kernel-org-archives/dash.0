From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v3] builtin: Fix handling of trailing IFS white spaces
Date: Sun, 12 Jun 2016 19:06:43 +0800
Message-ID: <20160612110643.GA927@gondor.apana.org.au>
References: <5661EEB7.8080908@gigawatt.nl>
 <20160606084805.GA20946@gondor.apana.org.au>
 <5755E07B.6090300@gigawatt.nl>
 <20160607092539.GA30397@gondor.apana.org.au>
 <575D3AE3.1080700@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:41315 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcFLLGs (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 12 Jun 2016 07:06:48 -0400
Content-Disposition: inline
In-Reply-To: <575D3AE3.1080700@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Stephane Chazelas <stephane.chazelas@gmail.com>, Gioele Barabucci <gioele@svario.it>

On Sun, Jun 12, 2016 at 12:35:15PM +0200, Harald van Dijk wrote:
>
> The results are a lot better now, but I did spot a problem:
> 
> src/dash -c 'X="x  "; echo $X'
> 
> This is supposed to print "x\n", but the IFS breakup of $X generates
> two words, one "x", one " ", meaning "x  \n" gets printed instead. I
> think this is intended to get fixed up in the if (ifsspc) block, but
> that block doesn't get executed when there are no more characters
> after the spaces.

Weird, I can't reproduce this at all:

$ src/dash -c 'X="x "; echo $X' | cat -A
x$
$ 

What am I doing wrong?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
