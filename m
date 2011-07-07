From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 'continue' does not work in files sourced with dotcmd
Date: Thu, 7 Jul 2011 22:46:35 +0800
Message-ID: <20110707144635.GA21272@gondor.apana.org.au>
References: <AANLkTimiFku8Uj9haYAxXWyJQOGSV7Uz3i2k75+aMvTU@mail.gmail.com> <20110707033749.GB16157@gondor.apana.org.au> <4E15B41A.9020601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:57857 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756332Ab1GGOql (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 10:46:41 -0400
Content-Disposition: inline
In-Reply-To: <4E15B41A.9020601@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: "Taylan Ulrich B." <taylanbayirli@gmail.com>, dash <dash@vger.kernel.org>

On Thu, Jul 07, 2011 at 07:26:50AM -0600, Eric Blake wrote:
> 
> zsh rejected the continue statement (no containing loop within the
> current scoping of the dot script), and as a result also aborted the
> overall dot script - but in doing so, it properly emitted an error message.

dash does not warn in this case because it never prints a warning
on continue anywhere.

This behaviour (not warning) is consistent with that of ksh.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
