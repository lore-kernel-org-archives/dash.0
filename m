From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2] [EXCEPTIONS] Stop documenting EXSHELLPROC
Date: Sun, 28 Nov 2010 20:47:25 +0800
Message-ID: <20101128124725.GB11109@gondor.apana.org.au>
References: <20101006100804.GB361@burratino> <20101006102930.GA6573@gondor.apana.org.au> <20101006105531.GB475@burratino> <4CAC68FD.4040602@redhat.com> <20101007010241.GB1276@burratino> <20101007010347.GC1276@burratino> <20101007030153.GA15132@gondor.apana.org.au> <20101007030414.GA2285@burratino> <20101007032903.GA15283@gondor.apana.org.au> <20101007033923.GC2285@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:56068 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab0K1Mr3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 28 Nov 2010 07:47:29 -0500
Content-Disposition: inline
In-Reply-To: <20101007033923.GC2285@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

On Wed, Oct 06, 2010 at 10:39:23PM -0500, Jonathan Nieder wrote:
> At some point between ash 0.3.5-11.0.1 and ash 0.3.8-37, Debian
> ash stopped using the EXSHELLPROC exception to handle shell
> scripts without a magic number.
> 
> Remove all remaining references to it to avoid confusion.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Also applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
