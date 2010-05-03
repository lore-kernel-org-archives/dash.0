From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [EVAL] fix parse_command_args to reliably parse --
Date: Mon, 3 May 2010 11:15:07 +0800
Message-ID: <20100503031507.GB31376@gondor.apana.org.au>
References: <20100428201143.3496.qmail@e3594ea3db687a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:55897 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754361Ab0ECDPL (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 2 May 2010 23:15:11 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1O8m7h-0004B0-0d
	for <dash@vger.kernel.org>; Mon, 03 May 2010 13:15:09 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1O8m7g-0008BQ-3W
	for dash@vger.kernel.org; Mon, 03 May 2010 11:15:08 +0800
Content-Disposition: inline
In-Reply-To: <20100428201143.3496.qmail@e3594ea3db687a.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Wed, Apr 28, 2010 at 10:11:43PM +0200, Gerrit Pape wrote:
> parse_command_args() returning a **argv pointer with *argv == 0 makes
> dash segfault in find_command().  To reproduce run
> 
>  dash -c 'command --'
> 
> With this commit, parse_command_args() returns 0 if *argv is null after
> parsing --, and so fixes the subsequent segfault.
> 
> Reported by Jonny through http://bugs.debian.org/579543
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>

Patch applied.  Thanks Gerrit!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
