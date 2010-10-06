From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [INPUT] Catch attempts to run a directory as a script
Date: Wed, 6 Oct 2010 20:31:47 +0800
Message-ID: <20101006123147.GA7608@gondor.apana.org.au>
References: <20100605160651.GA60028@stack.nl> <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org> <20100628065326.GA25667@gondor.apana.org.au> <20101006100420.GA361@burratino> <20101006100804.GB361@burratino> <20101006102930.GA6573@gondor.apana.org.au> <20101006105531.GB475@burratino> <4CAC68FD.4040602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:57841 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667Ab0JFMb4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 08:31:56 -0400
Content-Disposition: inline
In-Reply-To: <4CAC68FD.4040602@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

On Wed, Oct 06, 2010 at 06:18:05AM -0600, Eric Blake wrote:
>
> Right now, dash gets this wrong:
>
> dash -c 'exec .'; echo $?
> exec: 1: /: Permission denied
> 2
>
> And since you already have the code in dash to detect failure to 'exec'  
> a directory, you should be able to reuse that code when detecting  
> failure to run a directory as a script, as in 'dash .'.

Thanks for the detailed investiagtion!

If someone could send me a patch that does this without bloating
dash too much then I can apply it without feeling too much guilt :)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
