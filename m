From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: avoid compiler warning
Date: Wed, 12 Aug 2009 07:56:15 +1000
Message-ID: <20090811215615.GA31592@gondor.apana.org.au>
References: <4A55E8BD.1090809@byu.net> <20090811040330.GE10700@gondor.apana.org.au> <4A819D67.7060301@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:39739 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752740AbZHKV40 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Aug 2009 17:56:26 -0400
Content-Disposition: inline
In-Reply-To: <4A819D67.7060301@zytor.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Eric Blake <ebb9@byu.net>, dash@vger.kernel.org

On Tue, Aug 11, 2009 at 09:33:43AM -0700, H. Peter Anvin wrote:
> 
> Herbert... the *type* is int, but the *value* has to be in the range
> [-1,UCHAR_MAX] or the behavior is undefined in both the C and POSIX
> standards.

Good point.  I'll apply the patch.  I'd be very surprised though
if this was the only instance in which we pass a char along.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
