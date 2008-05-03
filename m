From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: dash regression against klibc
Date: Fri, 02 May 2008 23:06:23 -0700
Message-ID: <481C00DF.4060706@zytor.com>
References: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com> <20080502052530.GA15890@gondor.apana.org.au> <20080502062303.GA16356@gondor.apana.org.au> <449c10960805021808k6f4bb039nc37ba5177a9584d5@mail.gmail.com> <20080503022101.GA23067@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:34576 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbYECGGf (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 3 May 2008 02:06:35 -0400
In-Reply-To: <20080503022101.GA23067@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Dan McGee <dan@archlinux.org>, dash@vger.kernel.org

Herbert Xu wrote:
> On Fri, May 02, 2008 at 08:08:34PM -0500, Dan McGee wrote:
>> So the post-patch version of dash is acting identical to the prepatch
>> version. I'm not convinced this is a dash problem- it could very well
>> be an upstream klibc issue, and I will try to look into this
>> possibility as well.
> 
> Could you find out exactly what getcwd returned under klibc?
> Or perhaps somehow _GNU_SOURCE is still being defined under
> klibc?

_GNU_SOURCE is defined by the application, not by the library.

	-hpa
