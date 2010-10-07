From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 2/3] Revert "Eliminated global exerrno."
Date: Thu, 7 Oct 2010 12:14:06 +0800
Message-ID: <20101007041406.GA15529@gondor.apana.org.au>
References: <20100628065326.GA25667@gondor.apana.org.au> <20101006100420.GA361@burratino> <20101006100804.GB361@burratino> <20101006102930.GA6573@gondor.apana.org.au> <20101006105531.GB475@burratino> <4CAC68FD.4040602@redhat.com> <20101007010241.GB1276@burratino> <20101007010458.GD1276@burratino> <20101007025649.GA14649@gondor.apana.org.au> <20101007033518.GB2285@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:47250 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab0JGEOO (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Oct 2010 00:14:14 -0400
Content-Disposition: inline
In-Reply-To: <20101007033518.GB2285@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

On Wed, Oct 06, 2010 at 10:35:18PM -0500, Jonathan Nieder wrote:
> Herbert Xu wrote:
> 
> > Actually the bug is elsewhere.
> 
> It does bisect to there. :)  But you're right, it would have been
> simpler to send one patch.
> 
> > --- a/src/eval.c
> > +++ b/src/eval.c
> > @@ -854,7 +854,7 @@ bail:
> >  			int i;
> >  
> >  			i = exception;
> > -			if (i == EXEXIT)
> > +			if (i == EXEXIT || i == EXEXEC)
> >  				goto raise;
> 
> Good call.  This is better than my patch because it exits like it
> ought to for
> 
> 	command exec nonexistent
> 
> (as POSIX says:
> 
> 	If command is specified, exec shall not return to the shell
> 
> ).
> 
> Maybe the following would make sense on top?

Nice! I like where you are going with this :)

Let me run it through the tests and apply it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
