From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 2/3] Revert "Eliminated global exerrno."
Date: Sun, 28 Nov 2010 20:45:06 +0800
Message-ID: <20101128124506.GA11109@gondor.apana.org.au>
References: <20100628065326.GA25667@gondor.apana.org.au> <20101006100420.GA361@burratino> <20101006100804.GB361@burratino> <20101006102930.GA6573@gondor.apana.org.au> <20101006105531.GB475@burratino> <4CAC68FD.4040602@redhat.com> <20101007010241.GB1276@burratino> <20101007010458.GD1276@burratino> <20101007025649.GA14649@gondor.apana.org.au> <20101007033518.GB2285@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:53945 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab0K1MpQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 07:45:16 -0500
Content-Disposition: inline
In-Reply-To: <20101007033518.GB2285@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

On Wed, Oct 06, 2010 at 10:35:18PM -0500, Jonathan Nieder wrote:
>
> Maybe the following would make sense on top?
> 
> -- 8< --
> Subject: [EXCEPTIONS] Use EXEXIT in place of EXEXEC

Patch applied.  Thanks a lot!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
