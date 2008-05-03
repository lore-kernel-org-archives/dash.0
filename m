From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash regression against klibc
Date: Sat, 3 May 2008 10:21:01 +0800
Message-ID: <20080503022101.GA23067@gondor.apana.org.au>
References: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com> <20080502052530.GA15890@gondor.apana.org.au> <20080502062303.GA16356@gondor.apana.org.au> <449c10960805021808k6f4bb039nc37ba5177a9584d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:51779 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754234AbYECCVF (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 May 2008 22:21:05 -0400
Content-Disposition: inline
In-Reply-To: <449c10960805021808k6f4bb039nc37ba5177a9584d5@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan McGee <dan@archlinux.org>
Cc: dash@vger.kernel.org

On Fri, May 02, 2008 at 08:08:34PM -0500, Dan McGee wrote:
>
> So the post-patch version of dash is acting identical to the prepatch
> version. I'm not convinced this is a dash problem- it could very well
> be an upstream klibc issue, and I will try to look into this
> possibility as well.

Could you find out exactly what getcwd returned under klibc?
Or perhaps somehow _GNU_SOURCE is still being defined under
klibc?

Thanks,
--
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
