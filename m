From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Dash fails to compile on UTF-8 with the Coreutils i18n patch
Date: Mon, 30 Nov 2009 14:36:21 +0800
Message-ID: <20091130063621.GA9950@gondor.apana.org.au>
References: <62234dc60911291654k6a4fc375o131af7460db907e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:56391 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752281AbZK3GgS (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 30 Nov 2009 01:36:18 -0500
Content-Disposition: inline
In-Reply-To: <62234dc60911291654k6a4fc375o131af7460db907e4@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: William Immendorf <will.immendorf@gmail.com>
Cc: dash@vger.kernel.org

William Immendorf <will.immendorf@gmail.com> wrote:
> Hello,
> 
> I think you might rember this madness if you were around the LFS/BLFS
> lists and this list:
> 
> http://linuxfromscratch.org/pipermail/blfs-support/2009-August/065714.html
> http://linuxfromscratch.org/pipermail/lfs-dev/2009-August/063125.html
> http://www.mail-archive.com/dash@vger.kernel.org/msg00151.html
> 
> As of now, HEAD still fails with the exact same error!!!!!! The
> solution: Change all LC_COLLATES to LC_CTYPES in mkbuiltins, and it
> should work on the affected (Both LFS and Fedora), and on ones that
> aren't affected. Please, can you dash that fix out for me?

Well the fix just papers over the issue.

If you can reproduce the problem, please

1) Confirm that setting LC_CTYPES on the sed command only in
mkbuiltins also fixes the issue;
2) See if [[:lower:]] instead of [a-z] fixes the problem without
LC_CTYPES.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
