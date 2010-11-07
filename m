From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Partial patch] IFS and read builtin
Date: Sun, 7 Nov 2010 16:04:20 -0600
Message-ID: <20101107220420.GA3224@burratino>
References: <4C71A29C.1080609@gigawatt.nl>
 <20100908115324.GA17029@gondor.apana.org.au>
 <20100908120849.GA17121@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41429 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab0KGWEg (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 7 Nov 2010 17:04:36 -0500
Received: by gwj21 with SMTP id 21so3008121gwj.19
        for <dash@vger.kernel.org>; Sun, 07 Nov 2010 14:04:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100908120849.GA17121@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

Hi Herbert et al,

Herbert Xu wrote:

> commit f42e443bb511ed3224f09b4fcf0772438ebdbbfa
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Wed Sep 8 20:07:26 2010 +0800
> 
>     [EXPAND] Fix ifsfirst/ifslastp leak

Another puzzle bisecting to f42e443bb.  This one comes from the
grub-mkconfig script:

 $ sh -c 'datadir=/usr/share; pkgdatadir=${datadir}/`cat`' 2>&1 | cat -A
 cat: M-^\^M^F^HM-4^M^F^HM-(^M^F^H: No such file or directory$
 cat: M-(^M^F^H: No such file or directory$

Still reproducible with 016b529.  I'll try to find time to look into
it, but thought you might like to know nevertheless.

Regards,
Jonathan
