From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash regression against klibc
Date: Sat, 3 May 2008 14:13:51 +0800
Message-ID: <20080503061351.GA24061@gondor.apana.org.au>
References: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com> <20080502052530.GA15890@gondor.apana.org.au> <20080502062303.GA16356@gondor.apana.org.au> <449c10960805021808k6f4bb039nc37ba5177a9584d5@mail.gmail.com> <20080503022101.GA23067@gondor.apana.org.au> <481C00DF.4060706@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:50781 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753011AbYECGN5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 3 May 2008 02:13:57 -0400
Content-Disposition: inline
In-Reply-To: <481C00DF.4060706@zytor.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dan McGee <dan@archlinux.org>, dash@vger.kernel.org

On Fri, May 02, 2008 at 11:06:23PM -0700, H. Peter Anvin wrote:
> 
> _GNU_SOURCE is defined by the application, not by the library.

Yes, however the macro AC_GNU_SOURCE is supposed to define it
only for glibc.  Having seen the actual code though it seems
that the automake documentation is misleading and the macro is
always defined regardless of the library being used.

I'll change it to use __GLIBC__ instead.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
