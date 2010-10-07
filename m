From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/3] [EXCEPTIONS] Stop documenting EXSHELLPROC
Date: Thu, 7 Oct 2010 11:29:03 +0800
Message-ID: <20101007032903.GA15283@gondor.apana.org.au>
References: <20100628065326.GA25667@gondor.apana.org.au> <20101006100420.GA361@burratino> <20101006100804.GB361@burratino> <20101006102930.GA6573@gondor.apana.org.au> <20101006105531.GB475@burratino> <4CAC68FD.4040602@redhat.com> <20101007010241.GB1276@burratino> <20101007010347.GC1276@burratino> <20101007030153.GA15132@gondor.apana.org.au> <20101007030414.GA2285@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:52758 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681Ab0JGD3K (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 23:29:10 -0400
Content-Disposition: inline
In-Reply-To: <20101007030414.GA2285@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

On Wed, Oct 06, 2010 at 10:04:14PM -0500, Jonathan Nieder wrote:
> Herbert Xu wrote:
> > On Wed, Oct 06, 2010 at 08:03:47PM -0500, Jonathan Nieder wrote:
> 
> >> --- a/src/error.h
> >> +++ b/src/error.h
> >> @@ -66,9 +66,8 @@ extern int exception;
> >>  /* exceptions */
> >>  #define EXINT 0		/* SIGINT received */
> >>  #define EXERROR 1	/* a generic error */
> >> -#define EXSHELLPROC 2	/* execute a shell procedure */
> >> -#define EXEXEC 3	/* command execution failed */
> >> -#define EXEXIT 4	/* exit the shell */
> >> +#define EXEXEC 2	/* command execution failed */
> >> +#define EXEXIT 3	/* exit the shell */
> >
> > There is no need to renumber things.  Just leave a gap.
> 
> Ok.  Should I fix it up or would you like to?

Yeah please resend the patch with the fix-up.

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
