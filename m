From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: test -x should use faccessat, not stat
Date: Sun, 14 Feb 2010 14:11:37 +0800
Message-ID: <20100214061137.GA9882@gondor.apana.org.au>
References: <loom.20100210T162915-629@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:44804 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752062Ab0BNGLl (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 14 Feb 2010 01:11:41 -0500
Content-Disposition: inline
In-Reply-To: <loom.20100210T162915-629@post.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
Cc: dash@vger.kernel.org

Eric Blake <ebb9@byu.net> wrote:
> This report was originally raised on the cygwin list:
> 
> http://cygwin.com/ml/cygwin/2010-02/msg00239.html
> 
> In short, in the presence of ACLs, dash's implementation of test -r, test -w, 
> and test -x gives incorrect answers, when the current user has permissions to 
> access a file that were granted by ACLs but not by the current stat() 
> permissions.  dash should be using faccessat(,AT_EACCESS) (or 
> eaccess/euidaccess) if available, rather than stat(), to determine whether a 
> file is accessible.

What does bash to in this case?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
