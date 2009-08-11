From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: avoid compiler warning
Date: Tue, 11 Aug 2009 15:06:24 -0700
Message-ID: <4A81EB60.1020004@zytor.com>
References: <4A55E8BD.1090809@byu.net> <20090811040330.GE10700@gondor.apana.org.au> <4A819D67.7060301@zytor.com> <20090811215615.GA31592@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:36348 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbZHKWGz (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Aug 2009 18:06:55 -0400
In-Reply-To: <20090811215615.GA31592@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <ebb9@byu.net>, dash@vger.kernel.org

On 08/11/2009 02:56 PM, Herbert Xu wrote:
> On Tue, Aug 11, 2009 at 09:33:43AM -0700, H. Peter Anvin wrote:
>> Herbert... the *type* is int, but the *value* has to be in the range
>> [-1,UCHAR_MAX] or the behavior is undefined in both the C and POSIX
>> standards.
> 
> Good point.  I'll apply the patch.  I'd be very surprised though
> if this was the only instance in which we pass a char along.
> 

Personally I have a habit of wrapping most ctype things in macros or
inlines which cast the argument to (unsigned char), then it's up to me
to make sure EOF doesn't slink in.

	-hpa
