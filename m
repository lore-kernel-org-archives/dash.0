From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [EVAL] don't clear eflag when forking subshell
Date: Mon, 28 Jun 2010 17:11:45 +1000
Message-ID: <20100628071145.GB26558@gondor.apana.org.au>
References: <20100614095638.28024.qmail@e8dcd834951639.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:58194 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773Ab0F1HLr (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 28 Jun 2010 03:11:47 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by fornost.hengli.com.au with esmtp (Exim 4.69 #1 (Debian))
	id 1OT8VO-0005Qr-85
	for <dash@vger.kernel.org>; Mon, 28 Jun 2010 17:11:46 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1OT8VO-0006xt-5N
	for dash@vger.kernel.org; Mon, 28 Jun 2010 17:11:46 +1000
Content-Disposition: inline
In-Reply-To: <20100614095638.28024.qmail@e8dcd834951639.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Mon, Jun 14, 2010 at 09:56:38AM +0000, Gerrit Pape wrote:
> According to
>  http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_12
> "A subshell environment shall be created as a duplicate of the shell
> environment, except that signal traps set by that shell environment
> shall be set to the default values."
> 
> Currently the eflag is cleared when forking a subshell, e.g.
> 
> $ dash -c 'set -e ; z=$(false;echo foo) ; echo $z'
> foo
> 
> With this commit the eflag is preserved for subshells, and dash exits 1
> before echo.
> 
> The problem was reported by Vincent Lefevre through
>  http://bugs.debian.org/514863
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>

Patch applied.  Thanks Gerrit!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
