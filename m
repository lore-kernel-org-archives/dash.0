From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Quoted closing brace in variable default expansion
Date: Fri, 19 Nov 2010 21:54:06 +0800
Message-ID: <20101119135406.GA24391@gondor.apana.org.au>
References: <4CDECAE1.9010607@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:56300 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121Ab0KSNyK (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 19 Nov 2010 08:54:10 -0500
Content-Disposition: inline
In-Reply-To: <4CDECAE1.9010607@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, jrnieder@gmail.com

Harald van Dijk <harald@gigawatt.nl> wrote:
>
> Thanks, that helps to clarify. Unfortunately, the valid alternative 
> given there:
> 
>   sh -c 'echo "${x:-\}}"'
> 
> seemingly incorrectly prints \} with dash and with bash, so that is a 
> non-option at this time for me.

If you need to print anything involving a backspace you should
use printf and not echo.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
