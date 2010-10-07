From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/3] [EXCEPTIONS] Eliminate global exerrno
Date: Thu, 7 Oct 2010 11:00:25 +0800
Message-ID: <20101007030025.GB14649@gondor.apana.org.au>
References: <20100605160651.GA60028@stack.nl> <20100614095451.26362.qmail@43559bb7971308.315fe32.mid.smarden.org> <20100628065326.GA25667@gondor.apana.org.au> <20101006100420.GA361@burratino> <20101006100804.GB361@burratino> <20101006102930.GA6573@gondor.apana.org.au> <20101006105531.GB475@burratino> <4CAC68FD.4040602@redhat.com> <20101007010241.GB1276@burratino> <20101007010807.GE1276@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:48296 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab0JGDAa (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 6 Oct 2010 23:00:30 -0400
Content-Disposition: inline
In-Reply-To: <20101007010807.GE1276@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

On Wed, Oct 06, 2010 at 08:08:07PM -0500, Jonathan Nieder wrote:
> Pass the exit status from the exec builtin through the exitstatus
> global.  This just eliminates a global variable; no noticeable
> change is intended.
> 
> Based on v0.5.3~57 (Eliminated global exerrno, 2005-02-25).
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Heh, had you sent 2/3 and 3/3 as one patch I would've seen the
problem and just applied it :)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
