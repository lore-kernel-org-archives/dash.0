From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 'continue' does not work in files sourced with dotcmd
Date: Fri, 8 Jul 2011 16:09:36 +0800
Message-ID: <20110708080936.GA28335@gondor.apana.org.au>
References: <AANLkTimiFku8Uj9haYAxXWyJQOGSV7Uz3i2k75+aMvTU@mail.gmail.com> <20110707033749.GB16157@gondor.apana.org.au> <4E15B41A.9020601@redhat.com> <20110707144635.GA21272@gondor.apana.org.au> <4E15CE34.40403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:37699 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1GHIJo (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jul 2011 04:09:44 -0400
Content-Disposition: inline
In-Reply-To: <4E15CE34.40403@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: "Taylan Ulrich B." <taylanbayirli@gmail.com>, dash <dash@vger.kernel.org>, zsh-workers@zsh.org

On Thu, Jul 07, 2011 at 09:18:12AM -0600, Eric Blake wrote:
>
> Meanwhile, I still have to wonder about dash behavior - if dash is _not_
> treating continue as a syntax error, then why is it aborting the dot
> script?  Compare:

This is a consequence of the way continue/break/return is implemented
in dash.

As this construct cannot be used portably anyway, I'm not inclined to
make any changes unless you can do it without increasing the code
size.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
