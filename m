From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [INPUT] exit 127 if command_file is given but doesn't
	exist
Date: Mon, 28 Jun 2010 16:53:26 +1000
Message-ID: <20100628065326.GA25667@gondor.apana.org.au>
References: <20100605160651.GA60028@stack.nl> <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:55320 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab0F1H0Q (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 28 Jun 2010 03:26:16 -0400
Content-Disposition: inline
In-Reply-To: <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
Cc: dash@vger.kernel.org

On Mon, Jun 14, 2010 at 09:54:51AM +0000, Gerrit Pape wrote:
>
> @@ -405,11 +406,13 @@ setinputfile(const char *fname, int flags)
>  	int fd;
>  
>  	INTOFF;
> -	if ((fd = open(fname, O_RDONLY)) < 0) {
> +	if ((fd = open(fname, O_RDWR)) < 0) {

Why should the file be writeable?

Please do not mix multiple changes in one patch.

>  		if (flags & INPUT_NOFILE_OK)
>  			goto out;
> -		sh_error("Can't open %s", fname);
> +		exitstatus = 127;
> +		exerror(EXIFILE, "Can't open %s", fname);
>  	}
> +	fcntl(fd, F_SETFL, O_RDONLY);

This is wrong.  You're creating exactly the problem that Jilles
was talking about where dot(1) is returning 127.  This code should
be moved to procargs, which runs only for the "sh script" case.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
