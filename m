From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [INPUT] Catch attempts to run a directory as a script
Date: Wed, 6 Oct 2010 18:29:30 +0800
Message-ID: <20101006102930.GA6573@gondor.apana.org.au>
References: <20100605160651.GA60028@stack.nl> <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org> <20100628065326.GA25667@gondor.apana.org.au> <20101006100420.GA361@burratino> <20101006100804.GB361@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:49506 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab0JFK3f (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 06:29:35 -0400
Content-Disposition: inline
In-Reply-To: <20101006100804.GB361@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

On Wed, Oct 06, 2010 at 05:08:04AM -0500, Jonathan Nieder wrote:
> open() succeeds, though read() fails later, when a pathname
> passed as argv[0] on the command line points to a directory,
> which somehow results in dash thinking everything is okay:
> 
>  $ sh dir/
>  $ echo $?
>  0
> 
> But POSIX makes it clear enough that in "sh command_file",
> command_file is supposed to be a file, not a directory.  So
> diagnose this with an error message and exit with status 2.
> 
> Reported-by: Jari Aalto <jari.aalto@cante.net>
> Fixes: http://bugs.debian.org/548687
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Is this required by POSIX? If not this is simply making dash
bigger for no good reason.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
